# GitHub Copilot for .NET Teams – Building Agent Skills for Your Codebase

**Date:** April 28, 2026  
**Author:** Daniel Ward  
**URL:** https://daninacan.com/github-copilot-for-dotnet-teams-building-agent-skills-for-your-codebase/

_This post is part of a series on GitHub Copilot for .NET teams:_

-   [GitHub Copilot for .NET Teams – Getting Started the Right Way](https://daninacan.com/github-copilot-for-dotnet-teams-getting-started-the-right-way/)
-   [GitHub Copilot for .NET Teams – Writing Effective Prompts](https://daninacan.com/github-copilot-for-dotnet-teams-writing-effective-prompts/)
-   [GitHub Copilot for .NET Teams – Using Chat Participants Effectively](https://daninacan.com/github-copilot-for-dotnet-teams-using-chat-participants-effectively/)
-   [GitHub Copilot for .NET Teams – Custom Instructions with copilot-instructions.md](https://daninacan.com/github-copilot-for-dotnet-teams-custom-instructions-with-copilot-instructions-md/)
-   **GitHub Copilot for .NET Teams – Building Agent Skills for Your Codebase** (this post)

---

## Overview

Custom instructions tell Copilot about your conventions. But what if you could give Copilot specialized capabilities – like generating EF migrations, scaffolding new features, or running your specific test commands? That's what Agent Skills do.

Agent Skills are a newer Copilot feature (December 2025) that let you extend Copilot with domain-specific knowledge and procedures. In this final post, we'll build practical skills for a .NET codebase.

## What Are Agent Skills?

Agent Skills are markdown files that define:
- **When** the skill should be used (description/trigger)
- **What** the skill does (instructions)
- **How** to do it (step-by-step procedures)

Think of them as specialized assistants within Copilot that know exactly how YOUR project works.

## Skill File Structure

Skills live in your repository:
```
.github/
├── copilot-instructions.md    # General instructions
└── skills/                     # Custom skills directory
    ├── new-feature/
    │   └── SKILL.md
    ├── ef-migrations/
    │   └── SKILL.md
    └── integration-tests/
        └── SKILL.md
```

Each skill needs a `SKILL.md` file with frontmatter:

```markdown
---
name: skill-name
description: When to use this skill
---

# Skill content here
```

## Skill 1: New Feature Generator

This skill helps developers scaffold a new feature following your team's patterns.

```markdown
---
name: new-feature
description: Scaffold a new feature with controller, handler, DTO, validator, and tests. Use when creating a new feature or entity.
---

# New Feature Generator

This skill generates all the files needed for a new feature in our Clean Architecture project.

## When to Use

- Adding a new entity/feature to the API
- Creating a full CRUD module
- Scaffolding the standard feature structure

## Required Information

Before using this skill, gather:
1. **Feature name** (e.g., "Product", "Order", "Shipment")
2. **Properties** for the entity
3. **Relationships** to other entities
4. **Special business rules** (if any)

## File Structure to Generate

For a feature named `[Feature]`, create:

```
src/
├── Domain/
│   └── Entities/
│       └── [Feature].cs
├── Application/
│   └── [Feature]s/
│       ├── Commands/
│       │   ├── Create[Feature]/
│       │   │   ├── Create[Feature]Command.cs
│       │   │   ├── Create[Feature]Handler.cs
│       │   │   └── Create[Feature]Validator.cs
│       │   └── Update[Feature]/
│       │       └── ...
│       ├── Queries/
│       │   └── Get[Feature]/
│       │       └── ...
│       └── DTOs/
│           └── [Feature]Dto.cs
├── Infrastructure/
│   └── Data/
│       ├── Configurations/
│       │   └── [Feature]Configuration.cs
│       └── Repositories/
│           └── [Feature]Repository.cs
└── Api/
    └── Controllers/
        └── [Feature]sController.cs

tests/
├── UnitTests/
│   └── [Feature]s/
│       └── Create[Feature]HandlerTests.cs
└── IntegrationTests/
    └── [Feature]sControllerTests.cs
```

## Code Templates

### Entity Template

```csharp
namespace MyApp.Domain.Entities;

public class [Feature] : BaseEntity
{
    // Properties here
    
    // Navigation properties
    
    // Domain methods if needed
}
```

### Command Template

```csharp
namespace MyApp.Application.[Feature]s.Commands.Create[Feature];

public record Create[Feature]Command(
    // properties
) : IRequest<int>;

public class Create[Feature]Handler : IRequestHandler<Create[Feature]Command, int>
{
    private readonly I[Feature]Repository _repository;

    public Create[Feature]Handler(I[Feature]Repository repository)
        => _repository = repository;

    public async Task<int> Handle(Create[Feature]Command request, CancellationToken ct)
    {
        var entity = new [Feature](/* map from request */);
        await _repository.AddAsync(entity, ct);
        return entity.Id;
    }
}
```

### Controller Template

```csharp
namespace MyApp.Api.Controllers;

[ApiController]
[Route("api/[controller]")]
public class [Feature]sController : ControllerBase
{
    private readonly ISender _mediator;

    public [Feature]sController(ISender mediator) => _mediator = mediator;

    [HttpPost]
    [ProducesResponseType(typeof(int), StatusCodes.Status201Created)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public async Task<ActionResult<int>> Create(
        [FromBody] Create[Feature]Request request,
        CancellationToken ct)
    {
        var id = await _mediator.Send(
            new Create[Feature]Command(/* map from request */), ct);
        return CreatedAtAction(nameof(Get), new { id }, id);
    }

    [HttpGet("{id:int}")]
    [ProducesResponseType(typeof([Feature]Dto), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    public async Task<ActionResult<[Feature]Dto>> Get(int id, CancellationToken ct)
    {
        var result = await _mediator.Send(new Get[Feature]Query(id), ct);
        return result is null ? NotFound() : Ok(result);
    }
}
```

## Step-by-Step Process

1. **Create the entity** in Domain/Entities
2. **Create the EF configuration** in Infrastructure/Data/Configurations
3. **Create repository interface** in Domain/Interfaces
4. **Implement repository** in Infrastructure/Data/Repositories
5. **Register repository** in ServiceCollectionExtensions
6. **Create DTOs** in Application/[Feature]s/DTOs
7. **Create Commands** with handlers and validators
8. **Create Queries** with handlers
9. **Create Controller** with all endpoints
10. **Run migrations** to update database
11. **Create unit tests** for handlers
12. **Create integration tests** for API endpoints

## Example Usage

User prompt: "Create a new Shipment feature with TrackingNumber, Status, OrderId, and ShippedDate"

Follow the templates above, replacing [Feature] with Shipment.
```

## Skill 2: EF Core Migration Helper

This skill guides developers through EF Core migrations:

```markdown
---
name: ef-migrations
description: Help with Entity Framework Core migrations. Use when adding, updating, or troubleshooting database migrations.
---

# EF Core Migration Helper

This skill helps with Entity Framework Core migrations in our project.

## Project Configuration

Our EF Core setup:
- **DbContext:** `AppDbContext` in `MyApp.Infrastructure`
- **Startup Project:** `MyApp.Api`
- **Database:** PostgreSQL

## Common Tasks

### Create a New Migration

```bash
dotnet ef migrations add [MigrationName] \
  --project src/MyApp.Infrastructure \
  --startup-project src/MyApp.Api
```

Example:
```bash
dotnet ef migrations add AddShipmentEntity \
  --project src/MyApp.Infrastructure \
  --startup-project src/MyApp.Api
```

### Apply Migrations

To development database:
```bash
dotnet ef database update \
  --project src/MyApp.Infrastructure \
  --startup-project src/MyApp.Api
```

To specific migration:
```bash
dotnet ef database update [MigrationName] \
  --project src/MyApp.Infrastructure \
  --startup-project src/MyApp.Api
```

### Remove Last Migration

Only if not yet applied to database:
```bash
dotnet ef migrations remove \
  --project src/MyApp.Infrastructure \
  --startup-project src/MyApp.Api
```

### Generate SQL Script

For production deployment:
```bash
dotnet ef migrations script [FromMigration] [ToMigration] \
  --project src/MyApp.Infrastructure \
  --startup-project src/MyApp.Api \
  --output migrations.sql
```

### List Migrations

```bash
dotnet ef migrations list \
  --project src/MyApp.Infrastructure \
  --startup-project src/MyApp.Api
```

## Troubleshooting

### "No DbContext was found"

Ensure startup project references Infrastructure project and calls:
```csharp
services.AddDbContext<AppDbContext>(options =>
    options.UseNpgsql(connectionString));
```

### "Unable to create an object of type 'AppDbContext'"

Add a design-time factory:
```csharp
public class AppDbContextFactory : IDesignTimeDbContextFactory<AppDbContext>
{
    public AppDbContext CreateDbContext(string[] args)
    {
        var optionsBuilder = new DbContextOptionsBuilder<AppDbContext>();
        optionsBuilder.UseNpgsql("Host=localhost;Database=myapp_dev");
        return new AppDbContext(optionsBuilder.Options);
    }
}
```

### Migration Conflicts

If you have migration conflicts after a merge:
1. Remove your local migration (if not applied)
2. Pull the latest migrations
3. Re-create your migration with a new name

## Entity Configuration Template

When adding a new entity, create a configuration:

```csharp
public class [Entity]Configuration : IEntityTypeConfiguration<[Entity]>
{
    public void Configure(EntityTypeBuilder<[Entity]> builder)
    {
        builder.ToTable("[entities]"); // lowercase, plural
        
        builder.HasKey(e => e.Id);
        builder.Property(e => e.Id).ValueGeneratedOnAdd();
        
        // Configure properties
        builder.Property(e => e.Name)
            .IsRequired()
            .HasMaxLength(100);
            
        // Configure relationships
        builder.HasOne(e => e.Related)
            .WithMany(r => r.[Entities])
            .HasForeignKey(e => e.RelatedId)
            .OnDelete(DeleteBehavior.Cascade);
            
        // Configure indexes
        builder.HasIndex(e => e.UniqueField).IsUnique();
    }
}
```
```

## Skill 3: Integration Test Setup

This skill helps set up integration tests:

```markdown
---
name: integration-tests
description: Set up and run integration tests with TestContainers. Use when writing or debugging integration tests.
---

# Integration Test Helper

This skill helps with integration testing using TestContainers and WebApplicationFactory.

## Test Infrastructure

Our integration tests use:
- **xUnit** for test framework
- **TestContainers** for PostgreSQL
- **WebApplicationFactory** for API testing
- **Respawn** for database cleanup

## Base Test Class

All integration tests inherit from:

```csharp
public abstract class IntegrationTestBase : IAsyncLifetime
{
    protected PostgreSqlContainer Postgres { get; private set; } = null!;
    protected WebApplicationFactory<Program> Factory { get; private set; } = null!;
    protected HttpClient Client { get; private set; } = null!;
    protected Respawner Respawner { get; private set; } = null!;

    public async Task InitializeAsync()
    {
        Postgres = new PostgreSqlBuilder()
            .WithImage("postgres:16")
            .Build();
        await Postgres.StartAsync();

        Factory = new WebApplicationFactory<Program>()
            .WithWebHostBuilder(builder =>
            {
                builder.ConfigureServices(services =>
                {
                    services.RemoveAll<DbContextOptions<AppDbContext>>();
                    services.AddDbContext<AppDbContext>(options =>
                        options.UseNpgsql(Postgres.GetConnectionString()));
                });
            });

        Client = Factory.CreateClient();

        // Apply migrations
        using var scope = Factory.Services.CreateScope();
        var db = scope.ServiceProvider.GetRequiredService<AppDbContext>();
        await db.Database.MigrateAsync();

        // Setup Respawn
        await using var connection = new NpgsqlConnection(Postgres.GetConnectionString());
        await connection.OpenAsync();
        Respawner = await Respawner.CreateAsync(connection, new RespawnerOptions
        {
            DbAdapter = DbAdapter.Postgres,
            TablesToIgnore = new[] { new Table("__EFMigrationsHistory") }
        });
    }

    protected async Task ResetDatabaseAsync()
    {
        await using var connection = new NpgsqlConnection(Postgres.GetConnectionString());
        await connection.OpenAsync();
        await Respawner.ResetAsync(connection);
    }

    protected async Task<T> AddAsync<T>(T entity) where T : class
    {
        using var scope = Factory.Services.CreateScope();
        var db = scope.ServiceProvider.GetRequiredService<AppDbContext>();
        db.Set<T>().Add(entity);
        await db.SaveChangesAsync();
        return entity;
    }

    public async Task DisposeAsync()
    {
        Client.Dispose();
        await Factory.DisposeAsync();
        await Postgres.DisposeAsync();
    }
}
```

## Running Tests

### Run all integration tests
```bash
dotnet test tests/MyApp.IntegrationTests
```

### Run specific test class
```bash
dotnet test tests/MyApp.IntegrationTests --filter "FullyQualifiedName~UsersControllerTests"
```

### Run with verbose output
```bash
dotnet test tests/MyApp.IntegrationTests --logger "console;verbosity=detailed"
```

## Test Template

```csharp
public class [Feature]ControllerTests : IntegrationTestBase
{
    [Fact]
    public async Task Create_WithValidRequest_Returns201()
    {
        // Arrange
        await ResetDatabaseAsync();
        var request = new Create[Feature]Request { /* ... */ };

        // Act
        var response = await Client.PostAsJsonAsync("/api/[features]", request);

        // Assert
        response.StatusCode.Should().Be(HttpStatusCode.Created);
        var result = await response.Content.ReadFromJsonAsync<int>();
        result.Should().BePositive();
    }

    [Fact]
    public async Task Get_WithExistingId_Returns200()
    {
        // Arrange
        await ResetDatabaseAsync();
        var entity = await AddAsync(new [Feature] { /* ... */ });

        // Act
        var response = await Client.GetAsync($"/api/[features]/{entity.Id}");

        // Assert
        response.StatusCode.Should().Be(HttpStatusCode.OK);
    }

    [Fact]
    public async Task Get_WithNonExistentId_Returns404()
    {
        // Arrange
        await ResetDatabaseAsync();

        // Act
        var response = await Client.GetAsync("/api/[features]/99999");

        // Assert
        response.StatusCode.Should().Be(HttpStatusCode.NotFound);
    }
}
```

## Debugging Tips

### View SQL queries
Add to test setup:
```csharp
builder.ConfigureServices(services =>
{
    services.AddLogging(logging =>
    {
        logging.AddConsole();
        logging.SetMinimumLevel(LogLevel.Debug);
    });
});
```

### Inspect database state
```csharp
[Fact]
public async Task Debug_ViewDatabaseState()
{
    using var scope = Factory.Services.CreateScope();
    var db = scope.ServiceProvider.GetRequiredService<AppDbContext>();
    var entities = await db.[Entities].ToListAsync();
    // Set breakpoint here to inspect
}
```
```

## Using Skills in Chat

Once you've created skills, use them in Copilot Chat:

```
I need to create a new Shipment feature
```

Copilot recognizes this matches the `new-feature` skill and follows its instructions.

```
How do I run migrations for the new entity I added?
```

Copilot uses the `ef-migrations` skill to provide project-specific commands.

## Tips for Effective Skills

### 1. Be Specific

```markdown
# Bad
description: Database stuff

# Good
description: Entity Framework Core migrations - creating, applying, and troubleshooting database migrations
```

### 2. Include Real Examples

Use actual paths, commands, and code from your project.

### 3. Cover Common Scenarios

Include troubleshooting sections for things that commonly go wrong.

### 4. Keep Updated

Review skills quarterly – they should evolve with your codebase.

## Summary

In this final post, we learned how to:

- Create Agent Skills to extend Copilot's capabilities
- Build a feature scaffolding skill
- Create migration helper skills
- Set up integration test skills

## Series Summary

Throughout this series, we've transformed Copilot from a generic tool into a customized development assistant:

1. **Getting Started** – Setup and basic usage
2. **Writing Prompts** – The CLEAR framework for effective prompting
3. **Chat Participants** – @workspace, @terminal, @github
4. **Custom Instructions** – Project-wide conventions in copilot-instructions.md
5. **Agent Skills** – Domain-specific capabilities

With these tools, your team can get consistent, high-quality AI assistance that follows your patterns and knows your codebase.

## GitHub Example

You can find complete skill examples at: https://github.com/danielwarddev/CopilotDotNetExamples
