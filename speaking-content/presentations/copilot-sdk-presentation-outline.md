# Put An Agent Inside Your App In 10 Minutes Or Less With the GitHub Copilot SDK

**Duration:** 20 minutes  
**Demo language:** C#  
**Audience:** Mixed / general dev audience

---

## Slide 1: Title Slide

- "Put An Agent Inside Your App In 10 Minutes Or Less With the GitHub Copilot SDK"
- Your name, title, socials
- Conference name / date

## Slide 2: The Problem (~1 min)

- Your company wants AI in your product — yesterday
- Traditional path: pick a model, manage API keys, handle rate limits, build safety guardrails, figure out tool calling, prompt engineering, etc.
- That's a dedicated team and a big budget
- What if you could skip most of that?

## Slide 3: What Is an Agent? (~1.5 min)

- More than a chatbot — an agent can **take actions**
- The loop: receive input → reason about it → call tools → return a result
- Key distinction: agents don't just generate text, they interact with your systems
- Examples: triage a ticket, review a document, enrich an alert

## Slide 4: Why the GitHub Copilot SDK? (~2 min)

- You (probably) already have GitHub Copilot licenses
- No separate model hosting, API keys, or billing to manage
- Enterprise-grade: runs through your existing Copilot infrastructure (compliance, data residency, etc.)
- SDK vs. building from scratch:
    - You bring the **tools** (your business logic)
    - Copilot brings the **reasoning** (the LLM)
    - The SDK is the glue

## Slide 5: "Can't I Just Do This With Prompting?" (~1.5 min)

- Yes — and the Venn diagram overlaps a lot. But the center of gravity is different.
- **SDK:** Your code is the driver. You have a deterministic app, and at specific decision points, you hand off to the agent. Control flow stays in your code. The AI is a _component_ inside your system.
- **Prompting / chat:** The AI is the driver. You give it a task and tools, and it decides the flow. Your code exists to support _it_.
- **Assembly line analogy:** Your app is a factory line. The stations, the conveyor belt, the order — that's all your code. With the SDK, you put a person at one station who makes judgment calls instead of a robot doing the same thing every time. The line doesn't change — one step just got smarter. With prompting, you hand someone all the parts and a picture of the finished product and say "figure it out."
- Use the SDK when: you have an existing app/workflow and want to make a step smarter
- Use prompting when: the AI _is_ the workflow (chat interfaces, open-ended generation)

## Slide 6: How It Works — Architecture (~1.5 min)

- Diagram: Your App → Copilot SDK → GitHub Copilot → LLM
- Your app registers **tools** — plain functions the agent can call
- The agent receives a prompt, decides which tools to call, calls them, and returns a result
- You stay in control: you define what the agent can and can't do

## Slide 7: The Three Things You Need (~1 min)

- **A Copilot license** (Business or Enterprise)
- **The SDK** (NuGet package / npm / etc.)
- **Tools** — the C# methods that represent your business logic
- That's it. No model selection, no infra, no prompt chains.

## Slide 8: What We're About to Build (~1 min)

- Brief description of the demo app (the "before" state — what it does without Copilot)
- What the agent will add — the "after" state
- The tools we'll register
- "Let's do it live."

---

## 🛠️ LIVE CODING DEMO (~10 min)

**Structure:**

1. **Show the existing app** (~1 min) — walk through the pre-built service. "Here's what we have today. It works, but [problem the agent solves]."
2. **Add the Copilot SDK** (~2 min) — install the package, add configuration, wire up the agent to the app's pipeline.
3. **Register the tools** (~3 min) — show each tool as a simple C# method. Explain what each one does. Register them with the SDK. This is the core of the demo.
4. **Define the agent's prompt/instructions** (~1 min) — give the agent its role and constraints.
5. **Run it live** (~3 min) — submit input, watch the agent reason, see it call tools, show the output. Ideally show 2-3 different inputs to demonstrate the agent's judgment (not just pattern matching).

**Tips:**

- Have the "before" app pre-built and running
- Tools should return hardcoded/in-memory data — keep focus on the SDK, not the data layer
- Have a backup recording in case of Wi-Fi issues

---

## Slide 9: What Just Happened — Recap (~1 min)

- We started with an existing app
- Added the SDK (one package)
- Registered a few tools (plain C# methods)
- Got an agent that reasons about input and takes actions
- Total new code: ~[X] lines

## Slide 10: What Can You Build With This? (~1 min)

- Any workflow where input arrives and needs judgment + action:
    - Intake & triage (support tickets, bug reports, sales leads)
    - Document analysis (contracts, resumes, feedback)
    - Enrichment (alerts, CRM updates, data pipelines)
    - Q&A over internal knowledge
- The pattern is always the same: input → agent reasons → agent calls your tools → output
- Swap the tools, swap the domain

## Slide 11: Gotchas & Tips (~0.5 min)

- Agents are non-deterministic — same input may produce slightly different results
- Keep tools focused and well-named — the agent uses the name/description to decide when to call them
- Start simple: 2-3 tools, one clear workflow. Expand from there.
- Test with varied inputs, including edge cases

## Slide 12: Call to Action / Close (~1 min)

- The SDK is available today — link / QR code
- Start with one workflow your team already does manually
- You don't need a platform team or a six-month roadmap
- "If it took me 10 minutes on stage, imagine what you can do in an afternoon."
- Links: SDK docs, your blog, your GitHub, socials

---

## Timing Budget

| Section                      | Minutes |
| ---------------------------- | ------- |
| Slides 1–8 (setup & context) | ~9      |
| Live demo                    | ~9      |
| Slides 9–12 (recap & close)  | ~2      |
| **Total**                    | **~20** |
