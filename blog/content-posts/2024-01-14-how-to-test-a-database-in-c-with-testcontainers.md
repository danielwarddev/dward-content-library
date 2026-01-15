# Part 1: How to test a database in C# with TestContainers

**Date:** January 14, 2024  
**Author:** Daniel Ward  
**URL:** https://daninacan.com/how-to-test-a-database-in-c-with-testcontainers/

_This post is part 1 of a 3-part series:_

-   _Part 1: How to test a database in C# with TestContainers_
-   [Part 2: Resetting your test database in C# with Respawn](https://daninacan.com/resetting-your-test-database-in-c-with-respawn/)
-   [Part 3: Creating a clean test suite for C# integration tests](https://daninacan.com/part-3-creating-a-clean-test-suite-for-c-integration-tests/)

### The problem

Whether you're using EF Core, Dappr, or something else, you probably want to write integration tests that involve using your database at some point. With EF Core, [there are a few testing options available for you out of the box](https://learn.microsoft.com/en-us/ef/core/testing/choosing-a-testing-strategy), each with its own pitfall. Summarized, they are:

-   **The in-memory provider.** Microsoft itself recommends you don't use this for testing.
-   **The SQLite provider.** A better choice than the above, but still (probably) not the same engine as your production database.
-   **Mocking DbContext and DbSet.** This works, but isn't applicable here, as it's not suitable for running integration tests since it uses mocked EF Core objects.
-   **Using the repository pattern and mocking the repository in your tests.** Akin to the above, it works for unit tests, but is still effectively mocking the EF Core part of your application.

Of these, the SQLite provider is probably the best option for integration tests. Unfortunately, it still has the significant drawback of not being your actual database engine as your production database.

Eventually, you'll probably run into the issue of either false positives or false negatives. Subtle differences between SQLite and your real database can cause queries to work on SQLite and not in production, or vice versa. If you've ever run into this, you'll understand the frustration and how long it can take to diagnose that.

### The solution

The ideal solution would be to spin up an actual database inside a Docker container with the same database engine used in production and run the tests against that. Unfortunately, that typically entails all the intricacies of creating a Dockerfile and managing the container lifecycle for the tests.

Enter [TestContainers](https://testcontainers.com/), a library made for this exact scenario! Using just code, we can have it spin up a Docker container, create a database in the container using using the engine of our choice, and run tests against that database. It even takes care of the lifecycle management of the container for us! This post will use Postgres, but TestContainers provides preconfigured container builders for many database engines, with the additional option to use a more generic builder for others.

**Keep in mind that since TestContainers creates actual Docker containers, you'll need Docker installed in both your local environment and your pipeline to run any tests that use it!**

### Using TestContainers for integration tests

Here's the code for how to set up TestContainers, which I've put it inside of a `WebApplicationFactory` since it's for integration testing. We also only want it to spin up one container and database for the entire test suite, so I've also created a [collection fixture](https://xunit.net/docs/shared-context) so that all this setup only happens once for the whole fixture, which you can put as many tests in as you like.

_Note: For the sake of brevity, I won't include the code for the ProductContext, its entities, and the service with how I'm using it. Check out the full example in Github repo below if you're interested in seeing everything together._

```csharp
[CollectionDefinition(nameof(DatabaseTestCollection))]
public class DatabaseTestCollection : ICollectionFixture<IntegrationTestFactory>
{ }

public class IntegrationTestFactory : WebApplicationFactory<Program>, IAsyncLifetime
{
    private readonly PostgreSqlContainer _container = new PostgreSqlBuilder()
        .WithImage("postgres:latest") // Change this to same version as your production dataabse!
        .WithCleanUp(true)
        .Build();

    public ProductContext Db { get; private set; } = null!;
    private DbConnection _connection = null!;

    public async Task InitializeAsync()
    {
        await _container.StartAsync();
        Db = Services.CreateScope().ServiceProvider.GetRequiredService<ProductContext>();
        _connection = Db.Database.GetDbConnection();
        await _connection.OpenAsync();
    }

    public new async Task DisposeAsync()
    {
        await _connection.CloseAsync();
        await _container.DisposeAsync();
    }

    protected override void ConfigureWebHost(IWebHostBuilder builder)
    {
        builder.ConfigureTestServices(services =>
        {
            services.RemoveDbContext<ProductContext>();
            services.AddDbContext<ProductContext>(options =>
            {
                options.UseNpgsql(_container.GetConnectionString());
            });
            services.EnsureDbCreated<ProductContext>();
        });
    }
}

public static class ServiceCollectionExtensions
{
    public static void RemoveDbContext<T>(this IServiceCollection services) where T : DbContext
    {
        var descriptor = services.SingleOrDefault(x => x.ServiceType == typeof(DbContextOptions<T>));
        if (descriptor != null)
        {
            services.Remove(descriptor);
        }
    }

    public static void EnsureDbCreated<T>(this IServiceCollection services) where T : DbContext
    {
        using var scope = services.BuildServiceProvider().CreateScope();
        var serviceProvider = scope.ServiceProvider;
        var context = serviceProvider.GetRequiredService<T>();
        context.Database.EnsureCreated();
    }
}
```

At the top of the class, we use the TestContainers library to create a `PostgreSqlContainer`. We do that with a builder pattern using the `PostgreSqlBuilder`.

We tell it to use the [latest version of the Postgres image on Docker Hub](https://hub.docker.com/_/postgres). Although this isn't required with the `PostgreSqlBuilder` (which [uses 15.1 by default](https://github.com/testcontainers/testcontainers-dotnet/blob/e33d7431820f69ea2eee5f8622a85792a33078f6/src/Testcontainers.PostgreSql/PostgreSqlBuilder.cs) at the time of this writing), it can be a good idea to specify the version. **You will want to change this to be the specific version your production database is running, just to be safe with ensuring behavior parity.**

While there are a few other values required, such as the database name, username, and password, the builders use sensible defaults for these, so that you don't have to specify all of them. Check the previous link to see the Github source to see the defaults. Of course, you are free to override these if you like, but I can't think of why you'd need to.

It's worth pointing out that, although the port is given a static value, this is the value for the container port, and the host port is given a different random value each time to avoid port conflicts. This is a nice bit of logic that TestContainers has built out for you so that you don't have to do it yourself.

Finally, `WithCleanup(true)` tells it to not only stop the container after the tests finish, but to remove it, as well.

### Running a test with TestContainers

Once TestContainers has been setup, seamlessly using it in your tests becomes easy. You can effectively ignore its existence and use your DbContext as normal.

Here's a simple test demonstrating the working container:

```csharp
[Collection(nameof(DatabaseTestCollection))]
public class FavoriteServiceTests
{
    private readonly FavoriteService _service;
    private readonly ProductContext _dbContext;
    private Product _existingProduct = null!;
    private User _existingUser = null!;

    public FavoriteServiceTests(IntegrationTestFactory factory)
    {
        _dbContext = factory.Db;
        _service = new FavoriteService(_dbContext);
    }

    [Fact]
    public async Task When_User_Has_Not_Favorited_Product_Yet_Then_Inserts_Favorite_Record()
    {
        await SeedDb();
        var expectedFavorite = new ProductFavorite
        {
            ProductId = _existingProduct.Id,
            UserId = _existingUser.Id
        };

        await _service.FavoriteProduct(1, 1);

        var allFavorites = _dbContext.ProductFavorite.ToList();
        allFavorites
            .Should().ContainSingle()
            .Which.Should().BeEquivalentTo(expectedFavorite, options => options
                .Excluding(x => x.Id)
                .Excluding(x => x.Product)
                .Excluding(x => x.User)
            );
    }

    private async Task SeedDb()
    {
        _existingProduct = new Product { Name = "Cool product" };
        _existingUser = new User { Name = "Cool dude" };
        await _dbContext.AddAsync(_existingUser);
        await _dbContext.AddAsync(_existingProduct);
        await _dbContext.SaveChangesAsync();
    }
}
```

Success! The test passes successfully, running against an actual Postgres database. Testcontainers also takes care of cleaning up the containers for us.

If we look at our containers, we can can see what TestContainers has set up for our tests:

In addition to our Postgres container, TestContainers also automatically creates the [Ryuk container](https://dotnet.testcontainers.org/api/resource-reaper/). This is the container in charge of disposing of all the other containers and knowing when to do so, after which it disposes of itself. If you keep on eye on these containers after your tests finish, you'll see them disappear after a brief delay.

### Github example

You can find a full working example of this at the following Github repository: https://github.com/danielwarddev/TestingWithDb
