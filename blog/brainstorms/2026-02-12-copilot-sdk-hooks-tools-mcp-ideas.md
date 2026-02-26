# Copilot SDK Blog Post Ideas: Hooks + Custom Tools + MCP Servers

**Generated:** 2026-02-12  
**Context:** Blog post demo ideas for the GitHub Copilot SDK in C#/.NET. Each idea is scoped for a single blog post and **must use all three SDK features**: a lifecycle hook, a custom tool, and an MCP server. All ideas are new (not remixes of existing brainstorm lists).

---

## What Each Feature Does (Quick Reference)

| Feature         | What It Is                                                                                                               | Why It Matters for a Blog Post                                                              |
| --------------- | ------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------- |
| **Hook**        | Lifecycle interceptor (e.g., `beforeToolCall`, `afterToolCall`, `onTurn`) that lets you observe or modify agent behavior | Shows the SDK isn't a black box — you can add guardrails, logging, approvals, cost tracking |
| **Custom Tool** | A C# function you register that the agent can call during its planning loop                                              | The core "make it do something useful" capability                                           |
| **MCP Server**  | An external tool server the agent connects to via Model Context Protocol (GitHub, Playwright, filesystem, etc.)          | Shows the SDK integrates with the broader ecosystem, not just your code                     |

---

## Ideas

### 1. PR Merge Readiness Checker

**The problem:** Before merging a PR, you mentally check: Are CI checks passing? Are there unresolved review comments? Did the description get updated? Does the diff look reasonable? This is tedious and easy to miss something.

**What it does:** Given a PR number, the agent evaluates merge readiness and produces a go/no-go report with specific findings.

| Feature         | How It's Used                                                                                                                                                                                                                                             |
| --------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **MCP Server**  | **GitHub MCP** — reads PR metadata, diff, review comments, CI check status                                                                                                                                                                                |
| **Custom Tool** | `CheckConventionalCommits` — parses commit messages against your team's conventions (e.g., conventional commits format). `CheckBreakingChanges` — scans the diff for patterns that indicate breaking changes (removed public methods, changed interfaces) |
| **Hook**        | `afterToolCall` — accumulates a readiness score as each check completes; at the end, the hook compiles all check results into a structured report card                                                                                                    |

**Why it's good for a blog post:** Developers relate immediately. The hook adding up a score across multiple tool calls is a clean demo of why hooks exist. The mix of GitHub MCP (external data) and custom tools (your team's rules) shows the SDK's composability.

**Scope:** ~80-120 lines of SDK code. 2 custom tools, 1 MCP server, 1 hook.

---

### 2. Live Documentation Verifier

**The problem:** Your README says "run `npm start` to launch the app" but you switched to `dotnet run` six months ago. Docs go stale and nobody catches it until a new hire tries to onboard.

**What it does:** The agent reads your documentation, extracts every command and code example, then actually tries to verify them against the current state of the repo — checking if referenced files exist, if commands are valid, and if code examples match the actual source.

| Feature         | How It's Used                                                                                                                                                                                                                           |
| --------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **MCP Server**  | **GitHub MCP** — reads the repo's markdown files, checks if referenced file paths exist in the repo tree, reads source files to compare against doc examples                                                                            |
| **Custom Tool** | `ValidateCommand` — checks if a shell command referenced in docs is valid (e.g., does `dotnet run --project src/Api` actually resolve?). `CompareCodeSnippet` — diffs a code example in the docs against the actual current source file |
| **Hook**        | `beforeToolCall` — filters out tool calls that would execute destructive commands (anything with `rm`, `drop`, `delete`). Safety guardrail that's easy to explain in a blog post                                                        |

**Why it's good for a blog post:** Everyone has stale docs. The safety hook is a natural "and here's why hooks matter" moment. The before/after is satisfying — you get a report of exactly which doc sections are outdated.

**Scope:** ~70-100 lines. 2 custom tools, 1 MCP server, 1 hook.

---

### 3. Visual Regression Spotter

**The problem:** You merged a CSS change and need to quickly check if it broke anything visible. Full visual regression testing suites are heavy. You just want a quick "does anything look obviously wrong?"

**What it does:** The agent navigates to key pages of your local dev site, takes screenshots, and compares them against baseline screenshots stored in your repo. Produces a markdown report with findings.

| Feature         | How It's Used                                                                                                                                                                                      |
| --------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **MCP Server**  | **Playwright MCP** — navigates to pages, takes screenshots, captures page accessibility snapshots for structural comparison                                                                        |
| **Custom Tool** | `CompareScreenshots` — compares a new screenshot against a baseline image (pixel diff or hash comparison). `GetPageRoutes` — reads your app's route configuration to discover which pages to check |
| **Hook**        | `beforeToolCall` — prompts for approval before the agent navigates to any URL (safety gate so the agent doesn't wander to external sites). Logs every URL visited for the final report             |

**Why it's good for a blog post:** Visual output is great for blog posts — you can show screenshot diffs inline. The approval hook is a concrete, relatable use of hooks. Playwright MCP is underutilized in demos.

**Scope:** ~100-130 lines. 2 custom tools, 1 MCP server, 1 hook.

---

### 4. Incident Response Runbook Executor

**The problem:** When your service is down at 2 AM, you pull up the runbook wiki page and manually follow the steps. Half the steps are "check if X is running" or "look at the Y dashboard." The agent could do the first-pass triage.

**What it does:** The agent reads a runbook (markdown file or wiki page), executes the diagnostic checks described in it, and produces a triage report with findings for each step.

| Feature         | How It's Used                                                                                                                                                                                              |
| --------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **MCP Server**  | **Playwright MCP** — navigates to status pages, dashboards, or health check endpoints to gather live data the runbook references                                                                           |
| **Custom Tool** | `CheckHealthEndpoint` — hits an HTTP health endpoint and parses the response. `ParseRunbookStep` — extracts actionable checks from a runbook markdown step (e.g., "verify the API returns 200 at /health") |
| **Hook**        | `afterToolCall` — logs a timestamped audit trail of every check performed. During an incident, you need to know exactly what was checked and when. The hook writes each result to a structured timeline    |

**Why it's good for a blog post:** High "wow, I want this" factor. The audit trail hook is a natural, non-contrived use case. The mix of Playwright (checking live pages) and custom tools (health endpoints) shows real-world composition.

**Scope:** ~100-140 lines. 2 custom tools, 1 MCP server, 1 hook.

---

### 5. Repo Compliance Auditor

**The problem:** Your team has repo standards — branch protection must be on, CODEOWNERS must exist, CI must include specific checks, sensitive files must be in `.gitignore`. Checking this manually across repos is painful.

**What it does:** Given a GitHub repo, the agent audits it against a set of compliance rules and produces a pass/fail report with remediation suggestions.

| Feature         | How It's Used                                                                                                                                                                                                                                |
| --------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **MCP Server**  | **GitHub MCP** — reads repo settings (branch protection, CODEOWNERS, .gitignore, CI workflow files, license)                                                                                                                                 |
| **Custom Tool** | `EvaluateRule` — takes a compliance rule definition (from a local JSON/YAML config) and the repo data, and determines pass/fail. `GenerateRemediation` — for each failed rule, generates the specific fix (e.g., "add this CODEOWNERS file") |
| **Hook**        | `onTurn` — tracks how many rules have been evaluated vs total, providing progress updates. Also enforces a max-iterations guard so the agent doesn't loop forever on a misconfigured rule                                                    |

**Why it's good for a blog post:** Platform engineering is hot. The progress-tracking hook is practical and easy to understand. The output (a compliance report card) is visually clean for a blog post.

**Scope:** ~90-120 lines. 2 custom tools, 1 MCP server, 1 hook.

---

### 6. Changelog Drafter from Merged PRs

**The problem:** Release day. You need to write a changelog. You open GitHub, scroll through merged PRs, mentally categorize them (feature, bugfix, breaking change, docs), and write it up. Every. Single. Time.

**What it does:** Given a date range or milestone, the agent pulls all merged PRs, categorizes them, groups them, and drafts a formatted changelog.

| Feature         | How It's Used                                                                                                                                                                                                                                                           |
| --------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **MCP Server**  | **GitHub MCP** — lists merged PRs in a date range, reads PR descriptions, labels, linked issues                                                                                                                                                                         |
| **Custom Tool** | `CategorizePR` — applies your team's changelog categories (Features, Bug Fixes, Breaking Changes, Internal) based on PR labels, title patterns, and diff content. `FormatChangelogEntry` — generates a one-liner changelog entry from a PR with proper markdown linking |
| **Hook**        | `beforeToolCall` — intercepts calls to the categorization tool and injects your team's specific categorization rules from a local config file. This means the same agent code works across different teams/projects just by swapping the config                         |

**Why it's good for a blog post:** Extremely practical — readers can use this immediately. The hook injecting team-specific config is an elegant pattern worth teaching. Clean, shippable output.

**Scope:** ~80-110 lines. 2 custom tools, 1 MCP server, 1 hook.

---

### 7. Stale Branch Cleanup Advisor

**The problem:** Your repo has 47 branches. Some are merged, some are abandoned, some are active. You need to clean up but don't want to delete anything someone's working on.

**What it does:** The agent analyzes all branches, cross-references with PR status, last commit date, and author activity, then produces a categorized cleanup recommendation (safe to delete, probably stale, needs author confirmation, actively used).

| Feature         | How It's Used                                                                                                                                                                                                                                        |
| --------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **MCP Server**  | **GitHub MCP** — lists branches, reads branch metadata (last commit, author), checks for associated PRs (open, merged, or closed)                                                                                                                    |
| **Custom Tool** | `CategorizeBranch` — applies staleness heuristics (last commit > 90 days, merged PR exists, no associated PR). `GenerateCleanupScript` — produces a shell script of `git push origin --delete` commands for the "safe to delete" branches            |
| **Hook**        | `afterToolCall` — counts branches in each category as they're processed. At the end, provides a summary: "47 branches analyzed: 12 safe to delete, 8 probably stale, 27 active." Also prevents the agent from actually executing any delete commands |

**Why it's good for a blog post:** Every repo has this problem. The safety hook (preventing actual deletion) is a great teaching moment. The generated cleanup script is a tangible, useful output.

**Scope:** ~80-100 lines. 2 custom tools, 1 MCP server, 1 hook.

---

### 8. Web App Accessibility Quick Audit

**The problem:** You want a quick accessibility check of your web app before pushing to production, but full accessibility audit tools are complex to set up and interpret.

**What it does:** The agent navigates to your local dev server, captures accessibility snapshots of key pages, and produces a prioritized report of accessibility issues with specific fix suggestions and WCAG references.

| Feature         | How It's Used                                                                                                                                                                                                                             |
| --------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **MCP Server**  | **Playwright MCP** — navigates pages, captures accessibility tree snapshots, checks for ARIA attributes, tab order, color contrast via page evaluation                                                                                    |
| **Custom Tool** | `EvaluateAccessibility` — takes a page's accessibility snapshot and checks it against a subset of WCAG rules you care about. `SuggestFix` — for each violation, generates a specific code fix referencing the actual HTML element         |
| **Hook**        | `afterToolCall` — categorizes findings by severity (Critical, Major, Minor) as they accumulate. Enforces a rule: if any Critical issues are found, the agent stops checking more pages and focuses its report on the critical items first |

**Why it's good for a blog post:** Accessibility matters and is underserved in demos. The severity-based early-stopping hook is a smart, non-trivial hook pattern. Playwright MCP is the natural fit here.

**Scope:** ~100-130 lines. 2 custom tools, 1 MCP server, 1 hook.

---

## Ranking for Blog Post Fit

| Rank | Idea                         | Scope  | "Wow" Factor | Hook Clarity                 | MCP Fit             | Ease of Demo |
| ---- | ---------------------------- | ------ | ------------ | ---------------------------- | ------------------- | ------------ |
| 1    | Changelog Drafter            | Small  | High         | Elegant (config injection)   | GitHub: natural     | Easy         |
| 2    | PR Merge Readiness Checker   | Medium | High         | Clear (score accumulation)   | GitHub: natural     | Easy         |
| 3    | Stale Branch Cleanup Advisor | Small  | Medium       | Practical (safety + summary) | GitHub: natural     | Easy         |
| 4    | Live Documentation Verifier  | Medium | High         | Relatable (safety gate)      | GitHub: natural     | Medium       |
| 5    | Repo Compliance Auditor      | Medium | Medium       | Useful (progress tracking)   | GitHub: natural     | Medium       |
| 6    | Visual Regression Spotter    | Medium | Very High    | Concrete (URL approval)      | Playwright: natural | Medium       |
| 7    | Web App Accessibility Audit  | Medium | High         | Smart (severity routing)     | Playwright: natural | Medium       |
| 8    | Incident Response Runbook    | Large  | Very High    | Critical (audit trail)       | Playwright: natural | Hard         |

**Changelog Drafter is #1** for blog post fit: small scope, universally relatable, the hook pattern (injecting team config) is an elegant teaching moment, and the output is immediately useful. PR Merge Readiness Checker is a close #2 with higher wow factor but slightly more setup.

---

## Notes

- Every idea uses **exactly one MCP server** (GitHub or Playwright) to keep blog post scope manageable. In practice you could combine multiple MCP servers.
- Hook patterns demonstrated across the ideas: safety gates, score accumulation, audit logging, progress tracking, config injection, severity routing. A blog post could highlight which pattern it's showcasing.
- All ideas produce a **markdown report** as output, which makes for great blog post visuals (show the actual output inline).
- These are all new ideas, distinct from the existing brainstorm lists at `2026-02-09` and `2026-02-11`.
