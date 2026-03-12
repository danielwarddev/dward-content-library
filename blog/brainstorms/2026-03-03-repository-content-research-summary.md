# Repository Content Research Summary — Blog Post Inspiration

**Generated:** March 3, 2026  
**Context:** Comprehensive review of the dward-content-library repository to catalog all topics, themes, technologies, and ideas for generating new blog post content for daninacan.com.

---

## Table of Contents

1. [Blog Analytics & What Works](#1-blog-analytics--what-works)
2. [Existing Published Content](#2-existing-published-content)
3. [Presentation Portfolio](#3-presentation-portfolio)
4. [Brainstormed Copilot SDK Ideas](#4-brainstormed-copilot-sdk-ideas)
5. [Project Ideas](#5-project-ideas)
6. [Workshop Content](#6-workshop-content)
7. [Conference Talk Research — New Territory](#7-conference-talk-research--new-territory)
8. [SEO Research & Opportunities](#8-seo-research--opportunities)
9. [Ideas Backlog (Already Cataloged)](#9-ideas-backlog-already-cataloged)
10. [Master Theme & Technology Index](#10-master-theme--technology-index)

---

## 1. Blog Analytics & What Works

### Top-Performing Content (by Views)

| Rank | Post | Views | Key Insight |
|------|------|-------|-------------|
| 1 | Mock HttpClient with NSubstitute (3 ways) | 7,142 | "How to mock X in C#" is the winning formula |
| 2 | Enums in ASP.NET Core Routes | 7,133 | Specific ASP.NET pain points perform well |
| 3 | Mock HttpClient with Moq | 5,029 | Moq version also top performer |
| 4 | Test Database with TestContainers | 4,228 | Integration testing is a strong niche |
| 5 | Mutation Testing in C# (Stryker) | 4,179 | Advanced testing concepts find audience |
| 6 | Mock File/Directory IO Calls | 3,798 | IO mocking is common pain point |
| 7 | IAsyncEnumerable for Paged APIs | 3,309 | Async patterns resonate |
| 8 | Test/Mock IAsyncEnumerable | 3,298 | Testing + async = strong combo |
| 9 | Serilog LogContext with TestCorrelator | 3,227 | Logging + testing niche |
| 10 | Central Package Management | 3,158 | Dev tooling also works |

### Proven Patterns

- **Title formula:** "How to [verb] X in C# using/with Y" dominates
- **Audience:** Intermediate C#/.NET devs searching for testability solutions
- **Structure:** Problem → Solution → Code → GitHub link
- **Engagement:** Code-first, ~150-300 lines of markdown, series format works well
- **Underperformers:** Opinion/soft-skills posts, saturated topics (VS shortcuts), non-dev audience content

### Key Takeaway

The blog's sweet spot is **specific, searchable C#/.NET testing pain points** with working code examples. Mocking, integration testing, and developer tooling are the three proven pillars.

---

## 2. Existing Published Content

### Full Catalog of 37 Published Posts (by topic area)

#### Mocking & Unit Testing (Core Niche)
- Mock HttpClient with Moq (Apr 2023)
- Mock HttpClient with NSubstitute — 3 ways (Sep 2023)
- Verify object/list arguments with Moq (Apr 2023)
- Match object/list arguments with NSubstitute (Sep 2023)
- Return values multiple times with NSubstitute (Nov 2023)
- Mock ClaimsPrincipal in C# (Mar 2024)
- Mock File/FileStream/Directory IO calls (Feb 2024)
- Serilog LogContext with TestCorrelator (Apr 2023)

#### xUnit Patterns
- Run every combination of arguments in xUnit (Oct 2023)
- Create clean test cases with TheoryData (Feb 2024)
- Variable naming in tests (Apr 2024)
- Naming conventions for tests (May 2024)

#### Integration Testing
- Test a database with TestContainers (Jan 2024)
- Reset test database with Respawn (Jan 2024)
- Clean test suite for integration tests (Jan 2024)
- AutoFixture with EF Core (Jan 2024)

#### Contract Testing with Pact (9-part series)
- What contract testing is (Sep 2024)
- Consumer tests (Oct 2024)
- Provider tests (Oct 2024)
- Provider states (Nov 2024)
- TestContainers integration (Dec 2024)
- Provider state parameters (Jan 2025)
- Query parameters (Jan 2025)
- Message interactions (Feb 2025)
- Pact Brokers (Mar 2025)

#### Mutation Testing
- How and why to write mutation tests (Stryker) (Dec 2024)

#### Infrastructure as Code — Pulumi Series (6+ parts)
- IaC: What it is and why (Mar 2025)
- First project with Pulumi + C# (Apr 2025)
- How Pulumi works (May 2025)
- Inputs and Outputs (Jul 2025)
- Component Resources (Aug 2025)
- Projects, Stacks, Config (Oct 2025)
- Stack References (Dec 2025)

#### Other
- IAsyncEnumerable for paged APIs (Jul 2023)
- Test/Mock IAsyncEnumerable (Aug 2023)
- Enums in ASP.NET Core Routes (Jun 2023)
- OAuth token auto-fetch in Postman (May 2023)
- Central Package Management (Feb 2024)
- Conference talk ideas guide (Aug 2023)
- Interview with Mads Kristensen: VS 2026 (Sep 2025)

### Series That Worked
| Series | Posts | Status |
|--------|-------|--------|
| Contract Testing with Pact | 9 parts | Complete |
| Pulumi with C# | 6+ parts | Ongoing |
| TestContainers/Integration Testing | 3 parts | Complete |

---

## 3. Presentation Portfolio

### Active/Delivered Talks

| Talk | Topic | Key Technologies |
|------|-------|-----------------|
| **AI Test Generation That Actually Works** | Getting AI to write trustworthy tests | GitHub Copilot, Agent Skills, AAA pattern, naming conventions |
| **The Copilot Gap** | What devs miss with AI coding tools — patterns for effective use | GitHub Copilot, Claude Code, MCP, Agent Skills, context engineering |
| **Put An Agent Inside Your App (Copilot SDK)** | Building custom agents using GitHub Copilot SDK in 10 minutes | Copilot SDK, custom tools, C# |
| **AI Agents with Agent Framework** | Getting started building AI agents in C#/Python | Microsoft Agent Framework, tool calling, multi-agent orchestration |
| **No More SQLite — TestContainers** | Replace SQLite/in-memory with TestContainers for EF Core testing | TestContainers, EF Core, Docker, integration testing |
| **Testing Your Tests — Stryker** | Mutation testing to find weak spots in test suites | Stryker, mutation testing, AI-assisted remediation |
| **Contract Testing with Pact** | Testing between microservices | Pact, consumer-driven contract testing |
| **Manage Cloud with Pulumi + C#** | Infrastructure as code in C# | Pulumi, Azure, C# |
| **C#/.NET on AWS** | Using C# for IaC + deploying .NET on AWS | AWS CDK, .NET on AWS |
| **Measure Developer Productivity** | Metrics, DORA, developer experience | SPACE framework, DORA metrics |
| **xUnit Expanded** | Advanced xUnit patterns and libraries | xUnit, FluentAssertions, parallelism |
| **Hearing and Being Heard** | Team communication and psychological safety | Soft skills, team dynamics |
| **Copilot Mastery (planned)** | Autocomplete → Agent Skills progression | GitHub Copilot, skills, prompts, MCP, agents |

### Key Themes Across Presentations
- **AI + Testing intersection** is the most unique angle
- **"The testing person who does AI" positioning** is distinctive
- **Live coding demos** are a signature format
- **Enterprise adoption** experience (coaching teams on AI)

---

## 4. Brainstormed Copilot SDK Ideas

### 4a. Community-Inspired SDK Project Ideas (Feb 9)
12 ideas based on real projects people built with the SDK:
1. Boilerplate scaffolder from templates
2. Chat interface embedded in existing web app
3. PR description generator
4. Codebase onboarding assistant
5. GitHub issue triage tool ("Tinder for Issues")
6. Discord/Slack bot for dev teams
7. System tray desktop app with OS context
8. Automated changelog generator (GitHub Actions)
9. **Test spec generator from acceptance criteria** ← testing angle!
10. CLI tool that explains unfamiliar code
11. Migration script helper
12. Interactive API explorer

### 4b. Original SDK Project Ideas (Feb 11)
10 new ideas with blog-post scope:
1. **Config Drift Detector** ← ranked #1 for blog fit
2. Database Migration Describer
3. **Merge Conflict Resolver** ← high wow factor
4. **Dockerfile Optimizer** ← clear before/after
5. API Mock Data Generator
6. Pre-Review Self-Check Tool
7. Hardcoded String Extractor for Localization
8. Dependency Upgrade Impact Report
9. Exception Handling Audit
10. Project Health Dashboard Generator

### 4c. Hooks + Custom Tools + MCP Ideas (Feb 12)
5 ideas using all three SDK features:
1. PR Merge Readiness Checker (GitHub MCP)
2. **Live Documentation Verifier** ← verify docs match actual code
3. Visual Regression Spotter (Playwright MCP)
4. Incident Response Runbook Executor
5. Repo Compliance Auditor

### 4d. Self-Contained SDK Ideas (Feb 15)
8 fully self-contained ideas (clone + run):
1. Local Recipe Site Nutrition Auditor
2. **Portfolio Site SEO & Link Checker** ← ranked #1
3. **Markdown Knowledge Base Q&A** ← ranked #2
4. CSS Theme Contrast Checker (WCAG)
5. Local API Contract Tester
6. Résumé Tailoring Assistant
7. **Log File Anomaly Investigator** ← ranked #3
8. Static Site Generator Preview Checker (meta!)

### 4e. SDK Demo App Ideas for Talks (Feb 18 + Feb 26)
Investigation/analysis-focused demos:
1. **Deployment Risk Assessor** ← agent investigates across data
2. **Production Error Investigator** ← "15 min of senior engineer work in 3 seconds"
3. Support Ticket Triage Service
4. Expense Report Processor
5. On-Call Alert Enricher

---

## 5. Project Ideas

### Copilot Conversation Visualizer (VS Code Extension)
- Parses GitHub Copilot's debug chat log JSON
- Creates interactive visualizations of conversations
- Shows tool calls, system prompts, token usage, cached tokens
- **Nothing like this exists** — gap confirmed by marketplace research
- Full planning doc with TypeScript interfaces, Mermaid generator prototype
- Status: Planning complete, ready for implementation

### Overnight MVP Factory
- Autonomous .NET 10 console app that runs weekly
- Scans idea notes → picks highest-scored idea → builds working MVP using Copilot SDK
- Wake up to a new prototype ready to evaluate
- Full architecture: Scheduler → Idea Picker → MVP Generator → Validation
- Uses custom orchestration with the Copilot SDK (no IDE required)

---

## 6. Workshop Content

### Testing Workshop (Option A — highest comfort)
- **Beer City Code (1-day):** "Confident .NET Testing: From Unit Tests to TestContainers"
  - xUnit deep dive → Mocking → Mutation testing → TestContainers → Capstone
- **NDC Oslo (2-day):** "Mastering .NET Testing: From Unit Tests to Contract Testing"
  - Day 1: Unit testing mastery (xUnit, mocking, async, Stryker)
  - Day 2: Integration & contract testing (TestContainers, Pact, CI/CD)

### AI/Copilot Workshop (Option B — hot topic)
- **Beer City Code (1-day):** "Effective AI Coding: Mastering GitHub Copilot for Real Development"
  - Features → Prompt engineering → Test generation → Custom instructions → The Copilot Gap
- **NDC Oslo (2-day):** "From Copilot to Agents: Building AI-Powered Development Workflows"
  - Day 1: Mastering AI coding assistants
  - Day 2: Agentic coding & AI applications (Agent Framework, RAG patterns)

### Workshop Ideas Vault
Extensive ideas for Copilot workshop content:
- Privacy & security considerations
- TDD with Copilot (write tests first, let AI implement)
- Documentation generation workflows
- MCP servers worth knowing
- Debugging with Copilot
- Refactoring challenges
- Real-world workflow patterns

---

## 7. Conference Talk Research — New Territory

### Gartner 2026 Trends & Hot Topics
Researched ideas for talks beyond existing portfolio:

**Tier 1: High Priority New Territory**
1. **Multiagent Systems 101** — orchestrating AI agents that work together
2. **AI Agent Debugging & Guardrails** — observability + testing angle for agents (unique niche!)
3. **Digital Provenance for Developers** — SBOMs, code signing, content authenticity

**Tier 2: Strong Contenders**
4. **Hidden Cost of AI (FinOps for LLM)** — token costs, optimization, cost tracking
5. **Confidential Computing** — encrypting data in use, secure enclaves
6. **Golden Paths / Platform Engineering** — developer experience, reducing cognitive load

**Tier 3: Worth Considering**
7. Post-Quantum Cryptography (ties to .NET 10)
8. AI Security Platforms
9. Measuring Developer Experience (evolves existing talk)
10. AI-Native Development — bigger picture thought leadership
11. Preemptive Cybersecurity
12. Geopatriation / Data Sovereignty

---

## 8. SEO Research & Opportunities

### Confirmed High-Opportunity Topics

| Topic | Competition | Opportunity | Notes |
|-------|------------|-------------|-------|
| **Mocking Azure OpenAI in C#** | Almost none | 🔥 Very High | Could rank #1 — nothing exists |
| **Testing Semantic Kernel in C#** | Low, outdated | 🔥 Very High | Only 1 article from Apr 2024 |
| **Microsoft Agent Framework Testing** | None | 🔥 Very High | Zero testing content exists |
| **LaunchDarkly Testing in C#** | Almost none | 🔥 Very High | Testing feature flag logic |
| **Microsoft Agent Framework Tutorial** | Low (new tech) | High | First-mover advantage |
| **GitHub Copilot Test Generation** | Medium | Medium | Need unique angle (critical eval) |
| **OpenAPI 3.1 Migration in .NET 10** | Medium | High | Swashbuckle → native migration |
| **.NET 10 Testing Features** | Low | High | Microsoft.Testing.Platform, C# 14 |
| **OpenTelemetry + Aspire Testing** | Medium | Medium | Verifying instrumentation |

### .NET 10 Features Worth Covering
- C# 14: `field` keyword, extension blocks, null-conditional assignment, partial constructors
- Microsoft.Testing.Platform in `dotnet test`
- EF Core 10: Named query filters
- ASP.NET Core 10: OpenAPI 3.1, Blazor improvements, passkey support
- Post-quantum cryptography in runtime

---

## 9. Ideas Backlog (Already Cataloged)

### High-Priority Quick Wins (Testing Niche)
- How to Mock ILogger in C# (3 Ways)
- How to Mock IOptions<T> in C#
- Test Minimal APIs with WebApplicationFactory
- Mock DateTime/TimeProvider (.NET 8+)
- Test Background Services (IHostedService)
- Snapshot Testing with Verify Library
- Integration Tests for Azure Functions

### AI & Copilot Content
- "Missing Copilot Manual for .NET Teams" series (instructions, prompts, agents, skills, MCP)
- Testing AI-generated code — critical evaluation
- Copilot cost comparison (Copilot vs Claude Code actual token costs)
- Testing Semantic Kernel applications (2-3 parts)
- Mocking OpenAI/Azure OpenAI in C#
- Unit testing AI agents in C#

### Series Ideas
- Testing with MassTransit/RabbitMQ (3-4 parts)
- Testing with .NET Aspire (3-4 parts)
- Fluent Assertions Deep Dive (3-4 parts)
- Testing GraphQL APIs in C# (2-3 parts)

### Bridge Topics (Audience Expansion)
- TypeScript testing for C# devs (Mock Fetch, React testing, xUnit vs Jest)
- Pulumi vs AWS CDK comparison
- Testing AWS CDK constructs

### Interview Ideas
- Jimmy Bogard (AutoMapper, MediatR)
- Dennis Doomen (Fluent Assertions)
- Stryker.NET maintainers
- David Fowler (.NET Aspire)
- Isaac Levin (Semantic Kernel)

---

## 10. Master Theme & Technology Index

### Core Technologies Appearing Across Repository

| Technology | Where It Appears | Blog Potential |
|-----------|-----------------|----------------|
| **xUnit** | Published posts, presentations, workshops | Series expansion, .NET 10 updates |
| **NSubstitute/Moq** | Top-performing posts, workshops | More "How to Mock X" posts |
| **TestContainers** | Published series, presentations, workshops | Azure Functions, Aspire integration |
| **Pact (Contract Testing)** | 9-part series, presentations | Message-based systems expansion |
| **Stryker (Mutation Testing)** | Published post, presentations, workshops | Deep dive series, AI remediation angle |
| **Pulumi** | 6-part series, presentations | Comparison with CDK, testing IaC |
| **GitHub Copilot** | Presentations, workshops, brainstorms | SDK tutorials, effectiveness guide, cost analysis |
| **Copilot SDK** | 4 brainstorm files, presentation, demo ideas | Blog post series with working demos |
| **Microsoft Agent Framework** | Presentations, conference research | Testing agents (zero competition!) |
| **Semantic Kernel** | Ideas backlog, SEO research | Testing SK apps (no content exists) |
| **EF Core** | Published posts, presentations | Named query filters (.NET 10), migrations |
| **ASP.NET Core** | Published posts, ideas backlog | Minimal API testing, OpenAPI 3.1 |
| **AWS CDK** | Presentation, bridge topics | C# on AWS, IaC comparison |
| **Playwright** | SDK brainstorms (MCP usage) | Visual testing, E2E testing |
| **FluentAssertions** | Presentations, ideas backlog | Deep dive series |
| **Docker** | TestContainers integration | Dockerfile optimization |
| **MCP (Model Context Protocol)** | Copilot Gap talk, SDK brainstorms, workshop | Standalone tutorial content |

### Cross-Cutting Themes

| Theme | Description | Unique Angle |
|-------|-------------|-------------|
| **Testing everything** | The blog's DNA — testing applied to every new technology | "How to test X" where X is whatever's new |
| **AI + Testing intersection** | Most distinctive positioning in the space | Testing AI-generated code, testing agents, mocking LLM APIs |
| **Developer tooling** | Practical tools that solve dev pain points | SDK-based tools, VS Code extensions, CLI utilities |
| **Enterprise AI adoption** | Real-world coaching experience | What actually works vs. hype |
| **Infrastructure as Code** | Established series with expansion potential | Multi-cloud, testing IaC |
| **Code quality & patterns** | Mutation testing, naming, structure | Applied to new contexts (AI code, etc.) |
| **Cost optimization** | AI FinOps, premium request tracking | Practical wallet-hitting content |
| **Security & trust** | Digital provenance, AI security, confidential computing | Emerging topics with low competition |

### Unique Content Moats

1. **"The testing person who does AI"** — nobody else occupies this exact niche
2. **9-part contract testing series** — demonstrated deep commitment
3. **Mads Kristensen interview** — proven interview format works
4. **Enterprise coaching experience** — real-world AI adoption stories
5. **Repository of 40+ brainstormed SDK ideas** — massive pipeline

---

## Notes

- This summary covers **37 published posts**, **13+ presentation abstracts**, **4 brainstorm files** with 40+ Copilot SDK ideas, **2 project ideas**, **2 workshop plans**, extensive conference talk research, and detailed SEO analysis.
- The strongest untapped opportunities are at the **intersection of AI and testing** — mocking Azure OpenAI, testing Semantic Kernel, testing Agent Framework apps, and AI test generation evaluation.
- The Copilot SDK brainstorm files alone contain enough ideas for a 6-12 month blog post calendar.
- The `ideas-backlog.md` already contains a prioritized list with SEO research backing each suggestion.
