---
name: saas-research
description: Research and validate SaaS business ideas through systematic market analysis. Use this skill when helping discover business opportunities, validate ideas against real market signals, or generate scored SaaS concepts for a solo founder.
user-invocable: true
disable-model-invocation: false
---

# SaaS Idea Research & Validation

Act as a SaaS market research analyst helping a solo founder discover and validate business
opportunities: generate a wide net of ideas, score them, validate them against real market signals,
and present them in a scannable format.

## ⏱️ Research Expectations

**Take your time. This is not a quick task.** Navigate to many sites, dig deep, follow threads,
cross-reference findings. 30+ minutes is fine. Quality research beats fast research.

## CRITICAL: Output Requirement

**Save all findings to `saas-research/[YYYY-MM-DD]-idea-research.md`.** Do NOT just respond in chat —
the user needs a persistent, reviewable document. Use
[references/output-template.md](references/output-template.md) for the structure.

## Founder Context

- **Expertise domains**: DevOps, Finance, Agriculture, E-commerce, Game Development (but open to any industry with opportunity signals)
- **Team**: Solo founder (must be buildable by one person)
- **Goal**: $10K+ MRR lifestyle business
- **Time**: Nights and weekends (part-time)
- **Implication**: Ideas must be simple enough to build solo, in a niche where you can compete without VC funding, and generate meaningful recurring revenue

## Workflow

Work through these phases in order, reading each reference as you reach it.

| Phase | Reference | Purpose |
| ----- | --------- | ------- |
| −1. Check prior work | [references/previous-research.md](references/previous-research.md) | **Do this first.** If an idea (or a close variant) was already researched, skip it and branch into different domains. |
| 0. Domain discovery | [references/domain-discovery.md](references/domain-discovery.md) | Find which industries show the strongest opportunity signals, before generating ideas |
| 1. Web research | [references/web-research.md](references/web-research.md) | Deep research across Reddit, G2, job boards; competition analysis and PMF stage |
| 2. Idea validation | [references/idea-validation.md](references/idea-validation.md) | Kill criteria, proceed signals, evidence to document |
| 3. Scoring | [references/scoring-rubric.md](references/scoring-rubric.md) | Score each idea 1–5 across 8 dimensions (out of 40) |
| 4. Write up | [references/output-template.md](references/output-template.md) | Final document structure |

Apply [references/saas-principles.md](references/saas-principles.md) throughout — bootstrapper
wisdom to evaluate ideas against.

Background reading recommendations: [references/recommended-reading.md](references/recommended-reading.md)

## Focus Areas

When generating ideas:

1. **Problems, not solutions** — start with the pain
2. **Niches over broad markets** — specific beats generic
3. **B2B opportunities** — higher willingness to pay, lower churn
4. **Workflows currently manual or using outdated tools** — automation opportunities
5. **Founder expertise as bonus, not requirement** — domain knowledge helps, but don't ignore great opportunities in learnable domains
6. **Customer access matters** — can you actually reach and talk to potential customers?

## After Completing Research

1. Ask the user whether they'd like a deep dive on any idea — that's the **saas-idea-deep-dive** skill.
2. **Record every idea researched** in [references/previous-research.md](references/previous-research.md) as `| YYYY-MM-DD | Idea Name | One-liner summary |`. This applies to both broad research sessions and deep dives.

## Related Skills

- **saas-idea-deep-dive** — phase 2 validation on a single idea
