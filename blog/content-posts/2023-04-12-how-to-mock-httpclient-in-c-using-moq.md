# How to mock HttpClient in C# using Moq

**Date:** April 12, 2023  
**Author:** Daniel Ward  
**URL:** https://daninacan.com/how-to-mock-httpclient-in-c-using-moq/

---

_There is an NSubstitute counterpart to this post: [How to mock HttpClient in C# using NSubstitute 3 ways](https://daninacan.com/how-to-mock-httpclient-in-c-using-nsubstitute-3-ways/). Click there if you would like to see how to do this using NSubstitute._

Very often while unit testing, we need to mock our HTTP calls so that we don't actually make HTTP calls out to an external service. `HttpClient` is the class typically used for making HTTP requests, with its `SendAsync()` method being the method used by all HTTP requests in it. Unfortunately, `SendAsync()` can't be mocked by Moq, and attempting to do so will throw a **NotSupportedException**, with a message that looks like this:

_Unsupported expression: x => x.SendAsync(It.IsAny()) Non-overridable members (here: HttpClient.SendAsync) may not be used in setup / verification expressions._

To get around this, we can mock the underlying service, `HttpMessageHandler`, which is the class that `HttpClient` uses internally to make the HTTP calls.

### Using Moq to mock HttpMessageHandler

Moq is the library we'll be using to mock our HTTP calls. The method that we'll need to setup is `SendAsync()`, which is ultimately what all HTTP requests are made through. Since this is a protected method, we'll need to first call `Protected()` on our mock object. From there, we can set up as usual. Keep in mind that, since we're working with a protected member, Moq makes us use `ItExpr` rather than `It`.

We'll be accomplishing the mocking through extension methods, because frankly, the setup required for these is rather long and ugly, and even more so when you need to do it for every different case in your tests. The nice thing about using extension methods is that they can just return the same type a normal `Setup()` call returns, `ISetup`, which will allow us to chain Moq methods on to it as normal, such as `Returns()` or `Throws()`.

Two extension methods will be needed: one for setting up expected calls to the client, and another for setting up fake responses from it.

### Moq extension methods for mocking HTTP calls

```csharp
public static class MoqExtensions
{
    public static ISetup<HttpMessageHandler, Task<HttpResponseMessage>> SetupSendAsync(
        this Mock<HttpMessageHandler> handler,
        HttpMethod requestMethod,
        string requestUrl)
    {
        return handler.Protected().Setup<Task<HttpResponseMessage>>(
            "SendAsync",
            ItExpr.Is<HttpRequestMessage>(r =>
                r.Method == requestMethod &&
                r.RequestUri != null &&
                r.RequestUri.ToString() == requestUrl
            ),
            ItExpr.IsAny<CancellationToken>()
        );
    }

    public static IReturnsResult<HttpMessageHandler> ReturnsHttpResponseAsync(
        this ISetup<HttpMessageHandler, Task<HttpResponseMessage>> moqSetup,
        object? responseBody,
        HttpStatusCode responseCode)
    {
        var serializedResponse = JsonSerializer.Serialize(responseBody);
        var stringContent = new StringContent(serializedResponse ?? string.Empty);
        var responseMessage = new HttpResponseMessage
        {
            StatusCode = responseCode,
            Content = stringContent
        };
        return moqSetup.ReturnsAsync(responseMessage);
    }
}
```

I feel these are quite flexible as is, but obviously, you can tweak these to suit your needs, such as if you need to assert on something different.

### Example

To illustrate an example of using these extension methods in a test, let's use an overly-simple client class:

```csharp
public class SomeClient
{
    private readonly HttpClient _httpClient;

    public SomeClient(HttpClient httpClient)
    {
        _httpClient = httpClient;
    }

    public async Task<int> AddOneToResponseResult()
    {
        var responseValue = await _httpClient.GetFromJsonAsync<int>("myEndpoint");
        return responseValue + 1;
    }
}
```

We can now test this class like so (also using [xUnit](https://xunit.net/) and [FluentAssertions](https://fluentassertions.com/)):

```csharp
[Fact]
public async void Returns_Response_Result_Plus_One()
{
    var fakeBaseAddress = "https://www.example.com";
    var httpMessageHandler = new Mock<HttpMessageHandler>();

    httpMessageHandler
        .SetupSendAsync(HttpMethod.Get, $"{fakeBaseAddress}/myEndpoint")
        .ReturnsHttpResponseAsync(10, HttpStatusCode.OK);

    var httpClient = new HttpClient(httpMessageHandler.Object)
    {
        BaseAddress = new Uri(fakeBaseAddress)
    };

    var client = new SomeClient(httpClient);

    var result = await client.AddOneToResponseResult();

    result.Should().Be(11);
}
```

### Github example

You can find a full working example of this at the following Github repository: https://github.com/danielwarddev/MoqHttpExtensions
