# Fluent Assertions in C# – Collections and Object Comparisons

**Date:** January 27, 2026  
**Author:** Daniel Ward  
**URL:** https://daninacan.com/fluent-assertions-in-csharp-collections-and-object-comparisons/

_This post is part of a series on Fluent Assertions:_

-   [Fluent Assertions in C# – Introduction and Basic Assertions](https://daninacan.com/fluent-assertions-in-csharp-introduction-and-basic-assertions/)
-   **Fluent Assertions in C# – Collections and Object Comparisons** (this post)
-   [Fluent Assertions in C# – Testing Exceptions and Async Code](https://daninacan.com/fluent-assertions-in-csharp-testing-exceptions-and-async-code/)
-   [Fluent Assertions in C# – Custom Assertions and Extension Methods](https://daninacan.com/fluent-assertions-in-csharp-custom-assertions-and-extension-methods/)
-   [Fluent Assertions in C# – Advanced Patterns and Equivalency Options](https://daninacan.com/fluent-assertions-in-csharp-advanced-patterns-and-equivalency-options/)

---

## Overview

Testing collections and complex objects is where Fluent Assertions truly shines. The default xUnit and NUnit assertions for collections are limited and produce poor error messages. Fluent Assertions provides rich, expressive assertions that make collection testing a breeze.

In this post, we'll cover everything from basic collection assertions to the powerful `BeEquivalentTo()` method and how to compare complex objects.

## Basic Collection Assertions

### Checking Emptiness and Count

```csharp
var items = new List<string> { "apple", "banana", "cherry" };

items.Should().NotBeEmpty();
items.Should().HaveCount(3);
items.Should().HaveCountGreaterThan(1);
items.Should().HaveCountLessThanOrEqualTo(5);
items.Should().NotBeNullOrEmpty();
```

For empty collections:

```csharp
var empty = new List<string>();

empty.Should().BeEmpty();
empty.Should().HaveCount(0);
```

### Checking for Elements

```csharp
var fruits = new[] { "apple", "banana", "cherry" };

// Single element checks
fruits.Should().Contain("apple");
fruits.Should().NotContain("grape");

// Multiple element checks
fruits.Should().Contain("apple", "banana");
fruits.Should().Contain(new[] { "apple", "cherry" });

// Position checks
fruits.Should().StartWith("apple");
fruits.Should().EndWith("cherry");
fruits.Should().HaveElementAt(1, "banana");
```

### Checking All Elements Match a Condition

Use `OnlyContain()` to verify all elements meet a criteria:

```csharp
var numbers = new[] { 2, 4, 6, 8 };

numbers.Should().OnlyContain(n => n % 2 == 0);
numbers.Should().OnlyContain(n => n > 0, because: "we only deal with positive numbers");
```

Use `AllSatisfy()` for more complex validations:

```csharp
var users = GetActiveUsers();

users.Should().AllSatisfy(user =>
{
    user.IsActive.Should().BeTrue();
    user.Email.Should().NotBeNullOrEmpty();
});
```

## Collection Ordering

Fluent Assertions makes it easy to verify collection order:

```csharp
var sorted = new[] { 1, 2, 3, 4, 5 };

sorted.Should().BeInAscendingOrder();
sorted.Should().BeInDescendingOrder(); // This would fail

// For complex objects, specify the property
var users = new[] { new User("Alice", 25), new User("Bob", 30), new User("Charlie", 35) };

users.Should().BeInAscendingOrder(u => u.Age);
users.Should().BeInDescendingOrder(u => u.Name); // This would fail - alphabetically, this is ascending
```

## The Power of BeEquivalentTo()

This is Fluent Assertions' most powerful feature. `BeEquivalentTo()` performs a deep comparison of objects, comparing by value rather than reference.

### Basic Usage

```csharp
var expected = new List<int> { 1, 2, 3 };
var actual = new List<int> { 1, 2, 3 };

// This compares references - FAILS
actual.Should().BeSameAs(expected);

// This compares by value - PASSES
actual.Should().BeEquivalentTo(expected);
```

### Ignoring Order

By default, `BeEquivalentTo()` for collections **ignores order**:

```csharp
var expected = new[] { 1, 2, 3 };
var actual = new[] { 3, 1, 2 };

// PASSES - order doesn't matter by default
actual.Should().BeEquivalentTo(expected);

// If order matters, use this:
actual.Should().BeEquivalentTo(expected, options => 
    options.WithStrictOrdering());
```

### Comparing Complex Objects

Here's where `BeEquivalentTo()` really shines:

```csharp
public record Product(int Id, string Name, decimal Price, Category Category);
public record Category(int Id, string Name);

[Fact]
public void GetProducts_ReturnsExpectedProducts()
{
    var expected = new[]
    {
        new Product(1, "Widget", 9.99m, new Category(1, "Tools")),
        new Product(2, "Gadget", 19.99m, new Category(2, "Electronics"))
    };

    var actual = _service.GetProducts();

    // Deep comparison of all properties, including nested Category
    actual.Should().BeEquivalentTo(expected);
}
```

When this assertion fails, you get an incredibly detailed error message:

```
Expected actual[0].Name to be "Widget" with a length of 6, but "Widgett" has a length of 7.
Expected actual[0].Price to be 9.99M, but found 10.99M.
```

## Configuring BeEquivalentTo()

The options parameter gives you fine-grained control:

### Excluding Properties

```csharp
actual.Should().BeEquivalentTo(expected, options => options
    .Excluding(p => p.Id)
    .Excluding(p => p.CreatedAt));
```

Use wildcards for nested properties:

```csharp
actual.Should().BeEquivalentTo(expected, options => options
    .Excluding(p => p.Category.Id));
```

### Including Only Specific Properties

```csharp
actual.Should().BeEquivalentTo(expected, options => options
    .Including(p => p.Name)
    .Including(p => p.Price));
```

### Comparing by Specific Members

For comparing objects that have different types but equivalent data:

```csharp
var dto = new ProductDto { Name = "Widget", Price = 9.99m };
var entity = new ProductEntity { ProductName = "Widget", UnitPrice = 9.99m };

dto.Should().BeEquivalentTo(entity, options => options
    .WithMapping<ProductDto>(d => d.Name, e => e.ProductName)
    .WithMapping<ProductDto>(d => d.Price, e => e.UnitPrice));
```

### Handling Dates and Precision

```csharp
var expected = new Order { CreatedAt = DateTime.UtcNow };

// Allow some tolerance for timestamps
actual.Should().BeEquivalentTo(expected, options => options
    .Using<DateTime>(ctx => ctx.Subject.Should()
        .BeCloseTo(ctx.Expectation, TimeSpan.FromSeconds(1)))
    .WhenTypeIs<DateTime>());
```

## Comparing Collections of Complex Objects

### Exact Collection Comparison

```csharp
var expectedUsers = new[]
{
    new User(1, "Alice"),
    new User(2, "Bob")
};

var actualUsers = _service.GetUsers();

actualUsers.Should().BeEquivalentTo(expectedUsers);
```

### Verifying Subset

Check that a collection contains certain elements:

```csharp
var allUsers = _service.GetAllUsers();

allUsers.Should().ContainEquivalentOf(new User(1, "Alice"));
```

### Comparing Only Specific Elements

```csharp
// Verify at least these exist (ignore extras)
actual.Should().Contain(expected);

// Verify these AND ONLY these exist
actual.Should().BeEquivalentTo(expected);
```

## Common Collection Scenarios

### Testing API Responses

```csharp
[Fact]
public async Task GetProducts_ReturnsAllProducts()
{
    var response = await _client.GetAsync("/api/products");
    var products = await response.Content.ReadFromJsonAsync<List<ProductDto>>();

    products.Should().NotBeNullOrEmpty()
        .And.HaveCount(3)
        .And.OnlyContain(p => p.Price > 0)
        .And.Contain(p => p.Name == "Featured Product");
}
```

### Testing Database Queries

```csharp
[Fact]
public async Task GetActiveUsers_ReturnsOnlyActiveUsers()
{
    // Arrange - seed database
    var users = new[]
    {
        new User { Name = "Active1", IsActive = true },
        new User { Name = "Active2", IsActive = true },
        new User { Name = "Inactive", IsActive = false }
    };
    await _context.Users.AddRangeAsync(users);
    await _context.SaveChangesAsync();

    // Act
    var result = await _repository.GetActiveUsers();

    // Assert
    result.Should().HaveCount(2)
        .And.OnlyContain(u => u.IsActive)
        .And.NotContain(u => u.Name == "Inactive");
}
```

### Testing Transformations

```csharp
[Fact]
public void MapToDto_TransformsCorrectly()
{
    var entities = new[]
    {
        new ProductEntity { Id = 1, ProductName = "Widget", UnitPrice = 9.99m },
        new ProductEntity { Id = 2, ProductName = "Gadget", UnitPrice = 19.99m }
    };

    var dtos = _mapper.Map(entities);

    dtos.Should().BeEquivalentTo(new[]
    {
        new { Name = "Widget", Price = 9.99m },
        new { Name = "Gadget", Price = 19.99m }
    }, options => options
        .ExcludingMissingMembers()); // Ignore Id since DTO doesn't have it
}
```

## Single Element Selection

Sometimes you want to assert on a single element from a collection:

```csharp
var users = _service.GetUsers();

// Get first element and continue asserting
users.Should().ContainSingle(u => u.IsAdmin)
    .Which.Name.Should().Be("Admin User");

// Assert on first element
users.Should().HaveElementAt(0, expectedUser);

// Find and assert
users.Should().Contain(u => u.Id == 5)
    .Which.Email.Should().EndWith("@company.com");
```

## Dictionary Assertions

Dictionaries have their own set of assertions:

```csharp
var settings = new Dictionary<string, string>
{
    ["Environment"] = "Production",
    ["LogLevel"] = "Warning"
};

settings.Should().NotBeEmpty();
settings.Should().HaveCount(2);
settings.Should().ContainKey("Environment");
settings.Should().ContainValue("Production");
settings.Should().Contain("Environment", "Production");
settings.Should().Contain(KeyValuePair.Create("LogLevel", "Warning"));
```

## Putting It All Together

Here's a realistic test combining various collection assertions:

```csharp
[Fact]
public async Task SearchProducts_WithFilters_ReturnsFilteredSortedResults()
{
    // Arrange
    var filters = new ProductFilters
    {
        MinPrice = 10.00m,
        MaxPrice = 100.00m,
        Category = "Electronics",
        SortBy = "Price",
        SortDescending = false
    };

    // Act
    var results = await _service.SearchProducts(filters);

    // Assert
    results.Should().NotBeNullOrEmpty(
        because: "matching products exist in the database");
    
    results.Should().OnlyContain(p => 
        p.Price >= 10.00m && p.Price <= 100.00m,
        because: "results should respect price filter");
    
    results.Should().OnlyContain(p => 
        p.Category == "Electronics",
        because: "results should match category filter");
    
    results.Should().BeInAscendingOrder(p => p.Price,
        because: "results should be sorted by price ascending");
    
    results.Should().HaveCountLessThanOrEqualTo(100,
        because: "pagination should limit results");
}
```

## Summary

In this post, we covered:

- Basic collection assertions (count, contains, ordering)
- The powerful `BeEquivalentTo()` method for deep comparisons
- Configuration options for excluding, including, and mapping properties
- Dictionary-specific assertions
- Real-world scenarios for testing APIs, databases, and transformations

In the next post, we'll explore **testing exceptions and async code** with Fluent Assertions, including how to verify that exceptions are thrown with specific messages and how to test async methods properly.

## GitHub Example

You can find a full working example of this at the following GitHub repository: https://github.com/danielwarddev/FluentAssertionsExamples
