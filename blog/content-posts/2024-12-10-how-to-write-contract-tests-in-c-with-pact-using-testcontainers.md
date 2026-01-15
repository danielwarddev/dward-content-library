# How to Write Contract Tests in C# With Pact – Using Testcontainers

**Date:** December 10, 2024  
**Author:** Daniel Ward  
**URL:** https://daninacan.com/how-to-write-contract-tests-in-c-with-pact-using-testcontainers/

_This post is part of a series on contract testing:_

-   [What contract testing is and why to write them](https://daninacan.com/what-contract-testing-is-and-why-to-write-them/)
-   [How to Write Contract Tests in C# With Pact – Consumer Tests](https://daninacan.com/how-to-write-contract-tests-in-c-with-pact-consumer-tests/)
-   [How to Write Contract Tests in C# With Pact – Provider Tests](https://daninacan.com/how-to-write-contract-tests-in-c-with-pact-provider-tests/)
-   [How to Write Contract Tests in C# With Pact – Provider States](https://daninacan.com/how-to-write-contract-tests-in-c-with-pact-provider-states/)
-   **(Optional) How to Write Contract Tests in C# With Pact – Using Testcontainers** (this post)
-   [How to Write Contract Tests in C# With Pact – Provider State Parameters](https://daninacan.com/how-to-write-contract-tests-in-c-with-pact-provider-state-parameters/)
-   [Writing Contract Tests in C# With Pact – Query Parameters](https://daninacan.com/writing-contract-tests-in-c-with-pact-query-parameters/)
-   [Writing Contract Tests in C# With Pact – Message Interactions](https://daninacan.com/writing-contract-tests-in-c-with-pact-message-interactions/)
-   [Writing Contract Tests in C# With Pact – Pact Brokers](https://daninacan.com/writing-contract-tests-in-c-with-pact-pact-brokers/)

---

### Overview

If you chose to use another option for a data source besides Testcontainers, you can skip this post. This is sort of a "bonus" post in the contract testing series that will show how to set up Testcontainers as your data source for contract tests, as well as Respawn to reset the data source between tests.

You don't have to use Testcontainers with Pact – you can set up or mock a data source in any way you like. Just like any other integration test, though, you'll need to set up something so that your database queries end up returning something that your business logic can work with.

I believe that Testcontainers is the best option for this in general (not just for Pact), so this is the method I'll be going with. I'll also being using Respawn to set the database back to a clean slate for each test run. This shorter post will just be showing the setup required to get Testcontainers and Respawn working with Pact.

For more information about Testcontainers in general, you can check out my series on that here: [Part 1: How to test a database in C# with TestContainers](https://daninacan.com/how-to-test-a-database-in-c-with-testcontainers/).

### Using Testcontainers and Respawn with Pact

The goal is for the `ProductApiFixture` to maintain a PostgreSQL container for us during the tests. This database will then be used to insert data into for the tests depending on the provider state.

We'll be using the existing Pact setup we have from the previous posts. I'll mark the code with numbered sections with the changes we need to make.

Note that, due to needing to call some async methods to set up Testcontainers, we now implement `IAsyncLifetime` and move our code out of the constructor and into `InitializeAsync()`.

```csharp
public class ProductApiFixture : IDisposable, IAsyncLifetime
{
    // Create a PostgreSQL container that Testcontainers will manage. Keep the DbConnection to close it and ProductContext to manipulate data
    private readonly PostgreSqlContainer _container = new PostgreSqlBuilder().WithCleanUp(true).Build();
    private Respawner _respawner = null!;
    private IHost _server = null!;
    private DbConnection _connection = null!;
    public ProductContext Db { get; private set; } = null!;
    public Uri PactServerUri { get; } = new ("http://localhost:26404");

    public async Task InitializeAsync()
    {
        // Start the container. This must be done before the host is set up so that we can get the connection string of the database in the container
        await _container.StartAsync();

        _server = Host.CreateDefaultBuilder()
            .ConfigureWebHostDefaults(builder =>
            {
                builder.UseUrls(PactServerUri.ToString());
                builder.UseStartup<TestStartup>();
            })
            .ConfigureServices(services =>
            {
                // Replace the normal ProductContext from Startup.cs with the one inside of the container
                services.ReplaceDbContext<ProductContext>(_container.GetConnectionString());

                // Pass in a method that allows us to reset the database from the middleware
                services.AddSingleton<Func<Task>>(_ => ResetDatabase);
            })
            .Build();

        // Assign our ProductContext and its connection, then open the connection
        Db = _server.Services.CreateScope().ServiceProvider.GetRequiredService<ProductContext>();
        _connection = Db.Database.GetDbConnection();
        await _connection.OpenAsync();
        _respawner = await Respawner.CreateAsync(_connection, new RespawnerOptions
        {
            DbAdapter = DbAdapter.Postgres,
            SchemasToInclude = ["public"]
        });

        _server.Start();
    }

    public async Task DisposeAsync()
    {
        // Close the connection and dispose of the container after the tests finish
        // If something crashes and we don't reach this point, Testcontainers will clean up for us, anyway
        await _connection.CloseAsync();
        await _container.DisposeAsync();
    }

    public void Dispose()
    {
        _server.Dispose();
    }

    // This will reset our containerized database to a clean state
    private async Task ResetDatabase()
    {
        await _respawner.ResetAsync(_connection);
    }
}

// This extension method isn't required, but makes our code a bit cleaner
public static class ServiceProviderExtensions
{
    public static IServiceCollection ReplaceDbContext<T>(this IServiceCollection services, string connectionString) where T : DbContext
    {
        services.RemoveAll<DbContextOptions<T>>();
        services.AddDbContext<T>(options =>
        {
            options.UseNpgsql(connectionString);
        });
        var scope = services.BuildServiceProvider().CreateScope();
        var dbContext = scope.ServiceProvider.GetRequiredService<ProductContext>();
        dbContext.Database.EnsureCreated();
        return services;
    }
}
```

❗ There is a bit of a catch with Pact and resetting state, which is why we have the `ResetDatabase()` method. Normally, with integration tests, you'd reset your database to a clean slate either in the setup or teardown between each test. You can't do that with Pact, because **the provider test is only one test for the entire pact file**. There is only a single setup and teardown on xUnit's side for the entire file. Thus, unfortunately, we cannot use xUnit's `DisposeAsync()` to reset our Testcontainers database.

We can still reset our database between tests, though – we just have to do it in our `ProviderStateMiddleware`. Since we're injecting the function to reset the database into the middleware, this is now possible. Now, we just call this method at the beginning of `HandleProviderStateRequest()`, since that method will be hit every time the `/provider-state` endpoint is hit, which happens for every interaction in the pact file:

Our `ProviderStateMiddleware` will have the following changes:

```csharp
...
// The resetDatabase function is now passed in to the constructor
public ProviderStateMiddleware(RequestDelegate next, Func<Task> resetDatabase)
{
    ...
    _resetDatabase = resetDatabase;
    ...
}
...
// resetDatabase is called every time the middleware is hit to reset our database to a clean slate
private async Task HandleProviderStateRequest(HttpContext context)
{
    await _resetDatabase();
    ...
}
...
```

And we're finished! The provider's contract tests will now use Testcontainers as its data source, as well as Respawn to reset that data source between each test case.

### Github example

You can find a full working example of this at the following Github repository: [https://github.com/danielwarddev/ContractTestingCSharp](https://github.com/danielwarddev/ContractTestingCSharp)
