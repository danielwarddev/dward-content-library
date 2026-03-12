# Blog Topic Ideas Mined From the Repo

**Generated:** 2026-03-03  
**Context:** Analyzed all presentations, brainstorms, project ideas, published posts, SEO research, and analytics to surface the highest-potential blog topics — including extrapolations the user hasn't explicitly listed yet.

---

## The Ideas

### 1. How to Mock Azure OpenAI in C# for Unit Testing

**Source:** SEO research shows *almost zero competition*. Your mocking posts (HttpClient, File IO, ClaimsPrincipal) are your top performers. This is the same proven formula applied to the hottest topic in .NET right now.

**Why it's great:** Your #1 post (Mock HttpClient with NSubstitute, 7.1k views) proves this exact format works. The Azure OpenAI SDK has an `AzureOpenAIModelFactory` that almost nobody knows about. You'd likely rank #1 on Google.

**Format:** Single post, "How to Mock Azure OpenAI in C# (3 Ways)"

---

### 2. How to Unit Test Semantic Kernel Plugins and Planners in C#

**Source:** SEO research confirms only 1 outdated official article from April 2024. Your presentation on AI unit testing (`ai-unit-testing.md`) already covers the thinking behind testing AI-generated code, and you have the testing credibility to own this space.

**Why it's great:** Semantic Kernel is Microsoft's flagship AI orchestration library and the testing story is essentially undocumented. A 2–3 part series would establish early authority the way your Pact contract testing series did.

**Format:** 2–3 part series

---

### 3. The Copilot Gap: What Most Teams Get Wrong With AI Coding Tools

**Source:** Your `copilot-gap.md` presentation abstract. You've been coaching enterprise teams on AI for a year — that's rare firsthand experience. Your analytics show opinion pieces *without code* underperform, but this one can include concrete examples (Agent Skills config, custom instructions, MCP setup).

**Why it's great:** This is your most differentiated presentation idea. A blog version lets you reach the massive audience of devs whose companies gave them Copilot with zero guidance. Make it code-heavy (show the `.github/copilot-instructions.md`, Agent Skill YAML, MCP config) and it avoids the "soft skills" trap.

**Format:** Single post or 2-part series (Part 1: The problem & mental model, Part 2: Features & patterns demo)

---

### 4. How to Test Feature Flag Logic in C# with LaunchDarkly

**Source:** SEO research shows almost no C# content, and *zero* with a testing angle. This is a direct extension of your testing niche into a widely-used enterprise tool.

**Why it's great:** Feature flags are everywhere in enterprise .NET but testing them is an afterthought. You'd cover mocking `ILdClient`, testing flag evaluation logic, and integration testing with LaunchDarkly's test fixtures. Same "How to Mock X in C#" formula.

**Format:** Single post

---

### 5. How to Build a Custom AI Agent in C# with the GitHub Copilot SDK

**Source:** Your 4 brainstorm files have 40+ project ideas. Your `copilot-sdk.md` presentation promises "zero to working agent in 10 minutes." A blog walkthrough of one of the simpler ideas (PR Description Generator or Codebase Onboarding Assistant) turns that presentation into evergreen search traffic.

**Why it's great:** The SDK just launched and independent tutorial content is almost nonexistent. Your presentation already has the structure — the blog version adds the step-by-step code your audience expects.

**Format:** Single post (could expand into a series with different agent examples)

---

### 6. How to Mock ILogger in C# (3 Ways)

**Source:** Listed as a quick win in your ideas backlog. Your "3 Ways" format is proven (HttpClient posts are #1 and #3 by views). ILogger mocking is one of the most common C#/.NET pain points on Stack Overflow.

**Why it's great:** This is probably a top-5 Google search among .NET devs writing tests. It's a fast write, follows your best-performing formula exactly, and backlinks naturally to your existing mocking posts.

**Format:** Single post

---

### 7. How to Write Integration Tests for .NET Aspire Applications

**Source:** Your ideas backlog lists a 3–4 part Aspire series, and your TestContainers expertise (4.2k views on that post) transfers directly. Aspire is Microsoft's new distributed app framework and the testing story is still forming.

**Why it's great:** You'd be one of the first to cover this intersection authoritatively. Aspire's `DistributedApplicationTestingBuilder` is new and confusing. Combine it with your TestContainers and Respawn knowledge for a unique angle nobody else has.

**Format:** 2–3 part series

---

### 8. How to Test MassTransit Consumers in C# with the Test Harness

**Source:** Your ideas backlog lists a 3–4 part MassTransit series. Message-based architecture testing is underserved, and your contract testing series (9 parts on Pact) shows you can own a testing sub-niche through depth.

**Why it's great:** Message-based systems (RabbitMQ, Azure Service Bus) are increasingly common but testing them is poorly documented. MassTransit has a built-in test harness that few people know about. This fills a genuine gap.

**Format:** 3–4 part series (Unit testing consumers → Test Harness → Integration with TestContainers → Contract testing messages with Pact)

---

### 9. Measuring Developer Productivity: What Actually Works (With Data)

**Source:** Your `measure-developer-productivity.md` presentation. This is a deviation from pure coding tutorials, but your analytics show the Mads Kristensen interview (a non-code post) got 1.6k views because it offered *unique perspective*. Your experience on both sides of leadership and development is that unique angle.

**Why it's great:** Make it data-driven and opinionated rather than a listicle. Include real examples of metrics that helped vs. metrics that backfired, DORA/SPACE frameworks with honest evaluation, and concrete recommendations. Pairs well with a "How to Implement DORA Metrics with GitHub Actions" follow-up post that brings the code angle back.

**Format:** Single post (opinion/framework) + optional follow-up (code tutorial)

---

### 10. From SQLite to TestContainers: Migrating Your EF Core Test Suite

**Source:** Your `no-more-sqlite-testcontainers.md` presentation and your existing TestContainers blog series (4.2k views). The presentation frames it as a *migration* story, which is a different (and arguably more useful) entry point than your existing "how to set up TestContainers" posts.

**Why it's great:** Many teams already have SQLite-based test suites and know they're flaky. A migration guide with before/after code, gotchas, and performance benchmarks gives them a concrete path. This captures a different search query ("replace sqlite tests") than your existing posts.

**Format:** Single post

---

### 11. How to Mock DateTime and TimeProvider in C# (.NET 8+)

**Source:** Ideas backlog quick win. `TimeProvider` is a .NET 8 abstraction that replaced the old "wrap DateTime.Now in an interface" pattern, and many devs don't know it exists yet.

**Why it's great:** Classic "How to Mock X in C#" format. The old pattern (custom `IDateTimeProvider` interface) is still what most Stack Overflow answers recommend. A post showing the built-in `TimeProvider` + `FakeTimeProvider` from `Microsoft.Extensions.TimeProvider.Testing` would be genuinely useful and rank well.

**Format:** Single post

---

### 12. Building a VS Code Extension That Visualizes Copilot Conversations

**Source:** Your `project-ideas/copilot-conversation-visualizer/` folder. You noted no competitor exists. A "build log" style blog post series documenting the creation of a real VS Code extension — using AI to build it — would be compelling content that doubles as marketing for the extension.

**Why it's great:** It's a unique content format for your blog (build diary), showcases AI-assisted development in practice, and produces a real artifact (the extension). Each post in the series could cover a phase: architecture decisions, VS Code extension API, parsing Copilot's conversation format, the visualization UI.

**Format:** 3–4 part series

---

### 13. What's New in .NET 10 for Testing

**Source:** SEO research on .NET 10 features, specifically `Microsoft.Testing.Platform` becoming the default in `dotnet test`, C# 14 features (partial constructors, `field` keyword), and EF Core 10 named query filters.

**Why it's great:** Every .NET major release drives a wave of "what's new" searches. Filtering it through a testing lens is your distinctive angle. Cover the new testing platform, how C# 14 features affect test code, and EF Core 10's named query filters for cleaner test setups.

**Format:** Single post

---

### 14. How to Test Background Services (IHostedService) in C#

**Source:** Ideas backlog quick win. Background services are everywhere in .NET apps but testing them is awkward because of their lifecycle (start/stop, timers, cancellation tokens).

**Why it's great:** Common pain point, poor existing content, and fits neatly into your "How to Test X in C#" formula. Cover both unit testing the logic and integration testing with `WebApplicationFactory`.

**Format:** Single post

---

### 15. GitHub Copilot vs Claude Code: What Does AI Coding Actually Cost?

**Source:** Your ideas backlog has this flagged with a 🔥. Your Copilot Gap presentation gives you credibility on both tools. Nobody is measuring *actual token costs* vs. premium request limits with real data.

**Why it's great:** The existing comparison content is all generic pricing pages ($10/mo vs $20/mo). A post that runs the same real task on both tools, measures actual token consumption, and compares dollar-for-dollar cost would go viral in dev circles. It's the kind of original research that gets shared.

**Format:** Single post

---

## Suggested Priority Order

| Priority | Post | Rationale |
|----------|------|-----------|
| 1 | Mock Azure OpenAI (#1) | Highest SEO opportunity, proven format, fastest to write |
| 2 | Mock ILogger (#6) | Quick win, highest search volume, builds momentum |
| 3 | Mock DateTime/TimeProvider (#11) | Quick win, pairs with #6 for a "mocking week" |
| 4 | Copilot Gap blog version (#3) | Differentiator, timely, leverages your coaching experience |
| 5 | Test Semantic Kernel (#2) | Very high SEO opportunity, establishes AI+testing authority |
| 6 | Copilot SDK tutorial (#5) | New tech first-mover advantage |
| 7 | LaunchDarkly testing (#4) | Zero competition, enterprise relevance |
| 8 | Test IHostedService (#14) | Quick win between bigger posts |
| 9 | .NET Aspire testing series (#7) | Series to build sustained traffic |
| 10 | Copilot vs Claude Code cost (#15) | Viral potential, original research |

---

## Notes

- Ideas 1, 2, 4, 6, 11, and 14 follow your proven "How to Mock/Test X in C#" formula and can each be written in under a week.
- Ideas 3, 5, 12, and 15 are *differentiators* — they leverage your unique experience (AI coaching, Copilot SDK presentations, project ideas) and are harder for competitors to replicate.
- Ideas 7, 8, and 12 are series that build sustained traffic over months, like your Pact and Pulumi series did.
- The "testing person who does AI" positioning is your biggest strategic advantage. Ideas 1, 2, 3, 5, and 15 all reinforce it.
