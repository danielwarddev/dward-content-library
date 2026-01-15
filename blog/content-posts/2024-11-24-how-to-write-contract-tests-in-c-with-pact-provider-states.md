# How to Write Contract Tests in C# With Pact – Provider States

**Date:** November 24, 2024  
**Author:** Daniel Ward  
**URL:** https://daninacan.com/how-to-write-contract-tests-in-c-with-pact-provider-states/

_This post is part of a series on contract testing:_

-   [What contract testing is and why to write them](https://daninacan.com/what-contract-testing-is-and-why-to-write-them/)
-   [How to Write Contract Tests in C# With Pact – Consumer Tests](https://daninacan.com/how-to-write-contract-tests-in-c-with-pact-consumer-tests/)
-   [How to Write Contract Tests in C# With Pact – Provider Tests](https://daninacan.com/how-to-write-contract-tests-in-c-with-pact-provider-tests/)
-   **How to Write Contract Tests in C# With Pact – Provider States** (this post)
-   [(Optional) How to Write Contract Tests in C# With Pact – Using Testcontainers](https://daninacan.com/how-to-write-contract-tests-in-c-with-pact-using-testcontainers)
-   [How to Write Contract Tests in C# With Pact – Provider State Parameters](https://daninacan.com/how-to-write-contract-tests-in-c-with-pact-provider-state-parameters/)
-   [Writing Contract Tests in C# With Pact – Query Parameters](https://daninacan.com/writing-contract-tests-in-c-with-pact-query-parameters/)
-   [Writing Contract Tests in C# With Pact – Message Interactions](https://daninacan.com/writing-contract-tests-in-c-with-pact-message-interactions/)
-   [Writing Contract Tests in C# With Pact – Pact Brokers](https://daninacan.com/writing-contract-tests-in-c-with-pact-pact-brokers/)

---

### Overview

In the last post, we wrote a contract test on the provider side, which failed, because we hadn't set up any kind of data source for the integration tests to use.

In the real world, your API will CRUD data from somewhere – a database, another API, a file system, etc. – and will return different results based on the state of that data. For instance, if no record exists for the query given to your API, you might return a 404 instead of a 200. We'd like to be able to test this behavior, as well.

Ultimately, you can use whatever preference of data source you already have for integration tests – SQLite, in-memory, a real database, etc. I'm going to be using [Testcontainers](https://testcontainers.com/) because I believe it's the best option for integration tests in general. I'll show the changes to the code for this, although how Testcontainers works won't be the subject of these posts – you can check out [my other posts on that](https://daninacan.com/how-to-test-a-database-in-c-with-testcontainers/) if you like.

This is also a good opportunity to talk about why using OpenAPI isn't sufficient for testing purposes.

### Why not use OpenAPI instead of creating a separate Pact specification?

We already have an existing specification to describe APIs that's even used for tools like Swagger, so why not use that for contract testing? The ultimate answer is that it's not descriptive enough.

OpenAPI does a good job of describing an API's requests and responses insofar that we can learn how to properly call its endpoints and how it might respond. However, it's not a great tool when used for testing purposes, because **OpenAPI doesn't tell you anything about the conditions that make each response happen**.

For instance, it might tell you a single endpoint can return a 200, a 401, or a 404, but not what the conditions are for those different responses to occur. Most likely, a 404 would be returned when the requested object couldn't be found in the database, but now you're kind of talking further than the API spec itself is concerned. Your tests do care about those situations, however, and so the Pact specification includes provider states, which allow you to assert the provider gives specific responses under certain conditions.

With the philosophy bit out of the way, let's look at how to actually use provider states in our tests!

### Testcontainers setup (if using Testcontainers)

For brevity, this has been moved to a separate post: [How to Write Contract Tests in C# With Pact – Using Testcontainers](https://daninacan.com/how-to-write-contract-tests-in-c-with-pact-using-testcontainers/)

### The consumer side – putting provider states into the pact file

Our provider's contract test is failing because we haven't put a product with an id of 1 into our data source, and so it isn't returning the expected response. It's nice to see the test fail first so that we know we're writing it correctly, but now we'd like to fix this!

The part we care about is the `Given("There is a product with id 1")` from the consumer's test. This is put into the `interactions/providerStates` property in the pact JSON file, and tells the provider what you're looking for as a consumer. This means that the separate teams need to talk together and come up with some kind of an agreed-upon format, template, set of strings, etc., to make this work.

So, in this case, the consumer is telling the provider the following:

> For this case, we're expecting a product with an id of 1 to exist in whatever data source you use, so do whatever you need to for that to happen on your side when you run your tests.

### The provider side – using provider states to set up data

The provider will read that provider state and insert data accordingly. Using provider states isn't too hard, but it might seem a little unorthodox at first. In our provider contract test, we update our test with a single new line before our `Verify()` call:

```csharp
...
pactVerifier
    .WithHttpEndpoint(_apiFixture.PactServerUri)
    .WithFileSource(new FileInfo(pactPath))
    .WithProviderStateUrl(new Uri(_apiFixture.PactServerUri, "/provider-states"))
    .Verify();
...
```

The endpoint we give it is arbitrary, but whatever we give it, it will use that value to stand up a new endpoint on the web server that Pact is running for your contract tests.

In order to hit that endpoint, we'll need some middleware. Here's the code I'm using for that:

```csharp
// 1
public class ProviderState
{
    [property: JsonPropertyName("action")]
    public string Action { get; init; } = null!;

    [property: JsonPropertyName("params")]
    public Dictionary<string, string> Params { get; init; } = null!;

    [property: JsonPropertyName("state")]
    public string State { get; init; } = null!;
}

public class ProviderStateMiddleware
{
    // 2
    private readonly RequestDelegate _next;

    // 3
    private readonly IDictionary<string, Action> _providerStates;
    private ProductContext _dbContext;

    public ProviderStateMiddleware(RequestDelegate next)
    {
        _next = next;
        _providerStates = new Dictionary<string, Action>
        {
            { "There is a product with id 1", () => MockData(1) }
        };
    }

    // 4
    public async Task Invoke(HttpContext context, ProductContext dbContext)
    {
        if (context.Request.Path.Value == "/provider-states")
        {
            _dbContext = dbContext;
            await HandleProviderStateRequest(context);
            await context.Response.WriteAsync(string.Empty);
        }
        else
        {
            await _next(context);
        }
    }

    // 5
    private async Task HandleProviderStateRequest(HttpContext context)
    {
        context.Response.StatusCode = (int)HttpStatusCode.OK;

        if (context.Request.Method.ToUpper() == HttpMethod.Post.ToString().ToUpper())
        {
            string body;
            using (var reader = new StreamReader(context.Request.Body, Encoding.UTF8))
            {
                body = await reader.ReadToEndAsync();
            }
            var providerState = JsonSerializer.Deserialize<ProviderState>(body);
            if (!string.IsNullOrEmpty(providerState?.State))
            {
                _providerStates[providerState.State].Invoke();
            }
        }
    }

    // 6
    private void MockData(int id)
    {
        _dbContext.Add(new Product { Id = id, Name = "A cool product", Price = 10.5, Location = "Cool Store #12345" });
        _dbContext.SaveChanges();
    }
}
```

Just like any other middleware, HTTP requests will now hit this middleware first before being routed to the server (the Pact server, in this case).

There's a bit going on here, so like before, let's break it down into steps:

1. The `ProviderState` record is the shape of the Pact request our middleware receives from Pact. While not required, having a type for it allows us to be type safe with our logic.

2. The `RequestDelegate` we assign is something you'll see in any middleware, and isn't specific to Pact. It forwards the request down the pipeline to the next middleware (which is why it's called `_next`), or to the server if there aren't any more.

3. The providerStates dictionary is where our Pact logic comes into play. In this case, we're just keeping track of a list of specific strings, and if the provider state matches one of them, we run a specific function to set up data. We'll see this in the `HandleProviderStateRequest` method of the middleware.

4. `Invoke()` is the entry point to our middleware and isn't something you directly call yourself. This method will be called implicitly when your middleware is executed. This middleware is now in your request pipeline, so it's executed on every request. However, we only care about the URL we assigned earlier, which was `/provider-states`, so we just do nothing if it doesn't match that URL. If it does, we execute our logic inside `HandleProviderStateRequest()`.

5. In `HandleProviderStateRequest()`, we parse the JSON body into a `ProviderState` object. For this test, here's the body that Pact sends our middleware:

```json
{
    "action": "setup",
    "params": {},
    "state": "There is a product with id 1"
}
```

We'll look at `params` later, but the value we care about for now is `state`. As you can see, this is the value that originally came from the consumer's test. Perhaps the two teams spoke and decided that this would be an acceptable string to give for a state value. We'll handle this state by inserting a product with an id of 1 into our containerized database. We do this by looking at the `_providerStates` dictionary defined earlier, and if the state matches any of the keys in it, we execute the value, which in this case is `MockData()`.

6. `MockData()` itself is a pretty simple function that just inserts a single record into the Product table of our containerized database. Since we replaced the connection string for the `ProductContext` with the one of our containerized database, this is the actual data that ends up getting fetched by the `ProductService`.

With our middleware in place, let's now run the provider test again. With our database and an inserted record now in place, our test now passes!

Of course, if you don't like the dictionary approach, you're free to do it any other way you please. Eventually, you'll probably decide that's not a scalable enough approach and use something else. Anything is fine as long as it inserts data into your data source depending on the provider state.

### Improving with state parameters

As you may have already thought to yourself, using a static string may not be the most flexible solution. While you _could_ make that work with some kind of templating, Pact offers something easier in the form of provider state parameters. This will be the topic of the next post.

### Github example

You can find a full working example of this at the following Github repository: [https://github.com/danielwarddev/ContractTestingCSharp](https://github.com/danielwarddev/ContractTestingCSharp)
