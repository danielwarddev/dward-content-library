# How to unit test Serilog LogContext with TestCorrelator

**Date:** April 19, 2023  
**Author:** Daniel Ward  
**URL:** https://daninacan.com/how-to-unit-test-serilog-logcontext-with-testcorrelator/

---

I recently had a use case where I had added custom properties to the `LogContext` with Serilog, and I wanted to be able to test if those properties were being added as expected.

As it turns out, this is actually quite easy, thanks to a library called TestCorrelator by Mitch Bodmer over at https://github.com/MitchBodmer/serilog-sinks-testcorrelator (which also has a number of helpful examples in its tests).

### Using TestCorrelator

TestCorrelator provides a sink for Serilog that exists solely to be used in tests. When written to, it stores information about the current logging context and any messages that were logged in it. From there, you simply verify the properties inside of it.

This post will show how to test two ways:

-   Using the static logger
-   Using an injected logger

Use whichever is relevant for your use case; the testing strategy between them is almost identical.

### Use case #1 – Using the static logger

Consider that we have some class that modifies the `LogContext` like so (note that this is not the only way to modify it; you could also use a custom [Enricher](https://github.com/serilog/serilog/wiki/Enrichment)):

```csharp
public class ServiceWithStaticLogger
{
    public void MethodUsingStaticLogger(bool usePropertyOne)
    {
        var logPropertyName = usePropertyOne ? "propertyOne" : "propertyTwo";
        var logPropertyValue = usePropertyOne ? 1 : 2;

        using (LogContext.PushProperty(logPropertyName, logPropertyValue))
        {
            Log.Logger.Information("Very cool message");
        }
    }
}
```

We can verify the property's existence in a test with the `TestCorrelator` like so:

```csharp
public class ServiceWithStaticLoggerTests
{
    [Theory]
    [InlineData(true, "propertyOne", 1)]
    [InlineData(false, "propertyTwo", 2)]
    public void Log_Context_Should_Have_Correct_Property_With_Static_Logger(bool usePropertyOne, string expectedKey, int expectedValue)
    {
        using (TestCorrelator.CreateContext())
        using (var logger = new LoggerConfiguration()
            .WriteTo.Sink(new TestCorrelatorSink())
            .Enrich.FromLogContext()
            .CreateLogger())
        {
            Log.Logger = logger;

            var service = new ServiceWithStaticLogger();
            service.MethodUsingStaticLogger(usePropertyOne);

            var logEvent = TestCorrelator.GetLogEventsFromCurrentContext().Single();
            var logEventProperty = logEvent.Properties.Single();
            var propertyValue = logEventProperty.Value as ScalarValue;

            logEventProperty.Key.Should().Be(expectedKey);
            propertyValue!.Value.Should().Be(expectedValue);
        }
    }
}
```

### Use case #2 – Using an injected logger

Using an almost identical service and tests, notice that the main difference here is the use of the `SerilogLoggerFactory` and the fact that `logEvent.Properties` will now have more two properties in it instead of 1 (with the new one being the `SourceContext`).

```csharp
public class ServiceWithInjectedLogger
{
    private readonly ILogger<ServiceWithInjectedLogger> _logger;

    public ServiceWithInjectedLogger(ILogger<ServiceWithInjectedLogger> logger)
    {
        _logger = logger;
    }

    public void MethodUsingInjectedLogger(bool usePropertyOne)
    {
        var logPropertyName = usePropertyOne ? "propertyOne" : "propertyTwo";
        var logPropertyValue = usePropertyOne ? 1 : 2;

        using (LogContext.PushProperty(logPropertyName, logPropertyValue))
        {
            _logger.LogInformation("Very cool message");
        }
    }
}
```

```csharp
public class ServiceWithInjectedLoggerTests
{
    [Theory]
    [InlineData(true, "propertyOne", 1)]
    [InlineData(false, "propertyTwo", 2)]
    public void Log_Context_Should_Have_Correct_Property_With_Injected_Logger(bool usePropertyOne, string expectedKey, int expectedValue)
    {
        using (TestCorrelator.CreateContext())
        using (var serilogLogger = new LoggerConfiguration()
            .WriteTo.Sink(new TestCorrelatorSink())
            .Enrich.FromLogContext()
            .CreateLogger())
        {
            var microsoftLogger = new SerilogLoggerFactory(serilogLogger).CreateLogger<ServiceWithInjectedLogger>();

            var service = new ServiceWithInjectedLogger(microsoftLogger);
            service.MethodUsingInjectedLogger(usePropertyOne);

            var logEvent = TestCorrelator.GetLogEventsFromCurrentContext().Single();
            var logEventProperty = logEvent.Properties.Where(x => x.Key == expectedKey).Single();
            var propertyValue = logEventProperty.Value as ScalarValue;

            logEventProperty.Key.Should().Be(expectedKey);
            propertyValue!.Value.Should().Be(expectedValue);
        }
    }
}
```

And you're off!

### Other log values

Whichever option you choose, if you take a peek at what's in the `LogEvent` itself, you'll find some other helpful values that you may want to assert on, depending on your situation:

![Public members of a Serilog LogEvent object]

### Github example

You can find a full working example of this at the following Github repository: https://github.com/danielwarddev/SerilogLogContextProperty
