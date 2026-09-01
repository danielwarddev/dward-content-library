---
name: saas-idea-deep-dive
description: Deep dive validation on a specific SaaS idea, focused on customer access and competitive gaps before building.
user-invocable: true
disable-model-invocation: true
---

# SaaS Idea Deep Dive Validation

Validation research on a **specific** SaaS idea. This is phase 2, after initial idea generation with
the **saas-research** skill.

**Philosophy:** validate before building. Technical decisions and detailed financial models come
AFTER talking to 5–10 customers. Don't plan what to build until you've confirmed people will pay for it.

## CRITICAL: Output Requirement

**Save all findings to `saas-research/[YYYY-MM-DD]-deep-dive-[idea-name-slug].md`.** Do NOT just
respond in chat — the user needs a persistent, reviewable document.

## Input Required

Check `saas-research/` for an existing idea research file from the **saas-research** skill. If one
exists, **reference the existing analysis — don't repeat** the one-liner, target customer, problem,
basic competitor list, user quotes, initial scoring, or MVP scope.

If no prior research exists, confirm you have:

- **Idea name**
- **One-liner description**
- **Target customer**

## Research Method

**Use Playwright MCP for all web searches.** Gather the signals listed in
[references/research-inputs.md](references/research-inputs.md) that weren't in the initial research.

## Document Sections

Work through these in order. Each reference contains the section's prompts, tables, and templates.

| # | Section | Reference |
| - | ------- | --------- |
| 1 | Competitive Landscape | [references/competitive-landscape.md](references/competitive-landscape.md) |
| 2 | Customer Access Plan | [references/customer-access.md](references/customer-access.md) |
| 3 | Market Sizing (rough) | [references/market-sizing.md](references/market-sizing.md) |
| 4 | Go-to-Market Strategy | [references/go-to-market.md](references/go-to-market.md) |
| 5 | Validation Experiments | [references/validation-experiments.md](references/validation-experiments.md) |
| 6 | Risk Assessment | [references/risk-and-decision.md](references/risk-and-decision.md) |
| 7 | Two-Week Action Plan | [references/risk-and-decision.md](references/risk-and-decision.md) |
| 8 | Go/No-Go Recommendation | [references/risk-and-decision.md](references/risk-and-decision.md) |

Close the document with a **Research Sources** list: every URL visited and what was gathered from it.

## Deferred to Post-Validation

**Do NOT include these until customer validation is complete:**

- Detailed tech stack decisions
- Build vs. buy analysis
- Development timeline estimates
- Detailed financial models / unit economics
- Precise pricing tiers

These decisions should be informed by customer interviews, not speculation.

## After Completing

Record the deep dive in
[../saas-research/references/previous-research.md](../saas-research/references/previous-research.md)
as `| YYYY-MM-DD | Idea Name | One-liner summary |`.

## Related Skills

- **saas-research** — phase 1 idea generation and initial validation
