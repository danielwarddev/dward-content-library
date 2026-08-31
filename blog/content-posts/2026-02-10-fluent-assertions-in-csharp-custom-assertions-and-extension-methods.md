# Fluent Assertions in C# – Custom Assertions and Extension Methods

**Date:** February 10, 2026  
**Author:** Daniel Ward  
**URL:** https://daninacan.com/fluent-assertions-in-csharp-custom-assertions-and-extension-methods/

_This post is part of a series on Fluent Assertions:_

-   [Fluent Assertions in C# – Introduction and Basic Assertions](https://daninacan.com/fluent-assertions-in-csharp-introduction-and-basic-assertions/)
-   [Fluent Assertions in C# – Collections and Object Comparisons](https://daninacan.com/fluent-assertions-in-csharp-collections-and-object-comparisons/)
-   [Fluent Assertions in C# – Testing Exceptions and Async Code](https://daninacan.com/fluent-assertions-in-csharp-testing-exceptions-and-async-code/)
-   **Fluent Assertions in C# – Custom Assertions and Extension Methods** (this post)
-   [Fluent Assertions in C# – Advanced Patterns and Equivalency Options](https://daninacan.com/fluent-assertions-in-csharp-advanced-patterns-and-equivalency-options/)

---

## Overview

Fluent Assertions provides an extensive set of built-in assertions, but sometimes you need assertions specific to your domain. Maybe you want to assert that an `Order` is "complete" (has items, payment, shipping address), or that a `User` is "verified" (email confirmed, phone verified, ID uploaded).

In this post, we'll learn how to create custom assertions that fit naturally into Fluent Assertions' syntax and provide clear error messages.

## Why Create Custom Assertions?

Consider this test:

```csharp
[Fact]
public void CompleteCheckout_WithValidCart_CreatesCompleteOrder()
{
    var order = _service.CompleteCheckout(cart);
    
    // Many separate assertions for "complete order"
    order.Should().NotBeNull();
    order.Items.Should().NotBeEmpty();
    order.PaymentInfo.Should().NotBeNull();
    order.ShippingAddress.Should().NotBeNull();
    order.Status.Should().Be(OrderStatus.Confirmed);
    order.OrderNumber.Should().NotBeNullOrEmpty();
}
```

This works, but it's repetitive if you need to verify a "complete order" in multiple tests. Let's make it fluent:

```csharp
[Fact]
public void CompleteCheckout_WithValidCart_CreatesCompleteOrder()
{
    var order = _service.CompleteCheckout(cart);
    
    order.Should().BeComplete();
}
```

Much cleaner! Let's learn how to create this.

## Creating Custom Assertions

Fluent Assertions uses the extension method pattern. To add custom assertions, you create:

1. A custom **Assertions class** that extends `ReferenceTypeAssertions<TSubject, TAssertions>`
2. An **extension method** on your type that returns your assertions class

### Step 1: Create the Assertions Class

```csharp
using FluentAssertions;
using FluentAssertions.Execution;
using FluentAssertions.Primitives;

public class OrderAssertions : ReferenceTypeAssertions<Order, OrderAssertions>
{
    public OrderAssertions(Order subject) : base(subject)
    {
    }

    protected override string Identifier => "order";
}
```

The `Identifier` is used in error messages (e.g., "Expected order to be complete...").

### Step 2: Add Assertion Methods

```csharp
public class OrderAssertions : ReferenceTypeAssertions<Order, OrderAssertions>
{
    public OrderAssertions(Order subject) : base(subject)
    {
    }

    protected override string Identifier => "order";

    public AndConstraint<OrderAssertions> BeComplete(string because = "", params object[] becauseArgs)
    {
        Execute.Assertion
            .BecauseOf(because, becauseArgs)
            .Given(() => Subject)
            .ForCondition(order => order != null)
            .FailWith("Expected {context:order} to be complete{reason}, but it was null.")
            .Then
            .ForCondition(order => order.Items?.Any() == true)
            .FailWith("Expected {context:order} to be complete{reason}, but it has no items.")
            .Then
            .ForCondition(order => order.PaymentInfo != null)
            .FailWith("Expected {context:order} to be complete{reason}, but it has no payment info.")
            .Then
            .ForCondition(order => order.ShippingAddress != null)
            .FailWith("Expected {context:order} to be complete{reason}, but it has no shipping address.")
            .Then
            .ForCondition(order => order.Status == OrderStatus.Confirmed)
            .FailWith("Expected {context:order} to be complete{reason}, but status was {0}.", 
                order => order.Status);

        return new AndConstraint<OrderAssertions>(this);
    }
}
```

Key elements:
- **`Execute.Assertion`** – starts the assertion chain
- **`BecauseOf()`** – includes the optional "because" reason
- **`Given()`** – provides the subject for subsequent conditions
- **`ForCondition()`** – checks a boolean condition
- **`FailWith()`** – the error message if the condition fails
- **`Then`** – chains to the next condition
- **`{context:order}`** – replaced with the identifier
- **`{reason}`** – replaced with the "because" text

### Step 3: Create the Extension Method

```csharp
public static class OrderAssertionsExtensions
{
    public static OrderAssertions Should(this Order instance)
    {
        return new OrderAssertions(instance);
    }
}
```

Now you can use it:

```csharp
order.Should().BeComplete();
order.Should().BeComplete(because: "checkout succeeded");
```

## Multiple Custom Assertions

Let's add more assertions to our `OrderAssertions` class:

```csharp
public class OrderAssertions : ReferenceTypeAssertions<Order, OrderAssertions>
{
    public OrderAssertions(Order subject) : base(subject)
    {
    }

    protected override string Identifier => "order";

    public AndConstraint<OrderAssertions> BeComplete(string because = "", params object[] becauseArgs)
    {
        // ... (as shown above)
    }

    public AndConstraint<OrderAssertions> BePending(string because = "", params object[] becauseArgs)
    {
        Execute.Assertion
            .BecauseOf(because, becauseArgs)
            .ForCondition(Subject?.Status == OrderStatus.Pending)
            .FailWith("Expected {context:order} to be pending{reason}, but status was {0}.", 
                Subject?.Status);

        return new AndConstraint<OrderAssertions>(this);
    }

    public AndConstraint<OrderAssertions> HaveTotalGreaterThan(
        decimal amount, 
        string because = "", 
        params object[] becauseArgs)
    {
        Execute.Assertion
            .BecauseOf(because, becauseArgs)
            .ForCondition(Subject?.Total > amount)
            .FailWith("Expected {context:order} to have total greater than {0}{reason}, but was {1}.",
                amount, Subject?.Total);

        return new AndConstraint<OrderAssertions>(this);
    }

    public AndConstraint<OrderAssertions> HaveItem(
        string productName, 
        string because = "", 
        params object[] becauseArgs)
    {
        Execute.Assertion
            .BecauseOf(because, becauseArgs)
            .ForCondition(Subject?.Items?.Any(i => i.ProductName == productName) == true)
            .FailWith("Expected {context:order} to contain item '{0}'{reason}, but it was not found.",
                productName);

        return new AndConstraint<OrderAssertions>(this);
    }

    public AndConstraint<OrderAssertions> HaveShippingMethod(
        ShippingMethod method, 
        string because = "", 
        params object[] becauseArgs)
    {
        Execute.Assertion
            .BecauseOf(because, becauseArgs)
            .ForCondition(Subject?.ShippingMethod == method)
            .FailWith("Expected {context:order} to have shipping method {0}{reason}, but was {1}.",
                method, Subject?.ShippingMethod);

        return new AndConstraint<OrderAssertions>(this);
    }
}
```

Now you have a rich assertion vocabulary for orders:

```csharp
[Fact]
public void ExpressCheckout_CreatesExpressOrder()
{
    var order = _service.ExpressCheckout(cart, user);
    
    order.Should().BeComplete()
        .And.HaveTotalGreaterThan(0)
        .And.HaveShippingMethod(ShippingMethod.Express);
}
```

## Custom Assertions for Value Types

For value types (structs, enums), extend `ObjectAssertions` instead:

```csharp
public class MoneyAssertions : ObjectAssertions
{
    private readonly Money _subject;

    public MoneyAssertions(Money subject) : base(subject)
    {
        _subject = subject;
    }

    protected override string Identifier => "money";

    public AndConstraint<MoneyAssertions> BePositive(string because = "", params object[] becauseArgs)
    {
        Execute.Assertion
            .BecauseOf(because, becauseArgs)
            .ForCondition(_subject.Amount > 0)
            .FailWith("Expected {context:money} to be positive{reason}, but was {0}.", _subject.Amount);

        return new AndConstraint<MoneyAssertions>(this);
    }

    public AndConstraint<MoneyAssertions> HaveCurrency(
        string currency, 
        string because = "", 
        params object[] becauseArgs)
    {
        Execute.Assertion
            .BecauseOf(because, becauseArgs)
            .ForCondition(_subject.Currency == currency)
            .FailWith("Expected {context:money} to have currency '{0}'{reason}, but was '{1}'.",
                currency, _subject.Currency);

        return new AndConstraint<MoneyAssertions>(this);
    }
}

public static class MoneyAssertionsExtensions
{
    public static MoneyAssertions Should(this Money instance)
    {
        return new MoneyAssertions(instance);
    }
}
```

## Custom Assertions for Collections

Sometimes you need custom assertions for collections of your types:

```csharp
public class OrderCollectionAssertions : 
    GenericCollectionAssertions<Order, OrderCollectionAssertions>
{
    public OrderCollectionAssertions(IEnumerable<Order> orders) : base(orders)
    {
    }

    protected override string Identifier => "orders";

    public AndConstraint<OrderCollectionAssertions> AllBeComplete(
        string because = "", 
        params object[] becauseArgs)
    {
        Execute.Assertion
            .BecauseOf(because, becauseArgs)
            .ForCondition(Subject.All(o => IsComplete(o)))
            .FailWith("Expected all {context:orders} to be complete{reason}.");

        return new AndConstraint<OrderCollectionAssertions>(this);
    }

    public AndConstraint<OrderCollectionAssertions> HaveTotalValueGreaterThan(
        decimal amount,
        string because = "",
        params object[] becauseArgs)
    {
        var totalValue = Subject.Sum(o => o.Total);
        
        Execute.Assertion
            .BecauseOf(because, becauseArgs)
            .ForCondition(totalValue > amount)
            .FailWith("Expected {context:orders} to have combined total greater than {0}{reason}, but was {1}.",
                amount, totalValue);

        return new AndConstraint<OrderCollectionAssertions>(this);
    }

    private static bool IsComplete(Order order) =>
        order.Items?.Any() == true &&
        order.PaymentInfo != null &&
        order.ShippingAddress != null &&
        order.Status == OrderStatus.Confirmed;
}

public static class OrderCollectionExtensions
{
    public static OrderCollectionAssertions Should(this IEnumerable<Order> orders)
    {
        return new OrderCollectionAssertions(orders);
    }
}
```

Usage:

```csharp
[Fact]
public void GetMonthlyOrders_ReturnsAllCompleteOrders()
{
    var orders = _service.GetMonthlyOrders(DateTime.Now);
    
    orders.Should().AllBeComplete()
        .And.HaveTotalValueGreaterThan(1000m);
}
```

## Real-World Example: User Verification

Here's a complete example for testing user verification status:

```csharp
public class User
{
    public int Id { get; set; }
    public string Email { get; set; } = string.Empty;
    public bool EmailVerified { get; set; }
    public bool PhoneVerified { get; set; }
    public bool IdentityVerified { get; set; }
    public DateTime? LastLoginAt { get; set; }
    public UserRole Role { get; set; }
}

public class UserAssertions : ReferenceTypeAssertions<User, UserAssertions>
{
    public UserAssertions(User subject) : base(subject)
    {
    }

    protected override string Identifier => "user";

    public AndConstraint<UserAssertions> BeFullyVerified(
        string because = "", 
        params object[] becauseArgs)
    {
        Execute.Assertion
            .BecauseOf(because, becauseArgs)
            .Given(() => Subject)
            .ForCondition(user => user != null)
            .FailWith("Expected {context:user} to be fully verified{reason}, but it was null.")
            .Then
            .ForCondition(user => user.EmailVerified)
            .FailWith("Expected {context:user} to be fully verified{reason}, but email is not verified.")
            .Then
            .ForCondition(user => user.PhoneVerified)
            .FailWith("Expected {context:user} to be fully verified{reason}, but phone is not verified.")
            .Then
            .ForCondition(user => user.IdentityVerified)
            .FailWith("Expected {context:user} to be fully verified{reason}, but identity is not verified.");

        return new AndConstraint<UserAssertions>(this);
    }

    public AndConstraint<UserAssertions> BeActive(
        string because = "", 
        params object[] becauseArgs)
    {
        Execute.Assertion
            .BecauseOf(because, becauseArgs)
            .ForCondition(Subject?.LastLoginAt > DateTime.UtcNow.AddDays(-30))
            .FailWith("Expected {context:user} to be active{reason}, but last login was {0}.", 
                Subject?.LastLoginAt);

        return new AndConstraint<UserAssertions>(this);
    }

    public AndConstraint<UserAssertions> HaveRole(
        UserRole expectedRole,
        string because = "",
        params object[] becauseArgs)
    {
        Execute.Assertion
            .BecauseOf(because, becauseArgs)
            .ForCondition(Subject?.Role == expectedRole)
            .FailWith("Expected {context:user} to have role {0}{reason}, but was {1}.",
                expectedRole, Subject?.Role);

        return new AndConstraint<UserAssertions>(this);
    }

    public AndConstraint<UserAssertions> HaveValidEmail(
        string because = "",
        params object[] becauseArgs)
    {
        Execute.Assertion
            .BecauseOf(because, becauseArgs)
            .ForCondition(!string.IsNullOrWhiteSpace(Subject?.Email))
            .FailWith("Expected {context:user} to have valid email{reason}, but email was empty.")
            .Then
            .ForCondition(Subject!.Email.Contains("@"))
            .FailWith("Expected {context:user} to have valid email{reason}, but '{0}' is not valid.",
                Subject.Email);

        return new AndConstraint<UserAssertions>(this);
    }
}

public static class UserAssertionsExtensions
{
    public static UserAssertions Should(this User instance)
    {
        return new UserAssertions(instance);
    }
}
```

Usage in tests:

```csharp
[Fact]
public void CompleteVerification_WithAllSteps_UserIsFullyVerified()
{
    var user = _service.GetUser(userId);
    _service.VerifyEmail(user, validToken);
    _service.VerifyPhone(user, validCode);
    _service.VerifyIdentity(user, validDocument);
    
    user.Should().BeFullyVerified()
        .And.HaveValidEmail()
        .And.HaveRole(UserRole.Standard);
}

[Fact]
public void PromoteToAdmin_WithVerifiedUser_GrantsAdminRole()
{
    var user = _service.CreateVerifiedUser();
    
    _service.PromoteToAdmin(user);
    
    user.Should().HaveRole(UserRole.Admin)
        .And.BeFullyVerified(because: "admins must be verified");
}
```

## Tips for Great Custom Assertions

### 1. Use Specific Error Messages

Bad:
```csharp
.FailWith("Assertion failed.")
```

Good:
```csharp
.FailWith("Expected {context:order} to have total greater than {0}, but total was {1}.", 
    expectedMinimum, Subject?.Total)
```

### 2. Support the "because" Pattern

Always include the `because` parameter for consistency:

```csharp
public AndConstraint<OrderAssertions> BeComplete(
    string because = "", 
    params object[] becauseArgs)
```

### 3. Return AndConstraint for Chaining

Always return `AndConstraint<TAssertions>` to enable chaining:

```csharp
return new AndConstraint<OrderAssertions>(this);
```

### 4. Place Extensions in a Shared Location

Create an `Extensions` folder in your test project:

```
Tests/
  Extensions/
    OrderAssertions.cs
    UserAssertions.cs
```

## Summary

In this post, we covered:

- Why custom assertions improve test readability
- Creating custom assertion classes using `ReferenceTypeAssertions<T, TAssertions>`
- Writing assertion methods with clear error messages
- Custom assertions for value types and collections
- Real-world examples for domain-specific testing

In the final post of this series, we'll explore **advanced patterns and equivalency options** – including assertion scopes, equivalency customization, and testing complex object graphs.

## GitHub Example

You can find a full working example of this at the following GitHub repository: https://github.com/danielwarddev/FluentAssertionsExamples
