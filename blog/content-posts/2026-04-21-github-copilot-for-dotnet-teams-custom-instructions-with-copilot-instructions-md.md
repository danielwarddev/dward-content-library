# GitHub Copilot for .NET Teams – Custom Instructions with copilot-instructions.md

**Date:** April 21, 2026  
**Author:** Daniel Ward  
**URL:** https://daninacan.com/github-copilot-for-dotnet-teams-custom-instructions-with-copilot-instructions-md/

_This post is part of a series on GitHub Copilot for .NET teams:_

-   [GitHub Copilot for .NET Teams – Getting Started the Right Way](https://daninacan.com/github-copilot-for-dotnet-teams-getting-started-the-right-way/)
-   [GitHub Copilot for .NET Teams – Writing Effective Prompts](https://daninacan.com/github-copilot-for-dotnet-teams-writing-effective-prompts/)
-   [GitHub Copilot for .NET Teams – Using Chat Participants Effectively](https://daninacan.com/github-copilot-for-dotnet-teams-using-chat-participants-effectively/)
-   **GitHub Copilot for .NET Teams – Custom Instructions with copilot-instructions.md** (this post)
-   [GitHub Copilot for .NET Teams – Building Agent Skills for Your Codebase](https://daninacan.com/github-copilot-for-dotnet-teams-building-agent-skills-for-your-codebase/)

---

## Overview

Every team has conventions: naming patterns, preferred libraries, architectural rules, testing standards. Without custom instructions, you'll spend time correcting Copilot's output to match your patterns – or worse, inconsistent code sneaks in.

The `copilot-instructions.md` file tells Copilot how YOUR team writes code. In this post, we'll create comprehensive custom instructions for a .NET team.

## Where to Put Instructions

Create the file at:
```
.github/copilot-instructions.md
```

Copilot automatically reads this file and applies the instructions to all suggestions and chat responses for your repository.

## Anatomy of Good Instructions

### Structure

```markdown
# [Project Name] Copilot Instructions

## Project Overview
Brief description of what the project does and its architecture.

## Technology Stack
List of technologies and versions.

## Code Conventions
Specific rules for how code should be written.

## Patterns to Follow
Examples of patterns your team uses.

## Anti-Patterns to Avoid
Things Copilot should NOT generate.

## Testing Standards
How tests should be written.

## Common Tasks
Instructions for frequent operations.
```

## Complete Example: E-Commerce API

Here's a real-world example for an e-commerce API:

```markdown
# ShopAPI Copilot Instructions

## Project Overview

ShopAPI is an e-commerce REST API built with ASP.NET Core 8 following Clean Architecture principles. The solution contains four projects:

- **ShopAPI.Domain** - Entities, value objects, domain events
- **ShopAPI.Application** - CQRS handlers, DTOs, interfaces
- **ShopAPI.Infrastructure** - EF Core, external services, repositories
- **ShopAPI.Api** - Controllers, middleware, configuration

## Technology Stack

| Technology | Version | Purpose |
|------------|---------|---------|
| .NET | 8.0 | Runtime |
| ASP.NET Core | 8.0 | Web framework |
| Entity Framework Core | 8.0 | ORM |
| PostgreSQL | 16 | Database |
| MediatR | 12.x | CQRS/Mediator |
| FluentValidation | 11.x | Input validation |
| Serilog | 3.x | Logging |
| xUnit | 2.x | Testing framework |
| FluentAssertions | 6.x | Test assertions |
| NSubstitute | 5.x | Mocking |
| TestContainers | 3.x | Integration testing |

## Code Conventions

### Naming

- **Files:** PascalCase matching the primary type (UserService.cs, CreateUserCommand.cs)
- **Namespaces:** Match folder structure (ShopAPI.Application.Users.Commands)
- **Classes/Records:** PascalCase nouns (User, CreateUserCommand)
- **Interfaces:** I + PascalCase describing purpose (IUserRepository, not IUser)
- **Methods:** PascalCase verbs (GetUserAsync, CreateOrder)
- **Private fields:** _camelCase (_userRepository)
- **Local variables:** camelCase (userId, orderItems)
- **Constants:** PascalCase (MaxRetryCount, DefaultPageSize)

### Formatting

- Use file-scoped namespaces
- One class per file (except private nested classes)
- Order members: Fields, Constructors, Properties, Methods
- Use expression-bodied members for single-line implementations
- Maximum line length: 120 characters

### Async/Await

- All I/O methods must be async
- Suffix async methods with Async (GetUserAsync)
- Accept CancellationToken in public async methods
- Never use .Result or .Wait() - always await

### Null Handling

- Use nullable reference types (enabled project-wide)
- Use null-forgiving (!) only when logically certain
- Prefer null-conditional (?.) over explicit null checks
- Use records with required properties for DTOs

## Architecture Patterns

### Controllers

Controllers MUST:
- Inherit from ControllerBase
- Use [ApiController] and [Route("api/[controller]")] attributes
- Accept only DTOs, never entities
- Delegate all logic to MediatR handlers
- Return ActionResult<T> with appropriate status codes

```csharp
[ApiController]
[Route("api/[controller]")]
public class UsersController : ControllerBase
{
    private readonly ISender _mediator;

    public UsersController(ISender mediator) => _mediator = mediator;

    [HttpGet("{id:int}")]
    [ProducesResponseType(typeof(UserDto), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    public async Task<ActionResult<UserDto>> Get(int id, CancellationToken ct)
    {
        var user = await _mediator.Send(new GetUserQuery(id), ct);
        return user is null ? NotFound() : Ok(user);
    }
}
```

### Commands and Queries (CQRS)

Use MediatR with this structure:

```csharp
// Command - in Application/Users/Commands/CreateUser/
public record CreateUserCommand(string Name, string Email) : IRequest<int>;

public class CreateUserHandler : IRequestHandler<CreateUserCommand, int>
{
    private readonly IUserRepository _repository;

    public CreateUserHandler(IUserRepository repository) => _repository = repository;

    public async Task<int> Handle(CreateUserCommand request, CancellationToken ct)
    {
        var user = new User(request.Name, request.Email);
        await _repository.AddAsync(user, ct);
        return user.Id;
    }
}
```

### Validation

Use FluentValidation for all command/query validation:

```csharp
public class CreateUserValidator : AbstractValidator<CreateUserCommand>
{
    public CreateUserValidator(IUserRepository repository)
    {
        RuleFor(x => x.Name)
            .NotEmpty().WithMessage("Name is required")
            .MaximumLength(100).WithMessage("Name cannot exceed 100 characters");

        RuleFor(x => x.Email)
            .NotEmpty().WithMessage("Email is required")
            .EmailAddress().WithMessage("Invalid email format")
            .MustAsync(async (email, ct) => !await repository.EmailExistsAsync(email, ct))
            .WithMessage("Email already in use");
    }
}
```

### Repositories

Repositories encapsulate data access:

```csharp
public interface IUserRepository
{
    Task<User?> GetByIdAsync(int id, CancellationToken ct = default);
    Task<IReadOnlyList<User>> GetAllAsync(CancellationToken ct = default);
    Task AddAsync(User user, CancellationToken ct = default);
    Task UpdateAsync(User user, CancellationToken ct = default);
    Task DeleteAsync(User user, CancellationToken ct = default);
}
```

### DTOs

Use records for all DTOs:

```csharp
public record UserDto(int Id, string Name, string Email, DateTime CreatedAt);
public record CreateUserRequest(string Name, string Email);
public record UpdateUserRequest(string Name, string? Email);
```

## Anti-Patterns to Avoid

DO NOT generate code that:

1. **Exposes entities directly** - Always map to DTOs
2. **Uses static methods for business logic** - Use instance methods and DI
3. **Catches generic Exception** - Catch specific exception types
4. **Uses magic strings** - Use constants or configuration
5. **Has logic in controllers** - Controllers delegate to handlers
6. **Uses synchronous I/O** - All I/O must be async
7. **Swallows exceptions silently** - Log and rethrow or handle explicitly
8. **Uses Service Locator pattern** - Use constructor injection
9. **Returns IQueryable from repositories** - Return materialized collections
10. **Uses var for everything** - Use explicit types for clarity

## Testing Standards

### Unit Tests

```csharp
public class CreateUserHandlerTests
{
    private readonly IUserRepository _repository = Substitute.For<IUserRepository>();
    private readonly CreateUserHandler _sut;

    public CreateUserHandlerTests() => _sut = new CreateUserHandler(_repository);

    [Fact]
    public async Task Handle_WithValidCommand_CreatesUserAndReturnsId()
    {
        // Arrange
        var command = new CreateUserCommand("John", "john@test.com");
        _repository.AddAsync(Arg.Any<User>(), Arg.Any<CancellationToken>())
            .Returns(Task.CompletedTask);

        // Act
        var result = await _sut.Handle(command, CancellationToken.None);

        // Assert
        result.Should().BePositive();
        await _repository.Received(1).AddAsync(
            Arg.Is<User>(u => u.Name == "John" && u.Email == "john@test.com"),
            Arg.Any<CancellationToken>());
    }
}
```

### Integration Tests

```csharp
public class UsersApiTests : IAsyncLifetime
{
    private PostgreSqlContainer _postgres = null!;
    private WebApplicationFactory<Program> _factory = null!;
    private HttpClient _client = null!;

    public async Task InitializeAsync()
    {
        _postgres = new PostgreSqlBuilder().Build();
        await _postgres.StartAsync();
        
        _factory = new WebApplicationFactory<Program>()
            .WithWebHostBuilder(b => b.ConfigureServices(s =>
            {
                s.RemoveAll<DbContextOptions<AppDbContext>>();
                s.AddDbContext<AppDbContext>(o => 
                    o.UseNpgsql(_postgres.GetConnectionString()));
            }));
            
        _client = _factory.CreateClient();
    }

    [Fact]
    public async Task CreateUser_WithValidRequest_Returns201()
    {
        var request = new CreateUserRequest("John", "john@test.com");
        
        var response = await _client.PostAsJsonAsync("/api/users", request);
        
        response.StatusCode.Should().Be(HttpStatusCode.Created);
    }

    public async Task DisposeAsync()
    {
        _client.Dispose();
        await _factory.DisposeAsync();
        await _postgres.DisposeAsync();
    }
}
```

### Test Naming

Use this format: `MethodName_Scenario_ExpectedResult`

Examples:
- `GetUserAsync_WithValidId_ReturnsUser`
- `CreateUser_WithDuplicateEmail_ThrowsException`
- `UpdateUser_WithNonExistentId_ReturnsNotFound`

## Common Tasks

### Adding a New Endpoint

1. Create Command/Query record in Application/[Feature]/Commands/ or Queries/
2. Create Handler implementing IRequestHandler
3. Create Validator extending AbstractValidator
4. Add Controller action delegating to MediatR
5. Add unit tests for Handler
6. Add integration tests for Controller

### Adding a New Entity

1. Create Entity class in Domain/Entities/
2. Create EF Configuration in Infrastructure/Data/Configurations/
3. Add DbSet to AppDbContext
4. Create migration: `dotnet ef migrations add AddEntity`
5. Create Repository interface in Domain/Interfaces/
6. Implement Repository in Infrastructure/Data/Repositories/
7. Register repository in DI container
```

## Updating Instructions Over Time

Your instructions should evolve:

1. **When patterns change** - Update the examples
2. **When new libraries are added** - Document them
3. **When anti-patterns emerge** - Add to the avoid list
4. **When onboarding reveals gaps** - Add clarifications

Consider a quarterly review of your copilot-instructions.md.

## Team Adoption Tips

### Get Buy-In

1. Start with a draft based on existing code
2. Review with the team
3. Iterate based on feedback
4. Make it a living document

### Enforce Consistency

- Include copilot-instructions.md in code review checklist
- Update when patterns are established in PRs
- Reference during onboarding

### Measure Effectiveness

Track:
- Time to correct Copilot suggestions
- Consistency of generated code in PRs
- Onboarding time for new developers

## Summary

In this post, we learned how to:

- Create comprehensive copilot-instructions.md
- Document technology stack and conventions
- Provide pattern examples Copilot can follow
- List anti-patterns to avoid
- Define testing standards

In the final post, we'll explore **building custom agent skills** – extending Copilot with specialized capabilities for your specific codebase.

## GitHub Example

You can find a complete copilot-instructions.md template at: https://github.com/danielwarddev/CopilotDotNetExamples
