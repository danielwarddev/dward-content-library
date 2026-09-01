# Quality by Default: Mutation Testing with GitHub Agentic Workflows

## Description

Every enterprise today is looking at how to use AI to ship quickly. However, without a foundation of solid engineering practices, AI adoption is doomed to stall. Studies show that AI accelerates all practices of a team, both positive and negative. We want to make sure we have a strong implementation of the positive ones for AI adoption to succeed!

Automated tests are a huge part of that foundation. Many teams have these, though perhaps not enough, and the tests may not actually be verifying all the things the team thought they were.

Mutation testing can help address this. Mutation testing is a way to test your tests. Over time, teams using it get both higher-quality tests and the knowledge of how to write those tests to begin with.

The talk will introduce the mutation testing library Stryker and show how to use it in a TypeScript example repo. Attendees will learn how to perform mutation testing and see the actual results of the value it can bring to a codebase.

Afterwards, we'll cover GitHub Agentic Workflows, a new AI offering from GitHub. Agentic Workflows are very similar to normal GitHub Action workflows, but instead of writing deterministic steps in YAML, you write a prompt in Markdown, and Copilot figures out the rest.

The main part of the demo will be combining mutation testing and GitHub Agentic Workflows. Attendees will see the Agentic Workflow actually run to perform mutation tests, look at the report, pick out the highest-value problem to fix, and then open up a Pull Request after it's made a code change.

Attendees will leave with working knowledge of mutation testing and GitHub Agentic Workflows, the actual workflow files shown, and the leadership argument for why this is the shape AI adoption needs to take to actually scale.

## Organizer notes

This talk is the natural next step after "From Liability to Lifeline: AI Test Generation That Actually Works" ([ai-unit-testing.md](ai-unit-testing.md)) and "Testing Your Tests: Mutation Testing in C# with Stryker" ([testing-your-tests-stryker.md](testing-your-tests-stryker.md)). It assumes attendees already care about test quality and want the automated mechanism that enforces it — not just the conventions and patterns.

**Target audience:** Intermediate-to-advanced developers and engineering leads running AI-assisted workflows at team or org scale. Works for any language with a mutation testing tool (Stryker for .NET/JS, PITest for Java, etc.), though demos are in C# with Stryker.

**Session format:** 40-minute breakout. Could expand to 45-min Sandbox (hands-on) by giving attendees time to run Stryker on a provided repo.

**Demo plan:**
1. Start with a naive AI-generated test suite on a real codebase — coverage looks great, all tests pass.
2. Run Stryker — reveal the surviving mutants. Show the concrete failure: the tests don't catch real behavioral changes.
3. Build the GitHub Agentic Workflow live: mutation run → surviving mutants routed to Copilot agent → agent-strengthened tests → re-mutation until threshold is met.
4. Show the mutation-score delta before and after, and the PRs the workflow generates.
5. Discuss thresholds, PR vs. main run strategies, and where the loop costs more than it saves.

**3 key takeaways:**
1. Why "quality by default" is the precondition for AI adoption that actually scales — and why mutation testing is the mechanical truth-teller, not a training program or a code review guideline.
2. How to build the mutation testing loop: Stryker config, GitHub Agentic Workflow definition, agent instructions, re-mutation gate — all the decisions that separate a working loop from a flaky one.
3. Where to place the loop in your SDLC: mutation-score thresholds, partial runs on PRs vs. full sweeps on main, and the cost/coverage tradeoffs that matter at enterprise scale.

**Resources:**
- [Stryker Mutator](https://stryker-mutator.io/) — mutation testing framework for .NET, JS/TS, and more
- GitHub Agentic Workflows
- Public companion repo (to be created): Agentic Workflow definition, Stryker config, Agent Skills, and sample codebase attendees can fork

**What makes this different from "just a mutation testing talk":**
Most mutation testing talks stop at "here's how to run Stryker and read the HTML report." Most AI testing talks stop at human review conventions. This one collapses both into a concrete, demoable mechanism that ships quality by default into every repo it runs on — using GitHub Agentic Workflows as the delivery layer, which makes it a GitHub-native story, not a generic "use mutation testing" pitch.

**Related talks / source material:**
- [ai-unit-testing.md](ai-unit-testing.md) — AI test generation patterns (conventions, Agent Skills, test-first loop)
- [testing-your-tests-stryker.md](testing-your-tests-stryker.md) — Mutation testing fundamentals with Stryker

**Conferences submitted / targeted:**
- GitHub Universe 2026 — [submission entry #5](../conferences/github-universe-2026-submissions.md)
