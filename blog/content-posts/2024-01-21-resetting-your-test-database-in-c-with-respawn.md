# Part 2: Resetting your test database in C# with Respawn

**Date:** January 21, 2024  
**Author:** Daniel Ward  
**URL:** https://daninacan.com/resetting-your-test-database-in-c-with-respawn/

_This post is part 2 of a 3-part series:_

-   [Part 1: How to test a database in C# with TestContainers](https://daninacan.com/how-to-test-a-database-in-c-with-testcontainers/)
-   _Part 2: Resetting your test database in C# with Respawn_
-   [Part 3: Creating a clean test suite for C# integration tests](https://daninacan.com/creating-a-clean-test-suite-for-c-integration-tests/)

For our goal of setting up a containerized database for tests, it's important to be able to easily seed that database and reset it back to a clean slate. From the previous post, [How to test a database in C# with TestContainers](https://daninacan.com/how-to-test-a-database-in-c-with-testcontainers/), we now have an easy way to set up a containerized database for our tests. Next, we'll use a library called [Respawn](https://github.com/jbogard/Respawn) that allows us to quickly and easily reset our test database.

### Setting up Respawn to reset the test database

Respawn is designed to quickly reset test databases, allowing us to effectively seed our database for each test. This process involves:

-   Clearing the database before each test using Respawn
-   Seeding it with whatever data we want on a per-test (or set of tests) basis

_Note: if you're really curious about how Respawn works, you can look at this blog post from the creator Jimmy Bogard, [How Respawn Works](https://www.jimmybogard.com/how-respawn-works/), which describes the problem Respawn solves and goes into more depth how it solves it._

Let's get into the setup process, continuing with the `IntegrationTestFactory` from the previous post. Even though there's only a few new lines for Respawn, I'll include the whole class here for context's sake:

```csharp
public class IntegrationTestFactory : WebApplicationFactory<Program>, IAsyncLifetime
{
    private readonly PostgreSqlContainer _container = new PostgreSqlBuilder()
        .WithImage("postgres:latest") // You may want to change this to be the version your production db is on
        .WithDatabase("db")
        .WithUsername("postgres")
        .WithPassword("postgres")
        .WithWaitStrategy(Wait.ForUnixContainer().UntilCommandIsCompleted("pg_isready"))
        .WithCleanUp(true)
        .Build();

    public ProductContext Db { get; private set; } = null!;
    private Respawner _respawner = null!;
    private DbConnection _connection = null!;

    public async Task ResetDatabase()
    {
        await _respawner.ResetAsync(_connection);
    }

    public async Task InitializeAsync()
    {
        await _container.StartAsync();
        Db = Services.CreateScope().ServiceProvider.GetRequiredService<ProductContext>();
        _connection = Db.Database.GetDbConnection();
        await _connection.OpenAsync();
        _respawner = await Respawner.CreateAsync(_connection, new RespawnerOptions
        {
            DbAdapter = DbAdapter.Postgres,
            SchemasToInclude = new[] { "public" }
        });
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

There's only a few lines we're actually concerned about for Respawn:

-   We now define a Respawner at the top of our class
-   We provide a public `ResetDatabase()` method that calls `ResetAsync()` on it
-   We initialize the `_respawner` inside of the `InitializeAsync()` method using the `CreateAsync()` method. We specify that it's a Postgres database and that only the schema named public should be reset

### Using Respawn to reset the database before each test

To leverage this, simply have your test class inherit from `IAsyncLifetime` and call `ResetDatabase()` inside of the `DisposeAsync()` method. Let's look at the `FavoriteServiceTests` from the previous post, along with a second test demonstrating the avoidance of state bleed between tests:

```csharp
[Collection(nameof(DatabaseTestCollection))]
public class FavoriteServiceTests : IAsyncLifetime
{
    private readonly FavoriteService _service;
    private readonly ProductContext _dbContext;
    private Func<Task> _resetDatabase;
    private Product _existingProduct = null!;
    private User _existingUser = null!;

    public FavoriteServiceTests(IntegrationTestFactory factory)
    {
        _dbContext = factory.Db;
        _resetDatabase = factory.ResetDatabase;
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

    [Fact]
    public async Task When_User_Has_Already_Favorited_Product_Then_Does_Not_Insert_Another_Favorite_Record()
    {
        await _dbContext.AddAsync(new ProductFavorite
        {
            ProductId = _existingProduct.Id,
            UserId = _existingUser.Id
        });
        await _dbContext.SaveChangesAsync();

        await _service.FavoriteProduct(_existingProduct.Id, _existingUser.Id);

        var allFavorites = _dbContext.ProductFavorite.ToList();
        allFavorites.Should().ContainSingle();
    }

    private async Task SeedDb()
    {
        _existingProduct = new Product { Name = "Cool product" };
        _existingUser = new User { Name = "Cool dude" };
        await _dbContext.AddAsync(_existingUser);
        await _dbContext.AddAsync(_existingProduct);
        await _dbContext.SaveChangesAsync();
    }

    public Task DisposeAsync() => _resetDatabase();

    public Task InitializeAsync() => Task.CompletedTask;
}
```

The second test ensures that when a user favorites a product, if they have already favorited that product, another favorite record isn't inserted. To test this, we first need to insert a favorite record for the user, run our method, then make sure it didn't insert another one.

Our first test, however, _does_ insert a favorite record. This will make the second test fail when it tries to insert a favorite, which makes this a good use case to see if Respawn is working correctly. Respawn should wipe the database clean after each test so that everything works correctly. Run the tests and you'll see that this is the case.

Obviously, you could change how you seed the database depending on what each test or collection needs, making this solution fairly flexible. Respawn simply provides you with an easy, fast way to clean your database before every test run.

### Github example

You can find a full working example of this at the following Github repository: https://github.com/danielwarddev/TestingWithDb
