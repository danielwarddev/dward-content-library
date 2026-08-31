# Testing .NET Aspire Applications – Mocking External Services and APIs

**Date:** March 17, 2026  
**Author:** Daniel Ward  
**URL:** https://daninacan.com/testing-dotnet-aspire-applications-mocking-external-services-and-apis/

_This post is part of a series on testing .NET Aspire applications:_

-   [Testing .NET Aspire Applications – Introduction to Aspire Testing](https://daninacan.com/testing-dotnet-aspire-applications-introduction-to-aspire-testing/)
-   [Testing .NET Aspire Applications – Integration Testing with DistributedApplicationTestingBuilder](https://daninacan.com/testing-dotnet-aspire-applications-integration-testing-with-distributedapplicationtestingbuilder/)
-   [Testing .NET Aspire Applications – Testing with Real Dependencies Using TestContainers](https://daninacan.com/testing-dotnet-aspire-applications-testing-with-real-dependencies-using-testcontainers/)
-   **Testing .NET Aspire Applications – Mocking External Services and APIs** (this post)
-   [Testing .NET Aspire Applications – Testing Observability and Health Checks](https://daninacan.com/testing-dotnet-aspire-applications-testing-observability-and-health-checks/)

---

## Overview

Your Aspire application doesn't exist in isolation. It likely calls external APIs – payment gateways, third-party services, identity providers, or partner APIs. You can't (and shouldn't) hit these real services in tests.

In this post, we'll explore strategies for mocking external services in Aspire integration tests using WireMock, fake HTTP handlers, and stub services.

## The Challenge with External Dependencies

External APIs present testing challenges:

| Challenge | Impact |
|-----------|--------|
| **Rate limits** | Tests might get throttled |
| **Costs** | Payment APIs charge per call |
| **Unreliable** | Flaky tests from network issues |
| **State** | Can't control external data |
| **Sensitive** | Real credentials in tests |

The solution: Replace external calls with controlled mocks during testing.

## Approach 1: WireMock for HTTP API Mocking

WireMock is a powerful tool for mocking HTTP APIs. It runs as a real HTTP server that you can program with expected requests and responses.

### Setting Up WireMock

```bash
dotnet add package WireMock.Net
```

### Basic WireMock Test

```csharp
using WireMock.Server;
using WireMock.RequestBuilders;
using WireMock.ResponseBuilders;

public class PaymentServiceTests : IAsyncLifetime
{
    private WireMockServer _mockPaymentApi = null!;
    private WebApplicationFactory<Program> _factory = null!;
    private HttpClient _client = null!;

    public async Task InitializeAsync()
    {
        // Start WireMock server
        _mockPaymentApi = WireMockServer.Start();

        // Configure expected responses
        _mockPaymentApi
            .Given(Request.Create()
                .WithPath("/payments")
                .UsingPost())
            .RespondWith(Response.Create()
                .WithStatusCode(200)
                .WithHeader("Content-Type", "application/json")
                .WithBody("""
                {
                    "transactionId": "txn_123456",
                    "status": "approved",
                    "amount": 99.99
                }
                """));

        // Configure your service to use the mock
        _factory = new WebApplicationFactory<Program>()
            .WithWebHostBuilder(builder =>
            {
                builder.ConfigureServices(services =>
                {
                    services.Configure<PaymentApiSettings>(options =>
                    {
                        options.BaseUrl = _mockPaymentApi.Url!;
                    });
                });
            });

        _client = _factory.CreateClient();
    }

    [Fact]
    public async Task ProcessPayment_CallsPaymentApi_ReturnsSuccess()
    {
        var response = await _client.PostAsJsonAsync("/orders/1/pay", 
            new { CardToken = "tok_test" });

        response.Should().BeSuccessful();
        
        var result = await response.Content.ReadFromJsonAsync<PaymentResult>();
        result!.TransactionId.Should().Be("txn_123456");
        result.Status.Should().Be("approved");
    }

    [Fact]
    public async Task ProcessPayment_WhenApiDeclines_ReturnsError()
    {
        // Configure a decline response
        _mockPaymentApi.Reset();
        _mockPaymentApi
            .Given(Request.Create()
                .WithPath("/payments")
                .UsingPost())
            .RespondWith(Response.Create()
                .WithStatusCode(402)
                .WithBody("""{"error": "card_declined"}"""));

        var response = await _client.PostAsJsonAsync("/orders/1/pay", 
            new { CardToken = "tok_test" });

        response.StatusCode.Should().Be(HttpStatusCode.PaymentRequired);
    }

    public Task DisposeAsync()
    {
        _client.Dispose();
        _factory.Dispose();
        _mockPaymentApi.Stop();
        return Task.CompletedTask;
    }
}
```

### Dynamic Responses Based on Request

WireMock can match requests and respond dynamically:

```csharp
_mockPaymentApi
    .Given(Request.Create()
        .WithPath("/payments")
        .WithBody(new JsonMatcher(new { amount = 0 }))
        .UsingPost())
    .RespondWith(Response.Create()
        .WithStatusCode(400)
        .WithBody("""{"error": "invalid_amount"}"""));

_mockPaymentApi
    .Given(Request.Create()
        .WithPath("/payments")
        .UsingPost())
    .RespondWith(Response.Create()
        .WithStatusCode(200)
        .WithBodyAsJson(new 
        { 
            transactionId = Guid.NewGuid().ToString(),
            status = "approved"
        }));
```

### Verifying Requests Were Made

```csharp
[Fact]
public async Task ProcessPayment_SendsCorrectRequest()
{
    await _client.PostAsJsonAsync("/orders/1/pay", new { CardToken = "tok_test" });

    // Verify the mock received the expected request
    _mockPaymentApi.LogEntries.Should().ContainSingle(log =>
        log.RequestMessage.Path == "/payments" &&
        log.RequestMessage.Method == "POST");

    // Verify request body
    var requestBody = _mockPaymentApi.LogEntries.First().RequestMessage.Body;
    requestBody.Should().Contain("tok_test");
}
```

## Approach 2: WireMock as a Containerized Service

For Aspire distributed tests, run WireMock in a container:

```csharp
public class DistributedPaymentTests : IAsyncLifetime
{
    private IContainer _wiremockContainer = null!;
    private DistributedApplication _app = null!;
    private string _wiremockUrl = null!;

    public async Task InitializeAsync()
    {
        // Start WireMock container
        _wiremockContainer = new ContainerBuilder()
            .WithImage("wiremock/wiremock:latest")
            .WithPortBinding(8080, true)
            .WithWaitStrategy(Wait.ForUnixContainer().UntilHttpRequestIsSucceeded(r => r.ForPort(8080)))
            .Build();
        
        await _wiremockContainer.StartAsync();
        _wiremockUrl = $"http://localhost:{_wiremockContainer.GetMappedPublicPort(8080)}";

        // Configure WireMock stubs via HTTP
        await ConfigureWireMockStubs();

        // Start Aspire app with mock service URL
        var appHost = await DistributedApplicationTestingBuilder
            .CreateAsync<Projects.MyApp_AppHost>();
        
        appHost.Configuration["Services:PaymentApi:Url"] = _wiremockUrl;
        
        _app = await appHost.BuildAsync();
        await _app.StartAsync();
    }

    private async Task ConfigureWireMockStubs()
    {
        using var client = new HttpClient { BaseAddress = new Uri(_wiremockUrl) };
        
        var stubMapping = new
        {
            request = new { method = "POST", urlPath = "/payments" },
            response = new 
            { 
                status = 200, 
                jsonBody = new { transactionId = "txn_123", status = "approved" }
            }
        };

        await client.PostAsJsonAsync("/__admin/mappings", stubMapping);
    }

    [Fact]
    public async Task OrderService_ProcessesPayment()
    {
        var client = _app.CreateHttpClient("apiservice");
        
        var response = await client.PostAsJsonAsync("/orders/1/pay", 
            new { CardToken = "tok_test" });
        
        response.Should().BeSuccessful();
    }

    public async Task DisposeAsync()
    {
        await _app.DisposeAsync();
        await _wiremockContainer.DisposeAsync();
    }
}
```

## Approach 3: Fake HttpMessageHandler

For simpler cases, replace the `HttpMessageHandler` directly:

```csharp
public class FakePaymentApiHandler : HttpMessageHandler
{
    public List<HttpRequestMessage> ReceivedRequests { get; } = new();
    public Func<HttpRequestMessage, HttpResponseMessage> ResponseFactory { get; set; } 
        = _ => new HttpResponseMessage(HttpStatusCode.OK);

    protected override Task<HttpResponseMessage> SendAsync(
        HttpRequestMessage request, 
        CancellationToken cancellationToken)
    {
        ReceivedRequests.Add(request);
        return Task.FromResult(ResponseFactory(request));
    }
}

public class PaymentTests : IAsyncLifetime
{
    private FakePaymentApiHandler _fakeHandler = null!;
    private WebApplicationFactory<Program> _factory = null!;
    private HttpClient _client = null!;

    public async Task InitializeAsync()
    {
        _fakeHandler = new FakePaymentApiHandler
        {
            ResponseFactory = _ => new HttpResponseMessage(HttpStatusCode.OK)
            {
                Content = JsonContent.Create(new 
                { 
                    transactionId = "txn_123", 
                    status = "approved" 
                })
            }
        };

        _factory = new WebApplicationFactory<Program>()
            .WithWebHostBuilder(builder =>
            {
                builder.ConfigureServices(services =>
                {
                    // Replace the HttpClient for PaymentApiClient
                    services.AddHttpClient<IPaymentApiClient, PaymentApiClient>()
                        .ConfigurePrimaryHttpMessageHandler(() => _fakeHandler);
                });
            });

        _client = _factory.CreateClient();
    }

    [Fact]
    public async Task ProcessPayment_UsesPaymentApi()
    {
        await _client.PostAsJsonAsync("/orders/1/pay", new { CardToken = "tok_test" });

        _fakeHandler.ReceivedRequests.Should().ContainSingle();
    }

    public Task DisposeAsync()
    {
        _client.Dispose();
        _factory.Dispose();
        return Task.CompletedTask;
    }
}
```

## Approach 4: Stub Service Implementation

For complex external services, create a fake implementation:

```csharp
// Production implementation
public interface IPaymentGateway
{
    Task<PaymentResult> ProcessPaymentAsync(PaymentRequest request);
}

public class StripePaymentGateway : IPaymentGateway
{
    private readonly HttpClient _client;
    
    public StripePaymentGateway(HttpClient client) => _client = client;

    public async Task<PaymentResult> ProcessPaymentAsync(PaymentRequest request)
    {
        var response = await _client.PostAsJsonAsync("/charges", request);
        return await response.Content.ReadFromJsonAsync<PaymentResult>()!;
    }
}

// Test implementation
public class FakePaymentGateway : IPaymentGateway
{
    public List<PaymentRequest> ProcessedPayments { get; } = new();
    public Func<PaymentRequest, PaymentResult> ResultFactory { get; set; }
        = req => new PaymentResult 
        { 
            TransactionId = $"fake_{Guid.NewGuid():N}",
            Status = "approved"
        };

    public Task<PaymentResult> ProcessPaymentAsync(PaymentRequest request)
    {
        ProcessedPayments.Add(request);
        return Task.FromResult(ResultFactory(request));
    }
}
```

Usage in tests:

```csharp
public class OrderServiceTests : IAsyncLifetime
{
    private FakePaymentGateway _fakeGateway = null!;
    private WebApplicationFactory<Program> _factory = null!;
    private HttpClient _client = null!;

    public async Task InitializeAsync()
    {
        _fakeGateway = new FakePaymentGateway();

        _factory = new WebApplicationFactory<Program>()
            .WithWebHostBuilder(builder =>
            {
                builder.ConfigureServices(services =>
                {
                    services.RemoveAll<IPaymentGateway>();
                    services.AddSingleton<IPaymentGateway>(_fakeGateway);
                });
            });

        _client = _factory.CreateClient();
    }

    [Fact]
    public async Task ProcessPayment_DeclinedCard_ReturnsError()
    {
        _fakeGateway.ResultFactory = _ => new PaymentResult 
        { 
            TransactionId = null,
            Status = "declined",
            Error = "card_declined"
        };

        var response = await _client.PostAsJsonAsync("/orders/1/pay", 
            new { CardToken = "tok_declined" });

        response.StatusCode.Should().Be(HttpStatusCode.PaymentRequired);
    }

    [Fact]
    public async Task ProcessPayment_NetworkError_ReturnsServiceUnavailable()
    {
        _fakeGateway.ResultFactory = _ => 
            throw new HttpRequestException("Network error");

        var response = await _client.PostAsJsonAsync("/orders/1/pay", 
            new { CardToken = "tok_test" });

        response.StatusCode.Should().Be(HttpStatusCode.ServiceUnavailable);
    }

    public Task DisposeAsync()
    {
        _client.Dispose();
        _factory.Dispose();
        return Task.CompletedTask;
    }
}
```

## Mocking Multiple External Services

In real Aspire apps, you often have multiple external dependencies:

```csharp
public class ExternalServicesFixture : IAsyncLifetime
{
    public WireMockServer PaymentApi { get; private set; } = null!;
    public WireMockServer ShippingApi { get; private set; } = null!;
    public WireMockServer NotificationApi { get; private set; } = null!;

    public async Task InitializeAsync()
    {
        PaymentApi = WireMockServer.Start();
        ShippingApi = WireMockServer.Start();
        NotificationApi = WireMockServer.Start();

        SetupDefaultResponses();
    }

    private void SetupDefaultResponses()
    {
        // Payment API defaults
        PaymentApi
            .Given(Request.Create().WithPath("/payments").UsingPost())
            .RespondWith(Response.Create()
                .WithStatusCode(200)
                .WithBodyAsJson(new { transactionId = "txn_default", status = "approved" }));

        // Shipping API defaults
        ShippingApi
            .Given(Request.Create().WithPath("/shipments").UsingPost())
            .RespondWith(Response.Create()
                .WithStatusCode(200)
                .WithBodyAsJson(new { trackingNumber = "TRACK123", carrier = "FedEx" }));

        // Notification API defaults
        NotificationApi
            .Given(Request.Create().WithPath("/notifications").UsingPost())
            .RespondWith(Response.Create().WithStatusCode(202));
    }

    public Task DisposeAsync()
    {
        PaymentApi.Stop();
        ShippingApi.Stop();
        NotificationApi.Stop();
        return Task.CompletedTask;
    }
}

[CollectionDefinition("ExternalServices")]
public class ExternalServicesCollection : ICollectionFixture<ExternalServicesFixture> { }

[Collection("ExternalServices")]
public class OrderWorkflowTests
{
    private readonly ExternalServicesFixture _externalServices;

    public OrderWorkflowTests(ExternalServicesFixture externalServices)
    {
        _externalServices = externalServices;
    }

    [Fact]
    public async Task CompleteOrder_CallsAllExternalServices()
    {
        // Reset to track requests
        _externalServices.PaymentApi.ResetLogEntries();
        _externalServices.ShippingApi.ResetLogEntries();
        _externalServices.NotificationApi.ResetLogEntries();

        // ... run test ...

        // Verify all services were called
        _externalServices.PaymentApi.LogEntries.Should().HaveCount(1);
        _externalServices.ShippingApi.LogEntries.Should().HaveCount(1);
        _externalServices.NotificationApi.LogEntries.Should().HaveCountGreaterThan(0);
    }
}
```

## Simulating Failures and Edge Cases

Test how your app handles external service failures:

```csharp
[Fact]
public async Task ProcessOrder_WhenPaymentApiTimesOut_ReturnsSla()
{
    _mockPaymentApi.Reset();
    _mockPaymentApi
        .Given(Request.Create().WithPath("/payments").UsingPost())
        .RespondWith(Response.Create()
            .WithDelay(TimeSpan.FromSeconds(30))); // Longer than your timeout

    var response = await _client.PostAsJsonAsync("/orders/1/pay", 
        new { CardToken = "tok_test" });

    response.StatusCode.Should().Be(HttpStatusCode.GatewayTimeout);
}

[Fact]
public async Task ProcessOrder_WhenPaymentApi500s_RetriesAndSucceeds()
{
    var callCount = 0;
    _mockPaymentApi.Reset();
    _mockPaymentApi
        .Given(Request.Create().WithPath("/payments").UsingPost())
        .RespondWith(Response.Create()
            .WithCallback(request =>
            {
                callCount++;
                if (callCount < 3)
                    return new ResponseMessage { StatusCode = 500 };
                return new ResponseMessage 
                { 
                    StatusCode = 200,
                    BodyData = new BodyData 
                    { 
                        DetectedBodyType = BodyType.Json,
                        BodyAsJson = new { transactionId = "txn_123", status = "approved" }
                    }
                };
            }));

    var response = await _client.PostAsJsonAsync("/orders/1/pay", 
        new { CardToken = "tok_test" });

    response.Should().BeSuccessful();
    callCount.Should().Be(3); // Verify retries happened
}
```

## Summary

In this post, we learned how to mock external services in Aspire tests:

- **WireMock** for HTTP API mocking with request matching and verification
- **WireMock containers** for distributed Aspire tests
- **Fake HttpMessageHandler** for simple HTTP mocking
- **Stub implementations** for complex service interfaces
- **Testing failures** – timeouts, errors, and retries

In the final post, we'll explore **testing observability and health checks** – verifying that your OpenTelemetry instrumentation, health checks, and logging work correctly.

## GitHub Example

You can find a full working example of this at the following GitHub repository: https://github.com/danielwarddev/AspireTestingExamples
