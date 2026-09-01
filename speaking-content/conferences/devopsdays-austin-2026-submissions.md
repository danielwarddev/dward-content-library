# DevOpsDays Austin 2026 — Submissions

> **CFP Deadline:** February 26, 2026
> **CFP Link:** https://talks.devopsdays.org/devopsdays-austin-2026/cfp
> **Max entries per person:** 2 (but submitting 3 — workshops may be separate)
> **2026 Theme:** "Value All The Way Down"

---

## Submission 1: How to Measure Developer Productivity (Ignite)

### Title

How to Measure Developer Productivity

### Format

Ignite (5 minutes, 20 auto-advancing slides)

### Abstract

Story points are counted, DORA metrics are tracked, dashboards are built — yet many teams collect these numbers without knowing why, or what to do with them. Meanwhile, developers wonder if they're one bad sprint away from a performance review.

The question isn't "can we measure developer productivity?" — it's "are we measuring what actually drives value?" In 5 minutes, I'll cut through the noise: which metrics are meaningful, which are performative theater, and how the right measurements empower teams to deliver value instead of just reporting it.

### Notes

I spoke at DevOpsDays Austin 2025 ("Hearing and Being Heard," Day 2) and I'm excited to come back.

This ignite distills a full-length talk I've given at multiple conferences into the key takeaways — perfect for sparking an open spaces conversation afterward.

**Slide-by-slide outline (20 slides, 15 seconds each):**

1. Title slide — "How to Measure Developer Productivity"
2. The measurement explosion — everyone's tracking something
3. But why? Most teams don't know what to do with the data
4. The developer's fear — "Am I being watched?"
5. Story points — why they fail as a productivity metric
6. Lines of code, PRs merged — the vanity metrics graveyard
7. Goodhart's Law — when a measure becomes a target, it stops being useful
8. So should we measure at all? Yes — but differently
9. DORA metrics — what they're actually good for
10. Cycle time — the metric that tells you something real
11. Lead time to change — from commit to production
12. The difference: measuring the SYSTEM, not the PERSON
13. What meaningful measurement looks like in practice
14. Measurement as empowerment, not surveillance
15. How to introduce metrics without making your team hate you
16. Start with one metric, make it visible, act on it
17. Common trap: measuring everything, acting on nothing
18. The goal: continuous improvement, not performance reviews
19. Value all the way down — you can't deliver value if you can't see it
20. Takeaways + resources

---

## Submission 2: How to Get Started With Automated Testing In the Age of AI

### Title

How to Get Started With Automated Testing In the Age of AI

### Format

Presentation (20 minutes)

### Abstract

Many teams wonder whether automated testing is worth the effort. With modern AI lowering the barrier, building helpful, readable tests has never been more accessible — but there's a catch. Ask AI to write tests and you might get hardcoded values that always pass. Ask it to fix a failing test and watch it delete the test entirely. Teams either waste time babysitting the AI or accept faulty tests that give false confidence in their delivery pipeline.

The good news: the coding practices that help AI write trustworthy tests are the same ones that make your code better anyway. This session covers practical testing patterns to help you get started today, and shows how pairing those patterns with AI turns testing from a chore into a force multiplier — leading to faster deployments, fewer defects, and less tech debt.

### Notes

I spoke at DevOpsDays Austin 2025 ("Hearing and Being Heard," Day 2) and I'm looking forward to coming back with a technical topic this year.

This talk connects directly to the "Value All The Way Down" theme. Automated testing is the safety net that lets teams deploy with confidence. When that safety net is missing — or when AI undermines it with unreliable tests — value stops flowing. This talk helps teams start testing effectively and use AI to accelerate that process rather than undermine it.

**Why this audience:** DevOps teams live in CI/CD pipelines, and automated tests are the gate that makes continuous delivery possible. Many teams either skip testing (slowing delivery through manual processes and production bugs) or use AI to generate tests that can't be trusted (giving false confidence). This talk addresses both problems directly.

**Outline (20 minutes):**

1. **Why testing still matters** (3 min) — the value case: faster deployments, fewer defects, less tech debt. Why "we don't have time to test" actually costs more time.
2. **Patterns that work** (5 min) — Arrange-Act-Assert, one assertion per test, meaningful naming, testing behavior not implementation. These patterns work for humans AND for AI.
3. **The AI testing problem** (3 min) — live demo: what happens when you ask AI to write/fix tests without guardrails. Deleted tests, hardcoded values, false confidence.
4. **The AI testing solution** (5 min) — live demo: same scenario with the right approach. Agent skills, existing tests as context, test-first workflows that guide AI to produce trustworthy results.
5. **Getting started today** (4 min) — practical first steps for teams that don't test yet or want to use AI to accelerate their testing. What to test first, how to build the habit.

**Relevant experience:** I've been actively coaching enterprise teams on AI adoption for the past year. Unreliable AI-generated tests are the #1 pain point I hear from teams, and this talk distills the most practical lessons into immediate action.

---

## Submission 3: Zero to Hero with GitHub Copilot: What Works in Real Projects

### Title

Zero to Hero with GitHub Copilot: What Works in Real Projects

### Format

Workshop (90 minutes, ~35 attendees)

### Abstract

Many developers either underuse GitHub Copilot — treating it as fancy autocomplete — or put too much trust into it, having it implement entire features without verifying its work. In this hands-on workshop, you'll learn how effective teams use GitHub Copilot for real results.

Based on enterprise experience coaching teams on AI adoption, we'll cover GitHub Copilot's features, effective prompting techniques, and practical workflows for using AI reliably and productively. You'll learn when to let Copilot drive and when to take the wheel, and leave with a workflow you can immediately apply to your own projects. Bring your laptop and come ready to code!

### Notes

I spoke at DevOpsDays Austin 2025 and have since been delivering this workshop at meetups and user groups. I've coached dozens of enterprise teams on AI tool adoption over the past year, so this workshop is built from real patterns that work (and real mistakes I've seen teams make).

**Prerequisites (sent ahead to attendees):**

- Laptop with VS Code installed
- GitHub account with Copilot extension installed (free plan works)
- At least one language runtime (Node.js, .NET, or Python)

**Outline (90 minutes):**

| Time      | Block                                                                                                                                                                                                              | Type                    |
| --------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ----------------------- |
| 0:00–0:10 | **Welcome & Setup Check** — Verify everyone has Copilot working. Quick poll: how are you using AI today?                                                                                                           | Setup                   |
| 0:10–0:20 | **AI Quick Primer** — LLMs in 2 min, tokens and context windows, what Copilot can and can't do. Just enough to understand _why_ it behaves the way it does.                                                        | Presentation            |
| 0:20–0:40 | **Copilot Core Skills** — UI tour (chat panel, agent dropdown, model dropdown), inline completions, chat fundamentals. Quick exercise: generate a function from a comment, ask Copilot to explain unfamiliar code. | Mixed (demo + exercise) |
| 0:40–0:55 | **Prompting That Works** — Good vs bad prompts (live side-by-side demo), few-shot examples, "ask me clarifying questions," iterative refinement. Mini exercise: same task, different prompts, compare results.     | Mixed (demo + exercise) |
| 0:55–1:05 | **Break**                                                                                                                                                                                                          | —                       |
| 1:05–1:20 | **Context & Instructions** — What counts as context, context rot, creating a `.github/copilot-instructions.md` live, Ask vs Edit vs Agent mode (when to use which).                                                | Mixed (demo + exercise) |
| 1:20–1:30 | **Agent Mode in Action** — Live demo: build a feature end-to-end with Agent mode. Watch it plan, create files, run commands. Review and accept/reject changes. When NOT to use Agent.                              | Demo                    |
| 1:30–1:35 | **Wrap-Up & Resources** — Key takeaways, share resources, Q&A.                                                                                                                                                     | Presentation            |

**What makes this workshop work in 90 minutes:** I've delivered 3-hour and full-day versions of this workshop. The 90-minute version cuts extended exercises and deep dives, focusing on the highest-ROI skills: prompting, context management, and Agent mode. Attendees leave with immediately usable techniques rather than exhaustive coverage.

---

## Pre-Submission Checklist

- [ ] Verify all abstracts fit within CFP character limits
- [ ] Check format selection for each (Ignite / Presentation / Workshop)
- [ ] Mention 2025 speaking experience in Notes ✅
- [ ] Reference "Value All The Way Down" theme ✅
- [ ] Submit before February 26 deadline
