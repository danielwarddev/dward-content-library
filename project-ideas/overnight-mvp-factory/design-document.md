# Overnight MVP Factory - Design Document

**Generated:** January 31, 2026  
**Context:** Design and requirements for an autonomous system that picks a SaaS idea from notes, then builds a working MVP overnight using the Copilot SDK with custom orchestration (no IDE required).

---

## Executive Summary

The **Overnight MVP Factory** is a .NET 10 console application that runs on a weekly schedule. It autonomously:

1. Scans your idea notes and saas-research files
2. Selects the highest-scored idea that hasn't been attempted yet
3. Uses GitHub Copilot to generate a complete, working MVP
4. Produces a runnable .NET solution with tests, fake data, and documentation

You wake up to a new prototype ready to evaluate.

---

## System Architecture

```
┌─────────────────────────────────────────────────────────────────────┐
│                     OVERNIGHT MVP FACTORY                           │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│  ┌──────────────┐    ┌──────────────┐    ┌──────────────────────┐  │
│  │   Scheduler  │───▶│ Idea Picker  │───▶│  MVP Generator       │  │
│  │  (Task/Cron) │    │              │    │  (Copilot SDK)       │  │
│  └──────────────┘    └──────────────┘    └──────────────────────┘  │
│         │                   │                      │                │
│         │                   ▼                      ▼                │
│         │           ┌──────────────┐    ┌──────────────────────┐   │
│         │           │ Idea Sources │    │  Orchestration       │   │
│         │           │ - saas-research  │  │  - Scaffold (CLI)    │   │
│         │           │ - notes/     │    │  - Generate (SDK)    │   │
│         │           │ - external   │    │  - Validate (CLI)    │   │
│         │           └──────────────┘    └──────────────────────┘   │
│         │                                          │                │
│         ▼                                          ▼                │
│  ┌──────────────┐                       ┌──────────────────────┐   │
│  │ Attempt Log  │                       │   Output: Solution   │   │
│  │ (JSON/MD)    │                       │   - src/             │   │
│  └──────────────┘                       │   - tests/           │   │
│                                         │   - README.md        │   │
│                                         └──────────────────────┘   │
└─────────────────────────────────────────────────────────────────────┘
```

---

## Component Design

### 1. Scheduler Component

**Purpose:** Trigger the MVP generation process on schedule or manually.

**Options Evaluated:**

| Approach                   | Pros                     | Cons                            |
| -------------------------- | ------------------------ | ------------------------------- |
| **Windows Task Scheduler** | Simple, free, local      | Windows-only, no visibility     |
| **Systemd Timer (WSL)**    | Reliable                 | Requires WSL running            |
| **.NET BackgroundService** | Native C#, portable      | Requires app to always run      |
| **GitHub Actions**         | Great logging, free tier | Requires repo, remote execution |

**Recommendation:** Start with **Windows Task Scheduler** for simplicity. The console app can be triggered via Task Scheduler at 2 AM on Sundays. Later, migrate to GitHub Actions if you want logs/history.

**Implementation:**

```powershell
# One-time setup to register scheduled task
$action = New-ScheduledTaskAction -Execute "dotnet" -Argument "run --project C:\path\to\OvernightMvpFactory"
$trigger = New-ScheduledTaskTrigger -Weekly -DaysOfWeek Sunday -At 2am
Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "OvernightMvpFactory" -Description "Weekly MVP generation"
```

**Manual Trigger:**

```powershell
# Run on-demand
dotnet run --project OvernightMvpFactory
# Or with a specific idea
dotnet run --project OvernightMvpFactory -- --idea "Document Findability Index"
```

---

### 2. Idea Picker Component

**Purpose:** Select the best untried idea from all sources.

**Data Flow:**

```
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│  Scan Sources   │────▶│  Parse & Score  │────▶│  Filter Tried   │────▶ Winner
│                 │     │                 │     │                 │
│ - saas-research/│     │ - Extract ideas │     │ - Check log     │
│ - notes/        │     │ - Parse scores  │     │ - Skip attempts │
│ - project-ideas/│     │ - Normalize     │     │ - Return top 1  │
└─────────────────┘     └─────────────────┘     └─────────────────┘
```

**Idea Sources (Priority Order):**

1. `saas-research/*.md` - Already scored (use existing scores)
2. `project-ideas/**/*.md` - May need AI scoring
3. External notes folder - **TODO: @dward to provide path to external notes**

**App Type Detection:**
The AI will infer the appropriate app type (Console, Web API + Blazor, CLI, etc.) from the problem description and MVP scope. No explicit tagging required.

**Idea Schema:**

```csharp
public record IdeaCandidate
{
    public required string Id { get; init; }           // Unique hash or slug
    public required string Name { get; init; }         // "Document Findability Index"
    public required string SourceFile { get; init; }   // "saas-research/2026-01-29-idea-research.md"
    public required string Problem { get; init; }      // The pain point
    public required string MvpScope { get; init; }     // What to build
    public int Score { get; init; }                    // 0-40 from saas-research scoring
    public string? TargetIndustry { get; init; }
    public AppType SuggestedAppType { get; init; }     // Console, WebApi, Blazor, CLI
}

public enum AppType
{
    Console,
    WebApiWithBlazor,
    BlazorOnly,
    CliTool,
    BackgroundService
}
```

**Attempt Log Schema:**

```csharp
public record MvpAttempt
{
    public required string IdeaId { get; init; }
    public required string IdeaName { get; init; }
    public required DateTime AttemptedAt { get; init; }
    public required string OutputPath { get; init; }   // Where solution was created
    public required bool Success { get; init; }
    public string? FailureReason { get; init; }
    public int PremiumRequestsUsed { get; init; }
    public TimeSpan Duration { get; init; }
    public int? Rating { get; init; }                  // 1-5 rating after review (null = not reviewed)
    public string? ReviewNotes { get; init; }          // Optional notes from review
}
```

**Log Storage:** `overnight-mvp-factory/attempt-log.json`

---

### 3. MVP Generator Component

**Purpose:** Use the Copilot SDK to generate the solution with custom orchestration (no IDE required).

#### 3a. Architecture: Copilot SDK + Custom Orchestration

Since we're not using VS Code or any IDE, the console app handles everything:

1. **Scaffold** - Run `dotnet` CLI commands to create solution structure
2. **Generate** - Use Copilot SDK to generate code file-by-file
3. **Write** - Save generated code to disk
4. **Validate** - Run `dotnet build` and `dotnet test`
5. **Retry** - If validation fails, feed errors back to Copilot and retry

```
┌─────────────────────────────────────────────────────────────────┐
│                    MVP GENERATION FLOW                          │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  1. SCAFFOLD (dotnet CLI)                                       │
│     dotnet new sln -n ProjectName -o ./output                   │
│     dotnet new webapi -n ProjectName.Api ...                    │
│     dotnet new xunit -n ProjectName.Tests ...                   │
│                                                                 │
│  2. PLAN (Copilot SDK - 1 request)                              │
│     Input: Idea description, MVP scope, project structure       │
│     Output: List of files to create with descriptions           │
│                                                                 │
│  3. GENERATE (Copilot SDK - N requests)                         │
│     For each file in plan:                                      │
│       - Send prompt with file context                           │
│       - Receive code                                            │
│       - Write to disk                                           │
│       - Increment request counter                               │
│                                                                 │
│  4. VALIDATE (dotnet CLI)                                       │
│     dotnet build → if fails, extract errors                     │
│     dotnet test  → if fails, extract failures                   │
│                                                                 │
│  5. FIX LOOP (Copilot SDK - retry until cap)                    │
│     While (errors exist AND requestCount < hardCap):            │
│       - Send errors to Copilot                                  │
│       - Get fixed code                                          │
│       - Overwrite files                                         │
│       - Re-validate                                             │
│                                                                 │
│  6. FINALIZE                                                    │
│     - Generate README.md                                        │
│     - Log attempt results                                       │
│     - Report success/failure                                    │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

#### 3b. Copilot SDK Usage

```csharp
public class MvpGenerator
{
    private readonly CopilotClient _copilot;
    private readonly int _hardCap;
    private int _requestCount = 0;

    public async Task<GenerationResult> GenerateMvpAsync(IdeaCandidate idea, string outputPath)
    {
        // Phase 1: Scaffold using dotnet CLI
        await ScaffoldProjectAsync(idea, outputPath);

        // Phase 2: Plan files to generate
        var plan = await PlanFilesAsync(idea);
        _requestCount++;

        // Phase 3: Generate each file
        foreach (var file in plan.Files)
        {
            if (_requestCount >= _hardCap)
                return GenerationResult.CapExhausted(_requestCount);

            var code = await GenerateFileAsync(idea, file);
            await File.WriteAllTextAsync(Path.Combine(outputPath, file.Path), code);
            _requestCount++;
        }

        // Phase 4-5: Validate and fix loop
        var (success, errors) = await ValidateAsync(outputPath);
        while (!success && _requestCount < _hardCap)
        {
            var fixes = await GetFixesAsync(errors);
            _requestCount++;
            await ApplyFixesAsync(outputPath, fixes);
            (success, errors) = await ValidateAsync(outputPath);
        }

        // Phase 6: Generate README
        await GenerateReadmeAsync(idea, outputPath);
        _requestCount++;

        return new GenerationResult(success, _requestCount);
    }
}
```

#### 3c. Failure Recovery Strategy

**Retry until hard cap is hit:**

- If `dotnet build` fails → send compiler errors to Copilot, request fixes, retry
- If `dotnet test` fails → send test failures to Copilot, request fixes, retry
- If hard cap reached → save partial work, log failure reason, stop
- Never skip to next idea mid-run (one idea per scheduled run)

#### 3d. Cost Control

| Setting                 | Value | Notes                          |
| ----------------------- | ----- | ------------------------------ |
| `premiumRequestHardCap` | 50    | Absolute max requests per run  |
| `requestsPerFile`       | ~1    | Most files need one generation |
| `fixRetries`            | ~5-10 | Typical fix iterations         |
| `estimatedTotal`        | 20-40 | Typical successful run         |

The hard cap ensures you never exceed budget, and retries maximize chance of success within that budget.

---

### 4. Project Templates Component

**Purpose:** Provide consistent dotnet CLI command sequences for each app type.

**Directory Structure:**

```
overnight-mvp-factory/
├── src/
│   └── OvernightMvpFactory/
│       ├── Program.cs
│       ├── IdeaPicker/
│       ├── MvpGenerator/
│       └── Scaffolders/
│           ├── IProjectScaffolder.cs
│           ├── ConsoleAppScaffolder.cs
│           ├── WebApiBlazorScaffolder.cs
│           └── CliToolScaffolder.cs
├── templates/
│   └── shared/
│       ├── .editorconfig
│       ├── .gitignore
│       ├── Directory.Build.props
│       └── nuget.config
├── mvp-outputs/           # Generated MVPs go here
│   └── 2026-01-31-dfi/
├── attempt-log.json
└── config.json
```

**Scaffolder Interface:**

```csharp
public interface IProjectScaffolder
{
    AppType AppType { get; }
    Task ScaffoldAsync(string solutionName, string outputPath);
}
```

**Example Scaffolder (Web API + Blazor):**

```csharp
public class WebApiBlazorScaffolder : IProjectScaffolder
{
    public AppType AppType => AppType.WebApiWithBlazor;

    public async Task ScaffoldAsync(string solutionName, string outputPath)
    {
        var commands = new[]
        {
            // Create solution
            $"dotnet new sln -n {solutionName} -o {outputPath}",

            // Create projects
            $"dotnet new webapi -n {solutionName}.Api -o {outputPath}/src/{solutionName}.Api --use-controllers false",
            $"dotnet new blazor -n {solutionName}.Web -o {outputPath}/src/{solutionName}.Web --interactivity Auto",
            $"dotnet new classlib -n {solutionName}.Core -o {outputPath}/src/{solutionName}.Core",
            $"dotnet new xunit -n {solutionName}.Tests -o {outputPath}/tests/{solutionName}.Tests",

            // Add projects to solution
            $"dotnet sln {outputPath}/{solutionName}.sln add {outputPath}/src/{solutionName}.Api",
            $"dotnet sln {outputPath}/{solutionName}.sln add {outputPath}/src/{solutionName}.Web",
            $"dotnet sln {outputPath}/{solutionName}.sln add {outputPath}/src/{solutionName}.Core",
            $"dotnet sln {outputPath}/{solutionName}.sln add {outputPath}/tests/{solutionName}.Tests",

            // Add project references
            $"dotnet add {outputPath}/src/{solutionName}.Api reference {outputPath}/src/{solutionName}.Core",
            $"dotnet add {outputPath}/src/{solutionName}.Web reference {outputPath}/src/{solutionName}.Core",
            $"dotnet add {outputPath}/tests/{solutionName}.Tests reference {outputPath}/src/{solutionName}.Core",
        };

        foreach (var cmd in commands)
        {
            await RunCommandAsync(cmd);
        }

        // Copy shared template files
        CopySharedFiles(outputPath);
    }
}
```

**Console App Scaffolder:**

```csharp
public class ConsoleAppScaffolder : IProjectScaffolder
{
    public AppType AppType => AppType.Console;

    public async Task ScaffoldAsync(string solutionName, string outputPath)
    {
        var commands = new[]
        {
            $"dotnet new sln -n {solutionName} -o {outputPath}",
            $"dotnet new console -n {solutionName} -o {outputPath}/src/{solutionName}",
            $"dotnet new classlib -n {solutionName}.Core -o {outputPath}/src/{solutionName}.Core",
            $"dotnet new xunit -n {solutionName}.Tests -o {outputPath}/tests/{solutionName}.Tests",
            $"dotnet sln {outputPath}/{solutionName}.sln add {outputPath}/src/{solutionName}",
            $"dotnet sln {outputPath}/{solutionName}.sln add {outputPath}/src/{solutionName}.Core",
            $"dotnet sln {outputPath}/{solutionName}.sln add {outputPath}/tests/{solutionName}.Tests",
            $"dotnet add {outputPath}/src/{solutionName} reference {outputPath}/src/{solutionName}.Core",
            $"dotnet add {outputPath}/tests/{solutionName}.Tests reference {outputPath}/src/{solutionName}.Core",
        };

        foreach (var cmd in commands)
        {
            await RunCommandAsync(cmd);
        }

        CopySharedFiles(outputPath);
    }
}
```

---

### 5. Agent Prompt Template

**Purpose:** The prompt given to Copilot Agent Mode to generate the MVP.

**File:** `AGENT-PROMPT.md` (generated per run)

```markdown
# MVP Generation Task

## Idea Selected

**Name:** Document Findability Index (DFI)
**Score:** 33/40
**Source:** saas-research/2026-01-29-idea-research.md

## Problem Statement

Mid-size companies (100-500 employees) have 10+ years of documents scattered across
SharePoint, network drives, and cloud storage. Their search doesn't work. They can't
find what they need.

## MVP Scope

- Connect to SharePoint/Google Drive/Dropbox (FAKE - use mock data)
- AI-powered semantic search across documents (FAKE - use hardcoded results)
- "Find documents like this one" feature
- Simple relevance scoring dashboard

## Your Task

Build a working MVP that demonstrates this concept. Follow these rules:

### CRITICAL RULES

1. **ALL DATA IS FAKE** - Do not connect to any external services, APIs, or databases
2. Use hardcoded mock data that simulates real behavior
3. Create realistic-looking fake documents, users, and search results
4. The app must compile and run with `dotnet run`
5. Include unit tests with at least 80% coverage of core logic
6. Write a comprehensive README.md explaining what was built

### Project Structure

A solution has been scaffolded at this location. Use the existing structure:

- `src/Dfi.Api/` - Web API backend
- `src/Dfi.Web/` - Blazor frontend
- `src/Dfi.Core/` - Shared models and logic
- `tests/Dfi.Tests/` - Unit tests

### Fake Data Requirements

Create mock data that includes:

- 50+ fake documents with titles, content snippets, dates, authors
- 5-10 fake users with names and departments
- Pre-computed "similar documents" relationships
- Sample search queries with expected results

### UI Requirements

- Clean, professional Blazor UI
- Search box with results list
- Document detail view
- "Find similar" button that shows related docs
- Basic filtering (by date, author, type)

### README Requirements

The README.md must include:

1. What this MVP demonstrates
2. Why this idea was chosen (include the score and rationale)
3. How to run the application
4. What's fake vs what would be real in production
5. Potential next steps if this idea is pursued

## Begin

Start by reviewing the scaffolded solution, then implement the features above.
Create realistic, polished output that demonstrates the concept effectively.
```

---

## Local vs GitHub Actions: Pros & Cons

| Factor                 | Local (Task Scheduler)     | GitHub Actions                       |
| ---------------------- | -------------------------- | ------------------------------------ |
| **Setup Complexity**   | Low - just schedule a task | Medium - need workflow file, secrets |
| **Visibility/Logs**    | Must check local files     | Built-in run history, logs           |
| **Compute Cost**       | Free (your machine)        | Free tier: 2000 min/month            |
| **Machine State**      | Must be on and awake       | Always available                     |
| **Copilot SDK Access** | Full access via auth       | Requires secret for API key          |
| **Iteration Speed**    | Fast - change and re-run   | Slower - commit, push, wait          |
| **Collaboration**      | Single machine             | Can share workflow                   |
| **Output Access**      | Immediate on disk          | Need to download artifacts           |

**Recommendation:** **Start local** for faster iteration and immediate access to generated MVPs. Since we're using the Copilot SDK (no IDE required), GitHub Actions becomes viable for later:

- Could run the full generation in Actions
- Download the solution artifact when done
- Better logging and history

---

## Configuration

**File:** `config.json`

```json
{
    "ideaSources": [
        {
            "path": "C:/WS/Repos/dward-content-library/saas-research",
            "pattern": "*.md",
            "parser": "saas-research"
        },
        {
            "path": "C:/WS/Repos/dward-content-library/project-ideas",
            "pattern": "**/*.md",
            "parser": "generic"
        },
        {
            "path": "TODO: @dward to provide external notes path",
            "pattern": "*.md",
            "parser": "generic"
        }
    ],
    "outputPath": "C:/WS/Repos/overnight-mvp-outputs",
    "premiumRequestHardCap": 50,
    "schedule": {
        "dayOfWeek": "Sunday",
        "time": "02:00"
    }
}
```

---

## MVP Success Criteria

An overnight run is considered **successful** if:

- [ ] Solution compiles (`dotnet build` exits 0)
- [ ] Tests pass (`dotnet test` exits 0)
- [ ] App runs (`dotnet run` starts without crash)
- [ ] README.md exists and explains the idea
- [ ] At least one fake data file exists
- [ ] UI is accessible (for web apps, localhost responds)

---

## Implementation Phases

### Phase 1: Foundation (Week 1-2)

- [ ] Create solution structure for OvernightMvpFactory
- [ ] Implement idea parser for `saas-research/*.md` files
- [ ] Implement attempt log (read/write JSON) with rating support
- [ ] Create C# scaffolder classes for each app type (using dotnet CLI)
- [ ] Implement app type inference (AI determines Console vs Web vs CLI from description)
- [ ] Manual testing: pick idea → scaffold solution

### Phase 2: Copilot SDK Integration (Week 3-4)

- [ ] Integrate Copilot SDK for code generation
- [ ] Implement file planning prompt
- [ ] Implement per-file generation with context
- [ ] Add build validation (`dotnet build` error parsing)
- [ ] Add test validation (`dotnet test` failure parsing)
- [ ] Implement fix loop (retry until hard cap)

### Phase 3: Scheduling & Polish (Week 5)

- [ ] Set up Windows Task Scheduler
- [ ] Add manual trigger with `--idea` parameter
- [ ] Implement premium request counting and hard cap
- [ ] Generate README with idea rationale
- [ ] Test full end-to-end overnight run

### Phase 4: Iterate (Ongoing)

- [ ] Add external notes folder as idea source
- [ ] Improve prompts based on generation quality
- [ ] Add CLI tool scaffolder
- [ ] Add simple rating CLI: `dotnet run -- review <attempt-id> --rating 4`
- [ ] Consider GitHub Actions migration

---

## Resolved Decisions

| Question                | Decision                                                            |
| ----------------------- | ------------------------------------------------------------------- |
| External notes location | **TODO: @dward to provide path**                                    |
| IDE requirement         | **None** - using Copilot SDK with custom orchestration              |
| App type detection      | **AI infers** from problem description and MVP scope                |
| Failure recovery        | **Retry until hard cap** - never skip mid-run                       |
| Review workflow         | **Simple 1-5 rating** stored in attempt log                         |
| Script language         | **dotnet CLI** commands executed from C# (may add PowerShell later) |

---

## TODOs

- [ ] **@dward**: Provide path to external notes folder
- [ ] Research Copilot SDK authentication and rate limits
- [ ] Determine if Copilot SDK supports streaming for long generations
- [ ] Design prompt templates for file planning and code generation

---

## Next Steps

Once you've reviewed this design:

1. Answer the open questions above
2. I'll create the solution structure and scaffold scripts
3. We'll test the idea picker on your existing saas-research files
4. Then tackle the Copilot automation piece

---

## Notes

- **No IDE required** - Copilot SDK handles generation, dotnet CLI handles scaffolding and validation
- **Hard cap ensures cost control** - Will never exceed configured premium request limit
- **Retry strategy maximizes success** - Uses full budget attempting to fix errors before giving up
- **Local execution preferred** - Faster iteration, immediate access to output
- **GitHub Actions viable later** - Since no GUI required, can migrate to cloud execution
- **Weekly cadence** - Gives time to review and rate each MVP before the next one
- **Simple rating system** - 1-5 scale stored in attempt log for tracking quality over time
