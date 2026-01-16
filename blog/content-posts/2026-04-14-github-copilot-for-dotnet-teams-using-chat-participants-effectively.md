# GitHub Copilot for .NET Teams – Using Chat Participants Effectively

**Date:** April 14, 2026  
**Author:** Daniel Ward  
**URL:** https://daninacan.com/github-copilot-for-dotnet-teams-using-chat-participants-effectively/

_This post is part of a series on GitHub Copilot for .NET teams:_

-   [GitHub Copilot for .NET Teams – Getting Started the Right Way](https://daninacan.com/github-copilot-for-dotnet-teams-getting-started-the-right-way/)
-   [GitHub Copilot for .NET Teams – Writing Effective Prompts](https://daninacan.com/github-copilot-for-dotnet-teams-writing-effective-prompts/)
-   **GitHub Copilot for .NET Teams – Using Chat Participants Effectively** (this post)
-   [GitHub Copilot for .NET Teams – Custom Instructions with copilot-instructions.md](https://daninacan.com/github-copilot-for-dotnet-teams-custom-instructions-with-copilot-instructions-md/)
-   [GitHub Copilot for .NET Teams – Building Agent Skills for Your Codebase](https://daninacan.com/github-copilot-for-dotnet-teams-building-agent-skills-for-your-codebase/)

---

## Overview

Chat participants are specialized agents that extend Copilot's capabilities beyond the current file. Instead of just looking at your open tabs, these agents can search your entire workspace, run terminal commands, query GitHub data, and more.

In this post, we'll master each chat participant and learn when to use them for .NET development.

## Available Chat Participants

| Participant | What It Does |
|-------------|--------------|
| `@workspace` | Searches and understands your entire codebase |
| `@terminal` | Explains and generates terminal commands |
| `@vscode` | VS Code settings, extensions, and configuration |
| `@github` | GitHub repos, PRs, issues, and actions |

## @workspace – Your Codebase Expert

The `@workspace` participant is the most powerful for .NET developers. It can search and understand your entire solution.

### Finding Code Patterns

```
@workspace how do we implement the repository pattern in this project?
```

Copilot searches your codebase and explains your implementation:

> "Based on your codebase, you use the generic repository pattern with EF Core. Here's how it works:
> 
> 1. `IRepository<T>` interface in `Domain/Interfaces/`
> 2. `EfRepository<T>` implementation in `Infrastructure/Data/`
> 3. Registration in `ServiceCollectionExtensions.cs`
> 
> Here's an example from `UserRepository.cs`..."

### Understanding Architecture

```
@workspace explain the architecture of this solution and how the projects relate to each other
```

### Finding Related Code

```
@workspace find all places where we handle user authentication
```

### Code Navigation

```
@workspace where is the CreateUserCommand handler implemented?
```

### Refactoring Assistance

```
@workspace I need to add soft delete to all entities. 
What would need to change across the codebase?
```

### .NET-Specific @workspace Queries

**Find all MediatR handlers:**
```
@workspace list all MediatR command and query handlers in this project
```

**Understand DI configuration:**
```
@workspace how is dependency injection configured? 
Show me where services are registered.
```

**Find API endpoints:**
```
@workspace what API endpoints exist for user management?
```

**Understand database schema:**
```
@workspace describe the database schema based on our EF Core entities and configurations
```

**Find test patterns:**
```
@workspace show me examples of integration tests that use TestContainers
```

### Creating New Code Based on Patterns

```
@workspace based on how ProductController and ProductService are implemented,
create an OrderController and OrderService following the same patterns
```

### Onboarding Questions

New team member questions:
```
@workspace how do I run the application locally?
```

```
@workspace what's the testing strategy in this project?
```

```
@workspace how do we handle configuration and secrets?
```

## @terminal – Command Line Expert

The `@terminal` participant helps with terminal commands, scripts, and CLI tools.

### Running the Project

```
@terminal how do I run this .NET solution in development mode?
```

> "Based on your project structure, you can run:
> ```
> dotnet run --project src/MyApp.Api
> ```
> Or use the launch profile:
> ```
> dotnet run --project src/MyApp.Api --launch-profile Development
> ```"

### Docker Commands

```
@terminal how do I build and run this project with Docker?
```

```
@terminal generate a docker-compose command to start the API with its dependencies
```

### Database Migrations

```
@terminal how do I create and apply EF Core migrations?
```

> "To create a new migration:
> ```
> dotnet ef migrations add MigrationName --project src/MyApp.Infrastructure --startup-project src/MyApp.Api
> ```
> To apply migrations:
> ```
> dotnet ef database update --project src/MyApp.Infrastructure --startup-project src/MyApp.Api
> ```"

### Test Commands

```
@terminal how do I run only the integration tests?
```

```
@terminal run tests with code coverage and generate a report
```

### Debugging Terminal Output

```
@terminal explain this error message:
"System.InvalidOperationException: Unable to resolve service for type 'IUserRepository'"
```

### Git Commands

```
@terminal how do I create a branch, commit my changes, and push?
```

```
@terminal show me how to revert the last commit but keep the changes
```

### Package Management

```
@terminal how do I add the FluentAssertions package to my test project?
```

```
@terminal update all NuGet packages in this solution to their latest versions
```

## @vscode – Editor Configuration

For VS Code users, `@vscode` helps with editor configuration.

### Extension Recommendations

```
@vscode what extensions should I install for .NET development?
```

### Launch Configurations

```
@vscode create a launch.json configuration for debugging my ASP.NET Core API
```

```
@vscode add a compound launch configuration to debug both the API and background worker
```

### Tasks Configuration

```
@vscode create tasks.json for building, testing, and running migrations
```

### Settings

```
@vscode configure VS Code to format C# code on save using CSharpier
```

```
@vscode set up file nesting so test files appear under their implementation files
```

### Snippets

```
@vscode create a snippet for generating xUnit test methods with FluentAssertions
```

## @github – GitHub Integration

The `@github` participant queries GitHub directly.

### Pull Request Context

```
@github summarize the changes in PR #42
```

```
@github what's the CI status for the current branch?
```

### Issue Discovery

```
@github find issues labeled 'bug' that mention authentication
```

```
@github what issues are assigned to me?
```

### Repository Information

```
@github show the project's README
```

```
@github what GitHub Actions workflows does this repo have?
```

### Code Review

```
@github generate a PR description for my current changes
```

```
@github what are the review comments on my PR?
```

## Combining Participants

Use multiple participants in a workflow:

### Workflow: Fixing a Bug

**Step 1: Understand the issue**
```
@github show me the details of issue #123
```

**Step 2: Find related code**
```
@workspace find the code related to this authentication bug
```

**Step 3: Generate a fix**
```
Based on the issue and codebase, generate a fix for the authentication timeout
```

**Step 4: Run tests**
```
@terminal how do I run tests for just the authentication module?
```

### Workflow: Adding a New Feature

**Step 1: Understand existing patterns**
```
@workspace how is the Order feature implemented? 
I need to add a similar Shipment feature.
```

**Step 2: Generate scaffold**
```
Based on the Order pattern, generate:
- ShipmentController
- ShipmentService
- Shipment entity and EF configuration
- ShipmentDto
```

**Step 3: Create tests**
```
@workspace show me the tests for OrderService.
Generate similar tests for ShipmentService.
```

**Step 4: Update documentation**
```
@github what's the format for our changelog entries? 
Generate one for this new feature.
```

## Tips for Better Results

### Be Specific About Context

Instead of:
```
@workspace how do we log?
```

Try:
```
@workspace how do we configure and use structured logging with Serilog in this project?
Show me the configuration and an example of logging in a service class.
```

### Ask Follow-Up Questions

```
@workspace how do we handle validation?
```

Then:
```
Show me a specific example with FluentValidation
```

Then:
```
How would I add a custom validation rule that checks the database?
```

### Reference Specific Files

```
@workspace based on #UserService.cs, explain the service layer pattern we use
```

### Ask for Comparisons

```
@workspace compare how we handle errors in the API layer vs the service layer
```

## Common .NET Queries by Role

### For New Team Members
```
@workspace give me an overview of this solution's architecture
@workspace how do I set up my local development environment?
@terminal how do I run the tests?
```

### For Feature Development
```
@workspace show me examples of how other features are implemented
@workspace where should I add a new API endpoint?
@workspace what validation patterns do we use?
```

### For Debugging
```
@workspace find all error handling for database operations
@terminal explain this exception
@workspace where is this method called from?
```

### For Code Review
```
@github summarize the changes in this PR
@workspace does this new code follow our existing patterns?
@workspace are there any similar implementations I should be aware of?
```

## Summary

In this post, we learned how to use chat participants:

- **@workspace** for codebase-wide understanding and code generation
- **@terminal** for CLI commands and DevOps tasks
- **@vscode** for editor configuration
- **@github** for GitHub integration and PR workflows

These participants transform Copilot from a code completer into a comprehensive development assistant that understands your entire project.

In the next post, we'll explore **custom instructions with copilot-instructions.md** – how to configure project-specific conventions, patterns, and guidelines that Copilot will follow.

## GitHub Example

You can find example queries and workflows at: https://github.com/danielwarddev/CopilotDotNetExamples
