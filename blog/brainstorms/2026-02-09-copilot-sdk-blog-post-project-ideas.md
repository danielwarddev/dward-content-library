
daniel note: anything around mob.sh? teams working together?

# Copilot SDK Blog Post Example Project Ideas

**Generated:** 2026-02-09
**Context:** Researched X/Twitter, Reddit (r/GithubCopilot, r/github, r/LocalLLaMA), dev.to, Microsoft Tech Community, YouTube, and the GitHub Copilot SDK contest winners to find real projects people are building. Filtered for developer-focused use cases suitable as a blog post walkthrough.

---

## What the SDK Is (Quick Context)

The [GitHub Copilot SDK](https://github.com/github/copilot-sdk) exposes the same agentic execution loop that powers `copilot` CLI as a programmable SDK. Available for **Python, TypeScript, Go, and .NET**. It can plan, invoke tools, edit files, and run commands. Supports custom tools, MCP servers, system prompt overrides, and BYOK.

---

## Project Ideas

### 1. Console App That Scaffolds Boilerplate From a Template

A small CLI that takes a project type (e.g., "REST API with auth") and generates a project scaffold using the SDK's file editing and command execution capabilities. Developer use case: replacing hand-maintained `dotnet new` or Yeoman templates with a flexible agent that adapts to the prompt.

**Inspired by:** Contest winner "App Factory" by u/brenbuilds and "ShipIt: Turn PRDs into shipped code" by u/kasuken82.

### 2. Chat Interface Embedded in an Existing Web App

Add a sidebar chat panel to an existing ASP.NET or Express app that answers questions about the app's own domain. The SDK handles the agentic loop while you provide domain-specific tools. This is the "put an agent inside your app" use case.

**Inspired by:** James Montemagno's YouTube video demo and the official GitHub blog post "Build an agent into any app."

### 3. PR Description Generator Console Tool

A console app that reads git diff output, understands the change, and generates a well-structured PR description. Run it before opening a PR to get a draft description you can paste in. Simple, single-purpose, no security concerns.

**Inspired by:** Multiple contest submissions and the CI-focused project by u/Fine-Imagination-595.

### 4. Codebase Onboarding Assistant

A CLI that indexes your repo and lets a new team member ask questions like "where does authentication happen?" or "how do I add a new API endpoint?" The SDK's tool support lets you feed it file contents on demand.

**Inspired by:** Contest winner "Repo Bootcamp" by u/arthur742.

### 5. GitHub Issue Triage Tool

A console or desktop app that pulls open issues from a repo and presents AI-generated summaries with suggested labels, priority, and whether it's a duplicate. The "Tinder for Issues" approach of swipe-to-triage is a fun UX spin.

**Inspired by:** The "Tinder for Issues" demo by a GitHub employee (u/RecommendationOk5036) in the contest thread.

### 6. Copilot-Powered Discord/Slack Bot for Your Dev Team

A bot that responds to developer questions in your team's Discord or Slack with context from your codebase or docs. Uses the SDK's streaming responses for real-time feedback. Practical for teams that want an internal Q&A assistant.

**Inspired by:** Contest winner "Copilot Discord Bot" by u/adirh3 (C#/.NET + Discord.Net) and DevFlow (Telegram/Slack remote control by Miracleio on dev.to).

### 7. Desktop System Tray App With OS Context

A WinUI 3 or Electron app that sits in your system tray and answers questions about your current dev environment — what's running in Docker, active processes, WSL distros, etc. The SDK handles the AI loop; custom tools provide system info.

**Inspired by:** u/Sharp_Indication7058's contest-winning .NET 10 WinUI 3 desktop chat app that auto-detects active windows, Docker, WSL, and env vars.

### 8. Automated Changelog Generator (GitHub Actions)

A GitHub Action that runs on merge to main, reads the diff, and generates a structured changelog entry. Combine the SDK with a scheduled GitHub Action for a "set it and forget it" workflow.

**Inspired by:** Microsoft Tech Community post "agent-framework-update-everyday" — a nightly GitHub Action that generates tech update blog posts from repo changes using the Copilot SDK's Python client.

### 9. Test Spec Generator From Acceptance Criteria

A CLI that reads a user story or acceptance criteria (from a file, Jira API, etc.) and generates test stubs. Not running tests — just helping bridge the gap between "what should we test?" and "here's a test file skeleton."

**Inspired by:** The general SDK capability of file editing + custom tools, and the pattern from "ShipIt" of translating requirements docs into code artifacts.

### 10. CLI Tool That Explains Unfamiliar Code

Pipe a file or function into a console app and get a plain-English explanation. Useful for reading legacy code, understanding a new codebase, or reviewing PRs. Tiny scope, easy to demo in a blog post.

**Inspired by:** DevFlow's `!explain` command and the overall pattern of small, single-purpose CLI tools that multiple community members are building.

### 11. Migration Script Helper

A console app that reads your old config format (e.g., XML config, old csproj format, Webpack config) and generates the equivalent in a new format (e.g., JSON, SDK-style csproj, Vite config). The SDK handles the translation logic through its planning and tool-calling loop.

**Inspired by:** The general SDK pattern of "read files → reason → write files" that powers many contest submissions.

### 12. Interactive API Explorer

A console app that reads your OpenAPI/Swagger spec and lets you ask natural language questions like "how do I create a user?" — then generates the actual HTTP request and optionally executes it. Basically a conversational Postman powered by the SDK.

**Inspired by:** The agentic web browser project (contest winner by u/johnwfivem) and the SDK's tool-calling capability for custom HTTP tools.

---

## Notes

- Every idea above is based on a real project someone has built or demoed with the SDK since its launch on Jan 22, 2026.
- The SDK contest (r/GithubCopilot) had ~160 entries and 10 winners, which was the richest source of inspiration.
- Ideas 1-4 and 10 are the simplest to demo in a blog post (console app, minimal setup). Ideas 6-7 have more moving parts but higher visual impact.
- The SDK is in **Technical Preview**, so expect API changes. All languages (Python, TypeScript, Go, .NET) share the same underlying Copilot CLI server mode.

### Sources

- [Reddit contest thread](https://www.reddit.com/r/GithubCopilot/comments/1qkz7oj/lets_build_copilot_sdk_weekend_contest_with_prizes/) — 10 contest winners
- [Reddit: I tested the SDK by building a CLI](https://www.reddit.com/r/GithubCopilot/comments/1qkg5eb/i_tested_github_copilots_new_sdk_by_building_a/)
- [Reddit: Built a Context-Aware CI action](https://www.reddit.com/r/GithubCopilot/comments/1qn6rfc/built_a_contextaware_ci_action_with_github/)
- [Reddit: GUI chat app context-aware of desktop](https://www.reddit.com/r/GithubCopilot/comments/1qvhjq4/i_crafted_a_gui_chat_app_with_github_copilot_sdk/)
- [Reddit: Building a product-grade AI app builder](https://www.reddit.com/r/GithubCopilot/comments/1qne1ku/building_a_productgrade_ai_app_builder_using_the/)
- [dev.to: DevFlow — remote Copilot via Telegram/Slack](https://dev.to/miracleio/devflow-build-anywhere-with-github-copilot-cli-2apc)
- [MS Tech Community: Automated tech update agent](https://techcommunity.microsoft.com/blog/azuredevcommunityblog/building-agents-with-github-copilot-sdk-a-practical-guide-to-automated-tech-upda/4488948)
- [GitHub Blog: Official SDK announcement](https://github.blog/news-insights/company-news/build-an-agent-into-any-app-with-the-github-copilot-sdk/)
- X/Twitter posts by @JamesMontemagno, @stevensanderson, @denicmarko, @itsafiz, @msdev
