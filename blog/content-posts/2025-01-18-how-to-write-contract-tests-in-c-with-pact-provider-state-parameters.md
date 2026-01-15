# How to Write Contract Tests in C# With Pact – Provider State Parameters

**Date:** January 18, 2025  
**Author:** Daniel Ward  
**URL:** https://daninacan.com/how-to-write-contract-tests-in-c-with-pact-provider-state-parameters/

_This post is part of a series on contract testing:_

-   [What contract testing is and why to write them](https://daninacan.com/what-contract-testing-is-and-why-to-write-them/)
-   [How to Write Contract Tests in C# With Pact – Consumer Tests](https://daninacan.com/how-to-write-contract-tests-in-c-with-pact-consumer-tests/)
-   [How to Write Contract Tests in C# With Pact – Provider Tests](https://daninacan.com/how-to-write-contract-tests-in-c-with-pact-provider-tests/)
-   [How to Write Contract Tests in C# With Pact – Provider States](https://daninacan.com/how-to-write-contract-tests-in-c-with-pact-provider-states/)
-   [(Optional) How to Write Contract Tests in C# With Pact – Using Testcontainers](https://daninacan.com/how-to-write-contract-tests-in-c-with-pact-using-testcontainers)
-   **How to Write Contract Tests in C# With Pact – Provider State Parameters** (this post)
-   [Writing Contract Tests in C# With Pact – Query Parameters](https://daninacan.com/writing-contract-tests-in-c-with-pact-query-parameters/)
-   [Writing Contract Tests in C# With Pact – Message Interactions](https://daninacan.com/writing-contract-tests-in-c-with-pact-message-interactions/)
-   [Writing Contract Tests in C# With Pact – Pact Brokers](https://daninacan.com/writing-contract-tests-in-c-with-pact-pact-brokers/)

---

### Overview

In the previous post, we saw how to use provider states. However, in the less-common case that you'd like to pass in multiple, more specific states, we didn't have that option. Provider state parameters give us that option.

### Consumer side – adding provider state parameters

Let's go back to the consumer test. The `Given()` method can also take a second parameter, which is a dictionary of string key-value pairs. These are our provider state parameters, and can be whatever values you want to pass to the provider through the contract. As before, you'll probably have the teams talk with one another and come up with agreed-upon values.

Here's what using parameters looks like on the consumer side – we only need to change the `Given()`:

```csharp
... .Given("A product with id 1 exists", new Dictionary<string, string>
{
    { "productId", "1" },
    { "productName", "Cool product" },
})
...
```

With this change, we're still passing in the state string, but we also pass in a dictionary of string key-value pairs along with it. Note that the value for each key must be a string, even for number values, so we'll have to parse them accordingly on the provider side.

### Provider side – reading provider state parameters

We'll add some code to the `ProviderStateMiddleware` to read these new parameters. First of all, we'll create some new types to deserialize the JSON body into, as well as add a `JsonSerializerOptions` field to the middleware for convenience:

```csharp
public record PossibleParameters(int? ProductId, string? ProductName, decimal? ProducePrice);

public record ProviderState(string Action, PossibleParameters Params, string State);

public class ProviderStateMiddleware
{
    ...
    private readonly JsonSerializerOptions _jsonOptions = new() { PropertyNameCaseInsensitive = true };
    ...
}
```

Then, when reading the JSON body in `HandleProviderStateRequest()`, we'll deserialize the provider state into these new types:

```csharp
var providerState = JsonSerializer.Deserialize<ProviderState>(body, _jsonOptions);
```

If you were to put a breakpoint in the `ProviderStateMiddleware` to take a look at what the provider state object here looks like, you'd see something like this:

As you can see, the state parameters come through and are correctly deserialized into their respective types. You can now use them to set up the state however you like.

Purely as an example, you may choose to do something like:

```csharp
await dataSetupAction!.Invoke(
    providerState.Params.ProductId ?? 1,
    providerState.Params.ProductName ?? "A cool product",
    providerState.Params.ProducePrice ?? 10.5m
);
```

With that, you now have a way to use provider state parameters to help set up your provider state. However, there are a couple important concepts to note.

### Do I have to create a custom type for the parameters? Can't I just use a Dictionary?

You don't have to use a custom type, but I think it's the least painful method. Without writing any custom `JsonConverter`s, here are the options:

-   **Dictionary<string, string>**. This works, but number values will also be strings in the JSON document, so they'll need to be parsed accordingly in your code.
-   **Dictionary<string, object>**. Unfortunately, the JSON values will not be serialized to their respective types, but `JsonElement`s, which can work, but are pretty ugly to convert.
-   **Custom type with optional properties**. This is my preference, and the deserializing will simply work as intended, as shown in this post. The obvious downside is that you need to make sure all the options are present as fields and that they must be nullable (unless you have some which must always be present, which I don't advise). I don't think this should cause much trouble, especially since you should (hopefully) not be using a ton of state parameters.

### A strong caution on functional testing

❗ It's absolutely worth mentioning at this point that **contract tests are not functional tests!**

That is, most contract tests probably shouldn't need state parameters. Remember, you only need to verify the contract, not any business logic. Contract tests are meant to test _only_ that the contract between the consumer and provider is understood on both sides. In general, a consumer probably shouldn't care about what fields an object in an API response comes back with, except to ensure that its query was satisfied. There may be some cases where you need to set up specific data to do that, which is what states and state parameters are for in Pact.

So, in short, just try to not overdo it too much with state parameters. In fact, as a general rule, I would say that you should try to use them as sparingly as possible.

### Github example

You can find a full working example of this at the following Github repository: [https://github.com/danielwarddev/ContractTestingCSharp](https://github.com/danielwarddev/ContractTestingCSharp)
