# .NET Testing Pain Points — Solo-Dev Library Opportunities (2024–2026)

## Executive Summary

The .NET testing ecosystem in 2024–2026 has been destabilized by three concurrent shocks: **FluentAssertions going commercial in v8** (~$130/dev/yr, Jan 2025)[^1], the **Moq SponsorLink controversy** (Aug 2023) that scared users without actually displacing the library[^2], and the **Microsoft.Testing.Platform (MTP) migration** which is breaking adapter-based tooling (Stryker, Coverlet, IDE test discovery, AI coding agents)[^3]. On top of that, **xUnit v3 dropped older TFMs and made test projects executables**, alienating multi-target library authors like Andrew Lock[^4], and **TUnit** is real but young and has critical AI-tooling and ecosystem gaps[^5].

The most actionable opportunities for a solo developer are concentrated in **integration testing helpers** (WebApplicationFactory auth/seeding boilerplate, HTTP mock that survives WireMock.Net going commercial, SignalR WebSocket TestServer), **AOT/source-generator alternatives** to reflection-based incumbents (Bogus, AutoFixture, mocking), and **CI orchestration** (test sharding, flaky test detection, BenchmarkDotNet regression bot) — all small enough to ship solo, with clear analogues in other ecosystems (pytest-xdist, Playwright `--shard`, k6) that prove demand. Several opportunities are time-sensitive: the FluentAssertions vacuum, the MTP ecosystem catch-up, and AI-agent-friendly tooling all have a 12–24 month window.

This report classifies as a **conceptual / market-research deep-dive**. Findings below are grouped by theme, with viability scoring for solo execution.

---

## 1. The Shockwaves That Created Today's Opportunities

| Event | Date | Impact | Opportunity Created |
|------|------|--------|--------------------|
| Moq adds SponsorLink (telemetry/spyware) | Aug 2023 | Reputational, no mass exodus[^2] | NSubstitute uplift; source-gen mocking thesis (TUnit.Mocks)[^6] |
| FluentAssertions v8 commercial relicense | Jan 2025 | AwesomeAssertions fork hit 2.46M downloads in ~16 months[^1] | Assertion message quality / collection diff niche |
| Microsoft.Testing.Platform replaces VSTest | 2024–ongoing | Stryker, Coverlet, FsCheck, AI agents all broke[^3][^7] | MTP adapters; CLI compat shims |
| xUnit v3 ships, drops TFMs, exe-only projects | 2024 | Andrew Lock declared he is "stuck on v2 forever"[^4] | xUnit v2 LTS forks; migration tooling |
| TUnit reaches v1, source-gen first | 2024–2025 | Real adoption but AI tools can't use it[^5] | TUnit-compat helper, ecosystem packages |

---

## 2. Top-Tier Opportunities (Solo Viable, High Demand, Clear Scope)

### 2.1 WebApplicationFactory Auth & Seeding Toolkit  ⭐ HIGHEST VIABILITY
**Every .NET shop reinvents ~30 lines of `TestAuthHandler` + claims-injection + scheme-override boilerplate**, and `dotnet/aspnetcore#26487` ("Scheme already exists: Identity.Application" when re-registering auth in tests) has been open since 2020[^8]. There is no first-class API for `factory.CreateAuthenticatedClient(claims...)`. Adjacent gap: no library wraps Respawn + per-test seeding into `Given.Database.Contains(new Product {...})` style declarative fixtures — Respawn only wipes, it doesn't seed (jbogard/Respawn#122)[^9].

**Scope:** Small-medium NuGet, ~2–4 weeks. **Risk:** Microsoft may eventually ship this. **Differentiator:** ship now, target xUnit + NUnit + TUnit + MSTest simultaneously via abstraction over `IHost`.

### 2.2 OSS HTTP Mock That Survives WireMock.Net Pro
WireMock.Net is moving features (record/playback, advanced matching, stateful behavior) into a paid `WireMock.Net.Pro` tier[^10]. Existing alternatives: `RichardSzalay.MockHttp` (handler-level only), `Costello.HttpClientInterception` (limited matching). None integrate cleanly with `IHttpClientFactory`/typed clients + WAF service replacement.

**Scope:** Medium NuGet, 3–6 weeks. **Risk:** WireMock.Net OSS tier might stay competitive. **Differentiator:** typed-client first-class API + `factory.MockHttpClient<IExternalApi>(...)` extensions.

### 2.3 SignalR `WithTestServer(... WebSockets)` Extension
`dotnet/aspnetcore#11888` has been open since **2019**: `TestServer` only supports LongPolling/SSE for SignalR, never WebSocket. The aspnetcore team proposed the API (`HubConnectionBuilder.WithTestServer(server, HttpTransportType.WebSockets)`) but never shipped it[^11]. Anyone with SignalR + binary-protocol bugs cannot reproduce them in-process.

**Scope:** Tiny-small package, 1–2 weeks. **Risk:** ASP.NET Core team might finally ship it. **Differentiator:** Nothing exists today and the design is already documented in the issue.

### 2.4 `dotnet-bench-compare` — BenchmarkDotNet Regression Bot
`dotnet/BenchmarkDotNet#155` (perf regression detection) has been open since **2016**[^12]. Teams manually paste two Markdown tables into PRs and eyeball them. Other ecosystems have `benchmark-action/github-action-benchmark`; .NET has nothing as polished. A global tool that diffs two BDN JSON exports, posts a Markdown PR comment, and exits non-zero on regression > threshold solves a problem every perf-conscious .NET team has.

**Scope:** Small CLI + GitHub Action, 1–2 weeks. **Monetization:** SaaS history dashboard. **Differentiator:** First-class BDN JSON, not a generic benchmark differ.

### 2.5 `dotnet-test-shard` — History-Aware Test Sharding
`dotnet test` has no built-in sharding. GitHub Actions matrix users manually hard-code `--filter "Category=Group1"` in YAML. Playwright has `--shard`, pytest has `pytest-xdist`, Go has `-parallel`. .NET has nothing equivalent. A tool that reads TRX/JUnit XML history and outputs a balanced `--filter` per shard fills the gap.

**Scope:** Small-medium global tool, 2–3 weeks. **Risk:** MTP may eventually ship cross-process sharding. **Differentiator:** Works today with VSTest *and* MTP runners.

### 2.6 `dotnet-flaky-detect` — Quarantine Tool for GitHub Actions
Azure DevOps has built-in flaky test detection; GitHub Actions has nothing. No OSS .NET tool parses TRX/junit.xml history and emits a quarantine list. Community workaround is manual `[Retry(3)]` with zero systemic tracking.

**Scope:** Small CLI, 1–2 weeks. **Differentiator:** Pair with `dotnet-test-shard` as a CI bundle.

---

## 3. Second-Tier Opportunities (Viable but Bigger Lift or Niche Risk)

### 3.1 Standalone Source-Generator Mocking Library
TUnit.Mocks proves AOT-compatible source-gen mocking works (global `VerifyInOrder` across mocks, no Castle.Core)[^6]. It is **not available as a standalone NuGet** for xUnit/NUnit/MSTest users. Castle.DynamicProxy can't mock statics, sealed classes, structs, `DateTime.Now`, or extension methods — a wall every team hits. No credible OSS solution exists for static mocking (Typemock and JustMock are paid, Microsoft Fakes is VS Enterprise only)[^13].

**Scope:** Large (3–6 months). **Risk:** Thomas Hurst may extract TUnit.Mocks himself. **Differentiator:** ship first as `Mockable.SourceGen` or similar; AOT-ready angle aligns with the Native AOT trend.

### 3.2 `ILogger<T>` Verification Helper
Every Castle.DynamicProxy-based framework fails on `ILogger.LogInformation(...)` because it's an extension method — you must verify the underlying `Log()` call with five `Arg.Any<>()` params[^14]. **Note:** Microsoft shipped `Microsoft.Extensions.Logging.Testing.FakeLogger<T>` in .NET 8; check whether this covers the gap before targeting it. If yes, this opportunity is closed; if no (e.g., insufficient fluent verification), a thin `logger.ShouldHaveLogged(LogLevel.Info, "message contains X")` extension is a weekend package.

**Scope:** Tiny if gap exists. **Verification needed:** investigate FakeLogger gaps first.

### 3.3 Bogus Source-Generator Companion
Bogus uses runtime reflection for `RuleFor`; no AOT support, no IDE autocomplete on generated property names, no compile-time validation. A `[GenerateFaker]`-attributed type produces a strongly-typed faker at compile time, AOT-compatible, with IntelliSense.

**Scope:** Medium, 3–6 weeks. **Risk:** Brian Chavez may add it. **Differentiator:** novel in .NET, AOT-aligned.

### 3.4 `Verify.Playwright.Visual` — Blazor Visual Regression
No packaged visual regression tool exists for Blazor. Playwright.NET can screenshot, but no library wires pixel diff + approval-file workflow + Verify integration. A small extension would slot into the Verify ecosystem.

**Scope:** Small-medium, 1–3 weeks. **Risk:** Cropp may ship `Verify.Playwright` himself. **Caveat:** screenshot determinism across OS/browser is hard.

### 3.5 Test Gap Roslyn Analyzer
A Roslyn analyzer that warns when a `public` method has no test calling it, plus a code-fix to generate a test skeleton (`[Theory]` + `AutoFixture`/`Bogus`). Bounded scope, immediately useful, no AI required for the MVP.

**Scope:** Medium analyzer. **Differentiator:** standalone, no SaaS required.

### 3.6 Database Isolation Strategy Library
Wraps the "transaction-per-test vs Respawn-reset vs container-per-class vs snapshot-restore" decision into a pluggable abstraction over WAF/EF Core/Testcontainers lifecycle. Today every team writes this from scratch[^9].

**Scope:** Medium, 4–6 weeks. **Differentiator:** EF Core + Respawn + Testcontainers wired together with clean lifecycle hooks.

---

## 4. Speculative / Long-Shot Opportunities

| Idea | Why Interesting | Why Hard |
|------|----------------|----------|
| Pure-C# property-based testing (Hypothesis equivalent) | FsCheck is F#-first and broken on xUnit v3[^15]; CsCheck is one-person; nothing offers stateful + DB shrinking | Large surface area; needs serious algorithmic work |
| Static-method mock via IL-weaving (OSS Pose successor) | Largest unfilled gap in .NET mocking | Very hard; brittle across runtimes; AOT-incompatible |
| `TestGapAnalyzer` + AI generation | No good Diffblue equivalent for .NET; IntelliTest abandoned | Drifts into product territory |
| MTP adapter for Stryker | Stryker is broken with TUnit/xUnit v3 MTP-mode (#3094, #3424)[^7] | Requires deep Stryker internals knowledge |
| AspNet WAF helpers for "service replacement that actually works" | `ConfigureTestContainer<T>` has been broken since Oct 2019 (#14907)[^16] | Risk MS finally fixes it upstream |

---

## 5. The Single Biggest Strategic Insight

**Multi-runner targeting is the differentiator.** Most existing libraries are tied to one framework (xUnit-only, NUnit-only). With xUnit v3 churn, NUnit v4 churn, MSTest in its MTP rebirth, and TUnit climbing — a library that abstracts over **all four** test runners (parametrized data attributes, lifecycle hooks, assertion failure types) buys insurance against the next framework war and immediately addresses 100% of the .NET test market. This is what tools like Verify and AutoFixture got right early. Any new package in this report should be designed this way from day one.

A close second: **AI-agent friendliness**. TUnit's biggest adoption blocker is that Copilot/Claude/Codex keep emitting `--filter` instead of `--treenode-filter` (TUnit #5454, #5088)[^5]. Any new test tooling should ship with a clear, conventional CLI; a doc page that AI corpora will scrape; and ideally a Roslyn analyzer that fixes wrong AI-generated calls in place. This is a *new* design constraint that didn't exist three years ago.

---

## 6. Recommendation Ranking for a Solo Builder

If you want to ship **one** library in **6–8 weeks**, ranked by (demand × scope-fit × ecosystem timing):

1. **WAF Auth + Seeding Toolkit** (§2.1) — universal need, no incumbent, clean scope
2. **`dotnet-bench-compare` GitHub Action** (§2.4) — viral if it works, tiny scope, monetizable
3. **SignalR `WithTestServer(WebSockets)`** (§2.3) — 6-year-old gap, surgical fix
4. **OSS `IHttpClientFactory`-aware HTTP mock** (§2.2) — bigger lift but timing on WireMock.Net Pro is now
5. **`dotnet-test-shard` + `dotnet-flaky-detect` bundle** (§2.5 + §2.6) — pair them for a "CI Toolkit for .NET" brand

If you want to ship a **flagship project** in 3–6 months, the Standalone Source-Generator Mocking library (§3.1) has the highest ceiling and aligns with the Native AOT direction Microsoft is pushing.

---

## 7. Confidence Assessment

**High confidence:**
- The FluentAssertions licensing event, Moq SponsorLink event, and xUnit v3 dropping TFMs all happened and created real ecosystem disruption. Cited GitHub issues are real and reflect current open state as of research date.
- WAF auth boilerplate, Respawn-only-wipes, WireMock.Net Pro tier shift, SignalR WebSocket gap, BenchmarkDotNet regression detection gap are all confirmed by long-open issues.

**Medium confidence:**
- Market sizing for each opportunity (download counts cited are accurate; revenue/adoption forecasts are not).
- Whether `Microsoft.Extensions.Logging.Testing.FakeLogger<T>` already addresses the ILogger mocking gap (needs verification before building anything in §3.2).
- Whether TUnit.Mocks will be extracted as a standalone NuGet by its maintainer (would close §3.1's window).

**Low confidence / assumptions made:**
- Reddit sentiment could not be verified — Reddit returned JS-challenge walls during research. Findings rely on GitHub issues, StackOverflow vote/view counts, and well-known .NET bloggers (Andrew Lock, Simon Cropp commentary).
- AwesomeAssertions v9 feature parity with FA v8/v9 was not fully audited.
- AutoFixture v5 release timeline ("soon" since 2019) — assumed it will continue to slip but not verified.
- Microsoft's roadmap for first-party WAF helpers and MTP sharding is not public; opportunities here could be closed by future MS releases.

---

## Footnotes

[^1]: AwesomeAssertions reached 2.46M downloads of v9.4.0 within ~16 months of FluentAssertions v8 relicense (Jan 2025, $129.95/dev/yr). [nuget.org/packages/AwesomeAssertions](https://www.nuget.org/packages/AwesomeAssertions); [fluentassertions.com licensing](https://fluentassertions.com/)
[^2]: Moq retains 172M downloads on v4.20.72 (Sep 2024) and 1,400 GitHub dependent repos — SponsorLink (Aug 2023) created noise but no mass exodus. [nuget.org/packages/Moq](https://www.nuget.org/packages/Moq); [devlooped/moq#1372](https://github.com/devlooped/moq/issues/1372)
[^3]: `stryker-mutator/stryker-net#3094` and `#3424` — Stryker fails on MTP-mode projects: "Could not find an assembly reference to a mutable assembly." [github.com/stryker-mutator/stryker-net/issues/3094](https://github.com/stryker-mutator/stryker-net/issues/3094)
[^4]: Andrew Lock, "Why I'm not adopting xUnit.v3" — describes TFM matrix problem and three major versions in 6 months as personal blockers. [andrewlock.net](https://andrewlock.net/)
[^5]: TUnit #5454 and #5088 — Claude Code / Codex repeatedly emit `--filter` instead of TUnit's `--treenode-filter`, wasting tokens and causing migration regret. [github.com/thomhurst/TUnit/issues/5454](https://github.com/thomhurst/TUnit/issues/5454)
[^6]: TUnit.Mocks provides global cross-mock `Mock.VerifyInOrder()`, AOT-compatible, no Castle.Core. Source: `thomhurst/TUnit/TUnit.Mocks/Mock.cs`. [github.com/thomhurst/TUnit](https://github.com/thomhurst/TUnit)
[^7]: `stryker-mutator/stryker-net#3117` — xUnit v3 emits "unexpected test case" for every test, dropping mutation score to ~3%. [github.com/stryker-mutator/stryker-net/issues/3117](https://github.com/stryker-mutator/stryker-net/issues/3117)
[^8]: `dotnet/aspnetcore#26487` — "Scheme already exists: Identity.Application" when re-adding auth in `ConfigureTestServices`. Open. [github.com/dotnet/aspnetcore/issues/26487](https://github.com/dotnet/aspnetcore/issues/26487)
[^9]: `jbogard/Respawn#122` — no snapshot/restore, only full wipe. Maintainer has no plans. [github.com/jbogard/Respawn/issues/122](https://github.com/jbogard/Respawn/issues/122)
[^10]: WireMock.Net split into free OSS tier and `WireMock.Net.Pro` paid tier; record/playback, advanced matchers, stateful behavior gated to Pro. [wiremock.net](https://wiremock.net/)
[^11]: `dotnet/aspnetcore#11888` — open since 2019: `TestServer` doesn't support WebSocket transport for SignalR. API was designed (`WithTestServer(server, HttpTransportType.WebSockets)`) but never shipped. [github.com/dotnet/aspnetcore/issues/11888](https://github.com/dotnet/aspnetcore/issues/11888)
[^12]: `dotnet/BenchmarkDotNet#155` — Perf regression detection ("competition perf testing"), open since 2016. Community wrote brittle external `BenchmarkDotNet.ResultDiff`. [github.com/dotnet/BenchmarkDotNet/issues/155](https://github.com/dotnet/BenchmarkDotNet/issues/155)
[^13]: Moq, NSubstitute, FakeItEasy all use Castle.Core DynamicProxy; cannot mock statics, sealed classes, structs, extension methods. No OSS solution exists; Typemock/JustMock are paid, Microsoft Fakes is VS Enterprise only.
[^14]: `ILogger<T>` extension methods (`LogInformation`, etc.) require verifying the underlying `Log()` call with five `Arg.Any<>()` parameters. `Microsoft.Extensions.Logging.Testing.FakeLogger<T>` shipped in .NET 8 but is not widely known.
[^15]: `fscheck/FsCheck#692` — xUnit v3 + `[Property]` + `[Fact]` mix throws "There is no currently active test" from `ITestOutputHelper.GuardInitialized()`. Downgrade to xUnit 2.8.1 or FsCheck 2.x works. [github.com/fscheck/FsCheck](https://github.com/fscheck/FsCheck)
[^16]: `dotnet/aspnetcore#14907` — `ConfigureTestContainer<T>` (Scrutor/Autofac DI replacement) doesn't execute with GenericHost. Open since Oct 2019. [github.com/dotnet/aspnetcore/issues/14907](https://github.com/dotnet/aspnetcore/issues/14907)
[^17]: xUnit `[Fact(Timeout=N)]` silently broken for synchronous tests — only triggers when an `await` yields. `Thread.Sleep` in code under test defeats it entirely. xUnit #2222.
[^18]: xUnit v3 migration: test projects are now executables, not libraries; older TFMs dropped. Breaks multi-TFM library authors and shared test infrastructure patterns. xUnit v3 docs migration guide.
[^19]: TUnit/#5816 — TUnit treats any assembly referencing `TUnit.Core` as a test assembly, breaking shared test infrastructure libraries that aren't themselves executables. [github.com/thomhurst/TUnit/issues/5816](https://github.com/thomhurst/TUnit/issues/5816)
[^20]: `microsoft/aspire#5257` — breakpoints in downstream services never hit during Aspire integration tests. [github.com/dotnet/aspire/issues/5257](https://github.com/dotnet/aspire/issues/5257)
[^21]: `microsoft/aspire#4462` — Aspire tests share named container volumes with dev environment, no automatic test isolation. [github.com/dotnet/aspire/issues/4462](https://github.com/dotnet/aspire/issues/4462)
[^22]: `testcontainers/testcontainers-dotnet#122` — docker-compose support missing since Aug 2019; Java version has it. [github.com/testcontainers/testcontainers-dotnet/issues/122](https://github.com/testcontainers/testcontainers-dotnet/issues/122)
[^23]: `coverlet-coverage/coverlet#1633` — records (sealed/abstract/derived) show 0% coverage on .NET 8 regardless of execution. [github.com/coverlet-coverage/coverlet/issues/1633](https://github.com/coverlet-coverage/coverlet/issues/1633)
[^24]: `AutoFixture/AutoFixture` v5 milestone open with 15+ issues from 2018–2020; project effectively stalled on major version. [github.com/AutoFixture/AutoFixture](https://github.com/AutoFixture/AutoFixture)
