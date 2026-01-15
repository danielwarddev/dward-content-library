# Writing Contract Tests in C# With Pact – Message Interactions

**Date:** February 15, 2025  
**Author:** Daniel Ward  
**URL:** https://daninacan.com/writing-contract-tests-in-c-with-pact-message-interactions/

_This post is part of a series on contract testing:_

-   [What contract testing is and why to write them](https://daninacan.com/what-contract-testing-is-and-why-to-write-them/)
-   [How to Write Contract Tests in C# With Pact – Consumer Tests](https://daninacan.com/how-to-write-contract-tests-in-c-with-pact-consumer-tests/)
-   [How to Write Contract Tests in C# With Pact – Provider Tests](https://daninacan.com/how-to-write-contract-tests-in-c-with-pact-provider-tests/)
-   [How to Write Contract Tests in C# With Pact – Provider States](https://daninacan.com/how-to-write-contract-tests-in-c-with-pact-provider-states/)
-   [(Optional) How to Write Contract Tests in C# With Pact – Using Testcontainers](https://daninacan.com/how-to-write-contract-tests-in-c-with-pact-using-testcontainers)
-   [How to Write Contract Tests in C# With Pact – Provider State Parameters](https://daninacan.com/how-to-write-contract-tests-in-c-with-pact-provider-state-parameters/)
-   [Writing Contract Tests in C# With Pact – Query Parameters](https://daninacan.com/writing-contract-tests-in-c-with-pact-query-parameters/)
-   **Writing Contract Tests in C# With Pact – Message Interactions**
-   [Writing Contract Tests in C# With Pact – Pact Brokers](https://daninacan.com/writing-contract-tests-in-c-with-pact-pact-brokers/)

## Overview

Up until now, all of the code shown has assumed you're writing contract tests for a typical HTTP API. However, nowadays, distributed systems are very common, and these make use of asynchronous designs, such as message queues (eg. Azure Service Bus or AWS SNS), and serverless computing options (eg. Azure Functions or AWS Lambda). What if you're using one of these technologies with Pact? Pact's message interactions provides a way to write contract tests in these situations.

Pact's message interactions provide a way to contract test with distributed or event-drive systems.

Ultimately, your contract tests shouldn't care about the protocol used. Your app will receive a contract one way or another, regardless of how that contract is passed over, and that's what should be tested.

## HTTP vs message interactions

The difference between Pact's HTTP interactions and message interactions can be summed up as follows:

-   **HTTP interactions** – describes both an expected request AND an expected response
-   **Message interactions** – describes only an expected response. The consumer does not send an initial request in this case, and is instead triggered by an event (such as a message being put on a queue). Thus, there is no initial request to describe.

❗ A note: make sure that any single consumer or provider name in your contract tests doesn't have both HTTP and messaging pacts. If you have a consumer or provider that does both, just make sure to split them out into two different names, such as "Products API" and "Products Messaging."

Let's look at an example.

## Using message interactions – calling Azure Service Bus

While any event-based technology will do, this example will use Azure Service Bus. Imagine you're the consumer in this case, and another service puts messages on the bus in question. You don't care how they get there, just that your service needs to pull and process them.

Here's an example Azure Function that pulls from Azure Service Bus and processes a message:

```csharp
public class ServiceBusListener
{
    private readonly IEmployeeService _employeeService;

    public ServiceBusListener(IEmployeeService employeeService)
    {
        _employeeService = employeeService;
    }

    [FunctionName("MyFunction")]
    public async Task Run(
        [ServiceBusTrigger("employee-queue", Connection = "ServiceBusConnectionString")] ServiceBusReceivedMessage message,
        ServiceBusMessageActions messageActions)
    {
        var bodyString = message.Body.ToString();
        var product = JsonSerializer.Deserialize<EmployeeEvent>(bodyString)!;
        await _employeeService.ProcessEmployee(product);
        await Task.CompletedTask;
    }
}
```

As you can see, our simple Azure Function receives a `ServiceBusReceivedMessage`. That's not what the provider actually puts on the queue, though. The provider only gives the content of the message body to the queue – the `Employee` – and Service Bus does the rest, adding some other fields such as `MessageId`. Since these additional pieces of data aren't actually part of our business contract, we don't include them in the contract test.

On the consumer's side, we can act like Service Bus doesn't even exist. We abstract away the Service Bus part of the message and focus only on the business contract. To accomplish this, we must make our Azure Function a thin layer concerned only with Azure. The Azure Function itself will only:

-   Get the message from the queue
-   **(Contract test this part!)** Pass the body data down to another service to handle
-   Send some data to Azure afterwards, if necessary

This type of design isn't specific to Pact – it's an existing pattern called [hexagonal architecture](<https://en.wikipedia.org/wiki/Hexagonal_architecture_(software)>). We'll have an "adapter," which is concerned only with retrieving from and returning to Service Bus. The adapter sends the data it gets down to a "port," which takes care of actually performing business logic.

As a comparison, this is also often done in ASP.NET Core controllers, having the controller method itself only concerned with HTTP-related matters, and then calling down to another service to actually handle the data passed in.

## Contract testing with the consumer

Here's what the consumer's test for the above code looks like:

```csharp
public class EmployeeServiceTests
{
    private readonly EmployeeService _employeeService = new EmployeeService(new EmployeeRepository());
    private readonly IMessagePactBuilderV4 _pactBuilder = Pact
        .V4("Employee Message Consumer", "Employee Message Publisher", new PactConfig())
        .WithMessageInteractions();

    [Fact]
    public async Task ProcessSalesEmployee()
    {
        var expectedEmployeeEvent = new EmployeeEvent(1, "John Doe", "Sales", "Sales Manager", "Created");

        await _pactBuilder
            .ExpectsToReceive("An employee event")
            .WithMetadata("contentType", "application/json")
            .WithJsonContent(Match.Type(expectedEmployeeEvent))
            .VerifyAsync<Employee>(async employee =>
            {
                await _employeeService.ProcessEmployee(employee);
                // In a real app, you'd also have an assertion here
                // eg. checking if the employee got inserted into the database for a Created event
                // For simplicity's sake, this is not shown here as it would require a data source to be set up
            });
    }
}
```

Firstly, notice that this is the `EmployeeServiceTests`, not `ServiceBusListenerTests`. Following our hexagonal architecture, we care about contract testing with the `EmployeeEvent`, the business object, rather than `ServiceBusReceivedMessage`, the Azure object.

Also notice that we now create an `IMessagePactBuilderV4`, rather than the previous `IPactBuilderV4`. The API for the messaging builder is a little different from the HTTP one, but still reads pretty similarly. Overall, it should hopefully be fairly clear how the contract test for this works, as it's quite close to the ones used for HTTP interactions.

Just like with the HTTP interactions, running this test will product a JSON file, which is the contract to be given to the provider.

## Contract testing with the provider

Our provider is the service responsible for publishing messages to Service Bus in the first place. Here's our example service for that:

```csharp
public class ServiceBusPublisher
{
    private ServiceBusSender _sender;

    public ServiceBusPublisher(ServiceBusClient client)
    {
        _sender = client.CreateSender("employee-queue");
    }

    public async Task PublishEmployee(Employee employee)
    {
        var message = new ServiceBusMessage(JsonSerializer.Serialize(employee))
        {
            ContentType = "application/json",
        };
        await _sender.SendMessageAsync(message);
    }
}

// Presumably, there would be some more complicated logic in here in a real app
// For instance, reading from a database or calculating some of the values
// You would then use this class to create an Employee and pass it to the ServiceBusPublisher
// Because this is how we create our business object, this is what we contract test
public interface IEmployeeGenerator
{
    Employee CreateEmployee();
}

public class EmployeeGenerator : IEmployeeGenerator
{
    public Employee CreateEmployee()
    {
        return new Employee(1, "John Doe", "Sales", "Sales Manager");
    }
}
```

Our provider will follow the same philosophy as the consumer, using hexagonal architecture and testing the port, rather than the adapter.

In the provider's case, it's actually the service that's creating the `Employee` to begin with. Whatever way that `Employee` is generated is what we want to contract test. In this example, that's the `CreateEmployee()` method on the `EmployeeGenerator`. Of course, in a real app, there would probably be more involved before getting to that final object.

Here's what the contract test looks like on the provider side:

```csharp
public class EmployeeGeneratorTests : IDisposable
{
    private readonly EmployeeEventGenerator _employeeEventGenerator = new();
    private readonly PactVerifier _pactVerifier;
    private readonly string _pactPath;
    private readonly ITestOutputHelper _outputHelper;

    public ServiceBusPublisherTests(ITestOutputHelper outputHelper)
    {
        _outputHelper = outputHelper;
        var config = new PactVerifierConfig
        {
            LogLevel = PactLogLevel.Debug,
            Outputters = new List<IOutput>
            {
                new XunitOutput(_outputHelper),
                new ConsoleOutput()
            }
        };
        _pactPath = Path.Combine("Pacts", "Employee Message Consumer-Employee Message Publisher.json");
        _pactVerifier = new PactVerifier("Employee Message Publisher", config);
    }

    [Fact]
    public void Verify_EmployeeService_Pact_Is_Honored()
    {
        _pactVerifier
            .WithMessages(scenarios =>
            {
                scenarios.Add(
                    "An employee event",
                    // This should create a business object the same way as the real app
                    () => _employeeGenerator.CreateEmployee()
                );
            })
            .WithFileSource(new FileInfo(_pactPath))
            .Verify();
    }

    public void Dispose()
    {
        _pactVerifier.Dispose();
    }
}
```

## Bonus – using provider states with messaging

I admit it seems like a niche case to need provider states with message interactions. However, it is possible to use them, just like with HTTP interactions. Since this concept [was already covered in a previous post](https://daninacan.com/how-to-write-contract-tests-in-c-with-pact-provider-states/) and is the same concept here (as well as [provider state parameters](https://daninacan.com/how-to-write-contract-tests-in-c-with-pact-provider-state-parameters/)), I won't cover the concepts in this post. However, I will show a code example of how to set provider states up for tests using messaging interactions, since it's a bit different.

On the consumer's side, not much changes. We just need to add a `Given()` to our builder pattern:

```csharp
await _pactBuilder
    .ExpectsToReceive("An employee event")
    .Given("some expected provider state") // new code
    .WithMetadata("contentType", "application/json")
    .WithJsonContent(Match.Type(expectedEmployeeEvent))
    .VerifyAsync<Employee>(async employeeEvent =>
    {
        await _employeeService.ProcessEmployee(employeeEvent);
        // Some assert statement
    });
```

We need to do a bit more on the provider side. Even though we aren't using HTTP interactions, Pact still sets up a local server to manage the provider states, so we'll still have to give it an endpoint to hit. That will require our xUnit test implement `IAsyncLifetime` to start and stop the web server.

We'll just use a minimal API in this case. For the previous HTTP tests, we had to set up a fake server anyway to test our ASP.NET Core endpoints, so it wasn't too much trouble to add middleware to it. We don't have an API to test here, so rather than set all that up just to test the provider states, a minimal API is a nice choice for simple cases like this.

## Github example

You can find a full working example of this at the following Github repository: https://github.com/danielwarddev/ContractTestingCSharp
