# Dan In A Can - Analytics & Strategy Data

**Last Updated:** January 11, 2026  
**Data Source:** Google Analytics (April 2023 - January 2026)

---

## What's Working

### Top Performing Posts (by Views)

| Rank | Post                                      | Views | Avg Engagement |
| ---- | ----------------------------------------- | ----- | -------------- |
| 1    | Mock HttpClient with NSubstitute (3 ways) | 7,142 | 68s            |
| 2    | Enums in ASP.NET Core Routes              | 7,133 | 36s            |
| 3    | Mock HttpClient with Moq                  | 5,029 | 46s            |
| 4    | Test Database with TestContainers         | 4,228 | 64s            |
| 5    | Mutation Testing in C# (Stryker)          | 4,179 | 39s            |
| 6    | Mock File/Directory IO Calls              | 3,798 | 40s            |
| 7    | IAsyncEnumerable for Paged APIs           | 3,309 | 41s            |
| 8    | Test/Mock IAsyncEnumerable                | 3,298 | 38s            |
| 9    | Serilog LogContext with TestCorrelator    | 3,227 | 46s            |
| 10   | Central Package Management                | 3,158 | 40s            |

### Successful Topic Areas

1. **Mocking/Testing (Primary Niche)**

    - HttpClient mocking (Moq, NSubstitute)
    - Database testing (TestContainers, Respawn)
    - xUnit patterns (TheoryData, combinations)
    - Mocking pain points (ClaimsPrincipal, File IO, IAsyncEnumerable)

2. **ASP.NET Core Specific Problems**

    - Enum routes
    - Authentication/authorization mocking

3. **Developer Tooling**

    - Central Package Management
    - AutoFixture + EF Core
    - Contract testing with Pact

4. **Unique Content**
    - Interview with Mads Kristensen (1,645 views) — differentiation works!

### Title Formulas That Work

-   **"How to [verb] X in C# using Y"** — Best performer (HttpClient posts)
-   **"How to [verb] X in C# with [Library]"** — TestContainers, Pact series
-   **"How to [action] and [action] X in C#"** — Test and Mock IAsyncEnumerable
-   Problem-focused headlines matching Google search patterns

### Content Structure That Engages

-   Clear **problem/solution framing** at the top
-   **Code-first approach** — working examples early
-   **Pros/cons comparisons** when multiple approaches exist
-   **GitHub example repo link** at the end
-   **~150-300 lines of markdown** (medium-length, scannable)
-   **Series format** performs well (TestContainers 3-part, Contract Testing 9-part, Pulumi 6-part)

### Audience Profile

-   **Primary:** Intermediate C#/.NET developers who know basics but need help with testing infrastructure, mocking patterns, and tooling
-   **Secondary:** Senior developers looking for quick reference or validation
-   **Search intent:** Solutions to specific, annoying problems (often testability roadblocks)

---

## What Underperforms

| Post                     | Views | Likely Reason                       |
| ------------------------ | ----- | ----------------------------------- |
| Variable Naming in Tests | 52    | Too abstract/opinionated for search |
| Visual Studio Shortcuts  | 42    | Saturated topic, many competitors   |
| Conference Talk Ideas    | 45    | Niche audience (speakers, not devs) |
| Presentation pages       | Low   | Not blog content; expected          |

**Patterns to avoid:**

-   Overly opinionated/soft-skills posts without actionable code
-   Topics with heavy existing competition
-   Content targeting non-developer audiences

---

## 2026 Content Plan

### Cadence Goal

**One post per week** — mix of quick wins and series posts

### High-Priority Topics (Testing Niche)

| Topic                                               | Format    | Priority |
| --------------------------------------------------- | --------- | -------- |
| How to Mock ILogger in C# (Multiple Ways)           | Single    | High     |
| How to Mock IOptions<T> in C#                       | Single    | High     |
| How to Test Minimal APIs with WebApplicationFactory | Single    | High     |
| How to Mock DateTime/TimeProvider (.NET 8+)         | Single    | High     |
| How to Test Background Services (IHostedService)    | Single    | High     |
| Snapshot Testing with Verify Library                | 1-2 parts | Medium   |
| Integration Tests for Azure Functions               | 2-3 parts | Medium   |

### Series Ideas

| Series                            | Est. Posts | Notes                                  |
| --------------------------------- | ---------- | -------------------------------------- |
| Testing with MassTransit/RabbitMQ | 3-4        | Messaging testing underserved          |
| Testing with .NET Aspire          | 3-4        | New tech, testing story developing     |
| Fluent Assertions Deep Dive       | 3-4        | Already use it; could be authoritative |
| Testing GraphQL APIs in C#        | 2-3        | Growing adoption                       |

### AI Content Opportunities

| Topic                                    | Format        | Rationale                              |
| ---------------------------------------- | ------------- | -------------------------------------- |
| Testing AI-generated code in C#          | Single        | Hot topic, unique angle                |
| Using GitHub Copilot for test generation | Single/Series | Practical AI + testing crossover       |
| Testing Semantic Kernel applications     | 2-3 parts     | C# AI framework; testing story unclear |
| AI code review tools comparison          | Single        | Ties into VS 2026 interview            |

### Interview Content (Leverage MVP Network)

| Potential Guest                   | Topic Area                            |
| --------------------------------- | ------------------------------------- |
| Jimmy Bogard                      | AutoMapper, MediatR, testing patterns |
| Dennis Doomen                     | Fluent Assertions                     |
| Stryker.NET maintainers           | Mutation testing                      |
| Other MVPs                        | Various .NET topics                   |
| Microsoft figures (if accessible) | New features, tooling                 |

### Branch-Out Topics (Lower Priority)

Technologies currently using at work that could become content:

| Tech          | Risk Level | Notes                         |
| ------------- | ---------- | ----------------------------- |
| AWS CDK       | Medium     | Different from Azure audience |
| TypeScript    | Medium     | Overlaps with C# devs         |
| React/Next.js | High       | Different audience entirely   |

**Recommendation:** Consider TypeScript testing content as a bridge (many .NET devs use TS). AWS CDK could work as "Infrastructure as Code" series extension (you already have Pulumi content).

---

## SEO Strategy

### Keyword Patterns to Target

Based on successful posts, target searches like:

-   "how to mock [X] in c#"
-   "how to test [X] in c#"
-   "[Library] c# example"
-   "[Library] c# tutorial"
-   "c# unit test [specific thing]"

### Internal Linking Strategy

-   Link related posts within series
-   Link mocking posts to each other (Moq ↔ NSubstitute equivalents)
-   Create "pillar" posts that link to detailed posts
-   Update old posts with links to new related content

### Post Update Opportunities

Consider refreshing high-traffic posts with:

-   .NET 8/9 updates
-   New library versions
-   Additional methods/approaches
-   Links to newer related posts

---

## Notes for AI Context

When generating content ideas or drafts for this blog:

1. **Primary audience:** Intermediate C#/.NET developers
2. **Core niche:** Testing, mocking, and developer tooling
3. **Tone:** Practical, code-first, not overly formal
4. **Structure:** Problem → Solution → Code → GitHub link
5. **Avoid:** Purely opinion pieces, topics with heavy competition
6. **Prioritize:** Specific pain points developers Google for
7. **Series work well:** 3-6 parts, each post standalone but linked
8. **Interviews differentiate:** Leverage MVP network for unique content
