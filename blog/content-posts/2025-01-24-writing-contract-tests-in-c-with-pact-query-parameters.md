# Writing Contract Tests in C# With Pact – Query Parameters

**Date:** January 24, 2025  
**Author:** Daniel Ward  
**URL:** https://daninacan.com/writing-contract-tests-in-c-with-pact-query-parameters/

_This post is part of a series on contract testing:_

-   [What contract testing is and why to write them](https://daninacan.com/what-contract-testing-is-and-why-to-write-them/)
-   [How to Write Contract Tests in C# With Pact – Consumer Tests](https://daninacan.com/how-to-write-contract-tests-in-c-with-pact-consumer-tests/)
-   [How to Write Contract Tests in C# With Pact – Provider Tests](https://daninacan.com/how-to-write-contract-tests-in-c-with-pact-provider-tests/)
-   [How to Write Contract Tests in C# With Pact – Provider States](https://daninacan.com/how-to-write-contract-tests-in-c-with-pact-provider-states/)
-   [(Optional) How to Write Contract Tests in C# With Pact – Using Testcontainers](https://daninacan.com/how-to-write-contract-tests-in-c-with-pact-using-testcontainers)
-   [How to Write Contract Tests in C# With Pact – Provider State Parameters](https://daninacan.com/how-to-write-contract-tests-in-c-with-pact-provider-state-parameters/)
-   **Writing Contract Tests in C# With Pact – Query Parameters** (this post)
-   [Writing Contract Tests in C# With Pact – Message Interactions](https://daninacan.com/writing-contract-tests-in-c-with-pact-message-interactions/)
-   [Writing Contract Tests in C# With Pact – Pact Brokers](https://daninacan.com/writing-contract-tests-in-c-with-pact-pact-brokers/)

---

### Overview

Up until now, we've covered writing tests for endpoints without query parameters. Let's cover that now.

For this, we'll add one new endpoint to our API that uses a query parameter:

```csharp
... [HttpGet("/products")]
public async Task<ActionResult<ProductDto>> GetAllProducts([FromQuery] string? name = null)
{
    if (name != null)
    {
        var products = await _productService.GetProductsByName(name);
        return Ok(products.Select(ProductDto.FromProduct));
    }
    var product = await _productService.GetAllProducts();
    return Ok(product.Select(ProductDto.FromProduct));
}
...
```

We'll also add two new methods on our consumer side to call that new endpoint:

```csharp
... public async Task<Product[]> GetAllProducts()
{
    return (await _client.GetFromJsonAsync<Product[]>($"/products"))!;
}

public async Task<Product[]> GetProductsByName(string name)
{
    return (await _client.GetFromJsonAsync<Product[]>($"/products?productName={name}"))!;
}
...
```

### Adding query parameters to consumer tests

All we need to do is use `WithQuery()` to specify our query parameters. Although only one of these methods uses a query parameter, I'll include both the tests for completeness sake:

```csharp
// Original test without query
[Fact]
public async Task Api_Returns_All_Products()
{
    var expectedProducts = new [] { new Product(1, "A cool product", 10.50m, "Cool Store #12345") };

    _pactBuilder
        .UponReceiving("A GET request to retrieve all products")
        .Given("Products exist")
        .WithRequest(HttpMethod.Get, "/products")
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

// Using query parameters
[Fact]
public async Task Api_Returns_All_Products_With_Name()
{
    var expectedProducts = new [] { new Product(1, "A cool product", 10.50m, "Cool Store #12345") };

    _pactBuilder
        .UponReceiving("A GET request to retrieve all products with given id and name")
        .Given("A product exists")
        .WithRequest(HttpMethod.Get, "/products")
        .WithQuery("name", "A cool product") // New method
        .WithHeaders(Program.ProductClientRequestHeaders)
        .WillRespond()
        .WithStatus(HttpStatusCode.OK)
        .WithHeader("Content-Type", "application/json; charset=utf-8")
        .WithJsonBody(expectedProducts);

    await _pactBuilder.VerifyAsync(async context =>
    {
        _httpClient.BaseAddress = context.MockServerUri;
        var actualProducts = await _productClient.GetProductsByName("A cool product");
        actualProducts.Should().BeEquivalentTo(expectedProducts);
    });
}
```

That's all that's required, with the `WithQuery()` call really being the only new concept. However, I encourage you to continue reading on, as there is actually an error in these tests.

### Looking at query parameters in provider tests

Since our existing single test on the provider side verifies the entire pact file at once, we don't need to add anything here.

### An important gotcha – false positives

❗ You may have noticed that there's actually an error between the consumer and the provider, even though all the tests passed. It's a bit hard to spot – can you tell what it is?

The issue is that the consumer expects the query parameter to be called `productName`, but it's actually called `name` on the actual API. So, why did the provider test pass even though the consumer is calling it incorrectly? Why did we get a false positive?

This is a case of ASP.NET Core designed according to the [Robustness principle](https://en.wikipedia.org/wiki/Robustness_principle). If it receives query parameters it doesn't recognize, it doesn't return a 500 – instead, it goes to the first applicable endpoint, if any. The merits of whether this is desirable or not is a subject for another time. We are, however, concerned with how this behavior affects our tests.

In our case, it saw `productName`, a query parameter that doesn't exist on that endpoint, ignored it, and instead called the controller method `GetAllProducts()` with `name` as null. This returns _all products in the database_, rather than the desired behavior of _only products with a certain name_.

The reason the tests didn't catch this is because of the test data. In both of the new tests, the consumer is only expecting one product to be returned in the response's array, and from the `Given()`, it seems that it's telling the provider to only set up one product in the database, as well. Because it only expects one product, and only asks for one product to exist, it isn't apparent that it's actually receiving all products in the database.

Ultimately, how you address this is up to you, but you can keep reading to see my preferred solution. For example, you might decide to…

-   As the provider team, tell consumer teams that a certain set of products will always be in the database for every test unless the test requests otherwise.
-   In the consumer tests, specify more objects you expect to be in the database. For the test with the query parameter, you could ask for a product to be present that you _don't_ expect to be returned.
-   Have either your tests or your actual API return a 500 if it receives any unrecognized query parameters.

### Ensuring query parameters are valid

Currently, my preferred option is #3, and applying the logic only to my tests. A possible con to this is that if you're only using this in your tests, then your tests will now behave different from your real app – your tests will fail on bad query parameters, but your real app won't. It's also more upkeep for your tests. This doesn't mean it's good or bad, but that there's tradeoffs. It's a design decision, so make your own choice in the matter.

You'll need a custom resource filter for this, which I've adapted a bit from [this Github issue](https://github.com/dotnet/aspnetcore/issues/15414#issuecomment-548024584):

```csharp
public class QueryStringValidatorFilter : IResourceFilter
{
    public void OnResourceExecuting(ResourceExecutingContext context)
    {
        var parameters = new HashSet<string>(context.ActionDescriptor.Parameters.Select(x => x.Name), StringComparer.OrdinalIgnoreCase);
        var unknownParameters = new Dictionary<string, string[]>();

        foreach (var item in context.HttpContext.Request.Query)
        {
            if (!parameters.Contains(item.Key))
            {
                unknownParameters.Add(item.Key, [$"Query string \"{item.Key}\" does not bind to any parameter. " +
                    $"Valid parameter names for endpoint {context.HttpContext.Request.Path}" +
                    $"are: {string.Join(", ", parameters)}."]);
            }
        }

        if (unknownParameters.Any())
        {
            context.Result = new BadRequestObjectResult(new ValidationProblemDetails(unknownParameters));
        }
    }

    public void OnResourceExecuted(ResourceExecutedContext context) { }
}
```

Then, add it to the `TestStartup`:

```csharp
services.AddControllers(options =>
{
    options.Filters.Add<QueryStringValidatorFilter>();
});
```

With this, the provider test will now fail if it receives unrecognized query parameters, which, in our case, would reveal the faulty use of the API.

### Github example

You can find a full working example of this at the following Github repository: [https://github.com/danielwarddev/ContractTestingCSharp](https://github.com/danielwarddev/ContractTestingCSharp)
