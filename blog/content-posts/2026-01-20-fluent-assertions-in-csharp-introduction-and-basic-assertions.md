# Fluent Assertions in C# – Introduction and Basic Assertions

**Date:** January 20, 2026  
**Author:** Daniel Ward  
**URL:** https://daninacan.com/fluent-assertions-in-csharp-introduction-and-basic-assertions/

_This post is part of a series on Fluent Assertions:_

-   **Fluent Assertions in C# – Introduction and Basic Assertions** (this post)
-   [Fluent Assertions in C# – Collections and Object Comparisons](https://daninacan.com/fluent-assertions-in-csharp-collections-and-object-comparisons/)
-   [Fluent Assertions in C# – Testing Exceptions and Async Code](https://daninacan.com/fluent-assertions-in-csharp-testing-exceptions-and-async-code/)
-   [Fluent Assertions in C# – Custom Assertions and Extension Methods](https://daninacan.com/fluent-assertions-in-csharp-custom-assertions-and-extension-methods/)
-   [Fluent Assertions in C# – Advanced Patterns and Equivalency Options](https://daninacan.com/fluent-assertions-in-csharp-advanced-patterns-and-equivalency-options/)

---

## Overview

If you've written unit tests in C#, you've probably used xUnit's `Assert.Equal()` or NUnit's `Assert.That()`. They work, but the assertions often feel backwards and produce cryptic error messages. Fluent Assertions is a library that transforms your test assertions into readable, chainable statements that tell you exactly what went wrong when tests fail.

In this first post of the series, we'll cover what Fluent Assertions is, why you should use it, and the most common basic assertions you'll use every day.

## Why Fluent Assertions?

Let's compare traditional xUnit assertions with Fluent Assertions:

```csharp
// xUnit - reads "backwards" and error message is generic
Assert.Equal(expected, actual);
// Error: "Assert.Equal() Failure. Expected: 5, Actual: 3"

// Fluent Assertions - reads naturally and error message is clear
actual.Should().Be(expected);
// Error: "Expected actual to be 5, but found 3."
```

The difference becomes dramatic with more complex assertions:

```csharp
// xUnit - multiple separate assertions
Assert.NotNull(result);
Assert.True(result.IsActive);
Assert.Equal("John", result.Name);

// Fluent Assertions - chainable and expressive
result.Should().NotBeNull()
    .And.Subject.IsActive.Should().BeTrue()
    .And.Subject.Name.Should().Be("John");
```

The key benefits are:

1. **Readable assertions** that follow natural English ("should be", "should contain")
2. **Better error messages** that explain what failed and why
3. **Chainable assertions** that reduce boilerplate
4. **Rich assertion library** for collections, strings, dates, exceptions, and more

## Installation

Install the NuGet package in your test project:

```bash
dotnet add package FluentAssertions
```

Then add the using statement:

```csharp
using FluentAssertions;
```

That's it! The `.Should()` extension method is now available on virtually any object.

## Basic Value Assertions

### Equality

The most common assertion – checking if a value equals an expected value:

```csharp
int result = calculator.Add(2, 3);

result.Should().Be(5);
result.Should().NotBe(0);
```

### Nullability

Check whether values are null or not:

```csharp
string? name = GetUserName(userId);

name.Should().NotBeNull();
name.Should().BeNull(); // for testing null cases
```

### Boolean Assertions

For boolean values, use the explicit `BeTrue()` and `BeFalse()`:

```csharp
bool isValid = validator.Validate(input);

isValid.Should().BeTrue();
isValid.Should().BeFalse();
```

❗ Don't use `Be(true)` – while it works, `BeTrue()` produces better error messages.

### Numeric Comparisons

For numbers, you have rich comparison options:

```csharp
int age = person.Age;

age.Should().BeGreaterThan(0);
age.Should().BeLessThanOrEqualTo(150);
age.Should().BeInRange(1, 120);
age.Should().BePositive();
```

For floating-point comparisons, always use `BeApproximately()` to handle precision issues:

```csharp
double result = Calculate();

// BAD - floating point comparison issues
result.Should().Be(3.14159);

// GOOD - allows small tolerance
result.Should().BeApproximately(3.14159, precision: 0.0001);
```

## String Assertions

Strings have their own rich set of assertions:

```csharp
string email = user.Email;

// Basic checks
email.Should().NotBeNullOrEmpty();
email.Should().NotBeNullOrWhiteSpace();

// Content checks
email.Should().Contain("@");
email.Should().StartWith("user");
email.Should().EndWith(".com");

// Pattern matching
email.Should().MatchRegex(@"^[\w\.-]+@[\w\.-]+\.\w+$");

// Length checks
email.Should().HaveLength(20);
email.Should().HaveLengthGreaterThan(5);
```

### Case Sensitivity

By default, string comparisons are case-sensitive. You can change this:

```csharp
string name = "JOHN";

// Case-sensitive (default) - this will FAIL
name.Should().Be("john");

// Case-insensitive - this will PASS
name.Should().BeEquivalentTo("john");
```

## DateTime Assertions

Date and time comparisons are common in business logic tests:

```csharp
DateTime orderDate = order.CreatedAt;
DateTime now = DateTime.UtcNow;

// Exact comparison (rarely useful due to timing)
orderDate.Should().Be(expectedDate);

// Proximity checks (more practical)
orderDate.Should().BeCloseTo(now, TimeSpan.FromSeconds(5));
orderDate.Should().BeAfter(DateTime.UtcNow.AddDays(-1));
orderDate.Should().BeBefore(DateTime.UtcNow.AddDays(1));

// Date parts
orderDate.Should().HaveYear(2026);
orderDate.Should().HaveMonth(1);
orderDate.Should().HaveDay(20);
```

### Testing Time-Sensitive Code

When testing code that uses `DateTime.Now`, you typically mock the time provider. But for assertions, `BeCloseTo()` is your friend:

```csharp
// Allow a 1-second window for test execution time
result.Timestamp.Should().BeCloseTo(DateTime.UtcNow, TimeSpan.FromSeconds(1));
```

## Type Assertions

Sometimes you need to verify the type of an object:

```csharp
object result = factory.Create("premium");

result.Should().BeOfType<PremiumUser>();
result.Should().BeAssignableTo<IUser>();
result.Should().NotBeOfType<GuestUser>();
```

Note the difference:
- `BeOfType<T>()` – exact type match
- `BeAssignableTo<T>()` – can be T or any derived type

## Chaining Assertions with And

One of Fluent Assertions' best features is chaining. Use `.And` to continue asserting:

```csharp
string result = processor.Process(input);

result.Should().NotBeNullOrEmpty()
    .And.StartWith("PROCESSED:")
    .And.Contain(input)
    .And.HaveLengthGreaterThan(10);
```

If any assertion in the chain fails, you get a clear message about which one failed.

## Adding Context with Because

When tests fail in CI, it helps to have context. Use `Because()`:

```csharp
user.Age.Should().BeGreaterThanOrEqualTo(18, 
    because: "users must be adults to register");

// Error: "Expected user.Age to be greater than or equal to 18 
// because users must be adults to register, but found 16."
```

This is especially valuable for complex business rules:

```csharp
order.Total.Should().Be(expectedTotal, 
    because: "discount {0}% should be applied for orders over {1}", 
    discountPercent, minimumOrderAmount);
```

## Common Mistakes to Avoid

### 1. Don't Assert on the Wrong Subject

```csharp
// BAD - asserting on the expected value!
expected.Should().Be(actual);

// GOOD - assert on the actual result
actual.Should().Be(expected);
```

### 2. Don't Use Be() for Collections

```csharp
var items = new[] { 1, 2, 3 };

// BAD - reference equality, will fail
items.Should().Be(new[] { 1, 2, 3 });

// GOOD - use collection assertions (covered in next post)
items.Should().BeEquivalentTo(new[] { 1, 2, 3 });
```

### 3. Don't Forget Floating-Point Precision

```csharp
double result = 0.1 + 0.2;

// BAD - will fail due to floating point
result.Should().Be(0.3);

// GOOD
result.Should().BeApproximately(0.3, 0.0001);
```

## Putting It All Together

Here's a realistic test using the assertions we've covered:

```csharp
[Fact]
public void CreateUser_WithValidInput_ReturnsNewUser()
{
    // Arrange
    var service = new UserService();
    var request = new CreateUserRequest("John", "john@example.com", 25);

    // Act
    var user = service.CreateUser(request);

    // Assert
    user.Should().NotBeNull();
    user.Id.Should().BePositive();
    user.Name.Should().Be("John");
    user.Email.Should().Be("john@example.com")
        .And.Contain("@");
    user.Age.Should().Be(25)
        .And.BeGreaterThanOrEqualTo(18, because: "only adults can register");
    user.CreatedAt.Should().BeCloseTo(DateTime.UtcNow, TimeSpan.FromSeconds(5));
    user.IsActive.Should().BeTrue();
}
```

## Summary

In this post, we covered the basics of Fluent Assertions:

- Why Fluent Assertions improves test readability and error messages
- Basic assertions for values, strings, numbers, dates, and types
- Chaining assertions with `.And`
- Adding context with `Because()`
- Common mistakes to avoid

In the next post, we'll dive into **collection assertions and object comparisons** – one of Fluent Assertions' most powerful features, including `BeEquivalentTo()` and its many configuration options.

## GitHub Example

You can find a full working example of this at the following GitHub repository: https://github.com/danielwarddev/FluentAssertionsExamples
