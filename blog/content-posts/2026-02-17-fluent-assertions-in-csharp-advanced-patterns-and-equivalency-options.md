# Fluent Assertions in C# – Advanced Patterns and Equivalency Options

**Date:** February 17, 2026  
**Author:** Daniel Ward  
**URL:** https://daninacan.com/fluent-assertions-in-csharp-advanced-patterns-and-equivalency-options/

_This post is part of a series on Fluent Assertions:_

-   [Fluent Assertions in C# – Introduction and Basic Assertions](https://daninacan.com/fluent-assertions-in-csharp-introduction-and-basic-assertions/)
-   [Fluent Assertions in C# – Collections and Object Comparisons](https://daninacan.com/fluent-assertions-in-csharp-collections-and-object-comparisons/)
-   [Fluent Assertions in C# – Testing Exceptions and Async Code](https://daninacan.com/fluent-assertions-in-csharp-testing-exceptions-and-async-code/)
-   [Fluent Assertions in C# – Custom Assertions and Extension Methods](https://daninacan.com/fluent-assertions-in-csharp-custom-assertions-and-extension-methods/)
-   **Fluent Assertions in C# – Advanced Patterns and Equivalency Options** (this post)

---

## Overview

In this final post of the Fluent Assertions series, we'll dive into advanced features that help with complex testing scenarios. We'll cover assertion scopes for seeing all failures at once, deep equivalency customization, testing object graphs, and patterns for cleaner test code.

## Assertion Scopes

By default, assertions fail fast – the first failed assertion stops the test. But sometimes you want to see **all** failures at once, especially when validating complex objects.

### The Problem: Fast-Fail Assertions

```csharp
[Fact]
public void CreateUser_ReturnsCorrectUser()
{
    var user = _service.CreateUser("John", "john@test.com");
    
    // If Name fails, you won't know about Email or IsActive
    user.Name.Should().Be("John");
    user.Email.Should().Be("john@test.com");
    user.IsActive.Should().BeTrue();
    user.CreatedAt.Should().BeCloseTo(DateTime.UtcNow, TimeSpan.FromSeconds(1));
}
```

### The Solution: Assertion Scopes

Wrap assertions in an `AssertionScope` to collect all failures:

```csharp
using FluentAssertions.Execution;

[Fact]
public void CreateUser_ReturnsCorrectUser()
{
    var user = _service.CreateUser("John", "john@test.com");
    
    using (new AssertionScope())
    {
        user.Name.Should().Be("John");
        user.Email.Should().Be("john@test.com");
        user.IsActive.Should().BeTrue();
        user.CreatedAt.Should().BeCloseTo(DateTime.UtcNow, TimeSpan.FromSeconds(1));
    }
}
```

If multiple assertions fail, you see them all:

```
Expected user.Name to be "John", but found "Johnny".
Expected user.IsActive to be true, but found false.
```

### Named Assertion Scopes

Add context to your scope with a name:

```csharp
using (new AssertionScope("User Validation"))
{
    // assertions...
}
```

### Scope for Part of a Test

You don't have to wrap the entire test:

```csharp
[Fact]
public void ProcessOrder_CreatesOrderWithCorrectDetails()
{
    var order = _service.ProcessOrder(request);
    
    // These fail fast (separate concerns)
    order.Should().NotBeNull();
    order.Items.Should().NotBeEmpty();
    
    // These are related - show all failures
    using (new AssertionScope())
    {
        order.Total.Should().Be(99.99m);
        order.Tax.Should().Be(8.99m);
        order.Shipping.Should().Be(5.00m);
    }
}
```

## Advanced BeEquivalentTo Options

We touched on `BeEquivalentTo()` in a previous post, but it has many more powerful options.

### Global Configuration

Set default options for all tests:

```csharp
// In your test assembly startup or a global fixture
AssertionOptions.AssertEquivalencyUsing(options => options
    .Using<DateTime>(ctx => ctx.Subject.Should()
        .BeCloseTo(ctx.Expectation, TimeSpan.FromSeconds(1)))
    .WhenTypeIs<DateTime>()
    .ExcludingProperties()
    .IncludingAllRuntimeProperties());
```

### Comparing Different Types

Compare objects with different types but similar shapes:

```csharp
var entity = new OrderEntity 
{ 
    OrderId = 1, 
    CustomerName = "John", 
    TotalAmount = 99.99m 
};

var dto = new OrderDto 
{ 
    Id = 1, 
    Customer = "John", 
    Total = 99.99m 
};

dto.Should().BeEquivalentTo(entity, options => options
    .WithMapping<OrderDto>(d => d.Id, e => e.OrderId)
    .WithMapping<OrderDto>(d => d.Customer, e => e.CustomerName)
    .WithMapping<OrderDto>(d => d.Total, e => e.TotalAmount));
```

### Excluding by Path or Expression

```csharp
actual.Should().BeEquivalentTo(expected, options => options
    .Excluding(x => x.Id)
    .Excluding(x => x.CreatedAt)
    .Excluding(x => x.UpdatedAt)
    .Excluding(member => member.Name == "InternalField")
    .ExcludingMissingMembers());
```

Use path wildcards for nested exclusions:

```csharp
actual.Should().BeEquivalentTo(expected, options => options
    .Excluding(x => x.Path.EndsWith("Id"))      // Exclude all Id properties
    .Excluding(x => x.Path.Contains("Audit"))); // Exclude all Audit-related
```

### Custom Comparison Rules

Apply custom logic for specific types:

```csharp
actual.Should().BeEquivalentTo(expected, options => options
    .Using<decimal>(ctx => ctx.Subject.Should()
        .BeApproximately(ctx.Expectation, 0.01m))
    .WhenTypeIs<decimal>()
    
    .Using<string>(ctx => ctx.Subject.Should()
        .BeEquivalentTo(ctx.Expectation))  // Case-insensitive strings
    .WhenTypeIs<string>());
```

### Recursive vs Structural Comparison

By default, `BeEquivalentTo` does deep/recursive comparison. Control this:

```csharp
// Only compare immediate properties (no recursion)
actual.Should().BeEquivalentTo(expected, options => options
    .RespectingRuntimeTypes()
    .IgnoringCyclicReferences());
```

## Testing Object Graphs

When objects reference each other (like Entity Framework navigation properties), you need special handling.

### Handling Circular References

```csharp
public class Order
{
    public int Id { get; set; }
    public Customer Customer { get; set; }
}

public class Customer
{
    public int Id { get; set; }
    public List<Order> Orders { get; set; } // Circular reference!
}
```

Without handling, this causes infinite recursion:

```csharp
// This will stack overflow!
actualCustomer.Should().BeEquivalentTo(expectedCustomer);
```

Fix with:

```csharp
actualCustomer.Should().BeEquivalentTo(expectedCustomer, options => options
    .IgnoringCyclicReferences());
```

### Limiting Recursion Depth

```csharp
actual.Should().BeEquivalentTo(expected, options => options
    .AllowingInfiniteRecursion() // Default
    // or
    .ExcludingNestedObjects());
```

## Assertion Scopes with Collections

Test all items in a collection, showing all failures:

```csharp
[Fact]
public void GetUsers_ReturnsValidUsers()
{
    var users = _service.GetUsers();
    
    using (new AssertionScope())
    {
        foreach (var user in users)
        {
            user.Email.Should().NotBeNullOrEmpty($"User {user.Id} has no email");
            user.CreatedAt.Should().NotBe(default, $"User {user.Id} has no creation date");
        }
    }
}
```

Or more concisely:

```csharp
users.Should().AllSatisfy(user =>
{
    using (new AssertionScope($"User {user.Id}"))
    {
        user.Email.Should().NotBeNullOrEmpty();
        user.CreatedAt.Should().NotBe(default);
        user.IsActive.Should().BeTrue();
    }
});
```

## The Which Keyword

Chain assertions on matched items:

```csharp
var users = _service.GetUsers();

// Find a specific user and continue asserting
users.Should().ContainSingle(u => u.Email == "admin@test.com")
    .Which.Role.Should().Be(UserRole.Admin);

// Works with collections too
users.Should().Contain(u => u.IsAdmin)
    .Which.Email.Should().EndWith("@company.com");
```

## Subject Identification

Help Fluent Assertions identify subjects for better error messages:

```csharp
var order = _service.CreateOrder();

// Generic error message
order.CustomerId.Should().BePositive();
// "Expected order.CustomerId to be positive, but found -1"

// With subject identification
order.CustomerId.Should().BePositive("the customer ID for order {0}", order.Id);
// "Expected order.CustomerId to be positive because the customer ID for order 42..."
```

## Combining Multiple Subjects

When you need to assert related values together:

```csharp
[Fact]
public void CalculateTotals_ReturnsCorrectValues()
{
    var result = _calculator.Calculate(items);
    
    using (new AssertionScope())
    {
        result.Subtotal.Should().Be(100.00m);
        result.Tax.Should().Be(10.00m);
        result.Total.Should().Be(110.00m);
        
        // Verify consistency
        (result.Subtotal + result.Tax).Should().Be(result.Total,
            because: "subtotal + tax should equal total");
    }
}
```

## Testing Event Handlers and Callbacks

Fluent Assertions has built-in support for testing events:

```csharp
using FluentAssertions.Events;

[Fact]
public void UpdatePrice_RaisesPropertyChangedEvent()
{
    var product = new Product();
    using var monitor = product.Monitor();
    
    product.Price = 19.99m;
    
    monitor.Should().Raise("PropertyChanged")
        .WithSender(product)
        .WithArgs<PropertyChangedEventArgs>(args => args.PropertyName == "Price");
}
```

### Checking Events Were NOT Raised

```csharp
[Fact]
public void SetSamePrice_DoesNotRaiseEvent()
{
    var product = new Product { Price = 10.00m };
    using var monitor = product.Monitor();
    
    product.Price = 10.00m; // Same value
    
    monitor.Should().NotRaise("PropertyChanged");
}
```

## Patterns for Cleaner Tests

### Extension Methods for Common Scenarios

```csharp
public static class TestExtensions
{
    public static AndConstraint<TAssertions> BeValidApiResponse<TAssertions>(
        this ObjectAssertions assertions)
        where TAssertions : ObjectAssertions
    {
        var response = assertions.Subject as ApiResponse;
        
        Execute.Assertion
            .ForCondition(response != null)
            .FailWith("Expected a valid API response but got null");
        
        using (new AssertionScope())
        {
            response!.StatusCode.Should().Be(200);
            response.Data.Should().NotBeNull();
            response.Errors.Should().BeNullOrEmpty();
        }
        
        return new AndConstraint<TAssertions>((TAssertions)assertions);
    }
}
```

### Factory Methods for Expected Objects

```csharp
public static class TestDataFactory
{
    public static User CreateExpectedUser(int id, string name) => new User
    {
        Id = id,
        Name = name,
        IsActive = true,
        CreatedAt = DateTime.UtcNow
    };
}

[Fact]
public void GetUser_ReturnsExpectedUser()
{
    var actual = _service.GetUser(1);
    var expected = TestDataFactory.CreateExpectedUser(1, "John");
    
    actual.Should().BeEquivalentTo(expected, options => options
        .Excluding(u => u.CreatedAt)); // Exclude volatile fields
}
```

### Reusable Equivalency Options

```csharp
public static class EquivalencyExtensions
{
    public static EquivalencyAssertionOptions<T> ExcludingAuditFields<T>(
        this EquivalencyAssertionOptions<T> options)
    {
        return options
            .Excluding(x => x.Path.EndsWith("Id"))
            .Excluding(x => x.Path.EndsWith("CreatedAt"))
            .Excluding(x => x.Path.EndsWith("UpdatedAt"))
            .Excluding(x => x.Path.EndsWith("CreatedBy"))
            .Excluding(x => x.Path.EndsWith("UpdatedBy"));
    }
    
    public static EquivalencyAssertionOptions<T> UsingDateTimeTolerance<T>(
        this EquivalencyAssertionOptions<T> options,
        TimeSpan tolerance)
    {
        return options.Using<DateTime>(ctx => ctx.Subject.Should()
            .BeCloseTo(ctx.Expectation, tolerance))
            .WhenTypeIs<DateTime>();
    }
}

// Usage
actual.Should().BeEquivalentTo(expected, options => options
    .ExcludingAuditFields()
    .UsingDateTimeTolerance(TimeSpan.FromSeconds(1)));
```

## Complete Example: Complex Integration Test

Putting it all together in a realistic test:

```csharp
[Fact]
public async Task PlaceOrder_WithValidCart_CreatesCompleteOrder()
{
    // Arrange
    var cart = await _testData.CreateCartWithItems(3);
    var user = await _testData.CreateVerifiedUser();
    
    // Act
    var order = await _orderService.PlaceOrderAsync(cart, user);
    
    // Assert
    using (new AssertionScope())
    {
        // Basic checks
        order.Should().NotBeNull();
        order.Id.Should().BePositive();
        order.Status.Should().Be(OrderStatus.Pending);
        
        // Items verification
        order.Items.Should().HaveCount(3)
            .And.OnlyContain(i => i.Quantity > 0)
            .And.OnlyContain(i => i.UnitPrice > 0);
        
        // Customer verification
        order.Customer.Should().BeEquivalentTo(user, options => options
            .ExcludingAuditFields()
            .Including(u => u.Id)
            .Including(u => u.Name)
            .Including(u => u.Email));
        
        // Financial calculations
        var expectedSubtotal = order.Items.Sum(i => i.Quantity * i.UnitPrice);
        order.Subtotal.Should().Be(expectedSubtotal);
        order.Tax.Should().BeGreaterThan(0);
        order.Total.Should().Be(order.Subtotal + order.Tax + order.ShippingCost);
        
        // Timestamps
        order.CreatedAt.Should().BeCloseTo(DateTime.UtcNow, TimeSpan.FromSeconds(5));
        order.UpdatedAt.Should().BeCloseTo(DateTime.UtcNow, TimeSpan.FromSeconds(5));
    }
}
```

## Summary

In this final post of the Fluent Assertions series, we covered:

- **Assertion Scopes** for collecting all failures at once
- **Advanced BeEquivalentTo options** for custom comparisons, type mapping, and exclusions
- **Object graph testing** with circular reference handling
- **Event monitoring** for property changed and other events
- **Patterns** for cleaner, more maintainable test code

Throughout this series, we've gone from basic value assertions to complex object comparisons and custom domain-specific assertions. Fluent Assertions is a powerful tool that, when used well, makes your tests more readable, maintainable, and informative.

## Series Summary

1. **Introduction and Basic Assertions** – Getting started, values, strings, dates, types
2. **Collections and Object Comparisons** – BeEquivalentTo, collection assertions, dictionaries  
3. **Testing Exceptions and Async Code** – Exception testing, async patterns, execution time
4. **Custom Assertions and Extension Methods** – Creating domain-specific fluent assertions
5. **Advanced Patterns and Equivalency Options** – Assertion scopes, equivalency customization, events

## GitHub Example

You can find a full working example of this at the following GitHub repository: https://github.com/danielwarddev/FluentAssertionsExamples
