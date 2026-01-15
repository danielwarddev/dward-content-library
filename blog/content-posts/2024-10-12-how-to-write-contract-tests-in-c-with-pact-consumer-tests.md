# How to Write Contract Tests in C# With Pact – Consumer Tests

**Date:** October 12, 2024  
**Author:** Daniel Ward  
**URL:** https://daninacan.com/how-to-write-contract-tests-in-c-with-pact-consumer-tests/

_This post is part of a series on contract testing:_

-   [What contract testing is and why to write them](https://daninacan.com/what-contract-testing-is-and-why-to-write-them/)
-   **How to Write Contract Tests in C# With Pact – Consumer Tests** (this post)
-   [How to Write Contract Tests in C# With Pact – Provider Tests](https://daninacan.com/how-to-write-contract-tests-in-c-with-pact-provider-tests/)
-   [How to Write Contract Tests in C# With Pact – Provider States](https://daninacan.com/how-to-write-contract-tests-in-c-with-pact-provider-states/)
-   [(Optional) How to Write Contract Tests in C# With Pact – Using Testcontainers](https://daninacan.com/how-to-write-contract-tests-in-c-with-pact-using-testcontainers)
-   [How to Write Contract Tests in C# With Pact – Provider State Parameters](https://daninacan.com/how-to-write-contract-tests-in-c-with-pact-provider-state-parameters/)
-   [Writing Contract Tests in C# With Pact – Query Parameters](https://daninacan.com/writing-contract-tests-in-c-with-pact-query-parameters/)
-   [Writing Contract Tests in C# With Pact – Message Interactions](https://daninacan.com/writing-contract-tests-in-c-with-pact-message-interactions/)
-   [Writing Contract Tests in C# With Pact – Pact Brokers](https://daninacan.com/writing-contract-tests-in-c-with-pact-pact-brokers/)

---

### Overview

As detailed in the introductory post, contract testing begins (ideally) with the consumer of an API writing their logic with tests first and generating a contract from those tests. Thus, the first coding post in this series will detail how to write these tests on the consumer's side. However, as we'll see, this requires almost no changes on the consumer's side to make to generate the contract file.

To write contract tests in C#, we'll use [a library called Pact](https://github.com/pact-foundation/pact-net). It's a fairly popular library for contract testing, and more importantly, it's available in many different programming languages. This isn't just important because it makes it more accessible – it also means that the different teams across your organization don't all need to be using the same language. For instance, I can consume an API and write contract tests for my app written in C#, but the provider might be writing that API in Typescript, and Pact will still work just fine between the two (as long as they're on the same Pact specification version).

### Pact Nuget package

The Nuget package for Pact is called [PactNet](https://www.nuget.org/packages/PactNet). At the time of this writing, in order to get the V4 Pact spec (which this tutorial uses), **you'll have to make sure you're looking for prerelease packages on Nuget**. The version I'm using is 5.0.0-beta.2.

### Consumer tests – creating the contract

Although "contract tests" on the consumer side can exist separately from the other tests, they don't need to – they're really just integration tests that you surround with Pact's `VerifyAsync()`, as we'll see in the example.

The service to be tested is quite simple. It only has one method that gets a product from an external API:

```csharp
public record Product(int Id, string Name, double Price, string Location);

public interface IProductClient
{
    Task<Product?> GetProduct(int productId);
}

public class ProductClient : IProductClient
{
    private readonly HttpClient _client;

    public ProductClient(HttpClient client)
    {
        _client = client;
    }

    public async Task<Product?> GetProduct(int productId)
    {
        Product? product;
        try
        {
            product = await _client.GetFromJsonAsync<Product?>($"/product/{productId}");
        }
        catch (HttpRequestException e) when (e.StatusCode == HttpStatusCode.NotFound)
        {
            return null;
        }
        return product;
    }
}
```

Let's take a look at what the integration test, with Pact included, looks like:

```csharp
public class ProductClientTests
{
    private readonly HttpClient _httpClient;
    private readonly ProductClient _productClient;

    // 1
    private readonly IPactBuilderV4 _pactBuilder = Pact
        .V4("My Consumer Service", "Product API", new PactConfig())
        .WithHttpInteractions();

    public ProductClientTests()
    {
        _httpClient = new HttpClient();
        _httpClient.DefaultRequestHeaders.Add("Accept", "application/json");
        _productClient = new ProductClient(_httpClient);
    }

    [Fact]
    public async Task When_Product_Exists_Then_Api_Returns_Product()
    {
        var expectedProduct = new Product(1, "A cool product", 10.50, "Cool Store #12345");

        // 2
        _pactBuilder
            .UponReceiving("A GET request to retrieve a product")
            .Given("There is a product with id 1")
            .WithRequest(HttpMethod.Get, "/product/1")
            .WithHeader("Accept", "application/json")
            .WillRespond()
            .WithStatus(HttpStatusCode.OK)
            .WithHeader("Content-Type", "application/json; charset=utf-8")
            .WithJsonBody(expectedProduct);

        // 3
        await _pactBuilder.VerifyAsync(async context =>
        {
            _httpClient.BaseAddress = context.MockServerUri;
            var actualProduct = await _productClient.GetProduct(1);
            actualProduct.Should().BeEquivalentTo(expectedProduct);
        });
    }
}
```

There's a bit more going on there, so let's break it down into parts.

1. At the top, we create our `PactBuilder` object. The names you give it for the consumer and provider don't matter and can be any string. The values will be used to create the pact file name and will also be part of the file contents. The config object has a few values in it you can tweak, such as the log level, that we don't care about for now. Here, we use `WithHttpInteractions()`, but there is another option, `WithMessageInteractions()`, that we'll look at and explain later. It's for event-driven systems that use things such as queues, message buses, and WebSocket.

2. Inside of the test, we set up quite a few things using our `PactBuilder`, which end up constructing our pact file. In this case, in plain English, we're saying:

> Whenever I send a GET request to this API at /product/1 with these headers, and a product with id 1 exists, I expect the API to respond with a 200 with these headers, and a JSON body of the product.

That's a bit of a mouthful, but I think it's also quite clear once you understand that and look back at the builder pattern being used. It's good to note that the string given to `UponReceiving()` and `Given()` are completely arbitrary and can be any value that you think is clear or that your teams have agreed upon.

3. Finally, for our actual assertion, we wrap the assertion inside `VerifyAsync()`, set the `HttpClient` to use the Pact mock server's URI, then run the same assertions we normally would. `VerifyAsync()` will take care of the rest, and when our tests are finished, a pact file will be generated in the /Pacts directory next to the tests. It's a little annoying that we need to set the `BaseAddress` in every single test, but it seems that's just the way Pact in .NET works.

❗ Be aware that `WithJsonBody()` actually takes in a `dynamic` for its parameter, rather than being a generic method using `<T>`. I'll go over the reason for this on the post about matchers, but it's good to realize this, since you could decouple your test from your expected response type by inadvertently.

Note that **we're doing the same assertions we would be doing for our integration tests, anyway – now, we're just surrounding it with `VerifyAsync()`.** Now, let's run this test and see what Pact does.

Once it's finished running, you'll see a new directory next to the test file called `pacts` (from my testing, this name doesn't seem to be case sensitive if you prefer to rename it with a capital letter) with a JSON file inside it. You can see that Pact named the file according to the string values you used in the `V4` constructor for the consumer and provider. In this case, that's `My Consumer Service-Product API.json`.

Let's take a look at the pact file it generated:

```json
{
    "consumer": {
        "name": "My Consumer Service"
    },
    "interactions": [
        {
            "description": "A GET request to retrieve a product",
            "pending": false,
            "providerStates": [
                {
                    "name": "There is a product with id 1"
                }
            ],
            "request": {
                "headers": {
                    "Accept": ["application/json"]
                },
                "method": "GET",
                "path": "/product/1"
            },
            "response": {
                "body": {
                    "content": {
                        "Id": 1,
                        "Location": "Cool Store #12345",
                        "Name": "A cool product",
                        "Price": 10.5
                    },
                    "contentType": "application/json",
                    "encoded": false
                },
                "headers": {
                    "Content-Type": ["application/json; charset=utf-8"]
                },
                "status": 200
            },
            "type": "Synchronous/HTTP"
        }
    ],
    "metadata": {
        "pactRust": {
            "ffi": "0.4.16",
            "models": "1.1.19"
        },
        "pactSpecification": {
            "version": "4.0"
        }
    },
    "provider": {
        "name": "Product API"
    }
}
```

Hey, that looks like the values we put in our Pact builder! Browsing through this file a bit, it should be fairly clear how it uses the values you gave it. There's also some other data, such as the Pact specification version, which is 4.0 here, since we used the `V4` builder. Note that `interactions/description` and `interactions/providerStates/name` are simply arbitrary string values.

Keep the `providerStates` section in mind, as it's an important concept in Pact that will be addressed in a couple posts.

With this, the job of our consumer is done. This pact file will then be sent to the provider so that they can test against it to ensure they're meeting the consumer's expectations.

### Okay, what do I do with my contract file now?

❗ Important! Note that **the contract file will not be overwritten when you run your tests – it will be appended to**. However, in a more realistic scenario, this won't actually be an issue. When running your tests from a pipeline and sending the results to a Pact broker, the Pact file be generated every time – more on that in a later post.

With that said, you should add something like the following to your .gitignore file to exclude the contract files from your repo:

`[Pp]act/`

### Cleaning up a bit – an issue with headers

There's still a part of our code I'm not a huge fan of – we're including the expected headers in the contract file, which is fine, but the headers in our test are not tied to the headers in our actual code. This means that if we ever added new headers inside Program.cs (perhaps for an auth token, for instance), our test wouldn't pick up that new header. It wouldn't be included in the contract, and so the provider wouldn't know we're using the API in this way.

My solution to this was to put the headers inside a public collection that both the real code and the tests share. I also made some extension methods to add headers more easily. Here's the code for what I did:

Program.cs with the changes:

```csharp
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;

namespace Consumer;

public class Program
{
    // Public collection for headers
    public static readonly HttpHeader[] ProductClientRequestHeaders =
    {
        new("Accept", "application/json")
    };

    public static async Task Main(string[] args)
    {
        await Host.CreateDefaultBuilder(args)
            .ConfigureServices((_, services) =>
            {
                services.AddHttpClient<IProductClient, ProductClient>(client =>
                {
                    client.BaseAddress = new Uri("http://example.com");
                    // Add the headers to the client here
                    client.AddRequestHeaders(ProductClientRequestHeaders);
                });
            })
            .Build()
            .RunAsync();
    }
}

// New type and extension method for the headers
public record HttpHeader(string Key, string Value);

public static class ServiceExtensions
{
    public static void AddRequestHeaders(this HttpClient client, IEnumerable<HttpHeader> headers)
    {
        foreach (var header in headers)
        {
            client.DefaultRequestHeaders.Add(header.Key, header.Value);
        }
    }
}
```

The tests with the changes:

```csharp
[Fact]
public async Task Api_Returns_All_Products()
{
    var expectedProducts = new [] { new Product(1, "A cool product", 10.50, "Cool Store #12345") };

    _pactBuilder
        .UponReceiving("A GET request to retrieve all products")
        .Given("Products exist")
        .WithRequest(HttpMethod.Get, "/products")
        // Now uses the new extension method to add the headers
        .WithHeaders(Program.ProductClientRequestHeaders)
        .WillRespond()
        .WithStatus(HttpStatusCode.OK)
        .WithHeader("Content-Type", "application/json; charset=utf-8")
        .WithJsonBody(expectedProducts);

    await _pactBuilder.VerifyAsync(async context =>
    {
        _httpClient.BaseAddress = context.MockServerUri;
        var actualProducts = await _productClient.GetAllProducts();
        actualProducts.Should().BeEquivalentTo(expectedProducts);
    });
}

...

public static class PactExtensions
{
    public static IRequestBuilderV4 WithHeaders(this IRequestBuilderV4 builder, IEnumerable headers)
    {
        foreach (var header in headers)
        {
            builder = builder.WithHeader(header.Key, header.Value);
        }
        return builder;
    }
}
```

### Github Example

You can find a full working example of this at the following Github repository: [https://github.com/danielwarddev/ContractTestingCSharp](https://github.com/danielwarddev/ContractTestingCSharp)
