# DOD Austin 2026 — Copilot Workshop: Refined Submission

**Generated:** February 26, 2026
**Context:** Refined abstract and notes for the 90-minute GitHub Copilot workshop submission to DevOpsDays Austin 2026.

---

## Title

Zero to Hero with GitHub Copilot: What Works in Real Projects

---

## Abstract

Most developers have GitHub Copilot installed, but few have changed how they actually work. They tab-complete single lines while Agent mode builds entire features, they retype context that project-level instructions could provide automatically, and they start conversations that go sideways because they've never learned to prompt effectively. The gap between "I have Copilot" and "Copilot makes me faster" comes down to a handful of workflows that take minutes to learn but permanently change how you write code.

In this hands-on workshop, you'll learn the techniques that separate casual users from effective ones — prompting strategies, context management, and when to let the AI drive versus when to take the wheel. Bring your laptop and come ready to code.

---

## Notes

I spoke at DevOpsDays Austin 2025 ("Hearing and Being Heard," Day 2) and have since been delivering this workshop at meetups and user groups. I've coached dozens of enterprise teams on AI tool adoption over the past year, so this content is built from real patterns that work — and real mistakes I've seen teams make.

This connects to the "Value All The Way Down" theme because AI coding tools are only delivering value if developers know how to use them effectively. Most organizations have invested in Copilot licenses but haven't invested in helping their teams get real results from them. This workshop closes that gap.

**Prerequisites (sent ahead to attendees):**

- Laptop with VS Code installed
- GitHub account with Copilot extension installed (free plan works)
- At least one language runtime (Node.js, .NET, or Python)

**High-level outline (90 minutes):**

1. **Setup & AI Primer** (15 min) — Verify Copilot is working, cover just enough LLM fundamentals (tokens, context windows) to understand why Copilot behaves the way it does.
2. **Core Skills & Prompting** (25 min) — UI walkthrough, inline completions, chat fundamentals, then the highest-ROI skill: prompting techniques (specificity, few-shot examples, "ask me clarifying questions before starting," iterative refinement). Hands-on exercises throughout.
3. **Context, Instructions & Modes** (20 min) — What counts as context, why context rot matters, creating a `.github/copilot-instructions.md` live, and when to use Ask vs Edit vs Agent mode.
4. **Agent Mode in Action** (15 min) — Live demo building a feature end-to-end with Agent mode. Watch it plan, create files, and run commands. Review and accept/reject changes.
5. **Hands-On Build** (10 min) — Attendees apply what they've learned to build something with Copilot using their preferred language.
6. **Wrap-Up** (5 min) — Key takeaways and resources.

I've delivered 3-hour and full-day versions of this workshop. The 90-minute version focuses on the highest-ROI skills — prompting, context management, and Agent mode — so attendees leave with immediately usable techniques rather than exhaustive feature coverage.

---

## Changes from Original Draft

| Area | Original | Refined |
|---|---|---|
| **Abstract opening** | "Many developers either underuse... or put too much trust" (general) | Specific examples of what they're missing (Agent mode, instructions, prompting) — paints a clearer picture |
| **Startling sentence** | Missing | "The gap between 'I have Copilot' and 'Copilot makes me faster' comes down to a handful of workflows that take minutes to learn but permanently change how you write code." |
| **Abstract tone** | Listed features (prompting, workflows, features) | Focused on the transformation and what attendees are leaving on the table |
| **Notes — theme tie-in** | Not present | Added explicit connection to "Value All The Way Down" (organizations invest in licenses but not in effective usage) |
| **Notes — outline** | Detailed per-minute table | High-level numbered list with topic clusters and time allocations |
