# Blog Topic Recommendations for daninacan.com — May 2026

## Executive Summary

Based on (a) your blog's proven SEO winners (testing/mocking in C#, "How to X in C# using Y" formula)[^1][^2], (b) your January 2026 ideas backlog and analytics[^3][^4], (c) your open ACTION-ITEMS[^5], and (d) the current state of the .NET / AI / Copilot ecosystem as of late May 2026[^6], the highest-leverage moves are clustered in **four lanes**:

1. **Finish what's already in flight** — three of your ACTION-ITEMS map directly to topics that *also* score "🔥 Very High" on the current opportunity scan (Mock Azure OpenAI, Mock ILogger, Test Feature Flags with LaunchDarkly). Ship these first; the research is done.
2. **Microsoft Agent Framework (MAF) — testing angle** — MAF is the active successor to Semantic Kernel[^7]. Per your constraint, do NOT write about Semantic Kernel. Reframe every former-SK idea to MAF, and lead with the testing angle, which has near-zero competition[^4].
3. **MCP in C#** — the .NET 11 SDK now ships an `mcp-server` template[^8], and the **Agent Governance Toolkit for MCP** launched as Public Preview on **May 21, 2026** — three days before this report was generated[^9]. First-mover window is open *right now*.
4. **C# `union` types** — Andrew Lock's deep dive hit HN front page this week (214 pts, 249 comments)[^10]. A practical, accessible tutorial fills a real gap and matches your existing "explain a new C# feature" content type[^11].

**Top 5 picks (in priority order)** are listed at the end of this report.

---

## How These Recommendations Were Filtered

Your blog has a sharp identity, and the analytics back it[^2]:

| Filter | Why it matters |
|---|---|
| **Niche: testing, mocking, and developer tooling for .NET** | All 10 of your top-10 posts fit this niche. Branching out is OK as a secondary, not primary, bet. |
| **Title formula: "How to [verb] X in C# using Y"** | All top performers use it. Generic "What is X?" posts (e.g., Variable Naming, Conference Talks) underperform 50x+. |
| **Quick wins > thought leadership** | "Mock HttpClient" pulled 7,142 views; "Naming Variables in Tests" pulled 52. Action-oriented dominates. |
| **AI angle is now in scope** | Your 2026 plan explicitly invites AI testing content[^3], and your most recent posts confirm the pivot. |
| **Skip oversaturated tooling posts** | Visual Studio shortcuts: 42 views. Don't compete on "Top 10 Lists." |
| **CONSTRAINT: no Semantic Kernel** | Per user — SK is deprecated. Every AI-agent idea below is reframed to Microsoft Agent Framework. |

I dropped or reframed several otherwise hot topics that don't fit your formula: e.g., "What is Microsoft Foundry?" becomes "How to Mock Azure OpenAI / Microsoft Foundry calls in C#"; ".NET MAUI on CoreCLR" doesn't fit at all and is omitted; "Claude Code vs Copilot for .NET" is included only as an optional branch-out bet.

---

## Tier 1 — Ship These First (Already in Your Action Items)

These three are not new ideas — they're items #2, #3, and #5 on your ACTION-ITEMS.md[^5]. They each independently rank "🔥 Very High" or "🔥 High" on the January 2026 SEO research[^4], they all fit the proven title formula, and your research/prep work is partially done. Finishing these is the cheapest path to high-traffic posts.

### 1. **How to Mock Azure OpenAI in C# (3 Ways)**
- **Why now:** Zero meaningful competition — Stack Overflow answers are 2.5 years old, no current tutorial exists[^4]. "Microsoft Foundry" rebrand and new Responses API (v2)[^12] add fresh search traffic.
- **Formula fit:** Direct mirror of your #1 post ("Mock HttpClient with NSubstitute, 3 Ways" — 7,142 views).
- **Estimated views:** 5,000–7,000 (analogous post performance)[^2].
- **Status:** Outline pending per ACTION-ITEMS #2[^5].

### 2. **How to Mock ILogger in C# (3 Ways)**
- **Why now:** Quick win, evergreen .NET dev question, same proven formula.
- **Formula fit:** Identical structure to your top performers.
- **Estimated views:** 4,000–5,000[^5].
- **Status:** Drafting pending per ACTION-ITEMS #3[^5].

### 3. **How to Test Feature Flag Logic in C# with LaunchDarkly**
- **Why now:** Sparse C#-specific content, and the testing angle is completely missing from existing material[^4]. Enterprise readers (your secondary audience) actively search for this.
- **Formula fit:** Yes — testing angle on a popular SaaS product.
- **Status:** Listed in ACTION-ITEMS #5[^5].

---

## Tier 2 — New, High-Leverage Topics (Aligned with Your Niche)

These are new ideas that fit your formula and are timely as of May 2026.

### 4. **How to Test Microsoft Agent Framework Agents in C# (Series, 3–4 parts)**
- **Why now:** MAF is the SK successor (per Microsoft's official migration guide)[^7]. Zero meaningful testing content exists for MAF[^4]. This is a series — multiple posts, multiple ranking opportunities, internal linking pillar.
- **Suggested parts:**
   1. *How to Unit Test a Microsoft Agent Framework Agent in C#*
   2. *How to Mock Tool Calls in Microsoft Agent Framework (NSubstitute / Moq)*
   3. *How to Test MAF Durable Workflows with TestContainers and Azure Functions* — ties into the official durable workflows release[^13]
   4. *End-to-End Testing of MAF Agents with the DevUI*
- **Formula fit:** Perfect.

### 5. **How to Mock IOptions&lt;T&gt; in C#**
- **Quick-win backlog item[^4].** Saturated by .NET conventions but underserved by tutorials in your niche.

### 6. **How to Test Background Services (IHostedService) in C#**
- **Quick-win backlog item[^4].** Recurring developer question with no canonical recent tutorial.

### 7. **How to Test Minimal APIs with WebApplicationFactory in C#**
- **Quick-win backlog item[^4].** Minimal APIs are now the default in .NET 9/10 templates; integration testing patterns are evolving.

### 8. **How to Mock DateTime / TimeProvider (.NET 8+) in C#**
- **Quick-win backlog item[^4].** `TimeProvider` is the modern answer that supersedes older "abstract `IClock`" patterns; tutorial-grade content is sparse.

### 9. **How to Build an MCP Server in C# (with Tests)**
- **Why now:** .NET 11 Preview 4 ships `dotnet new mcp-server`[^8]. Most MCP tutorials are Python/TypeScript — C# is wide open. Add a testing/mocking section to make it uniquely yours.
- **Formula fit:** "How to build [X] in C#" — strong.

### 10. **How to Secure MCP Tool Calls in C# with the Agent Governance Toolkit**
- **Why now:** `Microsoft.AgentGovernance.Extensions.ModelContextProtocol` launched as Public Preview on **May 21, 2026** — first-mover window is open[^9].
- **Formula fit:** "How to secure X in C# using Y" — works.
- **Risk:** New API, may shift in subsequent previews. Worth the risk given the timing.

### 11. **How to Snapshot-Test C# Code with Verify**
- **Quick-win backlog item[^4].** Verify is mature, has growing community adoption, and there's no canonical "intro for testers" article.

### 12. **How to Migrate from Semantic Kernel to Microsoft Agent Framework in C#**
- **Why now:** Migration searches are high-intent. Microsoft has an official migration guide[^7]; an independent practical walkthrough has clear demand.
- **Note:** This post inherently mentions SK (in the title and "migrating from" framing), which is unavoidable for the migration audience. It is *not* a tutorial on writing SK code — it's a guide *away* from it. If you'd rather not mention SK at all, skip this one.

---

## Tier 3 — Update / Refresh Posts (High ROI, Low Effort)

Per your strategy file, refreshing top-traffic posts for .NET 8/9/10 is explicitly recommended[^3]. Pick the highest-traffic ones:

### 13. **Refresh: "How to Mock HttpClient in C# Using Moq" / "...Using NSubstitute"**
- Your #1 and #3 top posts (7,142 + 5,029 views)[^2]. Add a `.NET 8/10` section, mention `IHttpClientFactory` evolution, link to the new TimeProvider/IOptions posts when those go live.

### 14. **Refresh: "How to Use Enums in ASP.NET Core Routes" — Minimal API Edition**
- Your #2 top post (7,133 views)[^2]. The original predates Minimal APIs; a "Minimal API version" appendix or follow-up captures the new traffic.

### 15. **Refresh: "Central Package Management with .NET Solutions"**
- 3,158 views[^2]. New SDK features around CPM exist; refresh + link the existing post.

---

## Tier 4 — Bet on a Trend (Single Posts, Slight Niche Stretch)

These don't fit your testing-and-mocking core, but each one rides a current wave and matches your "explain a new C# feature" content type (which has worked for you historically with C# Patterns posts).

### 16. **C# Union Types: A Practical Guide to the `union` Keyword in .NET 11**
- **Why now:** HN front page this week (214 pts, 249 comments)[^10]. Andrew Lock has the deep dive; an accessible practical tutorial fills a real gap.
- **Risk:** Outside your testing niche, but matches your `IAsyncEnumerable` / C# feature content type (which produced 3,300+ views per post)[^2].

### 17. **What's New for Testing in .NET 10 (Microsoft.Testing.Platform & C# 14)**
- **Why now:** .NET 10 LTS released Nov 2025; teams are migrating now[^6]. `Microsoft.Testing.Platform` is the new direction.
- **Formula fit:** Adjacent — slightly more "What's new" than "How to," but the testing focus keeps it in-niche.

### 18. **GitHub Copilot Agent Mode for .NET: How to Generate Unit Tests That Actually Work**
- **Why now:** Copilot agent mode is GA[^14]; you're already pivoting toward Copilot content (your latest two posts are AI-themed). A *critical, hands-on* take ("3 tests Copilot got right, 2 it got wrong") matches your formula and avoids the saturated "Copilot is amazing" tone.
- **Bonus:** Aligns with ACTION-ITEMS #4 ("Copilot Gap" repurpose)[^5].

---

## Tier 5 — Optional / Branch-Out Bets

Skip unless you want to broaden your audience:

- **Claude Code vs GitHub Copilot for .NET Development** — comparison posts pull traffic but pull a different audience; lower formula fit.
- **TUnit vs xUnit: I Replaced xUnit for a Month** — TUnit is rising[^15]; opinion/migration post is a stretch from "how to" but adjacent. Could be high-value if you really do migrate.
- **OpenTelemetry in ASP.NET Core 2026 Edition** — Application Insights is being de-emphasized in favor of OTEL[^16]. Outside your testing niche but in adjacent dev-tooling territory.
- **EF Core 11 Vector Search with SQL Server 2025** — very niche, very new[^17]. Wait until .NET 11 GAs.

---

## Top 5 Recommendations (Do These First, in This Order)

| # | Post | Why it's #1–5 |
|---|---|---|
| 1 | **How to Mock Azure OpenAI in C# (3 Ways)** | Highest projected ROI; zero competition; matches #1 top-post formula; already on your action list |
| 2 | **How to Mock ILogger in C# (3 Ways)** | Quick-win; near-zero competition; matches formula; already on your action list |
| 3 | **How to Build an MCP Server in C# (with Tests)** | Long-term SEO winner; .NET 11 template ships now; C# MCP content is sparse; testing angle is uniquely yours |
| 4 | **How to Test Microsoft Agent Framework Agents in C# (Part 1 of a series)** | Pillar post for a multi-part series; first-mover in MAF testing; replaces all former-SK ideas |
| 5 | **C# Union Types: A Practical Guide to the `union` Keyword** | Time-sensitive (HN wave is right now); matches your C# feature explainer type; ship within 2 weeks |

---

## Topics Explicitly Avoided

- **Semantic Kernel anything** — per your constraint. All former SK ideas have been reframed to Microsoft Agent Framework.
- **"Top 10 lists"**, opinion-only posts, soft-skills posts, conference-talk-ideas-style posts — per your strategy file[^1].
- **Heavily saturated dev tooling** (e.g., generic "Visual Studio shortcuts," generic "Git tips") — your analytics show these underperform 50–100x[^2].

---

## Confidence Assessment

| Area | Confidence | Notes |
|---|---|---|
| Your blog's niche, formula, and analytics | **Very High** | Direct read of your skill files and analytics doc[^1][^2]. |
| Ideas backlog priorities | **Very High** | Direct read of `ideas-backlog.md` (Jan 2026)[^4]. |
| MAF / MCP / Governance Toolkit timeliness | **High** | Confirmed against official Microsoft devblogs dated May 2026[^7][^8][^9]. |
| C# union types HN traction | **High** | Confirmed via HN front page snapshot[^10]. |
| Search demand estimates | **Medium** | Reddit and Google Trends were not directly accessible; estimates inferred from HN engagement, official content volume/freshness, and your own analytics on analogous past posts. Treat numbers as directional, not precise. |
| ".NET 11 ships `mcp-server` template" | **High** | Sourced from official .NET 11 Preview 4 blog post[^8]. |
| Microsoft Agent Framework as official SK successor | **High** | Confirmed via the MAF GitHub repo's "Migration from Semantic Kernel" section and the MS Learn migration guide[^7]. |

**Assumptions made (autonomous workflow):**
- Treated "currently" as "as of late May 2026" given the current date.
- Assumed you want recommendations weighted toward the proven testing/mocking niche rather than a pure "what's hot" list.
- Assumed your ACTION-ITEMS list is still active and not stale.

---

## Footnotes

[^1]: `.github/skills/blog-content-strategy/SKILL.md` — title formula, audience definition, content structure, and "what to avoid" checklist.

[^2]: `.github/skills/blog-content-strategy/analytics-and-strategy.md` — top 10 post views (April 2023 – January 2026), underperforming-post patterns, 2026 content plan.

[^3]: `.github/skills/blog-content-strategy/analytics-and-strategy.md` — "2026 Content Plan" section, including AI Opportunities and Update Opportunities lists.

[^4]: `.github/skills/post-ideas/ideas-backlog.md` — SEO research table (Jan 2026) ranking topics by opportunity, including Mock Azure OpenAI (🔥 Very High), MAF testing (✅ High), LaunchDarkly testing (✅ High).

[^5]: `ACTION-ITEMS.md` — items #2 (Mock Azure OpenAI outline), #3 (Mock ILogger draft), #4 (Copilot Gap repurpose), #5 (LaunchDarkly + testing).

[^6]: Microsoft .NET blog category index — `https://devblogs.microsoft.com/dotnet/` — surveyed for releases between Nov 2025 and May 2026.

[^7]: [microsoft/agent-framework](https://github.com/microsoft/agent-framework) — README, including "Migration from Semantic Kernel" section. Also `learn.microsoft.com/en-us/agent-framework/migration-guide/from-semantic-kernel`.

[^8]: [Announcing .NET 11 Preview 4](https://devblogs.microsoft.com/dotnet/dotnet-11-preview-4/) — ASP.NET Core / SDK section confirms the new `dotnet new mcp-server` template.

[^9]: [Announcing the Agent Governance Toolkit: MCP Extensions for .NET](https://devblogs.microsoft.com/dotnet/announcing-agent-governance-toolkit-mcp-extensions-for-dotnet/) — Public Preview launched May 21, 2026. Covers tool poisoning, prompt injection, typosquatting mitigations.

[^10]: Andrew Lock — `https://andrewlock.net/exploring-the-dotnet-11-preview-2-dotnet-gets-union-types/` and the corresponding Hacker News thread (#18 of the day, 214 points, 249 comments as of May 23, 2026).

[^11]: `blog/content-posts/` — your existing C# feature explainers (e.g., "How to Use IAsyncEnumerable in C# for Paged APIs" — 3,309 views) establish a working content pattern for new-feature posts.

[^12]: [What is Azure AI Foundry](https://learn.microsoft.com/en-us/azure/ai-foundry/what-is-azure-ai-foundry) — documents the "Microsoft Foundry" rebrand and the Responses API (v2) replacing the Assistants API.

[^13]: [Durable Workflows in Microsoft Agent Framework](https://devblogs.microsoft.com/dotnet/durable-workflows-in-microsoft-agent-framework/) — May 6, 2026 walkthrough of Durable Task scheduler hosting on Azure Functions.

[^14]: [GitHub Copilot: The Agent Awakens](https://github.blog/news-insights/product-news/github-copilot-the-agent-awakens/) — agent mode GA announcement.

[^15]: [thomhurst/TUnit](https://github.com/thomhurst/TUnit) — source-generated test discovery, parallel by default, AOT support, `TUnit.Aspire` integration.

[^16]: [Announcing .NET 11 Preview 4](https://devblogs.microsoft.com/dotnet/dotnet-11-preview-4/) — SDK section: "OpenTelemetry replaces Application Insights for CLI telemetry."

[^17]: [Announcing .NET 11 Preview 4](https://devblogs.microsoft.com/dotnet/dotnet-11-preview-4/) — EF Core section: approximate vector search for SQL Server 2025.
