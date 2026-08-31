# Testing .NET Aspire Applications – Introduction to Aspire Testing

**Date:** February 24, 2026  
**Author:** Daniel Ward  
**URL:** https://daninacan.com/testing-dotnet-aspire-applications-introduction-to-aspire-testing/

_This post is part of a series on testing .NET Aspire applications:_

-   **Testing .NET Aspire Applications – Introduction to Aspire Testing** (this post)
-   [Testing .NET Aspire Applications – Integration Testing with DistributedApplicationTestingBuilder](https://daninacan.com/testing-dotnet-aspire-applications-integration-testing-with-distributedapplicationtestingbuilder/)
-   [Testing .NET Aspire Applications – Testing with Real Dependencies Using TestContainers](https://daninacan.com/testing-dotnet-aspire-applications-testing-with-real-dependencies-using-testcontainers/)
-   [Testing .NET Aspire Applications – Mocking External Services and APIs](https://daninacan.com/testing-dotnet-aspire-applications-mocking-external-services-and-apis/)
-   [Testing .NET Aspire Applications – Testing Observability and Health Checks](https://daninacan.com/testing-dotnet-aspire-applications-testing-observability-and-health-checks/)

---

## Overview

.NET Aspire is Microsoft's new framework for building cloud-native, distributed applications. It simplifies orchestration, service discovery, configuration, and observability. But when your application becomes a collection of interconnected services, databases, and caches, how do you test it?

In this series, we'll explore testing strategies for .NET Aspire applications – from unit testing individual components to integration testing the entire distributed system. This first post introduces Aspire's architecture and testing philosophy.

## What is .NET Aspire?

If you're new to Aspire, here's a quick overview. .NET Aspire provides:

1. **App Host** – Orchestrates your distributed application
2. **Service Defaults** – Pre-configured patterns for resilience, health checks, and telemetry
3. **Components** – NuGet packages for common infrastructure (Redis, PostgreSQL, RabbitMQ, etc.)
4. **Tooling** – Dashboard for observability, debugging, and management

A typical Aspire solution looks like:

```
MySolution/
├── MyApp.AppHost/          # Orchestration project
├── MyApp.ServiceDefaults/  # Shared configuration
├── MyApp.ApiService/       # Your API project
├── MyApp.Web/              # Frontend project
└── MyApp.Tests/            # Test project
```

The **AppHost** is where you define your distributed application:

```csharp
var builder = DistributedApplication.CreateBuilder(args);

var cache = builder.AddRedis("cache");
var postgres = builder.AddPostgres("db").AddDatabase("mydb");

var apiService = builder.AddProject<Projects.MyApp_ApiService>("apiservice")
    .WithReference(cache)
    .WithReference(postgres);

builder.AddProject<Projects.MyApp_Web>("webfrontend")
    .WithExternalHttpEndpoints()
    .WithReference(apiService);

builder.Build().Run();
```

## The Testing Challenge

Testing distributed applications is inherently more complex than testing monolithic apps:

| Challenge | Description |
|-----------|-------------|
| **Multiple services** | Tests may need to spin up several services |
| **Infrastructure dependencies** | Databases, caches, message queues |
| **Service discovery** | Services need to find each other |
| **Configuration** | Environment-specific settings |
| **Observability** | Verifying telemetry, logs, metrics |

.NET Aspire provides tooling to help with all of these.

## Aspire's Testing Building Blocks

### 1. DistributedApplicationTestingBuilder

Aspire 8.0+ includes `Aspire.Hosting.Testing` with a testing builder that lets you spin up your entire distributed application in tests:

```csharp
var appHost = await DistributedApplicationTestingBuilder
    .CreateAsync<Projects.MyApp_AppHost>();

await using var app = await appHost.BuildAsync();
await app.StartAsync();
```

This is powerful because it uses your actual AppHost project, ensuring tests match production configuration.

### 2. Resource Access

Once your app is running, you can get connection strings, endpoints, and clients:

```csharp
var httpClient = app.CreateHttpClient("apiservice");
var connectionString = await app.GetConnectionStringAsync("mydb");
```

### 3. Integration with TestContainers

While Aspire can spin up containers for you, you can also use TestContainers for more control over test isolation and cleanup.

## Testing Levels for Aspire Applications

I recommend a layered testing approach:

### Level 1: Unit Tests (Component Level)

Test individual services in isolation. Mock their dependencies.

```csharp
public class OrderServiceTests
{
    private readonly Mock<IOrderRepository> _repoMock = new();
    private readonly OrderService _sut;

    public OrderServiceTests()
    {
        _sut = new OrderService(_repoMock.Object);
    }

    [Fact]
    public async Task GetOrder_WithValidId_ReturnsOrder()
    {
        _repoMock.Setup(r => r.GetByIdAsync(1))
            .ReturnsAsync(new Order { Id = 1 });

        var result = await _sut.GetOrderAsync(1);

        result.Should().NotBeNull();
        result.Id.Should().Be(1);
    }
}
```

**When:** Always. These are fast and reliable.

### Level 2: Service Integration Tests

Test a single service with real (containerized) dependencies.

```csharp
public class OrderServiceIntegrationTests : IAsyncLifetime
{
    private PostgreSqlContainer _postgres = null!;
    private WebApplicationFactory<Program> _factory = null!;

    public async Task InitializeAsync()
    {
        _postgres = new PostgreSqlBuilder().Build();
        await _postgres.StartAsync();
        
        _factory = new WebApplicationFactory<Program>()
            .WithWebHostBuilder(builder =>
            {
                builder.ConfigureServices(services =>
                {
                    // Replace connection string with container's
                    services.AddDbContext<AppDbContext>(options =>
                        options.UseNpgsql(_postgres.GetConnectionString()));
                });
            });
    }

    [Fact]
    public async Task CreateOrder_PersistsToDatabase()
    {
        var client = _factory.CreateClient();
        
        var response = await client.PostAsJsonAsync("/orders", new CreateOrderRequest());
        
        response.Should().BeSuccessful();
        // Verify in database...
    }

    public async Task DisposeAsync()
    {
        await _postgres.DisposeAsync();
        await _factory.DisposeAsync();
    }
}
```

**When:** For testing service-specific behavior with real infrastructure.

### Level 3: Distributed Application Tests

Test the entire Aspire application – all services, all infrastructure, all connections.

```csharp
public class DistributedAppTests : IAsyncLifetime
{
    private DistributedApplication _app = null!;

    public async Task InitializeAsync()
    {
        var appHost = await DistributedApplicationTestingBuilder
            .CreateAsync<Projects.MyApp_AppHost>();
        
        _app = await appHost.BuildAsync();
        await _app.StartAsync();
    }

    [Fact]
    public async Task WebFrontend_CanCallApiService()
    {
        var client = _app.CreateHttpClient("webfrontend");
        
        var response = await client.GetAsync("/api/products");
        
        response.Should().BeSuccessful();
    }

    public async Task DisposeAsync()
    {
        await _app.DisposeAsync();
    }
}
```

**When:** For end-to-end scenarios that span multiple services.

## Setting Up Your Test Project

### 1. Create the Test Project

```bash
dotnet new xunit -o MyApp.Tests
cd MyApp.Tests
```

### 2. Add Required Packages

```bash
# Aspire testing support
dotnet add package Aspire.Hosting.Testing

# Fluent assertions
dotnet add package FluentAssertions

# TestContainers (if using)
dotnet add package Testcontainers.PostgreSql
dotnet add package Testcontainers.Redis
```

### 3. Reference Your Projects

```xml
<ItemGroup>
  <ProjectReference Include="..\MyApp.AppHost\MyApp.AppHost.csproj" />
  <ProjectReference Include="..\MyApp.ApiService\MyApp.ApiService.csproj" />
</ItemGroup>
```

### 4. Configure for Integration Tests

In your test project's settings, you may want longer timeouts:

```json
// xunit.runner.json
{
  "parallelizeTestCollections": false,
  "maxParallelThreads": 1
}
```

## What We'll Cover in This Series

Here's the roadmap for the rest of this series:

| Post | Topic |
|------|-------|
| **Part 2** | Integration testing with `DistributedApplicationTestingBuilder` – spinning up your full app in tests |
| **Part 3** | Testing with real dependencies using TestContainers – PostgreSQL, Redis, RabbitMQ |
| **Part 4** | Mocking external services and APIs – WireMock, stubbing HTTP clients |
| **Part 5** | Testing observability – health checks, OpenTelemetry traces, logs |

## Best Practices Preview

Throughout this series, we'll follow these principles:

1. **Test isolation** – Each test should be independent
2. **Real dependencies when practical** – Containers over mocks for infrastructure
3. **Fast feedback** – Parallelize unit tests, sequence integration tests
4. **Match production** – Use the same AppHost configuration in tests
5. **Observable tests** – Use Aspire Dashboard even in tests

## Summary

In this introduction, we covered:

- What .NET Aspire is and its core components
- The challenges of testing distributed applications
- Aspire's testing tools: `DistributedApplicationTestingBuilder`
- Three levels of testing: unit, service integration, and distributed
- How to set up your test project

In the next post, we'll dive deep into **integration testing with DistributedApplicationTestingBuilder** – learning how to spin up your complete Aspire application in tests and verify service-to-service communication.

## GitHub Example

You can find a full working example of this at the following GitHub repository: https://github.com/danielwarddev/AspireTestingExamples
