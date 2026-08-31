# Testing .NET Aspire Applications – Integration Testing with DistributedApplicationTestingBuilder

**Date:** March 3, 2026  
**Author:** Daniel Ward  
**URL:** https://daninacan.com/testing-dotnet-aspire-applications-integration-testing-with-distributedapplicationtestingbuilder/

_This post is part of a series on testing .NET Aspire applications:_

-   [Testing .NET Aspire Applications – Introduction to Aspire Testing](https://daninacan.com/testing-dotnet-aspire-applications-introduction-to-aspire-testing/)
-   **Testing .NET Aspire Applications – Integration Testing with DistributedApplicationTestingBuilder** (this post)
-   [Testing .NET Aspire Applications – Testing with Real Dependencies Using TestContainers](https://daninacan.com/testing-dotnet-aspire-applications-testing-with-real-dependencies-using-testcontainers/)
-   [Testing .NET Aspire Applications – Mocking External Services and APIs](https://daninacan.com/testing-dotnet-aspire-applications-mocking-external-services-and-apis/)
-   [Testing .NET Aspire Applications – Testing Observability and Health Checks](https://daninacan.com/testing-dotnet-aspire-applications-testing-observability-and-health-checks/)

---

## Overview

In the previous post, we introduced testing concepts for .NET Aspire. Now let's get practical. The `DistributedApplicationTestingBuilder` is Aspire's primary tool for integration testing – it lets you spin up your entire distributed application in tests using the same AppHost configuration as production.

In this post, we'll learn how to use `DistributedApplicationTestingBuilder` to test service-to-service communication, verify connections, and write maintainable integration tests.

## Prerequisites

Make sure you have the Aspire testing package:

```bash
dotnet add package Aspire.Hosting.Testing
```

And reference your AppHost project:

```xml
<ProjectReference Include="..\MyApp.AppHost\MyApp.AppHost.csproj" />
```

## Your First Distributed Application Test

Let's start with a basic example. Assume you have an AppHost like this:

```csharp
// MyApp.AppHost/Program.cs
var builder = DistributedApplication.CreateBuilder(args);

var apiService = builder.AddProject<Projects.MyApp_ApiService>("apiservice");

builder.AddProject<Projects.MyApp_Web>("webfrontend")
    .WithExternalHttpEndpoints()
    .WithReference(apiService);

builder.Build().Run();
```

Here's how to test it:

```csharp
using Aspire.Hosting.Testing;

public class DistributedAppTests : IAsyncLifetime
{
    private DistributedApplication _app = null!;

    public async Task InitializeAsync()
    {
        // Create and build the app host
        var appHost = await DistributedApplicationTestingBuilder
            .CreateAsync<Projects.MyApp_AppHost>();
        
        _app = await appHost.BuildAsync();
        
        // Start all services
        await _app.StartAsync();
    }

    [Fact]
    public async Task ApiService_ReturnsSuccess()
    {
        // Get an HttpClient configured for the apiservice
        var client = _app.CreateHttpClient("apiservice");
        
        var response = await client.GetAsync("/health");
        
        response.Should().BeSuccessful();
    }

    public async Task DisposeAsync()
    {
        await _app.DisposeAsync();
    }
}
```

When `StartAsync()` is called, Aspire spins up all your services and their dependencies. The test then uses `CreateHttpClient()` to get an HTTP client pre-configured with the correct base address for the named service.

## Understanding Resource Lifetimes

### The Testing Builder Pattern

```csharp
var appHost = await DistributedApplicationTestingBuilder
    .CreateAsync<Projects.MyApp_AppHost>();
```

This creates a **builder** from your AppHost project. The `<Projects.MyApp_AppHost>` is a source-generated type that references your AppHost.

### Building and Starting

```csharp
_app = await appHost.BuildAsync();
await _app.StartAsync();
```

- `BuildAsync()` constructs the distributed application
- `StartAsync()` spins up all resources (services, containers, executables)

### Cleanup

Always dispose to stop services and free resources:

```csharp
await _app.DisposeAsync();
```

Using `IAsyncLifetime` ensures proper async cleanup in xUnit.

## Getting Resources and Connections

### HTTP Clients

For projects with HTTP endpoints:

```csharp
var apiClient = _app.CreateHttpClient("apiservice");
var webClient = _app.CreateHttpClient("webfrontend");
```

### Connection Strings

For databases and other resources:

```csharp
var postgresConnectionString = await _app.GetConnectionStringAsync("postgres");
var redisConnectionString = await _app.GetConnectionStringAsync("cache");
```

### Resource Endpoints

For other resource types:

```csharp
var resourceNotificationService = _app.Services
    .GetRequiredService<ResourceNotificationService>();

await resourceNotificationService
    .WaitForResourceAsync("apiservice", KnownResourceStates.Running);
```

## Testing Service-to-Service Communication

One of Aspire's strengths is service discovery. Let's test that services can communicate:

```csharp
public class ServiceCommunicationTests : IAsyncLifetime
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
        // The web frontend calls the API service internally
        var webClient = _app.CreateHttpClient("webfrontend");
        
        // This endpoint on webfrontend calls apiservice behind the scenes
        var response = await webClient.GetAsync("/products");
        
        response.Should().BeSuccessful();
        
        var products = await response.Content
            .ReadFromJsonAsync<List<ProductDto>>();
        products.Should().NotBeNullOrEmpty();
    }

    [Fact]
    public async Task ApiService_CanAccessDatabase()
    {
        var apiClient = _app.CreateHttpClient("apiservice");
        
        // POST creates a record in the database
        var createResponse = await apiClient.PostAsJsonAsync("/products", 
            new { Name = "Test Product", Price = 9.99 });
        createResponse.Should().BeSuccessful();
        
        var created = await createResponse.Content
            .ReadFromJsonAsync<ProductDto>();
        
        // GET retrieves it from the database
        var getResponse = await apiClient.GetAsync($"/products/{created!.Id}");
        getResponse.Should().BeSuccessful();
        
        var retrieved = await getResponse.Content
            .ReadFromJsonAsync<ProductDto>();
        retrieved!.Name.Should().Be("Test Product");
    }

    public async Task DisposeAsync() => await _app.DisposeAsync();
}
```

## Configuring the Test Application

You can modify the AppHost configuration for tests:

### Adding Arguments

```csharp
var appHost = await DistributedApplicationTestingBuilder
    .CreateAsync<Projects.MyApp_AppHost>(args: ["--environment", "Testing"]);
```

### Modifying Configuration

```csharp
var appHost = await DistributedApplicationTestingBuilder
    .CreateAsync<Projects.MyApp_AppHost>();

appHost.Services.ConfigureHttpClientDefaults(http =>
{
    http.AddStandardResilienceHandler();
});
```

### Waiting for Resources

By default, `CreateHttpClient` waits for the resource to be running. You can customize:

```csharp
// Wait explicitly
var resourceNotification = _app.Services
    .GetRequiredService<ResourceNotificationService>();

await resourceNotification.WaitForResourceAsync(
    "apiservice", 
    KnownResourceStates.Running,
    timeout: TimeSpan.FromMinutes(2));

// Then get the client
var client = _app.CreateHttpClient("apiservice", waitForReady: false);
```

## Sharing Application Across Tests

Starting the distributed application for every test is slow. For test classes that don't modify state, share the app:

### Using Class Fixtures

```csharp
public class AppHostFixture : IAsyncLifetime
{
    public DistributedApplication App { get; private set; } = null!;

    public async Task InitializeAsync()
    {
        var appHost = await DistributedApplicationTestingBuilder
            .CreateAsync<Projects.MyApp_AppHost>();
        App = await appHost.BuildAsync();
        await App.StartAsync();
    }

    public async Task DisposeAsync()
    {
        await App.DisposeAsync();
    }
}

public class ProductTests : IClassFixture<AppHostFixture>
{
    private readonly DistributedApplication _app;

    public ProductTests(AppHostFixture fixture)
    {
        _app = fixture.App;
    }

    [Fact]
    public async Task GetProducts_ReturnsProducts()
    {
        var client = _app.CreateHttpClient("apiservice");
        var response = await client.GetAsync("/products");
        response.Should().BeSuccessful();
    }

    [Fact]
    public async Task GetProduct_WithInvalidId_Returns404()
    {
        var client = _app.CreateHttpClient("apiservice");
        var response = await client.GetAsync("/products/99999");
        response.StatusCode.Should().Be(HttpStatusCode.NotFound);
    }
}
```

### Collection Fixtures for Multiple Test Classes

```csharp
[CollectionDefinition("Aspire")]
public class AspireCollection : ICollectionFixture<AppHostFixture> { }

[Collection("Aspire")]
public class OrderTests
{
    private readonly DistributedApplication _app;
    
    public OrderTests(AppHostFixture fixture) => _app = fixture.App;
    
    // tests...
}

[Collection("Aspire")]
public class CustomerTests
{
    private readonly DistributedApplication _app;
    
    public CustomerTests(AppHostFixture fixture) => _app = fixture.App;
    
    // tests...
}
```

## Handling Startup Failures

Distributed apps have many moving parts. Handle failures gracefully:

```csharp
public async Task InitializeAsync()
{
    try
    {
        var appHost = await DistributedApplicationTestingBuilder
            .CreateAsync<Projects.MyApp_AppHost>();
        
        _app = await appHost.BuildAsync();
        await _app.StartAsync();
    }
    catch (Exception ex)
    {
        throw new InvalidOperationException(
            $"Failed to start distributed application: {ex.Message}", ex);
    }
}
```

### Checking Resource Health

```csharp
[Fact]
public async Task AllServices_AreHealthy()
{
    var services = new[] { "apiservice", "webfrontend" };

    foreach (var service in services)
    {
        var client = _app.CreateHttpClient(service);
        var response = await client.GetAsync("/health");
        
        response.Should().BeSuccessful(
            because: $"{service} should be healthy");
    }
}
```

## Debugging Tips

### Enable Detailed Logging

```csharp
var appHost = await DistributedApplicationTestingBuilder
    .CreateAsync<Projects.MyApp_AppHost>();

appHost.Services.AddLogging(logging =>
{
    logging.SetMinimumLevel(LogLevel.Debug);
    logging.AddConsole();
});
```

### Use the Aspire Dashboard

Even in tests, you can launch the dashboard:

```csharp
// The dashboard URL is available after starting
var dashboardUrls = _app.GetDashboardUrls();
```

### Capture Service Logs

```csharp
// In your AppHost, enable logging capture
builder.Services.AddLogging(logging =>
{
    logging.AddTestOutput(testOutputHelper); // If using xUnit's ITestOutputHelper
});
```

## Common Patterns

### Base Class for Integration Tests

```csharp
public abstract class IntegrationTestBase : IAsyncLifetime
{
    protected DistributedApplication App { get; private set; } = null!;
    
    protected HttpClient ApiClient => App.CreateHttpClient("apiservice");
    protected HttpClient WebClient => App.CreateHttpClient("webfrontend");

    public async Task InitializeAsync()
    {
        var appHost = await DistributedApplicationTestingBuilder
            .CreateAsync<Projects.MyApp_AppHost>();
        App = await appHost.BuildAsync();
        await App.StartAsync();
    }

    public async Task DisposeAsync() => await App.DisposeAsync();
}

public class ProductApiTests : IntegrationTestBase
{
    [Fact]
    public async Task CreateProduct_ReturnsCreatedProduct()
    {
        var response = await ApiClient.PostAsJsonAsync("/products", 
            new { Name = "Widget" });
        
        response.StatusCode.Should().Be(HttpStatusCode.Created);
    }
}
```

### Resetting State Between Tests

If tests modify data, you may need to reset between tests:

```csharp
[Fact]
public async Task Test_ThatModifiesData()
{
    // Arrange - seed test data
    await SeedTestData();
    
    // Act
    var response = await ApiClient.DeleteAsync("/products/1");
    
    // Assert
    response.Should().BeSuccessful();
    
    // Cleanup - reset for next test
    await CleanupTestData();
}
```

We'll explore this more in the TestContainers post.

## Summary

In this post, we learned how to use `DistributedApplicationTestingBuilder` to:

- Spin up an entire Aspire application in tests
- Get HTTP clients for services using `CreateHttpClient()`
- Get connection strings with `GetConnectionStringAsync()`
- Test service-to-service communication
- Share the application across tests using fixtures
- Handle startup failures and debug issues

In the next post, we'll explore **testing with real dependencies using TestContainers** – giving you more control over database state, isolation between tests, and faster feedback loops.

## GitHub Example

You can find a full working example of this at the following GitHub repository: https://github.com/danielwarddev/AspireTestingExamples
