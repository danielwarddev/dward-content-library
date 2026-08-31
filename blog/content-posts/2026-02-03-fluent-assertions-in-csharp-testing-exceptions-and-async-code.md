# Fluent Assertions in C# – Testing Exceptions and Async Code

**Date:** February 3, 2026  
**Author:** Daniel Ward  
**URL:** https://daninacan.com/fluent-assertions-in-csharp-testing-exceptions-and-async-code/

_This post is part of a series on Fluent Assertions:_

-   [Fluent Assertions in C# – Introduction and Basic Assertions](https://daninacan.com/fluent-assertions-in-csharp-introduction-and-basic-assertions/)
-   [Fluent Assertions in C# – Collections and Object Comparisons](https://daninacan.com/fluent-assertions-in-csharp-collections-and-object-comparisons/)
-   **Fluent Assertions in C# – Testing Exceptions and Async Code** (this post)
-   [Fluent Assertions in C# – Custom Assertions and Extension Methods](https://daninacan.com/fluent-assertions-in-csharp-custom-assertions-and-extension-methods/)
-   [Fluent Assertions in C# – Advanced Patterns and Equivalency Options](https://daninacan.com/fluent-assertions-in-csharp-advanced-patterns-and-equivalency-options/)

---

## Overview

Testing that your code throws the right exceptions is critical for robust error handling. But exception testing in xUnit can be awkward – you either wrap everything in `Assert.Throws<T>()` or use `Record.Exception()`. Fluent Assertions makes exception testing clean and expressive.

In this post, we'll cover how to test synchronous and asynchronous code for exceptions, verify exception details, and handle common async testing patterns.

## The Problem with Traditional Exception Testing

Here's how you'd typically test exceptions in xUnit:

```csharp
// xUnit approach - wrapping in Assert.Throws
[Fact]
public void Divide_ByZero_ThrowsException()
{
    var calculator = new Calculator();
    
    Assert.Throws<DivideByZeroException>(() => calculator.Divide(10, 0));
}

// Or using Record.Exception for more control
[Fact]
public void Divide_ByZero_ThrowsExceptionWithMessage()
{
    var calculator = new Calculator();
    
    var exception = Record.Exception(() => calculator.Divide(10, 0));
    
    Assert.IsType<DivideByZeroException>(exception);
    Assert.Contains("Cannot divide by zero", exception.Message);
}
```

This works, but it's verbose and the exception details require separate assertions.

## Exception Testing with Fluent Assertions

Fluent Assertions uses the `Invoking()` or `FluentActions.Invoking()` pattern:

```csharp
[Fact]
public void Divide_ByZero_ThrowsException()
{
    var calculator = new Calculator();
    
    calculator.Invoking(c => c.Divide(10, 0))
        .Should().Throw<DivideByZeroException>();
}
```

For static methods or when you don't have a subject:

```csharp
[Fact]
public void ParseInt_WithInvalidInput_ThrowsException()
{
    FluentActions.Invoking(() => int.Parse("not a number"))
        .Should().Throw<FormatException>();
}
```

### A Cleaner Alternative: Action Variables

My preferred approach is using action variables – it's more readable:

```csharp
[Fact]
public void CreateUser_WithNullEmail_ThrowsArgumentException()
{
    var service = new UserService();
    
    Action act = () => service.CreateUser(name: "John", email: null!);
    
    act.Should().Throw<ArgumentNullException>();
}
```

## Verifying Exception Details

### Checking Exception Messages

```csharp
[Fact]
public void CreateUser_WithNullEmail_HasCorrectMessage()
{
    var service = new UserService();
    
    Action act = () => service.CreateUser(name: "John", email: null!);
    
    act.Should().Throw<ArgumentNullException>()
        .WithMessage("*email*"); // Wildcard matching
}
```

The `WithMessage()` method supports wildcards:
- `*text*` – contains "text"
- `text*` – starts with "text"
- `*text` – ends with "text"

For exact matching:

```csharp
act.Should().Throw<ArgumentException>()
    .WithMessage("Email cannot be empty (Parameter 'email')");
```

### Checking Parameter Names

For `ArgumentException` and derived types:

```csharp
[Fact]
public void CreateUser_WithNullEmail_SpecifiesParameterName()
{
    var service = new UserService();
    
    Action act = () => service.CreateUser(name: "John", email: null!);
    
    act.Should().Throw<ArgumentNullException>()
        .WithParameterName("email");
}
```

### Chaining Exception Assertions

You can chain multiple checks:

```csharp
[Fact]
public void ProcessOrder_WithInvalidId_ThrowsDetailedException()
{
    var service = new OrderService();
    
    Action act = () => service.ProcessOrder(-1);
    
    act.Should().Throw<ArgumentException>()
        .WithParameterName("orderId")
        .WithMessage("*must be positive*")
        .And.HelpLink.Should().NotBeNull();
}
```

## Testing Inner Exceptions

Sometimes exceptions wrap other exceptions. Fluent Assertions handles this:

```csharp
[Fact]
public void LoadConfiguration_WithMissingFile_ThrowsWithInnerException()
{
    var service = new ConfigService();
    
    Action act = () => service.LoadConfiguration("missing.json");
    
    act.Should().Throw<ConfigurationException>()
        .WithInnerException<FileNotFoundException>()
        .WithMessage("*missing.json*");
}
```

For deeper nesting, use `WithInnerExceptionExactly<T>()` to ensure the exact type:

```csharp
act.Should().Throw<ApplicationException>()
    .WithInnerExceptionExactly<InvalidOperationException>();
```

## Testing That Exceptions Are NOT Thrown

Sometimes you need to verify code completes without throwing:

```csharp
[Fact]
public void CreateUser_WithValidData_DoesNotThrow()
{
    var service = new UserService();
    
    Action act = () => service.CreateUser("John", "john@example.com");
    
    act.Should().NotThrow();
}
```

This is more expressive than just having no assertions – it documents the intent.

You can also specify which exceptions should not be thrown:

```csharp
act.Should().NotThrow<ValidationException>();
```

## Async Exception Testing

This is where Fluent Assertions really helps. Testing async exceptions traditionally is messy:

```csharp
// Traditional approach - awkward async wrapper
[Fact]
public async Task CreateUserAsync_WithNullEmail_ThrowsException()
{
    var service = new UserService();
    
    await Assert.ThrowsAsync<ArgumentNullException>(
        async () => await service.CreateUserAsync("John", null!));
}
```

### The Fluent Way

For async methods, use `Func<Task>` instead of `Action`:

```csharp
[Fact]
public async Task CreateUserAsync_WithNullEmail_ThrowsException()
{
    var service = new UserService();
    
    Func<Task> act = async () => await service.CreateUserAsync("John", null!);
    
    await act.Should().ThrowAsync<ArgumentNullException>();
}
```

❗ **Important:** Notice the `await` before the assertion. Without it, the exception won't be caught!

### Verifying Async Exception Details

All the same assertions work:

```csharp
[Fact]
public async Task ProcessOrderAsync_WithInvalidId_ThrowsDetailedException()
{
    var service = new OrderService();
    
    Func<Task> act = async () => await service.ProcessOrderAsync(-1);
    
    await act.Should().ThrowAsync<ArgumentException>()
        .WithParameterName("orderId")
        .WithMessage("*must be positive*");
}
```

### Testing Async Methods That Return Values

For methods returning `Task<T>`:

```csharp
[Fact]
public async Task GetUserAsync_WithInvalidId_ThrowsNotFoundException()
{
    var service = new UserService();
    
    Func<Task<User>> act = async () => await service.GetUserAsync(-1);
    
    await act.Should().ThrowAsync<NotFoundException>()
        .WithMessage("*User not found*");
}
```

### Verifying No Async Exceptions

```csharp
[Fact]
public async Task SaveUserAsync_WithValidData_DoesNotThrow()
{
    var service = new UserService();
    
    Func<Task> act = async () => await service.SaveUserAsync(validUser);
    
    await act.Should().NotThrowAsync();
}
```

## Testing Async Code That Doesn't Throw

Besides exception testing, Fluent Assertions helps with async result testing:

```csharp
[Fact]
public async Task GetUsersAsync_ReturnsUsers()
{
    var service = new UserService();
    
    var users = await service.GetUsersAsync();
    
    users.Should().NotBeNullOrEmpty()
        .And.HaveCountGreaterThan(0);
}
```

No special syntax needed for non-exception async testing – just await normally.

## Execution Time Assertions

Fluent Assertions can verify execution time, useful for performance tests:

```csharp
[Fact]
public void SlowOperation_CompletesWithinTimeout()
{
    var service = new CacheService();
    
    Action act = () => service.WarmUpCache();
    
    act.ExecutionTime().Should().BeLessThan(TimeSpan.FromSeconds(5));
}
```

For async:

```csharp
[Fact]
public async Task GetDataAsync_CompletesQuickly()
{
    var service = new DataService();
    
    Func<Task> act = async () => await service.GetDataAsync();
    
    (await act.ExecutionTimeAsync()).Should().BeLessThan(TimeSpan.FromMilliseconds(500));
}
```

## Common Patterns and Best Practices

### Testing Guard Clauses

```csharp
[Theory]
[InlineData(null)]
[InlineData("")]
[InlineData("   ")]
public void CreateUser_WithInvalidEmail_ThrowsArgumentException(string? email)
{
    var service = new UserService();
    
    Action act = () => service.CreateUser("John", email!);
    
    act.Should().Throw<ArgumentException>()
        .WithParameterName("email");
}
```

### Testing Multiple Possible Exceptions

When code might throw one of several exception types:

```csharp
[Fact]
public void ParseConfig_WithInvalidInput_ThrowsExpectedException()
{
    var parser = new ConfigParser();
    
    Action act = () => parser.Parse("invalid:::config");
    
    act.Should().ThrowExactly<FormatException>()
        .Or.ThrowExactly<InvalidOperationException>();
}
```

### Testing Exception Throwing in Collections

```csharp
[Fact]
public void ProcessItems_WithInvalidItem_ThrowsOnFirstInvalid()
{
    var processor = new ItemProcessor();
    var items = new[] { "valid", "invalid", "also-valid" };
    
    Action act = () => processor.ProcessAll(items);
    
    act.Should().Throw<InvalidItemException>()
        .Which.InvalidItem.Should().Be("invalid");
}
```

## Putting It All Together

Here's a comprehensive test class showing various exception testing patterns:

```csharp
public class UserServiceTests
{
    private readonly UserService _sut = new();

    [Fact]
    public void CreateUser_WithNullName_ThrowsArgumentNullException()
    {
        Action act = () => _sut.CreateUser(null!, "email@test.com");
        
        act.Should().Throw<ArgumentNullException>()
            .WithParameterName("name");
    }

    [Theory]
    [InlineData("")]
    [InlineData("   ")]
    public void CreateUser_WithEmptyName_ThrowsArgumentException(string name)
    {
        Action act = () => _sut.CreateUser(name, "email@test.com");
        
        act.Should().Throw<ArgumentException>()
            .WithMessage("*cannot be empty*")
            .WithParameterName("name");
    }

    [Fact]
    public void CreateUser_WithValidData_DoesNotThrow()
    {
        Action act = () => _sut.CreateUser("John", "john@test.com");
        
        act.Should().NotThrow();
    }

    [Fact]
    public async Task GetUserAsync_WithNonExistentId_ThrowsNotFoundException()
    {
        Func<Task> act = async () => await _sut.GetUserAsync(999);
        
        await act.Should().ThrowAsync<NotFoundException>()
            .WithMessage("*User with id 999 was not found*");
    }

    [Fact]
    public async Task SaveUserAsync_WithValidUser_DoesNotThrow()
    {
        var user = new User { Name = "Jane", Email = "jane@test.com" };
        
        Func<Task> act = async () => await _sut.SaveUserAsync(user);
        
        await act.Should().NotThrowAsync();
    }
}
```

## Summary

In this post, we covered:

- Basic exception testing with `Should().Throw<T>()`
- Verifying exception messages, parameter names, and inner exceptions
- Testing that code does NOT throw exceptions
- Async exception testing with `ThrowAsync<T>()`
- Execution time assertions for performance testing
- Common patterns for testing guard clauses and validation

In the next post, we'll explore **custom assertions and extension methods** – how to create your own fluent assertions for domain-specific testing needs.

## GitHub Example

You can find a full working example of this at the following GitHub repository: https://github.com/danielwarddev/FluentAssertionsExamples
