# GitHub Copilot for .NET Teams – Writing Effective Prompts

**Date:** April 7, 2026  
**Author:** Daniel Ward  
**URL:** https://daninacan.com/github-copilot-for-dotnet-teams-writing-effective-prompts/

_This post is part of a series on GitHub Copilot for .NET teams:_

-   [GitHub Copilot for .NET Teams – Getting Started the Right Way](https://daninacan.com/github-copilot-for-dotnet-teams-getting-started-the-right-way/)
-   **GitHub Copilot for .NET Teams – Writing Effective Prompts** (this post)
-   [GitHub Copilot for .NET Teams – Using Chat Participants Effectively](https://daninacan.com/github-copilot-for-dotnet-teams-using-chat-participants-effectively/)
-   [GitHub Copilot for .NET Teams – Custom Instructions with copilot-instructions.md](https://daninacan.com/github-copilot-for-dotnet-teams-custom-instructions-with-copilot-instructions-md/)
-   [GitHub Copilot for .NET Teams – Building Agent Skills for Your Codebase](https://daninacan.com/github-copilot-for-dotnet-teams-building-agent-skills-for-your-codebase/)

---

## Overview

The difference between "Copilot is meh" and "Copilot is incredible" often comes down to how you prompt it. In this post, we'll learn prompt patterns that consistently produce high-quality C# code – methods that work for inline completions and chat alike.

## The CLEAR Framework for Prompts

I use a framework I call CLEAR:

| Letter | Meaning | Example |
|--------|---------|---------|
| **C** | Context | "In an ASP.NET Core 8 API..." |
| **L** | Language/Libs | "Using EF Core and FluentValidation..." |
| **E** | Expectation | "Generate a validation pipeline..." |
| **A** | Assumptions | "Assume DTOs are records..." |
| **R** | Result format | "Return XML docs and implementation..." |

You don't need all five for every prompt, but the more context, the better the output.

## Prompt Patterns for Common .NET Tasks

### Pattern 1: Controller Generation

**Bad Prompt:**
```
create a user controller
```

**Good Prompt:**
```
Create an ASP.NET Core 8 UsersController that:
- Inherits from ControllerBase with [ApiController] attribute
- Uses constructor injection for ISender (MediatR)
- Has CRUD endpoints returning ActionResult<T>
- Uses records for request/response DTOs
- Includes XML documentation
- Handles not-found scenarios with appropriate status codes
```

**Result:**
```csharp
/// <summary>
/// Manages user resources.
/// </summary>
[ApiController]
[Route("api/[controller]")]
public class UsersController : ControllerBase
{
    private readonly ISender _mediator;

    public UsersController(ISender mediator) => _mediator = mediator;

    /// <summary>
    /// Gets a user by their unique identifier.
    /// </summary>
    /// <param name="id">The user's ID.</param>
    /// <returns>The user if found; otherwise, NotFound.</returns>
    [HttpGet("{id:int}")]
    [ProducesResponseType(typeof(UserResponse), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    public async Task<ActionResult<UserResponse>> Get(int id)
    {
        var user = await _mediator.Send(new GetUserQuery(id));
        return user is null ? NotFound() : Ok(user);
    }

    // ... additional endpoints
}

public record UserResponse(int Id, string Name, string Email, DateTime CreatedAt);
public record CreateUserRequest(string Name, string Email);
```

### Pattern 2: Unit Test Generation

**Bad Prompt:**
```
write tests for UserService
```

**Good Prompt:**
```
Generate xUnit tests for UserService.GetUserAsync method:

Testing framework: xUnit with FluentAssertions
Mocking: NSubstitute
Pattern: Arrange-Act-Assert with clear comments

Test cases needed:
1. Valid ID returns the user
2. Non-existent ID returns null
3. Negative ID throws ArgumentException
4. Repository throws exception - verify it propagates

Use _sut for system under test. Name tests as: MethodName_Scenario_ExpectedResult
```

**Result:**
```csharp
public class UserServiceTests
{
    private readonly IUserRepository _repository = Substitute.For<IUserRepository>();
    private readonly UserService _sut;

    public UserServiceTests()
    {
        _sut = new UserService(_repository);
    }

    [Fact]
    public async Task GetUserAsync_WithValidId_ReturnsUser()
    {
        // Arrange
        var expectedUser = new User { Id = 1, Name = "John", Email = "john@test.com" };
        _repository.GetByIdAsync(1).Returns(expectedUser);

        // Act
        var result = await _sut.GetUserAsync(1);

        // Assert
        result.Should().NotBeNull();
        result.Should().BeEquivalentTo(expectedUser);
    }

    [Fact]
    public async Task GetUserAsync_WithNonExistentId_ReturnsNull()
    {
        // Arrange
        _repository.GetByIdAsync(999).Returns((User?)null);

        // Act
        var result = await _sut.GetUserAsync(999);

        // Assert
        result.Should().BeNull();
    }

    [Fact]
    public async Task GetUserAsync_WithNegativeId_ThrowsArgumentException()
    {
        // Arrange & Act
        Func<Task> act = async () => await _sut.GetUserAsync(-1);

        // Assert
        await act.Should().ThrowAsync<ArgumentException>()
            .WithParameterName("id");
    }

    [Fact]
    public async Task GetUserAsync_WhenRepositoryThrows_PropagatesException()
    {
        // Arrange
        _repository.GetByIdAsync(Arg.Any<int>())
            .ThrowsAsync(new InvalidOperationException("Database error"));

        // Act
        Func<Task> act = async () => await _sut.GetUserAsync(1);

        // Assert
        await act.Should().ThrowAsync<InvalidOperationException>()
            .WithMessage("Database error");
    }
}
```

### Pattern 3: Entity Framework Configuration

**Good Prompt:**
```
Generate EF Core 8 entity configuration for a User entity:

Requirements:
- Table name: "users" (lowercase)
- Id: auto-increment, primary key
- Email: unique, required, max 255 chars
- Name: required, max 100 chars
- CreatedAt: default to UTC now, never updated
- UpdatedAt: auto-update on save
- HasMany relationship to Orders (cascade delete)
- Use shadow properties for audit fields

Implement IEntityTypeConfiguration<User>
```

### Pattern 4: Exception Handling

**Good Prompt:**
```
Create a custom exception hierarchy for a payment processing domain:

1. Base: PaymentException with ErrorCode enum property
2. Derived: PaymentDeclinedException, PaymentTimeoutException, PaymentValidationException
3. Each should include:
   - Meaningful default messages
   - Inner exception constructors
   - Serialization support
4. Include a static factory method for common scenarios
```

## Comment-Driven Development

For inline completions, comments are your prompt:

```csharp
// Validate that the email is unique in the database
// If duplicate found, throw a DuplicateEmailException with the email address
// Otherwise, return true
public async Task<bool> ValidateUniqueEmailAsync(string email)
{
    // Copilot generates:
    var exists = await _context.Users.AnyAsync(u => u.Email == email);
    if (exists)
    {
        throw new DuplicateEmailException(email);
    }
    return true;
}
```

### Multi-Line Comments for Complex Logic

```csharp
/*
 * Calculate the order total with the following rules:
 * 1. Sum all item prices (quantity * unit price)
 * 2. Apply discount if customer has loyalty status:
 *    - Gold: 15% off
 *    - Silver: 10% off
 *    - Bronze: 5% off
 * 3. Add tax (8.25%) after discount
 * 4. Add shipping (free if total > $100, else $9.99)
 * 5. Round to 2 decimal places
 */
public decimal CalculateOrderTotal(Order order, CustomerStatus status)
{
    // Copilot generates the complete implementation
}
```

## Iterative Prompting

Don't expect perfection on the first try. Iterate:

**Round 1:**
```
Create a retry policy for HTTP calls
```

**Response has issues, so Round 2:**
```
Update this to:
- Use Polly library
- Retry 3 times with exponential backoff
- Only retry on 5xx errors and timeouts
- Log each retry attempt
```

**Still needs work, Round 3:**
```
Also add a circuit breaker that opens after 5 consecutive failures
and stays open for 30 seconds
```

## Fixing Copilot's Output

When Copilot generates something close but not quite right:

### "Make it more [adjective]"
```
Make this code more:
- Testable (extract dependencies to interfaces)
- Defensive (add null checks and validation)
- Performant (use async properly, avoid allocations)
- Readable (extract methods, better names)
```

### "Convert this to [pattern]"
```
Convert this to:
- Use the Result pattern instead of exceptions
- Use async/await instead of Task.ContinueWith
- Use records instead of classes for DTOs
- Use the Options pattern for configuration
```

### "Add [feature]"
```
Add to this code:
- Cancellation token support
- Logging at appropriate levels
- Metrics/telemetry
- Input validation
```

## Negative Prompts

Tell Copilot what NOT to do:

```
Generate a repository class that:
- Uses EF Core for data access
- Has async methods for all operations

DO NOT:
- Use the repository pattern with generic repositories
- Add Unit of Work (DbContext handles it)
- Return IQueryable from methods
- Use FirstOrDefault without null handling
```

## Template Prompts for Your Team

Create standard prompts your team can reuse:

### API Endpoint Template
```
Create a [HTTP_METHOD] endpoint at [ROUTE] that:
- Accepts [INPUT_TYPE] from [BODY/QUERY/ROUTE]
- Validates input using FluentValidation
- Calls MediatR handler: [HANDLER_NAME]
- Returns [OUTPUT_TYPE] with appropriate status codes
- Includes OpenAPI documentation
```

### Service Method Template
```
Create a method [METHOD_NAME] that:
- Input: [PARAMETERS]
- Output: [RETURN_TYPE]
- Logic: [BUSINESS_RULES]
- Validation: [VALIDATION_RULES]
- Error handling: [ERROR_SCENARIOS]
- Dependencies: [REQUIRED_SERVICES]
```

### Test Class Template
```
Generate tests for [CLASS_NAME].[METHOD_NAME]:
- Framework: xUnit + FluentAssertions
- Mocking: NSubstitute
- Scenarios:
  1. [HAPPY_PATH]
  2. [EDGE_CASE_1]
  3. [EDGE_CASE_2]
  4. [ERROR_CASE]
- Use [TEST_DATA_APPROACH] for test data
```

## Context Loading Tricks

### Open Related Files

Before generating code, open:
- Interface definitions
- Related classes
- Existing similar implementations
- Test files showing expected patterns

Copilot uses open tabs as context.

### Use the # Symbol

In chat, reference specific files:
```
Based on #UserService.cs, create a similar ProductService
following the same patterns
```

### Include Sample Code

```
Generate a validator like this existing one:

```csharp
public class CreateUserValidator : AbstractValidator<CreateUserRequest>
{
    public CreateUserValidator()
    {
        RuleFor(x => x.Email).NotEmpty().EmailAddress();
        RuleFor(x => x.Name).NotEmpty().MaximumLength(100);
    }
}
```

Now create CreateProductValidator with rules for:
- Name: required, max 200 chars
- Price: positive number
- Category: must be a valid enum value
```

## Summary

In this post, we learned:

- The CLEAR framework for structuring prompts
- Specific patterns for .NET tasks (controllers, tests, EF configs)
- Comment-driven development for inline completions
- Iterative prompting to refine output
- Negative prompts to avoid unwanted patterns
- Template prompts for team consistency

In the next post, we'll explore **chat participants** (@workspace, @terminal, @github) – specialized agents that give Copilot superpowers for understanding your codebase and environment.

## GitHub Example

You can find example prompts and templates at: https://github.com/danielwarddev/CopilotDotNetExamples
