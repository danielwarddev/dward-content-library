# How to mock HttpClient in C# using NSubstitute 3 ways

**Date:** September 1, 2023  
**Author:** Daniel Ward  
**URL:** https://daninacan.com/how-to-mock-httpclient-in-c-using-nsubstitute-3-ways/

_There is a Moq counterpart to this post: [How to mock HttpClient in C# using Moq](https://daninacan.com/how-to-mock-httpclient-in-c-using-moq/). Click there if you would like to see how to do this using Moq._

This post will cover 3 different ways to mock `HttpClient` using NSubstitute and give pros and cons for each:

-   Create a fake `HttpMessageHandler` class
-   Set up calls to the protected `SendAsync()` method using reflection in extension methods
-   Use [RichardSzalay.MockHttp](https://github.com/richardszalay/mockhttp) (recommended)

### Overview

Mocking an `HttpClient` is a very common use case in unit testing, but its underlying method that all HTTP calls will eventually make, `SendAsync()`, is protected. Unfortunately, that means we can't mock it how we normally would, and chances are, if you've tried to set up a return value for `SendAsync()` on your `HttpClient` or `HttpMessageHandler` substitute, you've gotten an error message like this:

_Cannot access protected internal method 'SendAsync(HttpRequestMessage, CancellationToken)' here_

Quite annoying, and very rude. What can we do about this? Let's look at some options below. Keep in mind that for all of these, to mock `HttpClient`, what we really care about mocking is its underlying service `HttpMessageHandler`, which is the class that actually makes all of the HTTP calls.

For all of these, assume that we are working with the following simple service below (you may or may not even unit test this service normally since it's just a pass-through service, but it will do for demonstration purposes; check [the Github example](https://github.com/danielwarddev/NSubstitueMockHttpClient) for a slightly more involved example):

```csharp
using System.Net;
using System.Net.Http.Json;

namespace NSubstitueMockHttpClient;

public record Book(int Id, string Name, string[] Authors);

public interface IBookClient
{
    Task<Book> GetBook(int bookId);
}

public class BookClient : IBookClient
{
    private readonly HttpClient _httpClient;

    public BookClient(HttpClient httpClient)
    {
        _httpClient = httpClient;
    }

    public async Task<Book?> GetBook(int bookId)
    {
        try
        {
            return await _httpClient.GetFromJsonAsync<Book>($"books/{bookId}");
        }
    }
}
```

### 1. Create a fake HttpMessageHandler class

This is probably the most common way to accomplish this goal that I've seen online. Instead of using a testing or mocking library to set up your calls, you simply create the fake class yourself. Here's an example:

```csharp
public class MyMockHttpMessageHandler : HttpMessageHandler
{
    private readonly HttpStatusCode _statusCode;
    private readonly object? _responseContent;

    public MyMockHttpMessageHandler(HttpStatusCode statusCode, object? responseContent = null)
    {
        _statusCode = statusCode;
        _responseContent = responseContent;
    }

    protected override async Task<HttpResponseMessage> SendAsync(HttpRequestMessage request, CancellationToken cancellationToken)
    {
        return await Task.FromResult(new HttpResponseMessage
        {
            StatusCode = _statusCode,
            Content = JsonContent.Create(_responseContent)
        });
    }
}
```

Using it in a test:

```csharp
using AutoFixture;
using FluentAssertions;
using NSubstitueMockHttpClient;
using System.Net;

namespace NSubstituteMockHttpClient.UnitTests;

public class Method1_BookClientTests
{
    private readonly Fixture _fixture = new();

    [Fact]
    public async Task When_Call_To_Get_Books_Succeeds_Then_Returns_Books()
    {
        var genreId = _fixture.Create<int>();
        var expectedBooks = _fixture.CreateMany<Book>();
        var handler = new MyMockHttpMessageHandler(HttpStatusCode.OK, expectedBooks);
        var client = new HttpClient(handler) { BaseAddress = new Uri("https://www.example.com") };
        var bookClient = new BookClient(client);

        var actualBooks = await bookClient.GetBooks(genreId);

        actualBooks.Should().BeEquivalentTo(expectedBooks);
    }
}
```

**Pros:**

-   Simple to setup with no knowledge of testing libraries needed

**Cons:**

-   You're forced to create your handler, client, and system under test for every single test instead of being able to put it in the constructor
-   Not very flexible and adding different functionality requires manual coding every time
-   Doesn't verify that the correct URL was hit
-   Can't be configured to handle more calls or use different logic without additional setup

### Method 2: Set up calls to the protected SendAsync() method using reflection in extension methods

While we can't make NSubstitute set up the `SendAsync()` method directly, we can use reflection to do it indirectly. We can also make use of NSubstitute's `ReceivedCalls()`, because even though `SendAsync()` is protected, NSubstitute will still record if it was called. Here's the extension methods:

```csharp
public static class NSubstituteExtensions
{
    public static HttpMessageHandler SetupRequest(this HttpMessageHandler handler, HttpMethod method, string requestUri)
    {
        handler
            .GetType()
            .GetMethod("SendAsync", BindingFlags.NonPublic | BindingFlags.Instance)!
            .Invoke(handler, new object?[]
            {
                Arg.Is<HttpRequestMessage>(x => x.Method == method && x.RequestUri != null && x.RequestUri.ToString() == requestUri),
                Arg.Any<CancellationToken>()
            });

        return handler;
    }

    public static ConfiguredCall ReturnsResponse(this HttpMessageHandler handler, HttpStatusCode statusCode, object? responseContent = null)
    {
        return ((object)handler).Returns(
            Task.FromResult(new HttpResponseMessage()
            {
                StatusCode = statusCode,
                Content = JsonContent.Create(responseContent)
            })
        );
    }

    public static void ShouldHaveReceived(this HttpMessageHandler handler, HttpMethod requestMethod, string requestUri, int timesCalled = 1)
    {
        var calls = handler.ReceivedCalls()
            .Where(call => call.GetMethodInfo().Name == "SendAsync")
            .Select(call => call.GetOriginalArguments().First())
            .Cast<HttpRequestMessage>()
            .Where(request =>
                request.Method == requestMethod &&
                request.RequestUri != null &&
                request.RequestUri.ToString() == requestUri
            );

        calls.Should().HaveCount(timesCalled, $"HttpMessageHandler was expected to make the following call {timesCalled} times: {requestMethod} {requestUri}");
    }
}
```

Using them in a test:

```csharp
using AutoFixture;
using FluentAssertions;
using NSubstitueMockHttpClient;
using NSubstitute;
using System.Net;

namespace NSubstituteMockHttpClient.UnitTests;

public class Method2_BookClientTests
{
    private readonly BookClient _bookClient;
    private readonly Fixture _fixture = new();
    private readonly HttpMessageHandler _handler = Substitute.For<HttpMessageHandler>();
    private readonly string _baseAddress = "https://www.example.com";

    public Method2_BookClientTests()
    {
        var httpClient = new HttpClient(_handler) { BaseAddress = new Uri(_baseAddress) };
        _bookClient = new BookClient(httpClient);
    }

    [Fact]
    public async Task When_Call_To_Get_Books_Succeeds_Then_Returns_Books()
    {
        var genreId = _fixture.Create<int>();
        var expectedBooks = _fixture.CreateMany<Book>();
        var endpoint = $"{_baseAddress}/books/{genreId}";

        _handler
            .SetupRequest(HttpMethod.Get, endpoint)
            .ReturnsResponse(HttpStatusCode.OK, expectedBooks);

        var actualBooks = await _bookClient.GetBooks(genreId);

        _handler.ShouldHaveReceived(HttpMethod.Get, endpoint);
        actualBooks.Should().BeEquivalentTo(expectedBooks);
    }
}
```

**Pros:**

-   We only need to set up our handler, client, and system under test once in the constructor. Any setup for the handler can be specific for and scoped to each test
-   This is definitely an improvement in terms of flexibility. We can specify the HTTP verb and URL for the request, and can return whatever status code and response content we want, both on a per-call basis
-   We can verify that the expected HTTP calls were actually made, so that we can know our test succeeds for the right reasons

**Cons:**

-   While it's nice we can now verify that expected HTTP calls were made with `ShouldHaveReceived()`, it's redundant that we have to make a third call to do it with the exact same parameters passed into it that `SetupRequest()` received
-   The extension methods are fairly wordy, and they're not the simplest methods in the world on top of that. Extending them for additional functionality is possible but would probably take a little bit of effort to understand
-   You need to copy/paste these extension methods into every project you want to use them in

### Method 3: Use RichardSzalay.MockHttp (recommended)

The final option, and the one I recommend, is to not reinvent the wheel and just use Richard Szalay's great little project MockHttp found here: https://github.com/richardszalay/mockhttp. Instead of explaining what it does, let's just go through an example of it in action:

```csharp
using AutoFixture;
using FluentAssertions;
using NSubstitueMockHttpClient;
using RichardSzalay.MockHttp;
using System.Net;
using System.Net.Http.Json;

namespace NSubstituteMockHttpClient.UnitTests;

public class Method3_BookClientTests
{
    private readonly BookClient _bookClient;
    private readonly Fixture _fixture = new();
    private readonly MockHttpMessageHandler _handler = new();
    private readonly string _baseAddress = "https://www.example.com";

    public Method3_BookClientTests()
    {
        var httpClient = new HttpClient(_handler) { BaseAddress = new Uri(_baseAddress) };
        _bookClient = new BookClient(httpClient);
    }

    [Fact]
    public async Task When_Call_To_Get_Books_Succeeds_Then_Returns_Books()
    {
        var genreId = _fixture.Create<int>();
        var expectedBooks = _fixture.CreateMany<Book>();

        _handler
            .Expect(HttpMethod.Get, $"{_baseAddress}/books/{genreId}")
            .Respond(HttpStatusCode.OK, JsonContent.Create(expectedBooks));

        var actualBooks = await _bookClient.GetBooks(genreId);

        actualBooks.Should().BeEquivalentTo(expectedBooks);
    }
}
```

That's it!

**Pros:**

-   All the benefits of method 2, but less verbose. We get to set up a response for a specific expected request and also verify that the specific request was actually made in just 2 methods
-   Doesn't depend on NSubstitute. MockHttp works with any testing library, so you can carry the library knowledge over to any project
-   More features already built in, such as wildcards and checking query parameters. Check the Github link above for some examples
-   Easier to read and understand than both method 1 and 2

**Cons:**

-   The only con I can think of for this is that it requires another package in your project. Some organizations are extremely restrictive with what packages they allow developers to use and some teams may not be allowed to include it in their project

### Github Example

You can find a full working example of this at the following Github repository: https://github.com/danielwarddev/NSubstitueMockHttpClient
