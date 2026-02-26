# Original Copilot SDK Blog Post Project Ideas

**Generated:** 2026-02-11
**Context:** Original ideas for a developer-focused blog post demonstrating the GitHub Copilot SDK. Each idea is scoped for a single blog post, showcases the SDK's agentic loop (plan → tool call → observe → repeat), and was NOT found in any existing community project from the research.

---

## Selection Criteria

A good blog post demo should:

- Fit in ~50-150 lines of interesting SDK code (not counting boilerplate)
- Have a clear **before/after** the reader can see
- Show tool-calling and the agentic loop (what makes the SDK different from just calling an LLM API)
- Solve a real annoyance developers actually have

---

## Ideas

### 1. Config Drift Detector

Compare your `appsettings.Development.json` vs `appsettings.Production.json` (or `.env.development` vs `.env.production`) and flag missing keys, type mismatches, or values that look wrong for the environment (e.g., `localhost` in prod config). The agent reads both files, reasons about each key, and outputs a report.

**Why it's good for a blog post:** Two custom tools (read dev config, read prod config), clear tabular output, every developer has this problem, and it's completely safe — no runtime data involved.

### 2. Database Migration Describer

You've generated an EF Core / Prisma / Flyway migration file but the raw SQL or migration code is hard to scan quickly. This console app reads the migration file alongside your current model classes and generates a plain-English summary: what changed, potential data loss, and whether it's reversible.

**Why it's good for a blog post:** Developers run migrations constantly but rarely get a human-readable description. Two tools (read migration file, read model files), small scope, satisfying output. Great before/after.

### 3. Merge Conflict Resolver

Reads files with git merge conflict markers (`<<<<<<<` / `>>>>>>>`) and proposes resolutions by understanding what each branch was trying to do. The agent reads the conflicted file, the recent commits on each branch for context, and suggests a merged result.

**Why it's good for a blog post:** Everyone hates merge conflicts. Tools: read file, read git log for each branch. The agentic loop is visible — it may need to read surrounding code to understand intent. High "wow, that's useful" factor.

### 4. Dockerfile Optimizer

Reads your existing Dockerfile and project files, then generates an optimized version with multi-stage builds, better layer caching order, smaller base images, and no-root user. Shows a clear diff between the original and optimized version.

**Why it's good for a blog post:** Clear before/after, every developer uses Docker, and the "read project structure → reason → rewrite file" loop is a textbook SDK demo. Tools: read Dockerfile, read project file (csproj/package.json), write optimized Dockerfile.

### 5. API Mock Data Generator

Reads your C# DTOs, TypeScript interfaces, or OpenAPI spec and generates realistic mock response JSON files. Not random data — contextually appropriate values (real-looking emails, plausible dates, consistent IDs across related objects).

**Why it's good for a blog post:** Frontend devs waiting on backend APIs need this constantly. The tool reads type definitions and writes JSON files. Small, self-contained, and the output is immediately usable.

### 6. Pre-Review Self-Check Tool

Before pushing a PR, run this console app against your staged changes. It reads the diff, anticipates what a code reviewer would flag (naming issues, missing null checks, inconsistent patterns vs the rest of the codebase), and suggests fixes. Not an automated reviewer — a tool that helps YOU prepare.

**Why it's good for a blog post:** Developers already do this mentally. Making it explicit with tools (read diff, read related source files for patterns, output suggestions) shows the multi-step agentic loop nicely. Different from existing linters because it understands project conventions by reading your actual code.

### 7. Hardcoded String Extractor for Localization

Scans your codebase for user-facing hardcoded strings (in views, UI components, error messages) and generates a resource file or i18n JSON with extracted keys and the originals as default values. Also generates the updated source files with the resource references in place.

**Why it's good for a blog post:** Multi-file read/write is the SDK's sweet spot. The agent reads source files, identifies user-facing strings (skipping log messages, variable names), writes a resource file, AND updates the source files. The full agentic loop on display.

### 8. Dependency Upgrade Impact Report

Give it a package name and target version (e.g., "upgrade Newtonsoft.Json from 12.x to 13.x"). It fetches the changelog/release notes (via a tool), scans your codebase for usage of APIs that changed, and generates a report: what will break, what's deprecated, and what you need to change.

**Why it's good for a blog post:** Every developer dreads major version upgrades. Tools: fetch release notes (could use a web search tool or MCP), scan codebase for affected call sites. The multi-step investigation is a great agentic demo.

### 9. Exception Handling Audit

Reads your service/controller code and identifies methods with unhandled failure modes: HTTP calls without timeout/retry handling, database calls without transaction management, file operations without proper disposal. Generates a report with specific line references and suggested patterns from YOUR existing codebase (not generic advice).

**Why it's good for a blog post:** Not runtime analysis — purely static code reading. The agent reads your code, reads your existing error handling patterns in other files, and gives suggestions consistent with YOUR style. Shows the SDK reading multiple files to build understanding.

### 10. Project Health Dashboard Generator

A console app that reads your codebase and generates a single markdown "health report": test coverage gaps (files with no corresponding test file), outdated dependencies count, TODO/FIXME count grouped by area, files with the most churn (via git log), and areas with the least documentation. All from static analysis and git history — no runtime data.

**Why it's good for a blog post:** Multiple tools (read files, run git commands, scan directories), satisfying markdown output you could commit to your repo, and it shows off the SDK coordinating many small tools into one cohesive result.

---

## My Ranking for Blog Post Fit

| Rank | Idea                         | Scope  | "Wow" Factor | Ease of Demo |
| ---- | ---------------------------- | ------ | ------------ | ------------ |
| 1    | Config Drift Detector        | Small  | Medium       | Easy         |
| 2    | Merge Conflict Resolver      | Medium | High         | Medium       |
| 3    | Dockerfile Optimizer         | Small  | High         | Easy         |
| 4    | Database Migration Describer | Small  | Medium       | Easy         |
| 5    | Pre-Review Self-Check        | Medium | High         | Medium       |

Config Drift Detector is #1 for blog post fit: it's tiny, easy to explain, every reader relates to the problem, and it cleanly shows the tool-calling pattern. Merge Conflict Resolver and Dockerfile Optimizer are flashier but slightly bigger scope.
