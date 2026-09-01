# Blog Post Ideas Backlog

**Last Updated:** January 11, 2026

---

## 🔥 High-Priority Quick Wins (Testing Niche)

These follow proven patterns and have high search intent:

| Topic                                                     | Format    | Notes                                                    |
| --------------------------------------------------------- | --------- | -------------------------------------------------------- |
| How to Mock ILogger in C# (3 Ways)                        | Single    | Same pattern as HttpClient posts; very common pain point |
| How to Mock IOptions<T> in C# for Unit Testing            | Single    | Super common DI mocking question                         |
| How to Test Minimal APIs in C# with WebApplicationFactory | Single    | Minimal APIs mainstream; testing is common question      |
| How to Mock DateTime/TimeProvider in C# (.NET 8+)         | Single    | New TimeProvider abstraction still confusing             |
| How to Test Background Services (IHostedService) in C#    | Single    | Common problem, poor existing content                    |
| Snapshot Testing with Verify Library in C#                | 1-2 parts | Emerging library, low competition                        |
| How to Write Integration Tests for Azure Functions in C#  | 2-3 parts | TestContainers expertise applies                         |

---

## 🤖 AI & GitHub Copilot Content

High potential given the blog's testing angle + AI trend:

### GitHub Copilot Series

**Angle:** Official docs are dry — focus on practical "how & why" content with real examples and honest evaluation.

| Topic                                                    | Format | Notes                                                              |
| -------------------------------------------------------- | ------ | ------------------------------------------------------------------ |
| How to Use Agent Skills in GitHub Copilot                | Single | 🔥 New feature (Dec 2025). Practical tutorial with real examples. |
| Using GitHub Copilot for Test Generation: Does It Work?  | Single | Critical evaluation, not just hype                                 |
| How to Write Better Prompts for Copilot Test Generation  | Single | Practical tips                                                     |
| GitHub Copilot Chat for Debugging: A Testing Perspective | Single | Unique angle                                                       |
| Copilot Workspace: First Impressions for .NET Developers | Single | Early adopter content                                              |
| Testing Code That GitHub Copilot Generated               | Single | Quality assurance angle                                            |

**Potential Series: "The Missing Copilot Manual for .NET Teams"**

User observation: "Lots of orgs are giving their devs this tool with no instructions because it's from Microsoft and it's cost efficient."

| Topic                               | Format | Notes                                           |
| ----------------------------------- | ------ | ----------------------------------------------- |
| Custom Instructions for Your Team   | Single | copilot-instructions.md best practices          |
| Writing Effective Prompts           | Single | Practical patterns, not generic advice          |
| Using Agents in GitHub Copilot      | Single | When and how to use @workspace, @terminal, etc. |
| Agent Skills: What, How, and Why    | Single | Practical skill creation with C#/.NET examples  |
| MCP Servers with GitHub Copilot     | Single | Extending Copilot with custom tools             |

**Research notes (Jan 2026):**
- Official content exists but is scattered and generic
- Gap: No unified, opinionated enterprise/team onboarding guide
- Existing content is feature-by-feature, not workflow-based
- Agent Skills is NEW (Dec 2025) - mostly intro/announcement content, no practical tutorials yet

### Microsoft Agent Framework (Semantic Kernel + AutoGen)

| Topic                                                       | Format    | Notes                         |
| ----------------------------------------------------------- | --------- | ----------------------------- |
| What is Microsoft Agent Framework? A C# Developer's Guide   | Single    | Intro/explainer post          |
| How to Test Semantic Kernel Applications in C#              | 2-3 parts | Almost no good content exists |
| Testing LLM Integrations: Mocking OpenAI/Azure OpenAI in C# | Single    | Practical testing angle       |
| Building Your First Agent with Microsoft Agent Framework    | 2-3 parts | Tutorial series               |
| How to Unit Test AI Agents in C#                            | Single    | Novel topic                   |

### AI Coding Cost Comparison

| Topic                                                                   | Format | Notes                                                                                                            |
| ----------------------------------------------------------------------- | ------ | ---------------------------------------------------------------------------------------------------------------- |
| GitHub Copilot vs Claude Code: What Does AI Coding Actually Cost?       | Single | 🔥 Unique angle: Measure actual token cost vs premium requests with real data. Two tests: spec-driven + ad-hoc. |

**Research notes (Jan 2026):**
- Existing content is saturated with generic pricing comparisons ($10/mo vs $20/mo)
- Nobody measuring actual token consumption and real dollar costs
- Premium requests vs tokens is the fundamental pricing model difference that confuses devs
- Two-tool focus keeps it clean and comparable
- Language TBD (C# or Next.js) - cost insights apply to any stack

### General AI + Testing

| Topic                                                     | Format | Notes                                    |
| --------------------------------------------------------- | ------ | ---------------------------------------- |
| Should You Trust AI-Generated Unit Tests? A Critical Look | Single | Opinion with data/examples               |
| AI Code Review Tools Comparison for .NET                  | Single | Ties into VS 2026 interview              |
| Testing AI Features in Your Application                   | Single | How to test non-deterministic AI outputs |

---

## 📚 Series Ideas

### Testing with MassTransit/RabbitMQ (3-4 parts)

1. Introduction to Testing Message-Based Systems
2. Unit Testing MassTransit Consumers
3. Integration Testing with MassTransit Test Harness
4. Contract Testing for Message-Based Systems

### Testing with .NET Aspire (3-4 parts)

1. What is .NET Aspire and Why Should You Care?
2. Testing Aspire Applications with TestContainers
3. Integration Testing Distributed Aspire Apps
4. Debugging and Observability in Aspire Tests

### Fluent Assertions Deep Dive (3-4 parts)

1. Fluent Assertions Basics You Might Have Missed
2. Custom Assertions and Equivalency Options
3. Testing Collections and Complex Objects
4. Advanced Patterns and Extension Methods

### Testing GraphQL APIs in C# (2-3 parts)

1. Unit Testing GraphQL Resolvers in C#
2. Integration Testing GraphQL with WebApplicationFactory
3. Snapshot Testing GraphQL Responses

---

## 🎤 Interview Ideas (MVP Network)

| Potential Guest         | Topic Area                            | Status                  |
| ----------------------- | ------------------------------------- | ----------------------- |
| Jimmy Bogard            | AutoMapper, MediatR, testing patterns | Not contacted           |
| Dennis Doomen           | Fluent Assertions                     | Not contacted           |
| Stryker.NET maintainers | Mutation testing                      | Not contacted           |
| David Fowler            | .NET Aspire, minimal APIs             | Not contacted           |
| Damian Edwards          | .NET team insights                    | Not contacted           |
| Isaac Levin             | Semantic Kernel                       | Not contacted           |
| Other MVPs              | Various                               | Identify at conferences |

---

## 🌉 Bridge Topics (Expand Audience)

### TypeScript Testing (C# Dev Crossover)

| Topic                                                  | Format | Notes                    |
| ------------------------------------------------------ | ------ | ------------------------ |
| How to Mock Fetch in TypeScript with Jest              | Single | Mirrors HttpClient posts |
| Testing React Components: A C# Developer's Perspective | Single | Comparison angle         |
| xUnit vs Jest: Testing Patterns Comparison             | Single | Cross-language appeal    |

### Infrastructure as Code Expansion

| Topic                                           | Format | Notes                          |
| ----------------------------------------------- | ------ | ------------------------------ |
| Pulumi vs AWS CDK: A C# Developer's Perspective | Single | Extends existing Pulumi series |
| How to Test AWS CDK Constructs in TypeScript    | Single | Testing angle on IaC           |
| From Pulumi to AWS CDK: Migration Guide         | Single | If you've done both            |

---

## 🔄 Post Update Opportunities

Refresh high-traffic posts with:

| Post                          | Update Ideas                                   |
| ----------------------------- | ---------------------------------------------- |
| Mock HttpClient (Moq)         | .NET 8 updates, link to NSubstitute version    |
| Mock HttpClient (NSubstitute) | .NET 8 updates, new methods                    |
| TestContainers series         | New TestContainers features, Aspire comparison |
| Central Package Management    | Any new .NET SDK features                      |
| Enum Routes                   | Minimal API version                            |

---

## ❌ Topics to Avoid

Based on underperforming content:

-   Purely opinion/soft-skills posts without actionable code
-   Topics with heavy existing competition (VS shortcuts, basic tutorials)
-   Content targeting non-developer audiences (conference speaking tips)
-   Overly niche topics with low search volume
-   "Top 10 lists" style content

---

## 📝 Notes

### SEO Observations

-   "How to" titles with specific library names perform best
-   C# mocking and testing keywords have consistent search volume
-   AI/Copilot content is growing but competitive from big publishers
-   Microsoft Agent Framework is new enough to establish early authority

### Content Calendar Approach

-   Mix of quick wins (1 week to write) and series posts
-   Aim for 1 post/week
-   Front-load quick wins to build momentum
-   Series posts can span 2-3 weeks each post

### Differentiation Opportunities

-   Interviews with .NET community figures (proven with Mads Kristensen)
-   Testing angle on AI content (unique)
-   Early coverage of new tech (Aspire, Agent Framework)

---

## 🔍 SEO Research (January 2026)

### GitHub Copilot + Unit Tests C#

**Search:** "github copilot generate unit tests csharp"

| Source                | Type          | Date            | Notes                                            |
| --------------------- | ------------- | --------------- | ------------------------------------------------ |
| Microsoft Learn       | Official docs | Dec 2025        | Training module for Copilot test generation      |
| GitHub Docs           | Official docs | Recent          | Tutorial on writing tests with Copilot           |
| VS Code Docs          | Official docs | Recent          | "Test with GitHub Copilot" guide                 |
| GitHub Blog           | Official      | Dec 2024        | "How to generate unit tests with GitHub Copilot" |
| Johan Smarius blog    | Independent   | **Jul 2023**    | ⚠️ Over 2 years old                              |
| Medium (Yegor Sychev) | Independent   | 1 year ago      | General tips                                     |
| Reddit r/csharp       | Forum         | **4 years ago** | ⚠️ Very outdated                                 |

**Verdict:** ✅ **OPPORTUNITY** — Lots of official docs but independent content is dated (2023-2024). A _critical evaluation_ or _testing-focused_ angle (not just "how to use") would differentiate.

---

### Microsoft Agent Framework C#

**Search:** "microsoft agent framework csharp tutorial"

| Source                        | Type          | Date         | Notes                        |
| ----------------------------- | ------------- | ------------ | ---------------------------- |
| Microsoft Learn               | Official docs | Oct-Dec 2025 | Quick-start guide, tutorials |
| YouTube (Rasmus Wulff Jensen) | Independent   | Oct 2025     | "AI in C#" series            |
| YouTube (The Code Street)     | Independent   | Oct 2025     | Series on Agent Framework    |
| DEV Community                 | Independent   | **Jan 2026** | "Build AI Agents" tutorial   |
| Medium (Venya Brodetskiy)     | Independent   | 2 weeks ago  | Getting started guide        |
| elbruno.com                   | Independent   | Oct 2025     | With Hugging Face MCP        |

**Verdict:** ✅ **HIGH OPPORTUNITY** — Very new tech (Oct 2025). Almost all content is from last 3 months. **First-mover advantage available**, especially for testing angle which has ZERO coverage.

---

### Semantic Kernel Unit Testing C#

**Search:** "semantic kernel unit testing csharp"

| Source                 | Type        | Date         | Notes                                                       |
| ---------------------- | ----------- | ------------ | ----------------------------------------------------------- |
| Microsoft Dev Blogs    | Official    | **Apr 2024** | ⚠️ "Unit Testing with Semantic Kernel" — nearly 2 years old |
| DEV Community (skUnit) | Independent | **Jan 2024** | ⚠️ 2 years old                                              |
| Medium                 | Independent | 3 months ago | General guide, not testing focused                          |
| MongoDB Docs           | Official    | Recent       | Integration with MongoDB                                    |
| accessibleai.dev       | Independent | **Dec 2023** | ⚠️ Over 2 years old                                         |

**Verdict:** ✅ **HIGH OPPORTUNITY** — Only one official testing article (Apr 2024), now outdated. Independent content is 2+ years old. Perfect for your niche.

---

### Mocking Azure OpenAI C#

**Search:** "mock azure openai csharp unit test"

| Source           | Type        | Date          | Notes                                             |
| ---------------- | ----------- | ------------- | ------------------------------------------------- |
| OpenAI Community | Forum       | **Jul 2023**  | ⚠️ 2.5 years old, unanswered                      |
| Stack Overflow   | Forum       | **Aug 2023**  | ⚠️ 2+ years old, mentions AzureOpenAIModelFactory |
| Microsoft Learn  | Official    | Apr 2025      | General Azure SDK mocking (not OpenAI specific)   |
| Bakken & Baeck   | Independent | Jul 2024      | Python focused, not C#                            |
| Substack         | Independent | 10 months ago | General, not C# specific                          |
| DEV Community    | Independent | Jun 2022      | Azure Files, not OpenAI                           |

**Verdict:** ✅ **VERY HIGH OPPORTUNITY** — Almost nothing exists. Stack Overflow answers are 2+ years old. Microsoft only has general Azure SDK mocking docs. A dedicated "How to Mock Azure OpenAI in C#" post would likely rank #1.

---

### Summary: Priority Ranking by SEO Opportunity

| Topic                                  | Competition    | Opportunity  | Recommendation                         |
| -------------------------------------- | -------------- | ------------ | -------------------------------------- |
| **Mocking Azure OpenAI in C#**         | Almost none    | 🔥 Very High | Write first — could rank #1            |
| **Testing Semantic Kernel in C#**      | Low, outdated  | 🔥 Very High | Only 1 official article from 2024      |
| **Microsoft Agent Framework Testing**  | None           | 🔥 Very High | Zero testing content exists            |
| **Microsoft Agent Framework Tutorial** | Low (new tech) | High         | Good but more competition than testing |
| **GitHub Copilot Test Generation**     | Medium         | Medium       | Official docs exist, need unique angle |

---

## 🔍 SEO Research: Hot Topics (January 2026)

### .NET 10 Features (LTS Release - Nov 2025)

Key highlights from Microsoft docs:

-   **C# 14:** `field` keyword for properties, extension blocks (static extension methods!), null-conditional assignment, partial constructors
-   **SDK:** Microsoft.Testing.Platform in `dotnet test`, container image support for console apps
-   **ASP.NET Core 10:** OpenAPI 3.1 support, Blazor improvements, passkey support
-   **EF Core 10:** Named query filters (multiple filters per entity with selective disabling)
-   **Runtime:** Post-quantum cryptography, WebSocketStream, TLS 1.3 on macOS

**Angle:** "What's New in .NET 10 for Testing" or feature-specific practical posts.

---

### OpenAPI 3.1 in ASP.NET Core

**Search:** "openapi 3.1 asp.net core tutorial"

| Source               | Type        | Date            | Notes                                           |
| -------------------- | ----------- | --------------- | ----------------------------------------------- |
| Microsoft Learn      | Official    | Jan 2026        | Generate OpenAPI docs guide for ASP.NET Core 10 |
| YouTube (dotnetFlix) | Independent | Apr 2025        | 1-hour "How to use OpenAPI in .NET"             |
| YouTube (dotnet)     | Official    | Apr 2025        | "OpenAPI Enhancements in .NET 10 Previews"      |
| Medium (Sidharth CP) | Independent | 2 months ago    | "OpenAPI & Swagger in ASP.NET Core 10"          |
| Duende Software      | Independent | Nov 2025        | Securing OpenAPI with OAuth in .NET 10          |
| Medium (2021)        | Independent | **5 years old** | ⚠️ Outdated Swashbuckle guide                   |

**Verdict:** ⚡ **MEDIUM OPPORTUNITY** — Official content is fresh, but independent practical content is limited. Best angles: "Migrating from Swashbuckle to Native OpenAPI 3.1 in .NET 10" or "Testing APIs with OpenAPI 3.1 Specs".

---

### LaunchDarkly Feature Flags C#

**Search:** "launchdarkly feature flags csharp tutorial"

| Source                    | Type        | Date            | Notes                                 |
| ------------------------- | ----------- | --------------- | ------------------------------------- |
| LaunchDarkly Docs         | Official    | Current         | Getting started guide                 |
| Medium (Ravi Kant Sharma) | Independent | 8 months ago    | "Feature Flags in .NET Core with LD"  |
| DEV Community             | Independent | Feb 2024        | Integration with HttpClientFactory    |
| Stack Overflow            | Forum       | **5 years ago** | ⚠️ "How to implement in ASP.NET Core" |
| Stack Overflow            | Forum       | 9 months ago    | Handling enums with feature flags     |
| CodeAhoy                  | Independent | **Aug 2021**    | ⚠️ 4+ years old, uses Unlaunch        |
| YouTube (LaunchDarkly)    | Official    | 2022            | VS Code integration                   |

**Verdict:** ✅ **HIGH OPPORTUNITY** — Very little C#-specific content outside official docs. Independent tutorials are old or sparse. **Testing angle is completely missing** — "How to Unit Test Feature Flag Logic with LaunchDarkly in C#" would be unique.

---

### OpenTelemetry + Aspire ASP.NET Core

**Search:** "opentelemetry aspire asp.net core tutorial"

| Source                    | Type        | Date         | Notes                                    |
| ------------------------- | ----------- | ------------ | ---------------------------------------- |
| Microsoft Learn           | Official    | Aug 2024     | OTLP + Aspire Dashboard guide            |
| OpenTelemetry.io          | Official    | Aug 2025     | Getting started with .NET                |
| DEV Community             | Independent | Feb 2025     | "OpenTelemetry in ASP.NET with Aspire"   |
| Medium (Rajkumar)         | Independent | 2 months ago | Exporting to Aspire Dashboard            |
| aspireify.NET             | Independent | Aug 2024     | Docker + OpenTelemetry + Aspire tutorial |
| YouTube (Milan Jovanović) | Independent | May 2024     | Practical intro to OpenTelemetry         |
| YouTube (dotnet)          | Official    | Nov 2024     | Getting started with OpenTelemetry       |

**Verdict:** ⚡ **MEDIUM OPPORTUNITY** — Decent "getting started" content exists. Opportunity for **testing/validation angle** like "How to Verify OpenTelemetry Instrumentation in Integration Tests" or a deep-dive series.

---

### Summary: Hot Topics Priority (Jan 2026)

| Topic                              | Competition | Opportunity  | Best Angle                              |
| ---------------------------------- | ----------- | ------------ | --------------------------------------- |
| **LaunchDarkly Testing in C#**     | Almost none | 🔥 Very High | Testing feature flag logic              |
| **OpenAPI 3.1 Migration**          | Medium      | High         | Swashbuckle → Native migration, testing |
| **.NET 10 Testing Features**       | Low         | High         | Microsoft.Testing.Platform, C# 14       |
| **OpenTelemetry + Aspire Testing** | Medium      | Medium       | Verifying instrumentation in tests      |


---

### Testing Semantic Kernel Agents C# (Apr 2026)

**Search:** `how to test semantic kernel agents c#` (general engines blocked Playwright; used direct site search per skill fallback)

| Source                                              | Type        | Date / Status      | Notes                                                                              |
| --------------------------------------------------- | ----------- | ------------------ | ---------------------------------------------------------------------------------- |
| MS Learn — Semantic Kernel Agent Framework          | Official    | Live page          | Zero mentions of `test`, `mock`, or `unit` on the agent framework docs page |
| dev.to                                              | Independent | **0 results**      | No articles match `semantic kernel agent test`                                   |
| Code Maze                                           | Independent | **0 posts**        | `Sorry, No Posts Found` for `semantic kernel agent`                            |
| Hacker News (Algolia)                               | Forum       | **0 results**      | No discussions on agent testing                                                    |
| GitHub Repositories                                 | Code        | **12 repos total** | None testing-focused; mostly demos (Multi-Agent-App-Factory, OllamaAgent, etc.)    |
| GitHub Code search                                  | Code        | Login-walled       | Could not verify count                                                             |

**Verdict:** ✅ **HIGH OPPORTUNITY** — Builds directly on the existing `Semantic Kernel Unit Testing C#` win. The agent framework is newer than the older SK content already flagged, and there is essentially zero independent testing content for SK **Agents** specifically. Official docs cover `how to build` agents but not how to test them.

**Recommended angle:** Testing-first — "How to Unit Test Semantic Kernel Agents in C#" with a follow-up on mocking `IChatCompletionService` / agent kernel functions. Possible 2-part series: (1) unit-testing a single agent's plugin behavior, (2) integration-testing multi-agent orchestration.
