# GitHub Copilot for .NET Teams – Getting Started the Right Way

**Date:** March 31, 2026  
**Author:** Daniel Ward  
**URL:** https://daninacan.com/github-copilot-for-dotnet-teams-getting-started-the-right-way/

_This post is part of a series on GitHub Copilot for .NET teams:_

-   **GitHub Copilot for .NET Teams – Getting Started the Right Way** (this post)
-   [GitHub Copilot for .NET Teams – Writing Effective Prompts](https://daninacan.com/github-copilot-for-dotnet-teams-writing-effective-prompts/)
-   [GitHub Copilot for .NET Teams – Using Chat Participants Effectively](https://daninacan.com/github-copilot-for-dotnet-teams-using-chat-participants-effectively/)
-   [GitHub Copilot for .NET Teams – Custom Instructions with copilot-instructions.md](https://daninacan.com/github-copilot-for-dotnet-teams-custom-instructions-with-copilot-instructions-md/)
-   [GitHub Copilot for .NET Teams – Building Agent Skills for Your Codebase](https://daninacan.com/github-copilot-for-dotnet-teams-building-agent-skills-for-your-codebase/)

---

## Overview

Your organization just rolled out GitHub Copilot. You've got the licenses, it's enabled in VS Code and Visual Studio – now what? 

I've seen many teams treat Copilot like autocomplete-on-steroids and miss its most powerful features. This series is the guide I wish existed when my team adopted Copilot – practical patterns for .NET development, team configuration, and getting real value from AI coding assistance.

In this first post, we'll set up Copilot properly for .NET development and understand its core concepts.

## What GitHub Copilot Actually Is

Let's clear up some misconceptions:

| Copilot Is | Copilot Isn't |
|------------|---------------|
| An AI coding assistant | A replacement for developers |
| Context-aware code suggestions | A mind reader |
| Inline completions + chat interface | Just autocomplete |
| Configurable per-project | One-size-fits-all |

Copilot has several components:
- **Inline completions** – Code suggestions as you type
- **Copilot Chat** – Conversational interface for questions and generation
- **Chat Participants** – Specialized agents (@workspace, @terminal, etc.)
- **Custom Instructions** – Project-specific configuration
- **Agent Skills** – Custom tools you can build (new!)

## Setting Up Your .NET Project for Copilot

### 1. The .github Folder Structure

Create a `.github` folder in your repository root with Copilot configuration:

```
.github/
├── copilot-instructions.md    # Project-wide instructions
└── skills/                     # Custom agent skills (optional)
    └── my-skill/
        └── SKILL.md
```

### 2. Basic copilot-instructions.md

This file tells Copilot about your project's conventions:

```markdown
# Copilot Instructions for MyApp

## Project Overview
This is an ASP.NET Core 8 Web API using Clean Architecture.

## Technology Stack
- .NET 8
- Entity Framework Core 8 with PostgreSQL
- MediatR for CQRS
- FluentValidation for validation
- xUnit + FluentAssertions for testing

## Code Conventions

### Naming
- Use PascalCase for public members
- Use _camelCase for private fields
- Suffix interfaces with their purpose (IUserRepository, not IUser)

### Architecture
- Controllers should be thin - delegate to MediatR handlers
- Use records for DTOs
- Validation goes in FluentValidation validators, not in handlers

### Testing
- Test naming: MethodName_Scenario_ExpectedResult
- Use FluentAssertions for all assertions
- Mock external dependencies, use real database with TestContainers

## Patterns to Follow

### API Controllers
```csharp
[ApiController]
[Route("api/[controller]")]
public class UsersController : ControllerBase
{
    private readonly ISender _mediator;
    
    public UsersController(ISender mediator) => _mediator = mediator;
    
    [HttpGet("{id}")]
    public async Task<ActionResult<UserDto>> Get(int id)
        => Ok(await _mediator.Send(new GetUserQuery(id)));
}
```

### Unit Tests
```csharp
public class UserServiceTests
{
    [Fact]
    public async Task GetUser_WithValidId_ReturnsUser()
    {
        // Arrange
        var sut = new UserService(_mockRepo.Object);
        
        // Act
        var result = await sut.GetUserAsync(1);
        
        // Assert
        result.Should().NotBeNull();
    }
}
```

## What NOT to Generate
- Do not use var for everything - use explicit types for clarity
- Do not add unnecessary comments
- Do not create God classes - keep classes focused
```

### 3. Enable Copilot in Your IDE

**VS Code:**
1. Install the GitHub Copilot extension
2. Install the GitHub Copilot Chat extension
3. Sign in with your GitHub account

**Visual Studio:**
1. Update to VS 2022 17.10 or later
2. Enable Copilot in Extensions → Manage Extensions
3. Sign in via your GitHub account

## Understanding Inline Completions

Inline completions are what most people think of as "Copilot" – suggestions that appear as you type.

### Ghost Text

As you type, Copilot shows gray "ghost text" with suggestions:

```csharp
public async Task<User> GetUserAsync(int id)
{
    // You type this:
    var user = await _context.Users
    
    // Copilot suggests (in gray):
    .FirstOrDefaultAsync(u => u.Id == id);
```

Press **Tab** to accept, **Esc** to dismiss.

### Multiple Suggestions

Press **Alt+]** (VS Code) or **Alt+.** (Visual Studio) to see alternative suggestions. Copilot often has 2-3 options.

### Triggering Suggestions

Suggestions appear automatically, but you can force them:
- **VS Code:** Press Ctrl+Enter
- **Visual Studio:** Alt+/ or start typing

### Context Matters

Copilot uses context from:
1. **Current file** – What you're editing
2. **Open files** – Other tabs in your editor
3. **Comments** – Natural language descriptions
4. **File names** – "UserRepository.cs" hints at the pattern
5. **copilot-instructions.md** – Your project conventions

## Getting Better Suggestions

### Use Descriptive Names

Bad:
```csharp
public class Handler { }  // What does it handle?
```

Good:
```csharp
public class CreateUserCommandHandler { }  // Copilot understands the pattern
```

### Write Comments First

```csharp
// Get all active users who logged in within the last 30 days
// ordered by their last login date
public async Task<List<User>> GetRecentlyActiveUsers()
{
    // Copilot generates the implementation
}
```

### Use the Right File Context

Before generating a test, open:
- The class you're testing
- An existing test file (for pattern reference)
- Your test configuration files

## Copilot Chat Basics

Beyond inline completions, Copilot Chat lets you have conversations about code.

### Opening Chat

- **VS Code:** Click the Copilot icon in the sidebar
- **Visual Studio:** View → GitHub Copilot Chat

### Basic Commands

```
// Explain code
/explain what does this LINQ query do?

// Fix problems
/fix this null reference exception

// Generate tests
/tests generate tests for this class

// Documentation
/doc add XML documentation
```

### Selecting Context

Highlight code before asking questions – Copilot uses your selection as context:

1. Select a method
2. Open Chat
3. Ask: "What edge cases should I handle?"

## Chat Participants (Agents)

Chat participants are specialized agents for different tasks:

| Participant | Purpose |
|-------------|---------|
| `@workspace` | Questions about your entire codebase |
| `@terminal` | Terminal commands and explanations |
| `@vscode` | VS Code settings and extensions |
| `@github` | GitHub-specific queries (PRs, issues) |

### @workspace Example

```
@workspace how do we handle authentication in this project?
```

Copilot searches your entire codebase and provides a contextual answer.

### @terminal Example

```
@terminal how do I run the integration tests?
```

Copilot looks at your package.json, scripts, and project files to answer.

## .NET-Specific Tips

### Entity Framework Generation

```csharp
// Add context with a comment:
// User entity with navigation to Orders
// Use shadow properties for audit fields
public class User
{
    // Copilot generates appropriate properties and configuration
}
```

### Test Generation

Select a method and ask:
```
/tests generate xUnit tests with FluentAssertions
include happy path and edge cases
mock the repository with NSubstitute
```

### API Endpoint Generation

Start with the summary:
```csharp
/// <summary>
/// Creates a new user after validating the request.
/// Returns 201 Created with the user location.
/// Returns 400 Bad Request if validation fails.
/// Returns 409 Conflict if email already exists.
/// </summary>
[HttpPost]
public async Task<ActionResult<UserDto>> Create([FromBody] CreateUserRequest request)
{
    // Copilot generates complete implementation
}
```

## What's Coming in This Series

| Post | Topic |
|------|-------|
| **Part 2** | Writing effective prompts for .NET code generation |
| **Part 3** | Using chat participants (@workspace, @terminal, @github) |
| **Part 4** | Custom instructions with copilot-instructions.md |
| **Part 5** | Building custom agent skills for your codebase |

## Summary

In this introduction, we covered:

- What GitHub Copilot actually is and isn't
- Setting up the .github folder with copilot-instructions.md
- Understanding inline completions and ghost text
- Basic Copilot Chat commands and workflows
- Chat participants for specialized queries
- .NET-specific tips for better suggestions

In the next post, we'll dive deep into **writing effective prompts** – the art of getting Copilot to generate exactly the code you need, with the patterns your team follows.

## GitHub Example

You can find a full example copilot-instructions.md and skill configurations at: https://github.com/danielwarddev/CopilotDotNetExamples
