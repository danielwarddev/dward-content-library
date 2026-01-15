# How to Write Contract Tests in C# With Pact – Provider Tests

**Date:** October 29, 2024  
**Author:** Daniel Ward  
**URL:** https://daninacan.com/how-to-write-contract-tests-in-c-with-pact-provider-tests/

_This post is part of a series on contract testing:_

-   [What contract testing is and why to write them](https://daninacan.com/what-contract-testing-is-and-why-to-write-them/)
-   [How to Write Contract Tests in C# With Pact – Consumer Tests](https://daninacan.com/how-to-write-contract-tests-in-c-with-pact-consumer-tests/)
-   **How to Write Contract Tests in C# With Pact – Provider Tests** (this post)
-   [How to Write Contract Tests in C# With Pact – Provider States](https://daninacan.com/how-to-write-contract-tests-in-c-with-pact-provider-states/)
-   [(Optional) How to Write Contract Tests in C# With Pact – Using Testcontainers](https://daninacan.com/how-to-write-contract-tests-in-c-with-pact-using-testcontainers)
-   [How to Write Contract Tests in C# With Pact – Provider State Parameters](https://daninacan.com/how-to-write-contract-tests-in-c-with-pact-provider-state-parameters/)
-   [Writing Contract Tests in C# With Pact – Query Parameters](https://daninacan.com/writing-contract-tests-in-c-with-pact-query-parameters/)
-   [Writing Contract Tests in C# With Pact – Message Interactions](https://daninacan.com/writing-contract-tests-in-c-with-pact-message-interactions/)
-   [Writing Contract Tests in C# With Pact – Pact Brokers](https://daninacan.com/writing-contract-tests-in-c-with-pact-pact-brokers/)

---

### Overview

In the last post, we saw how the consumer can generate a pact file by running their integration tests. This post will directly follow that one, showing how to have the provider use that pact file to run contract tests. These contract tests will validate that the provider implements its API according to how the consumer is actually using it.

### The provider project

Like the consumer project, the provider project is fairly simple for the purposes of demonstration. We have a controller that calls a service that calls an Entity Framework context (I won't show the database context or models for the sake of brevity, but you can look at the Github example if you'd like to see them):

```csharp
public record ProductDto(
    [property: JsonPropertyName("Id")] int Id,
    [property: JsonPropertyName("Name")] string Name,
    [property: JsonPropertyName("Price")] double Price,
    [property: JsonPropertyName("Location")] string Location)
{
    public static ProductDto FromProduct(Product product) => new ProductDto(product.Id, product.Name, product.Price, product.Location);
}

[ApiController]
[Route("[controller]")]
public class ProductController : ControllerBase
{
    private readonly IProductService _productService;

    public ProductController(IProductService productService)
    {
        _productService = productService;
    }

    [HttpGet("/product/{productId:int}")]
    public async Task<ActionResult<ProductDto>> GetProduct(int productId)
    {
        var product = await _productService.GetProduct(productId);
        if (product == null)
        {
            return NotFound();
        }
        return Ok(ProductDto.FromProduct(product));
    }
}
```

```csharp
public interface IProductService
{
    Task<Product?> GetProduct(int productId);
}

public class ProductService : IProductService
{
    private readonly ProductContext _context;

    public ProductService(ProductContext context)
    {
        _context = context;
    }

    public async Task<Product?> GetProduct(int productId)
    {
        return await _context.Products.FirstOrDefaultAsync(x => x.Id == productId);
    }
}
```

### The provider tests – verifying the contract

On the provider's side of testing, our job is to ensure we're developing the API according to how the consumers' (AKA our customers') needs, and so we do have dedicated contract tests. The good news is that we need just a single test to verify the entire contract, and if any part of it fails, that test will fail and tell us why.

Firstly, we need the pact file to run our tests against. We'll see a more scalable way to do this later, but for now, we can just copy/paste it from the consumer test project into this one.

❗ It's important to point out that **you cannot use `WebApplicationFactory` or `TestServer` with Pact**. The internal web server portion of Pact is written in Rust, and your tests must be able to hit that server. Using either of those classes instead spins up an in-memory test server separate from Pact's Rust server. Thus, you are required to host the API on an actual TCP socket, such as by using `Host`, like this tutorial does.

Aside from the above, however, our test setup looks quite similar to a typical integration test suite:

```csharp
public class ProductApiFixture : IDisposable
{
    private readonly IHost _server;
    private IProductService ProductServiceMock { get; } = Substitute.For<IProductService>();
    public Uri PactServerUri { get; } = new ("http://localhost:26404");

    public ProductApiFixture()
    {
        _server = Host.CreateDefaultBuilder()
            .ConfigureWebHostDefaults(builder =>
            {
                builder.UseUrls(PactServerUri.ToString());
                builder.UseStartup<TestStartup>();
                builder.ConfigureServices(services =>
                {
                    services.RemoveAll<IProductService>();
                    services.AddSingleton<IProductService>(_ => ProductServiceMock);
                });
            })
            .Build();

        _server.Start();
    }

    public void Dispose()
    {
        _server.Dispose();
    }
}
```

In an xUnit [class fixture](https://xunit.net/docs/shared-context), we set up a web host using a builder pattern, and we give it a localhost URI so that all data stays local to the tests. However, notice that I make the URI used public and name it `PactServerUri`. We'll see this variable used in the tests.

Ensure that the URI here is the same one your app runs on when run locally, which can be found in the non-test project's `launchSettings.json` file. Also, since we're setting up a web host, you'll need to make sure that the test project's `.csproj` file is using `Microsoft.NET.Sdk.Web` at the top (you might need to add the ".Web" part).

Here's a test asserting the happy path for the endpoint:

```csharp
public class ProductControllerTests : IClassFixture<ProductApiFixture>
{
    private readonly ProductApiFixture _apiFixture;
    private readonly ITestOutputHelper _outputHelper;

    public ProductControllerTests(ProductApiFixture apiFixture, ITestOutputHelper outputHelper)
    {
        _apiFixture = apiFixture;
        _outputHelper = outputHelper;
    }

    [Fact]
    public void Verify_MyService_Pact_Is_Honored()
    {
        var config = new PactVerifierConfig
        {
            LogLevel = PactLogLevel.Debug,
            Outputters = new List<IOutput>
            {
                new XunitOutput(_outputHelper)
            },
        };

        var pactPath = Path.Combine("Pacts", "My Consumer Service-Product API.json");

        using var pactVerifier = new PactVerifier("Product API", config);

        pactVerifier
            .WithHttpEndpoint(_apiFixture.PactServerUri)
            .WithFileSource(new FileInfo(pactPath))
            .Verify();
    }
}
```

This is mostly where the interesting part is, as we finally see some Pact usage. We set up some config values in a `PactVerifierConfig` – notably, the `XunitOutput` requires [a separate Nuget package](https://www.nuget.org/packages/Pact-Net.XUnitOutput) and **is necessary to see Pact errors on test failure**, as Pact defaults to logging to the console, which xUnit doesn't capture. Setting the `LogLevel` isn't required, but I found it helpful when trying to debugging failing tests, so try experimenting with it yourself.

We then create a `PactVerifier` using the config and the pact file and tell it to use the `PactServerUri` to run the mock Pact server on. Finally, we tell it to `Verify()` that our API honors the contract that the consumer expects, and Pact takes care of the rest. This single test will verify the entire pact file and fail if the API is not honoring any part of it.

Let's run the test and see the result:

```
...
Starting verification...
Pact verification failed

Verifier Output
---------------

Verifying a pact between My Consumer Service and Product API

  A GET request to retrieve a product (0s loading, 132ms verification)
     Given There is a product with id 1
      returns a response which
        has status code 200 (FAILED)
        includes headers
          "Content-Type" with value "application/json; charset=utf-8" (FAILED)
        has a matching body (FAILED)

Failures:

1) Verifying a pact between My Consumer Service and Product API Given There is a product with id 1 - A GET request to retrieve a product
    1.1) has a matching body
           $ -> Actual map is missing the following keys: Id, Location, Name, Price

           {
           -  "Id": 1,
              "Location": "Cool Store #12345",
              "Name": "A cool product",
              "Price": 10.5
           +  "status": 404,
              "title": "Not Found",
              "traceId": "00-f2e38b2a99096d1fff6c2fe907c3b177-1e42ac3b68d9b56b-00",
              "type": "https://tools.ietf.org/html/rfc9110#section-15.5.5"
           }


    1.2) has status code 200
           expected 200 but was 404
    1.3) includes header 'Content-Type' with value 'application/json; charset=utf-8'
           Expected header 'Content-Type' to have value 'application/json; charset=utf-8' but was 'application/problem+json; charset=utf-8'


There were 1 pact failures
...
```

Oh no – the test failed! Pact gives us a rather useful and detailed error message, which says that the consumer is expecting a 200 response with a JSON body of a product, but instead we returned it a 404. Why did this happen?

Remember that we're running integration tests and hitting our actual controller and services on a local web server. We go through the `ProductController` to the `ProductService`, which tries to hit the `ProductContext`, which… Doesn't have a data source yet! We haven't set up any kind of data source for our tests.

This is where Pact's provider states come in, which will be the subject of the next post.

### Github Example

You can find a full working example of this at the following Github repository: [https://github.com/danielwarddev/ContractTestingCSharp](https://github.com/danielwarddev/ContractTestingCSharp)
