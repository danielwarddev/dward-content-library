# Part 3: Creating a clean test suite for C# integration tests

**Date:** January 28, 2024  
**Author:** Daniel Ward  
**URL:** https://daninacan.com/creating-a-clean-test-suite-for-c-integration-tests/

_This post is part 3 of a 3-part series:_

-   [Part 1: How to test a database in C# with TestContainers](https://daninacan.com/how-to-test-a-database-in-c-with-testcontainers/)
-   [Part 2: Resetting your test database in C# with Respawn](https://daninacan.com/resetting-your-test-database-in-c-with-respawn/)
-   _Part 3: Creating a clean test suite for C# integration tests_

### Overview

Now, we've got a test suite successfully running that uses a containerized database with our database provider of choice, and we also have the database being cleaned and reseeded after every test. Functionally, there's nothing left to do, but for maintainability, we can make our code a little cleaner to be more manageable in the long run.

### Base class for database tests

Since all of our tests will share some common requirements, such as setting up the `DbContext`, we can put them in a common class. In this case, I've called it `DatabaseTest`:

```csharp
[Collection(nameof(DatabaseTestCollection))]
public abstract class DatabaseTest : IAsyncLifetime
{
    private Func<Task> _resetDatabase;
    protected readonly ProductContext Db;
    protected readonly Fixture Fixture;

    public DatabaseTest(IntegrationTestFactory factory)
    {
        _resetDatabase = factory.ResetDatabase;
        Db = factory.Db;
        Fixture = new Fixture();
        Fixture.Customize(new NoCircularReferencesCustomization());
        Fixture.Customize(new IgnoreVirtualMembersCustomization());
    }

    public async Task Insert<T>(T entity) where T : class
    {
        await Db.AddAsync(entity);
        await Db.SaveChangesAsync();
    }

    public Task InitializeAsync() => Task.CompletedTask;

    public Task DisposeAsync() => _resetDatabase();
}
```

Even though this class is fairly small, it helps a lot in the long run as you create more classes for tests and have more common setup logic.

Here's the new `FavoriteServiceTests` from the previous post with `DatabaseTest` inherited:

```csharp
public class FavoriteServiceTests : DatabaseTest, IAsyncLifetime
{
    private readonly FavoriteService _service;
    private Product _existingProduct = null!;
    private User _existingUser = null!;

    public FavoriteServiceTests(IntegrationTestFactory factory) : base(factory)
    {
        _service = new FavoriteService(Db);
    }

    [Fact]
    public async Task When_User_Has_Not_Favorited_Product_Yet_Then_Inserts_Favorite_Record()
    {
        var expectedFavorite = new ProductFavorite
        {
            ProductId = _existingProduct.Id,
            UserId = _existingUser.Id
        };

        await _service.FavoriteProduct(_existingProduct.Id, _existingUser.Id);

        var allFavorites = Db.ProductFavorite.ToList();
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
        await Insert(new ProductFavorite
        {
            ProductId = _existingProduct.Id,
            UserId = _existingUser.Id
        });

        await _service.FavoriteProduct(_existingProduct.Id, _existingUser.Id);

        var allFavorites = Db.ProductFavorite.ToList();
        allFavorites.Should().ContainSingle();
    }

    public new async Task InitializeAsync()
    {
        await SeedDb();
    }

    private async Task SeedDb()
    {
        _existingProduct = Fixture.Create<Product>();
        _existingUser = Fixture.Create<User>();
        await Insert(_existingUser);
        await Insert(_existingProduct);
    }
}
```

The change was pretty simple, and we can even still override the `IAsyncLifetime` methods as needed – in this, to do some database seeding specific to the tests in this class.

### Other cleanup

Other than the new `DatabaseTest` class, I've also moved the common and setup classes into their own folder called Setup – for these posts, that's DatabaseTest.cs, IntegrationTestFactory.cs, and AutoFixtureExtensions.cs

### Github example

You can find a full working example of this at the following Github repository: https://github.com/danielwarddev/TestingWithDb
