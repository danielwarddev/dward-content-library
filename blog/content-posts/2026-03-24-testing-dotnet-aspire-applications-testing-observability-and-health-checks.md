# Testing .NET Aspire Applications – Testing Observability and Health Checks

**Date:** March 24, 2026  
**Author:** Daniel Ward  
**URL:** https://daninacan.com/testing-dotnet-aspire-applications-testing-observability-and-health-checks/

_This post is part of a series on testing .NET Aspire applications:_

-   [Testing .NET Aspire Applications – Introduction to Aspire Testing](https://daninacan.com/testing-dotnet-aspire-applications-introduction-to-aspire-testing/)
-   [Testing .NET Aspire Applications – Integration Testing with DistributedApplicationTestingBuilder](https://daninacan.com/testing-dotnet-aspire-applications-integration-testing-with-distributedapplicationtestingbuilder/)
-   [Testing .NET Aspire Applications – Testing with Real Dependencies Using TestContainers](https://daninacan.com/testing-dotnet-aspire-applications-testing-with-real-dependencies-using-testcontainers/)
-   [Testing .NET Aspire Applications – Mocking External Services and APIs](https://daninacan.com/testing-dotnet-aspire-applications-mocking-external-services-and-apis/)
-   **Testing .NET Aspire Applications – Testing Observability and Health Checks** (this post)

---

## Overview

Aspire applications come with built-in observability – health checks, OpenTelemetry tracing, metrics, and logging. But how do you verify these are actually working? In production, a missing health check or broken telemetry can cause deployment failures or blind spots in monitoring.

In this final post, we'll learn how to test health checks, verify OpenTelemetry instrumentation, and ensure your logging works correctly.

## Why Test Observability?

| Issue | Impact |
|-------|--------|
| **Broken health checks** | Kubernetes kills healthy pods |
| **Missing traces** | Can't debug production issues |
| **Wrong metrics** | False alarms or missed alerts |
| **Missing logs** | No audit trail |

Testing observability catches these issues before production.

## Testing Health Checks

ASP.NET Core health checks are exposed at `/health` by default in Aspire projects.

### Basic Health Check Test

```csharp
public class HealthCheckTests : IAsyncLifetime
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

    public async Task DisposeAsync() => await _app.DisposeAsync();
}
```

### Testing Specific Health Check Statuses

Use the `/health/ready` and `/health/live` endpoints for granular checks:

```csharp
[Fact]
public async Task ApiService_ReadinessCheck_ReturnsHealthy()
{
    var client = _app.CreateHttpClient("apiservice");
    
    var response = await client.GetAsync("/health/ready");
    
    response.Should().BeSuccessful();
    
    var content = await response.Content.ReadAsStringAsync();
    content.Should().Be("Healthy");
}

[Fact]
public async Task ApiService_LivenessCheck_ReturnsHealthy()
{
    var client = _app.CreateHttpClient("apiservice");
    
    var response = await client.GetAsync("/health/live");
    
    response.Should().BeSuccessful();
}
```

### Testing Health Check Details

For detailed health check responses:

```csharp
[Fact]
public async Task ApiService_HealthCheck_ReturnsAllChecks()
{
    var client = _app.CreateHttpClient("apiservice");
    client.DefaultRequestHeaders.Accept.Add(
        new MediaTypeWithQualityHeaderValue("application/json"));
    
    var response = await client.GetAsync("/health");
    
    response.Should().BeSuccessful();
    
    var health = await response.Content
        .ReadFromJsonAsync<HealthCheckResponse>();
    
    health!.Status.Should().Be("Healthy");
    health.Entries.Should().ContainKey("database");
    health.Entries.Should().ContainKey("redis");
    health.Entries["database"].Status.Should().Be("Healthy");
}

public record HealthCheckResponse(
    string Status,
    Dictionary<string, HealthCheckEntry> Entries);

public record HealthCheckEntry(
    string Status,
    string? Description,
    TimeSpan Duration);
```

### Testing Degraded Health

Test that your app correctly reports degraded status:

```csharp
public class DegradedHealthTests : IAsyncLifetime
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
                    services.RemoveAll<DbContextOptions<AppDbContext>>();
                    services.AddDbContext<AppDbContext>(options =>
                        options.UseNpgsql(_postgres.GetConnectionString()));
                });
            });
    }

    [Fact]
    public async Task HealthCheck_WhenDatabaseStopped_ReportsDegraded()
    {
        var client = _factory.CreateClient();
        
        // Verify healthy first
        var healthyResponse = await client.GetAsync("/health");
        healthyResponse.Should().BeSuccessful();

        // Stop the database
        await _postgres.StopAsync();

        // Health check should fail or report degraded
        var degradedResponse = await client.GetAsync("/health");
        degradedResponse.StatusCode.Should().Be(HttpStatusCode.ServiceUnavailable);
    }

    public async Task DisposeAsync()
    {
        await _factory.DisposeAsync();
        await _postgres.DisposeAsync();
    }
}
```

## Testing OpenTelemetry Traces

Aspire projects include OpenTelemetry by default. Let's verify traces are being created.

### Capturing Traces in Tests

```csharp
public class TracingTests : IAsyncLifetime
{
    private List<Activity> _capturedActivities = null!;
    private ActivityListener _listener = null!;
    private WebApplicationFactory<Program> _factory = null!;
    private HttpClient _client = null!;

    public async Task InitializeAsync()
    {
        _capturedActivities = new List<Activity>();
        
        // Set up an activity listener to capture traces
        _listener = new ActivityListener
        {
            ShouldListenTo = source => source.Name.Contains("Microsoft.AspNetCore") ||
                                        source.Name.Contains("System.Net.Http") ||
                                        source.Name.Contains("MyApp"),
            Sample = (ref ActivityCreationOptions<ActivityContext> options) => 
                ActivitySamplingResult.AllDataAndRecorded,
            ActivityStarted = activity => _capturedActivities.Add(activity),
        };
        ActivitySource.AddActivityListener(_listener);

        _factory = new WebApplicationFactory<Program>();
        _client = _factory.CreateClient();
    }

    [Fact]
    public async Task GetProducts_CreatesTrace()
    {
        _capturedActivities.Clear();
        
        await _client.GetAsync("/products");

        _capturedActivities.Should().Contain(a => 
            a.OperationName.Contains("products") ||
            a.DisplayName.Contains("GET /products"));
    }

    [Fact]
    public async Task GetProducts_TraceContainsExpectedTags()
    {
        _capturedActivities.Clear();
        
        await _client.GetAsync("/products");

        var httpActivity = _capturedActivities
            .FirstOrDefault(a => a.Kind == ActivityKind.Server);
        
        httpActivity.Should().NotBeNull();
        httpActivity!.GetTagItem("http.method").Should().Be("GET");
        httpActivity.GetTagItem("http.route").Should().Be("/products");
        httpActivity.GetTagItem("http.status_code").Should().Be(200);
    }

    public Task DisposeAsync()
    {
        _listener.Dispose();
        _client.Dispose();
        _factory.Dispose();
        return Task.CompletedTask;
    }
}
```

### Testing Distributed Traces Across Services

In Aspire apps, verify trace context propagates between services:

```csharp
[Fact]
public async Task WebFrontend_ToApiService_PropagatesTraceContext()
{
    var activities = new List<Activity>();
    using var listener = new ActivityListener
    {
        ShouldListenTo = _ => true,
        Sample = (ref ActivityCreationOptions<ActivityContext> _) => 
            ActivitySamplingResult.AllDataAndRecorded,
        ActivityStarted = activity => activities.Add(activity)
    };
    ActivitySource.AddActivityListener(listener);

    var client = _app.CreateHttpClient("webfrontend");
    await client.GetAsync("/api/products"); // Calls apiservice internally

    // Find activities from both services
    var frontendActivity = activities.FirstOrDefault(a => 
        a.Source.Name.Contains("webfrontend"));
    var apiActivity = activities.FirstOrDefault(a => 
        a.Source.Name.Contains("apiservice"));

    frontendActivity.Should().NotBeNull();
    apiActivity.Should().NotBeNull();
    
    // Verify they share the same trace
    apiActivity!.TraceId.Should().Be(frontendActivity!.TraceId);
    apiActivity.ParentId.Should().NotBeNullOrEmpty();
}
```

### Testing Custom Spans

If you add custom instrumentation:

```csharp
// In your service
public class ProductService
{
    private static readonly ActivitySource ActivitySource = 
        new("MyApp.ProductService");

    public async Task<Product> GetProductAsync(int id)
    {
        using var activity = ActivitySource.StartActivity("GetProduct");
        activity?.SetTag("product.id", id);
        
        // ... implementation ...
    }
}

// In tests
[Fact]
public async Task GetProduct_CreatesCustomSpan()
{
    _capturedActivities.Clear();
    
    await _client.GetAsync("/products/1");

    var customActivity = _capturedActivities
        .FirstOrDefault(a => a.OperationName == "GetProduct");
    
    customActivity.Should().NotBeNull();
    customActivity!.GetTagItem("product.id").Should().Be(1);
}
```

## Testing Metrics

Aspire apps expose metrics that you can verify:

```csharp
public class MetricsTests : IAsyncLifetime
{
    private WebApplicationFactory<Program> _factory = null!;
    private MeterListener _meterListener = null!;
    private Dictionary<string, List<double>> _recordedMeasurements = null!;

    public async Task InitializeAsync()
    {
        _recordedMeasurements = new Dictionary<string, List<double>>();
        
        _meterListener = new MeterListener
        {
            InstrumentPublished = (instrument, listener) =>
            {
                if (instrument.Meter.Name.StartsWith("Microsoft.AspNetCore") ||
                    instrument.Meter.Name.StartsWith("MyApp"))
                {
                    listener.EnableMeasurementEvents(instrument);
                }
            }
        };
        
        _meterListener.SetMeasurementEventCallback<double>((instrument, measurement, tags, state) =>
        {
            if (!_recordedMeasurements.ContainsKey(instrument.Name))
                _recordedMeasurements[instrument.Name] = new List<double>();
            _recordedMeasurements[instrument.Name].Add(measurement);
        });

        _meterListener.Start();

        _factory = new WebApplicationFactory<Program>();
    }

    [Fact]
    public async Task GetProducts_RecordsRequestDurationMetric()
    {
        var client = _factory.CreateClient();
        
        await client.GetAsync("/products");

        // Give time for metrics to be recorded
        await Task.Delay(100);

        _recordedMeasurements.Should().ContainKey("http.server.request.duration");
        _recordedMeasurements["http.server.request.duration"].Should().NotBeEmpty();
    }

    public Task DisposeAsync()
    {
        _meterListener.Dispose();
        _factory.Dispose();
        return Task.CompletedTask;
    }
}
```

### Testing Custom Metrics

```csharp
// In your service
public class OrderService
{
    private static readonly Meter Meter = new("MyApp.Orders");
    private static readonly Counter<int> OrdersCreated = 
        Meter.CreateCounter<int>("orders.created", "orders", "Number of orders created");

    public async Task CreateOrderAsync(Order order)
    {
        // ... create order ...
        OrdersCreated.Add(1, new KeyValuePair<string, object?>("order.type", order.Type));
    }
}

// In tests
[Fact]
public async Task CreateOrder_IncrementsOrdersCreatedMetric()
{
    var ordersCreatedCount = 0;
    using var listener = new MeterListener();
    listener.InstrumentPublished = (instrument, l) =>
    {
        if (instrument.Name == "orders.created")
            l.EnableMeasurementEvents(instrument);
    };
    listener.SetMeasurementEventCallback<int>((_, measurement, _, _) => 
        ordersCreatedCount += measurement);
    listener.Start();

    var client = _factory.CreateClient();
    await client.PostAsJsonAsync("/orders", new CreateOrderRequest());

    await Task.Delay(100);
    
    ordersCreatedCount.Should().Be(1);
}
```

## Testing Logging

Verify your application logs correctly:

### Capturing Logs in Tests

```csharp
public class LoggingTests : IAsyncLifetime
{
    private List<LogEntry> _capturedLogs = null!;
    private WebApplicationFactory<Program> _factory = null!;

    public async Task InitializeAsync()
    {
        _capturedLogs = new List<LogEntry>();

        _factory = new WebApplicationFactory<Program>()
            .WithWebHostBuilder(builder =>
            {
                builder.ConfigureLogging(logging =>
                {
                    logging.ClearProviders();
                    logging.AddProvider(new TestLoggerProvider(_capturedLogs));
                });
            });
    }

    [Fact]
    public async Task GetProducts_LogsRequest()
    {
        var client = _factory.CreateClient();
        
        await client.GetAsync("/products");

        _capturedLogs.Should().Contain(log => 
            log.Message.Contains("Request") || 
            log.Message.Contains("products"));
    }

    [Fact]
    public async Task GetProducts_WhenNotFound_LogsWarning()
    {
        var client = _factory.CreateClient();
        
        await client.GetAsync("/products/99999");

        _capturedLogs.Should().Contain(log => 
            log.Level == LogLevel.Warning &&
            log.Message.Contains("not found"));
    }

    public Task DisposeAsync()
    {
        _factory.Dispose();
        return Task.CompletedTask;
    }
}

public record LogEntry(LogLevel Level, string Message, Exception? Exception);

public class TestLoggerProvider : ILoggerProvider
{
    private readonly List<LogEntry> _logs;
    
    public TestLoggerProvider(List<LogEntry> logs) => _logs = logs;
    
    public ILogger CreateLogger(string categoryName) => new TestLogger(_logs);
    
    public void Dispose() { }
}

public class TestLogger : ILogger
{
    private readonly List<LogEntry> _logs;
    
    public TestLogger(List<LogEntry> logs) => _logs = logs;
    
    public IDisposable? BeginScope<TState>(TState state) where TState : notnull => null;
    
    public bool IsEnabled(LogLevel logLevel) => true;
    
    public void Log<TState>(
        LogLevel logLevel, 
        EventId eventId, 
        TState state, 
        Exception? exception, 
        Func<TState, Exception?, string> formatter)
    {
        _logs.Add(new LogEntry(logLevel, formatter(state, exception), exception));
    }
}
```

### Testing Structured Logging

```csharp
[Fact]
public async Task CreateOrder_LogsOrderIdInStructuredFormat()
{
    var client = _factory.CreateClient();
    
    var response = await client.PostAsJsonAsync("/orders", 
        new CreateOrderRequest { CustomerId = 1 });
    var order = await response.Content.ReadFromJsonAsync<OrderDto>();

    _capturedLogs.Should().Contain(log => 
        log.Message.Contains(order!.Id.ToString()) &&
        log.Level == LogLevel.Information);
}
```

## Putting It All Together: Observability Test Suite

```csharp
public class ObservabilityTests : IAsyncLifetime
{
    private DistributedApplication _app = null!;
    private List<Activity> _traces = null!;
    private ActivityListener _traceListener = null!;

    public async Task InitializeAsync()
    {
        _traces = new List<Activity>();
        _traceListener = new ActivityListener
        {
            ShouldListenTo = _ => true,
            Sample = (ref ActivityCreationOptions<ActivityContext> _) => 
                ActivitySamplingResult.AllDataAndRecorded,
            ActivityStarted = a => _traces.Add(a)
        };
        ActivitySource.AddActivityListener(_traceListener);

        var appHost = await DistributedApplicationTestingBuilder
            .CreateAsync<Projects.MyApp_AppHost>();
        _app = await appHost.BuildAsync();
        await _app.StartAsync();
    }

    [Fact]
    public async Task AllServices_ExposeHealthEndpoints()
    {
        var services = new[] { "apiservice", "webfrontend" };
        
        foreach (var service in services)
        {
            var client = _app.CreateHttpClient(service);
            
            var health = await client.GetAsync("/health");
            var ready = await client.GetAsync("/health/ready");
            var live = await client.GetAsync("/health/live");
            
            health.Should().BeSuccessful($"{service}/health should return 200");
            ready.Should().BeSuccessful($"{service}/health/ready should return 200");
            live.Should().BeSuccessful($"{service}/health/live should return 200");
        }
    }

    [Fact]
    public async Task CrossServiceCall_CreatesDistributedTrace()
    {
        _traces.Clear();
        
        var client = _app.CreateHttpClient("webfrontend");
        await client.GetAsync("/api/products");

        var traceIds = _traces.Select(t => t.TraceId).Distinct().ToList();
        
        // All activities should share the same trace ID
        traceIds.Should().HaveCount(1, 
            because: "distributed trace should have single trace ID");
    }

    public async Task DisposeAsync()
    {
        _traceListener.Dispose();
        await _app.DisposeAsync();
    }
}
```

## Summary

In this final post of the Aspire testing series, we covered:

- **Health check testing** – verifying `/health`, `/health/ready`, `/health/live`
- **OpenTelemetry traces** – capturing and verifying spans and distributed traces
- **Metrics testing** – verifying counters and measurements
- **Logging tests** – capturing and asserting on log output

## Series Summary

Throughout this series, we've learned:

1. **Introduction** – Testing levels and strategy for Aspire apps
2. **DistributedApplicationTestingBuilder** – Spinning up full Aspire apps in tests
3. **TestContainers** – Isolated containers for databases and services
4. **Mocking External Services** – WireMock and fake implementations
5. **Observability** – Health checks, traces, metrics, and logs

With these tools and techniques, you can build comprehensive test suites for even the most complex distributed .NET Aspire applications.

## GitHub Example

You can find a full working example of this at the following GitHub repository: https://github.com/danielwarddev/AspireTestingExamples
