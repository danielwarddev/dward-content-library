# How and Why to Get Started With Automated Testing in the Age of AI

## Description

Most developers who skip automated testing know they should write them — the barrier has always been time and not knowing where to start. AI removes the time barrier: GitHub Copilot will generate a test suite in minutes. The catch is that out of the box, AI-generated tests are notorious for asserting almost nothing: hardcoded values that always pass, deleted assertions, tests that mirror implementation instead of catching real bugs. A suite full of that is worse than no tests — it gives false confidence and gets in the way of refactoring.

This session makes the case for testing to the unconvinced, then shows the patterns that make AI-generated tests worth trusting. You'll see why automated tests pay off, why AI makes now the best time to start, and the handful of conventions and Copilot features that flip AI test generation from a liability into the most reliable thing AI does on your codebase.

## Organizer notes

This is a dual-audience talk:
- **Non-testers:** developers who know they should write tests but haven't — the non-code portions make the "why" argument and lower the barrier to entry
- **AI users who test:** developers who already write tests but are frustrated with AI-generated tests — the code portions give them the exact patterns and features that fix that

Talk outline:
- Why automated tests pay off — the argument for teams that have always been "too busy to test"
- Why AI makes now the best time to start — the time barrier is gone
- What developers expect vs. what actually happens when AI generates tests (failure modes: hardcoded values, deleted assertions, mirror tests)
- Patterns that help AI: variable/method/class names, Arrange-Act-Assert, testing one thing per test, "don't test implementation details — test the result"
- Features that help AI: Agent Skills to encode your team's testing rules, existing tests as context, repo-level instructions
- The test-first loop: write the test as the spec, let AI implement production code against it — dramatically more reliable than the reverse
- Demo interwoven throughout

Lightning talk version: quick demo of the failure modes + the two or three highest-leverage fixes.

**Conferences submitted / targeted:**
- GitHub Universe 2026 — [submission entry #3](../conferences/github-universe-2026-submissions.md)