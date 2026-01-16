# Testing .NET Aspire Applications – Testing with Real Dependencies Using TestContainers

**Date:** March 10, 2026  
**Author:** Daniel Ward  
**URL:** https://daninacan.com/testing-dotnet-aspire-applications-testing-with-real-dependencies-using-testcontainers/

_This post is part of a series on testing .NET Aspire applications:_

-   [Testing .NET Aspire Applications – Introduction to Aspire Testing](https://daninacan.com/testing-dotnet-aspire-applications-introduction-to-aspire-testing/)
-   [Testing .NET Aspire Applications – Integration Testing with DistributedApplicationTestingBuilder](https://daninacan.com/testing-dotnet-aspire-applications-integration-testing-with-distributedapplicationtestingbuilder/)
-   **Testing .NET Aspire Applications – Testing with Real Dependencies Using TestContainers** (this post)
-   [Testing .NET Aspire Applications – Mocking External Services and APIs](https://daninacan.com/testing-dotnet-aspire-applications-mocking-external-services-and-apis/)
-   [Testing .NET Aspire Applications – Testing Observability and Health Checks](https://daninacan.com/testing-dotnet-aspire-applications-testing-observability-and-health-checks/)

---

## Overview

In the previous post, we used `DistributedApplicationTestingBuilder` to spin up our entire Aspire application. But sometimes you need more control – especially over databases and caches. You might want:

- Fresh database state for each test
- Specific data scenarios
- Faster startup times by running only what you need
- Parallel test execution with isolated containers

TestContainers gives you that control. In this post, we'll learn how to combine TestContainers with Aspire applications for flexible, isolated integration tests.

## Why TestContainers with Aspire?

Aspire already manages containers, so why use TestContainers separately?

| Aspire Default | TestContainers Advantage |
|----------------|--------------------------|
| Shared state across tests | Fresh container per test/class |
| Slower cleanup | Automatic cleanup after test |
| Full app startup | Test single service with real deps |
| Production-like config | Test-specific configuration |

The best approach: Use Aspire's testing builder for end-to-end tests, and TestContainers for focused service tests.

## Setting Up TestContainers

Install the packages you need:

```bash
dotnet add package Testcontainers
dotnet add package Testcontainers.PostgreSql
dotnet add package Testcontainers.Redis
dotnet add package Testcontainers.RabbitMq
```

## Testing a Single Service with TestContainers

Let's test an API service that uses PostgreSQL, without spinning up the entire Aspire app:

```csharp
public class OrderServiceTests : IAsyncLifetime
{
    private PostgreSqlContainer _postgres = null!;
    private WebApplicationFactory<Program> _factory = null!;
    private HttpClient _client = null!;

    public async Task InitializeAsync()
    {
        // Start PostgreSQL container
        _postgres = new PostgreSqlBuilder()
            .WithImage("postgres:16")
            .Build();
        await _postgres.StartAsync();

        // Create test server with containerized database
        _factory = new WebApplicationFactory<Program>()
            .WithWebHostBuilder(builder =>
            {
                builder.ConfigureServices(services =>
                {
                    // Remove the existing DbContext registration
                    var descriptor = services.SingleOrDefault(
                        d => d.ServiceType == typeof(DbContextOptions<AppDbContext>));
                    if (descriptor != null)
                        services.Remove(descriptor);

                    // Add DbContext with test container connection
                    services.AddDbContext<AppDbContext>(options =>
                        options.UseNpgsql(_postgres.GetConnectionString()));
                });
            });

        _client = _factory.CreateClient();
        
        // Ensure database is created
        using var scope = _factory.Services.CreateScope();
        var db = scope.ServiceProvider.GetRequiredService<AppDbContext>();
        await db.Database.MigrateAsync();
    }

    [Fact]
    public async Task CreateOrder_PersistsToDatabase()
    {
        var request = new CreateOrderRequest 
        { 
            CustomerId = 1, 
            Items = new[] { new OrderItem { ProductId = 1, Quantity = 2 } }
        };

        var response = await _client.PostAsJsonAsync("/orders", request);

        response.Should().BeSuccessful();
        
        // Verify in database
        using var scope = _factory.Services.CreateScope();
        var db = scope.ServiceProvider.GetRequiredService<AppDbContext>();
        var order = await db.Orders.FirstOrDefaultAsync();
        order.Should().NotBeNull();
        order!.CustomerId.Should().Be(1);
    }

    public async Task DisposeAsync()
    {
        _client.Dispose();
        await _factory.DisposeAsync();
        await _postgres.DisposeAsync();
    }
}
```

## Testing with Multiple Containers

Real services often have multiple dependencies. Here's how to set up PostgreSQL and Redis together:

```csharp
public class ProductServiceTests : IAsyncLifetime
{
    private PostgreSqlContainer _postgres = null!;
    private RedisContainer _redis = null!;
    private WebApplicationFactory<Program> _factory = null!;
    private HttpClient _client = null!;

    public async Task InitializeAsync()
    {
        // Start containers in parallel
        _postgres = new PostgreSqlBuilder().Build();
        _redis = new RedisBuilder().Build();
        
        await Task.WhenAll(
            _postgres.StartAsync(),
            _redis.StartAsync());

        _factory = new WebApplicationFactory<Program>()
            .WithWebHostBuilder(builder =>
            {
                builder.ConfigureServices(services =>
                {
                    // Configure PostgreSQL
                    services.RemoveAll<DbContextOptions<AppDbContext>>();
                    services.AddDbContext<AppDbContext>(options =>
                        options.UseNpgsql(_postgres.GetConnectionString()));

                    // Configure Redis
                    services.RemoveAll<IConnectionMultiplexer>();
                    services.AddSingleton<IConnectionMultiplexer>(
                        ConnectionMultiplexer.Connect(_redis.GetConnectionString()));
                });
            });

        _client = _factory.CreateClient();
    }

    [Fact]
    public async Task GetProduct_UsesCache()
    {
        // First call - cache miss, hits database
        var response1 = await _client.GetAsync("/products/1");
        response1.Should().BeSuccessful();

        // Second call - should hit cache
        var response2 = await _client.GetAsync("/products/1");
        response2.Should().BeSuccessful();

        // Verify cache was populated
        var redis = ConnectionMultiplexer.Connect(_redis.GetConnectionString());
        var cachedValue = await redis.GetDatabase().StringGetAsync("product:1");
        cachedValue.HasValue.Should().BeTrue();
    }

    public async Task DisposeAsync()
    {
        _client.Dispose();
        await _factory.DisposeAsync();
        await Task.WhenAll(
            _postgres.DisposeAsync().AsTask(),
            _redis.DisposeAsync().AsTask());
    }
}
```

## Using Respawn for Database Reset

If you share containers across tests in a class (for speed), use Respawn to reset data:

```csharp
public class OrderIntegrationTests : IAsyncLifetime
{
    private PostgreSqlContainer _postgres = null!;
    private WebApplicationFactory<Program> _factory = null!;
    private Respawner _respawner = null!;
    private HttpClient _client = null!;

    public async Task InitializeAsync()
    {
        _postgres = new PostgreSqlBuilder().Build();
        await _postgres.StartAsync();

        _factory = new WebApplicationFactory<Program>()
            .WithWebHostBuilder(builder =>
            {
                builder.ConfigureServices(services =>
                {
                    services.RemoveAll<DbContextOptions<AppDbContext>>();
                    services.AddDbContext<AppDbContext>(options =>
                        options.UseNpgsql(_postgres.GetConnectionString()));
                });
            });

        _client = _factory.CreateClient();

        // Run migrations
        using var scope = _factory.Services.CreateScope();
        var db = scope.ServiceProvider.GetRequiredService<AppDbContext>();
        await db.Database.MigrateAsync();

        // Set up Respawn
        await using var connection = new NpgsqlConnection(_postgres.GetConnectionString());
        await connection.OpenAsync();
        _respawner = await Respawner.CreateAsync(connection, new RespawnerOptions
        {
            DbAdapter = DbAdapter.Postgres,
            TablesToIgnore = new[] { new Table("__EFMigrationsHistory") }
        });
    }

    private async Task ResetDatabase()
    {
        await using var connection = new NpgsqlConnection(_postgres.GetConnectionString());
        await connection.OpenAsync();
        await _respawner.ResetAsync(connection);
    }

    [Fact]
    public async Task CreateOrder_IncreasesOrderCount()
    {
        await ResetDatabase();
        
        var response = await _client.PostAsJsonAsync("/orders", 
            new CreateOrderRequest { CustomerId = 1 });
        
        response.Should().BeSuccessful();
        
        var countResponse = await _client.GetAsync("/orders/count");
        var count = await countResponse.Content.ReadFromJsonAsync<int>();
        count.Should().Be(1);
    }

    [Fact]
    public async Task DeleteOrder_DecreasesOrderCount()
    {
        await ResetDatabase();
        
        // Create an order first
        var createResponse = await _client.PostAsJsonAsync("/orders", 
            new CreateOrderRequest { CustomerId = 1 });
        var order = await createResponse.Content.ReadFromJsonAsync<OrderDto>();
        
        // Delete it
        var deleteResponse = await _client.DeleteAsync($"/orders/{order!.Id}");
        
        deleteResponse.Should().BeSuccessful();
        
        var countResponse = await _client.GetAsync("/orders/count");
        var count = await countResponse.Content.ReadFromJsonAsync<int>();
        count.Should().Be(0);
    }

    public async Task DisposeAsync()
    {
        _client.Dispose();
        await _factory.DisposeAsync();
        await _postgres.DisposeAsync();
    }
}
```

## Testing Message Queues with RabbitMQ

For event-driven services using RabbitMQ or MassTransit:

```csharp
public class OrderEventTests : IAsyncLifetime
{
    private PostgreSqlContainer _postgres = null!;
    private RabbitMqContainer _rabbitmq = null!;
    private WebApplicationFactory<Program> _factory = null!;
    private HttpClient _client = null!;

    public async Task InitializeAsync()
    {
        _postgres = new PostgreSqlBuilder().Build();
        _rabbitmq = new RabbitMqBuilder()
            .WithImage("rabbitmq:3-management")
            .Build();

        await Task.WhenAll(
            _postgres.StartAsync(),
            _rabbitmq.StartAsync());

        _factory = new WebApplicationFactory<Program>()
            .WithWebHostBuilder(builder =>
            {
                builder.ConfigureServices(services =>
                {
                    services.RemoveAll<DbContextOptions<AppDbContext>>();
                    services.AddDbContext<AppDbContext>(options =>
                        options.UseNpgsql(_postgres.GetConnectionString()));

                    // Configure MassTransit with test container
                    services.RemoveAll<IBusControl>();
                    services.AddMassTransit(x =>
                    {
                        x.AddConsumer<OrderCreatedConsumer>();
                        x.UsingRabbitMq((context, cfg) =>
                        {
                            cfg.Host(_rabbitmq.Hostname, _rabbitmq.GetMappedPublicPort(5672), "/", h =>
                            {
                                h.Username("guest");
                                h.Password("guest");
                            });
                            cfg.ConfigureEndpoints(context);
                        });
                    });
                });
            });

        _client = _factory.CreateClient();
    }

    [Fact]
    public async Task CreateOrder_PublishesOrderCreatedEvent()
    {
        // Arrange - set up a consumer to capture the event
        var eventReceived = new TaskCompletionSource<OrderCreatedEvent>();
        
        // This would typically be done through MassTransit test harness
        // Simplified here for illustration
        
        // Act
        var response = await _client.PostAsJsonAsync("/orders", 
            new CreateOrderRequest { CustomerId = 1 });

        // Assert
        response.Should().BeSuccessful();
        
        // Wait for event with timeout
        var completed = await Task.WhenAny(
            eventReceived.Task, 
            Task.Delay(TimeSpan.FromSeconds(10)));
        
        completed.Should().Be(eventReceived.Task, 
            because: "OrderCreatedEvent should be published");
    }

    public async Task DisposeAsync()
    {
        _client.Dispose();
        await _factory.DisposeAsync();
        await Task.WhenAll(
            _postgres.DisposeAsync().AsTask(),
            _rabbitmq.DisposeAsync().AsTask());
    }
}
```

## Combining TestContainers with Aspire Testing Builder

You can use both approaches together – TestContainers for specific resources, Aspire for the rest:

```csharp
public class HybridTests : IAsyncLifetime
{
    private PostgreSqlContainer _postgres = null!;
    private DistributedApplication _app = null!;

    public async Task InitializeAsync()
    {
        // Start your own PostgreSQL container with specific configuration
        _postgres = new PostgreSqlBuilder()
            .WithImage("postgres:16")
            .WithDatabase("testdb")
            .WithUsername("testuser")
            .WithPassword("testpassword")
            .Build();
        await _postgres.StartAsync();

        // Configure Aspire to use our container
        var appHost = await DistributedApplicationTestingBuilder
            .CreateAsync<Projects.MyApp_AppHost>();

        // Override the connection string
        appHost.Configuration["ConnectionStrings:postgres"] = 
            _postgres.GetConnectionString();

        _app = await appHost.BuildAsync();
        await _app.StartAsync();
    }

    [Fact]
    public async Task ServiceCanAccessCustomDatabase()
    {
        var client = _app.CreateHttpClient("apiservice");
        
        var response = await client.GetAsync("/health");
        
        response.Should().BeSuccessful();
    }

    public async Task DisposeAsync()
    {
        await _app.DisposeAsync();
        await _postgres.DisposeAsync();
    }
}
```

## Test Fixture for Shared Containers

For performance, share containers across test classes:

```csharp
public class DatabaseFixture : IAsyncLifetime
{
    public PostgreSqlContainer Postgres { get; private set; } = null!;
    public RedisContainer Redis { get; private set; } = null!;

    public async Task InitializeAsync()
    {
        Postgres = new PostgreSqlBuilder()
            .WithImage("postgres:16")
            .Build();
        Redis = new RedisBuilder().Build();

        await Task.WhenAll(
            Postgres.StartAsync(),
            Redis.StartAsync());
    }

    public async Task DisposeAsync()
    {
        await Task.WhenAll(
            Postgres.DisposeAsync().AsTask(),
            Redis.DisposeAsync().AsTask());
    }
}

[CollectionDefinition("Database")]
public class DatabaseCollection : ICollectionFixture<DatabaseFixture> { }

[Collection("Database")]
public class ProductTests
{
    private readonly DatabaseFixture _fixture;

    public ProductTests(DatabaseFixture fixture) => _fixture = fixture;

    [Fact]
    public async Task Test_UsingSharedContainers()
    {
        var connectionString = _fixture.Postgres.GetConnectionString();
        // Use the shared container...
    }
}
```

## Best Practices

### 1. Use Specific Images

```csharp
// Good - explicit version
new PostgreSqlBuilder().WithImage("postgres:16").Build();

// Avoid - might break with updates
new PostgreSqlBuilder().Build(); // Uses latest
```

### 2. Start Containers in Parallel

```csharp
await Task.WhenAll(
    _postgres.StartAsync(),
    _redis.StartAsync(),
    _rabbitmq.StartAsync());
```

### 3. Dispose in Finally Blocks

```csharp
public async Task DisposeAsync()
{
    try
    {
        _client?.Dispose();
        if (_factory != null) await _factory.DisposeAsync();
    }
    finally
    {
        // Always clean up containers
        if (_postgres != null) await _postgres.DisposeAsync();
    }
}
```

### 4. Use Respawn for Shared Containers

When sharing containers, reset state between tests with Respawn.

## Summary

In this post, we learned how to:

- Test individual services with TestContainers instead of spinning up the whole Aspire app
- Configure WebApplicationFactory to use containerized dependencies
- Set up multiple containers (PostgreSQL, Redis, RabbitMQ) in parallel
- Use Respawn to reset database state between tests
- Combine TestContainers with Aspire's testing builder
- Share containers across tests with fixtures

In the next post, we'll explore **mocking external services and APIs** – using WireMock and other tools to simulate third-party dependencies without hitting real endpoints.

## GitHub Example

You can find a full working example of this at the following GitHub repository: https://github.com/danielwarddev/AspireTestingExamples
