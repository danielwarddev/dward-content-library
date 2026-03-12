# Put An Agent Inside Your App With the GitHub Copilot SDK — 60-Minute Version

**Generated:** 2026-03-12
**Context:** Expansion of the 20-minute version into a 60-minute conference talk. Synthesized from the existing 20-min outline, expansion ideas, demo app research, and blog research content.

**Duration:** 60 minutes
**Demo language:** C#
**Audience:** Mixed / general dev audience

---

## Revised Timing Budget

| Section | 20-min | 60-min | Notes |
|---|---|---|---|
| Title, bio, outline | ~1 min | ~2 min | Add 60-min outline slide |
| What is the Copilot SDK? (intro) | ~1 min | ~1 min | Same |
| What is an agent? | ~1.5 min | ~5 min | Expand significantly |
| Why an agent in my app? | ~1 min | ~2 min | New: enterprise value props |
| SDK details & features | ~2 min | ~4 min | Expand auth + BYOK |
| Tool calling | ~1 min | ~1 min | Same (deep dive comes later) |
| SDK vs. prompting | ~1.5 min | ~3 min | Add decision flowchart |
| **NEW: Tool design deep dive** | — | ~4 min | New section (slides 16–18) |
| Demo intro | ~0.5 min | ~1 min | |
| **Demo 1: Simple agent from scratch** | ~9 min | ~12 min | Restructured, three phases |
| *Mid-talk pause* | — | ~2 min | Breathing room + quick Q&A |
| **NEW: Testing agents** | — | ~5 min | New section (slides 20–23) |
| **NEW: Production gotchas** | — | ~4 min | Expanded from 30-sec slide (slides 24–27) |
| Demo 2 intro | — | ~1 min | |
| **Demo 2: MVP generator (real-world)** | included above | ~8 min | Walkthrough, not live-coded |
| Recap & close | ~1 min | ~2 min | Expanded (slides 29–32) |
| Q&A | — | ~3 min | Buffer/audience questions |
| **Total** | **~20 min** | **~60 min** | |

---

## Part 1: Setup & Context (~18 min)

### Slide 1: Title Slide (~0.5 min)

- "Put An Agent Inside Your App In 10 Minutes Or Less With the GitHub Copilot SDK"
- Your name, title, socials
- Conference name / date

### Slide 2: Who Am I? (~1 min)

- Same as current — bio, Lean Techniques, MVP, user group, socials
- Keep it brief, audience wants the content

### Slide 3: Outline (~0.5 min)

Update the outline slide to reflect the 60-minute structure:

- What's an agent?
- The GitHub Copilot SDK — what it is, how it works, features
- SDK vs. prompting — when to use which
- **Tool design — the make-or-break skill** ← NEW
- Live demo: agent from scratch in 10 minutes
- **Testing agents** ← NEW
- **Production gotchas** ← NEW
- Live demo: real-world MVP generator
- Recap & resources

> **Speaker note:** Call out the new sections verbally — "If you've seen the 20-minute version of this talk, I'm going deeper on tool design, testing, and production realities today."

### Slide 4: What is the GitHub Copilot SDK? (~1 min)

- Open-source SDK to call GitHub Copilot from code
- Same as current — keep the code snippet
- No changes needed

### Slides 5–7: What is an Agent? — EXPANDED (~5 min)

The 20-minute version shows the loop visually but doesn't go deep. This is where the 60-minute version earns its runtime.

**Slide 5: Agent = LLM (current)**
- Same diagram — agent wrapping an LLM
- "At its simplest, an agent is just a wrapper around an LLM"

**Slide 6: Agent = LLM + Tools + Reasoning Loop (current, but expand speaker notes)**
- Same diagram with the Python sandbox / math example
- But NOW walk through it step by step with a concrete example:
  - **New speaker narration:** "Let's say you ask an agent to triage a bug report. The agent thinks: 'I need to look up open defects first.' It calls `GetOpenDefects` — gets 3 results. Then it thinks: 'I should check the severity of the component.' It calls `GetSeverity`. Then it synthesizes: 'This is a P1 bug in a critical component with 3 related open defects — escalate immediately.' That chain of think → act → observe → think again is what makes it an agent, not a chatbot."
- **Key point to land:** Agents don't run a script. They reason between steps. Same input might produce a different investigation path.

**Slide 7: Agent examples (current)**
- Keep the existing examples
- Add these to the slide or speaker notes:
  - Triage a ticket → decides priority, assigns to team, drafts response
  - Investigate a production error → chains through logs, deploys, related errors
  - Review a contract → flags risky clauses, suggests alternatives
  - Assess deployment risk → checks changed files, dependencies, recent incidents

**NEW Slide 7a: Non-determinism is a feature, not a bug (~1 min)**

> **Add this as a new slide between agents and SDK details.**

- Show two contrasting completions for the same input
  - Same bug report → Agent A checks severity first, then related defects
  - Same bug report → Agent B checks related defects first, then severity
  - Both reach the same conclusion, different path
- "This is unsettling if you're used to deterministic code. But it's the same reason you'd ask two senior engineers to triage the same bug — they'd investigate differently but reach similar conclusions."
- **Why this matters now:** Sets expectations before the demo. Audience won't be surprised when re-running produces slightly different tool call orders.

### Slide 8: Why Would I Want an Agent in My App? — EXPANDED (~2 min)

Current slide is just a title. Flesh it out:

- Your company wants AI in your product — yesterday
- Traditional path: pick a model, manage API keys, handle rate limits, build safety guardrails, figure out tool calling, prompt engineering… that's a dedicated team and a big budget
- **New content for 60-min:** Enterprise-specific value props:
  - Data residency — same compliance posture as your existing Copilot usage
  - No training on your data — enterprise promise carries over
  - Existing license — no new vendor, no new procurement process
  - "If your company already has Copilot Business or Enterprise, you have everything you need"

### Slides 9–11: SDK Details & Features — EXPANDED (~4 min)

**Slide 9: What is the GitHub Copilot SDK? (detail slide, current slide 10)**
- Open-source SDK to call GitHub Copilot from code
- Official: TypeScript, Python, Go, C#
- Unofficial: Java, Rust, Clojure, C++
- Talks to Copilot CLI through JSON-RPC

**Slide 10: Architecture diagram (current slide 11)**
- App → Copilot SDK → JSON-RPC → Copilot CLI → LLM
- **New speaker notes — explain each layer briefly:**
  - "Your app calls the SDK. The SDK talks to the Copilot CLI over JSON-RPC. The CLI handles auth, model routing, and communication with the LLM. You never touch the model directly."
  - "Why the CLI? It's the same infrastructure Copilot already uses. You get all the security, compliance, and model management for free."

**Slide 11: Copilot SDK features (current slide 12) — expand auth section**
- Need CLI installed on the host machine. Optionally bundle with app.
- Everything Copilot normally has in the CLI — agents, skills, MCP, etc.
- Some features are not available by design (export to file, interactive UI, YOLO mode)
- Supports BYOK — use API key from OpenAI, Azure, Anthropic, etc.
- **Auth options — expand with when you'd use each:**
  - Signed-in CLI user → local dev, demos, personal tools
  - GitHub OAuth → apps where users have GitHub identity
  - Environment variables / service account → CI, server-side apps, automation
  - BYOK → when you want a different model endpoint or don't have Copilot licenses
- **New speaker note:** "BYOK is the escape hatch. If your company decides to move to Azure OpenAI or Anthropic tomorrow, you change a config line, not your code. The SDK is the abstraction layer."

### Slide 12: Tool Calling (current slide 13) (~1 min)

- Normal code that you register as tools to the LLM
- Keep the existing code snippet visuals
- "We'll go deep on tool design in a few minutes — for now, just know that a tool is a regular C# method with some metadata."

### Slides 13–15: SDK vs. Prompting — EXPANDED (~3 min)

**Slide 13: "Wait! Can't I just do that with prompts?" (current slide 14)**
- Yes! But…
- App workflow vs. prompt workflow
- There's no playbook for this yet
- Keep the current content

**Slide 14: Spectrum diagram (current slide 15) — add decision flowchart**
- Keep the creative analysis ↔ normal prompting ↔ Copilot SDK spectrum
- **Add a decision flowchart** (new visual, same slide or new slide):
  - "Ask these 3 questions:"
    1. Does the AI drive the flow, or does your code drive the flow?
    2. Do you need repeatable, auditable steps?
    3. Are you embedding AI into an existing product?
  - If mostly "your code / yes / yes" → SDK
  - If mostly "AI / no / no" → Prompting
  - Mixed → Could go either way; start with SDK if you need guardrails

**Slide 15: Examples table (current slide 16)**
- Keep the existing table
- **Add 1–2 more rows to reinforce the pattern:**

| Use case | SDK or prompting? | Reason |
|---|---|---|
| Triage incoming defects | SDK | Fixed flow; AI pieces things together |
| Pair programming / code review | Prompting | Context heavy; back-and-forth |
| In-app product recommendations | SDK | AI embedded in the data flow |
| Brainstorming product names | Prompting | No tools needed; conversation is the process |
| **Investigate production errors** | **SDK** | **Chain of tool calls; deterministic pipeline around AI reasoning** |
| **Open-ended Q&A chatbot** | **Prompting** | **User drives the conversation; no fixed workflow** |

---

## NEW SECTION: Tool Design Deep Dive (~4 min)

> **This is the most important new section.** Tools are where agents succeed or fail in practice. The 20-minute version glosses over this — the 60-minute version makes it a first-class topic.

### Slide 16: Tool Design — The Make-or-Break Skill (~1 min)

- "The agent reads your tool name and description to decide whether to call it."
- Bad names = wrong tools called (or right tools ignored)
- Your tool descriptions are prompts — treat them like it
- "This is the single most impactful thing you can do to improve your agent's behavior."

### Slide 17: Good vs. Bad Tool Design — Side by Side (~1.5 min)

Show a concrete comparison:

**❌ Bad:**
```csharp
[Tool("ProcessData")]
// No description
public string ProcessData(string input) { ... }
```

**✅ Good:**
```csharp
[Tool("GetOpenDefectsForComponent")]
[Description("Returns a list of open defects assigned to the given component name. Use when the user asks about bugs or issues in a specific part of the system.")]
public List<Defect> GetOpenDefectsForComponent(string componentName) { ... }
```

- "The agent doesn't read your code. It reads the name and description. That's it. That's the entire interface between your code and the AI."

### Slide 18: Rules of Thumb for Tools (~1.5 min)

1. **One tool, one job.** Don't `GetAndProcessAndSave`. The agent can chain calls — let it.
2. **Return structured data, not prose.** The agent reasons better over JSON/objects than paragraphs.
3. **Design for idempotency.** If the agent calls the same tool twice (it will), what happens? Make it safe.
4. **Surface errors as data, not exceptions.** Return `{ success: false, reason: "..." }` — give the agent something to reason about. A thrown exception kills the loop.
5. **Descriptions are prompts.** Include when to use the tool, what it returns, and what inputs mean.

> **Speaker note:** "We'll see this live in the demo. I'm going to deliberately break a tool name and show you how the agent's behavior changes."

---

## Part 2: Demo 1 — Simple Agent From Scratch (~12 min)

> This is the talk's title promise — get a working agent into an app in under 10 minutes. Start a visible timer on screen.

### Slide 19: What We're About to Build (~1 min)

- Brief description of the demo app
- What the agent will add
- The tools we'll register
- "Let's do it live. Starting the clock."

### 🛠️ LIVE CODING DEMO 1 (~12 min)

**Phase 1: Empty project → working agent (~5 min)**
- `dotnet new console`, add the NuGet package
- Wire up one tool, configure the SDK
- Run it — agent responds using the tool
- "That's it. That's the '10 minutes or less' from the title. But we're not done."

**Phase 2: Add more tools + the "aha moment" (~4 min)**
- Add 2–3 more tools to the same agent
- Run the same input — now the agent chooses *which* tool(s) to call
- Run a different input that causes *different* tool calls
- "Watch the output. It's not calling the same tools. It's deciding based on the input."
- **This is the moment the audience realizes it's reasoning, not pattern-matching**
- Show `await using` for CopilotClient disposal
- Note that multiple sessions are perfectly fine

**Phase 3: Live tool naming contrast (~3 min)** *(reinforces the Tool Design slides)*
- Rename one tool to something vague — remove its description
- Rerun the same input
- Show degraded behavior — wrong tool called, or tool not called at all
- Restore the original name and description, behavior recovers
- "The tool name and description are the interface. This isn't magic — it's engineering."

**Demo tips:**
- Have the "before" app pre-built and ready to go in a git branch (`demo/simple-start`)
- Tools should return hardcoded/in-memory data — keep focus on the SDK, not the data layer
- Have git branches as checkpoints:
  - `demo/simple-start` — empty project, NuGet added, no tools yet
  - `demo/simple-one-tool` — one tool wired, agent runs
  - `demo/simple-full` — all tools added, naming contrast ready
- Have a backup recording in case of Wi-Fi issues
- Start the timer before this section to make the "10 minutes" claim tangible

---

## Mid-Talk Pause (~2 min, ~30 min in)

- "We've now seen a complete working agent from scratch. Before we go deeper — any questions so far?"
- This is a natural checkpoint. The audience has seen the core value prop delivered.
- Take 1–2 questions if hands go up; if not, transition smoothly: "Great — let's talk about what happens when you take this to production."

---

## Part 3: Going Deeper (~9 min)

### NEW SECTION: Testing AI Agents (~5 min)

> Frequently asked question that nobody has a clean answer to. Give the audience something actionable.

### Slide 20: "How Do I Test This?" (~1 min)

- "This is the number one question I get after this talk."
- Acknowledge the elephant: you can't assert on exact LLM output
- But you CAN test a lot more than people think

### Slide 21: What You CAN Test Deterministically (~2 min)

1. **Your tools themselves** — they're just C# methods. Standard unit tests. Nothing changes.
2. **Tool call sequences via hooks/interceptors** — the SDK lets you observe which tools were called. Assert on that.
   - "Given this input, did the agent call `GetOpenDefects` before `AssignTicket`? If yes, the reasoning flow is correct — even if the exact words differ."
3. **Approval/snapshot tests** — capture the sequence of tool calls for a known-good run. If the sequence changes, the test fails and you review intentionally.
   - Same concept as snapshot testing for UI components
4. **Error handling** — verify the agent handles tool failures gracefully
   - Reference: [error handling cookbook](https://github.com/github/awesome-copilot/blob/main/cookbook/copilot-sdk/dotnet/error-handling.md)

### Slide 22: What You CAN'T Test Deterministically (~1 min)

- The exact response text (wording will vary)
- The exact order of tool calls in complex multi-step flows (but the set of tools called should be stable)
- "Think of it like testing a senior engineer's work — you don't check that they typed the exact same keystrokes, you check that they followed the right process and got a correct result."

### Slide 23: Practical Testing Strategy (~1 min)

- **Layer 1:** Unit test your tools (you already know how)
- **Layer 2:** Integration test with hooks — assert tool call sequences
- **Layer 3:** Snapshot/approval tests for full agent runs
- **Layer 4 (optional):** Eval frameworks (promptfoo, braintrust) for scoring output quality
- **Foundation:** Log the full tool call sequence for every agent run. You can't debug what you didn't record.

---

### NEW SECTION: Production Gotchas (~4 min)

> The "gotchas" slide in the 20-minute version is 30 seconds. This deserves its own section.

### Slide 24: Taking This to Production (~0.5 min)

- "Building the agent is the easy part. Running it in prod is where the real questions start."

### Slide 25: Latency & UX (~1 min)

- Agent calls can take 3–15 seconds depending on complexity
- Design your UX for it:
  - Streaming responses (the SDK supports this — show the config)
  - Progress indicators ("Agent is investigating…")
  - Async patterns — don't block the UI thread
- "If your users are staring at a spinner for 10 seconds with no feedback, they'll think it's broken."

### Slide 26: Cost & Token Budgeting (~1 min)

- Every tool call adds tokens (input description + output)
- Napkin math: 5 tools × ~500 tokens each × 1000 runs/day = ~2.5M tokens/day
- With Copilot licensing, this is covered — but with BYOK, watch your bill
- Keep tool descriptions concise but complete — every extra word is tokens

### Slide 27: Guardrails, Security & the CLI in Prod (~1.5 min)

- **Guardrails are your tools.** The agent can only do what your tools allow. No "delete" tool = no deletes. This is a feature, not a limitation. Lean into it for security conversations with your team.
- **CLI in production — your options:**
  - Bundle the CLI with your app (simplest)
  - Sidecar container in Kubernetes
  - BYOK to skip the CLI entirely (most flexible for prod)
  - Pick one intentionally — don't discover this in prod
- **Session management:**
  - Multiple sessions are perfectly fine
  - Resuming sessions is supported — useful for multi-step workflows
  - Reference: [persisting sessions cookbook](https://github.com/github/awesome-copilot/blob/main/cookbook/copilot-sdk/dotnet/persisting-sessions.md)
- **Observability:** Log everything — tool names, inputs, outputs, elapsed time. Wrap tools in a logging decorator. "The same logging you'd put around any service call."

---

## Part 4: Demo 2 — Real-World MVP Generator (~9 min)

### Slide 28: Demo 2 — A Real Side Project (~1 min)

- "The first demo was a toy. This one's a tool I actually use."
- MVP generator: feed it a markdown description of an app idea → it generates a working C# project with tests, UI, README
- Same SDK. Same tool pattern. Wildly different complexity ceiling.

> **Note:** Start the MVP app running before the presentation begins so it's warmed up and ready to go.

### 🛠️ DEMO 2 WALKTHROUGH (~8 min)

> This demo is a walkthrough of a pre-built app, not live-coded from scratch. The first demo proved you can build it fast. This one proves you can build something real.

**Step 1: Show the architecture (~2 min)**
- Walk through the three phases from the existing PowerPoint (the architecture slide with Planning → Generation → Verification):
  - Phase 1: Planning — locate idea file, generate slug, validate, create folder
  - Phase 2: Generation — generate implementation plan + spec files, loop over each spec, implement as code
  - Phase 3: Verification — verify user flows, generate README
- "Notice the pattern: deterministic steps (your code) with AI judgment calls at specific points (the agent). This is the assembly line analogy from earlier."

**Step 2: Show the tools (~2 min)**
- Walk through 3–4 of the most interesting registered tools
- Highlight how tool descriptions guide the agent:
  - File I/O tools (deterministic operations the agent orchestrates)
  - Code generation tools (where the LLM does the heavy lifting)
  - Validation tools (your guardrails — the agent can't skip these)
- Point out: "These are just C# methods. The most complex part is deciding what to expose as tools."

**Step 3: Run it live (~3 min)**
- Submit a markdown idea file as input
- Watch the agent reason through the phases
- Highlight 1–2 moments where the agent made a non-obvious decision:
  - Chose an unexpected tool
  - Self-corrected after a validation failure
  - Called a tool multiple times with different parameters
- "This is why the reasoning loop matters. A script would have failed at step 3. The agent adapted."

**Step 4: BYOK moment (~1 min)** *(optional, if time allows)*
- Show the config lines that switch from Copilot to a different model endpoint
- "Same tools, same code, different brain. That's the portability story."

**Demo tips:**
- Have the app pre-built and running in a `demo/poc-generator` branch
- Use a short, simple idea file — don't let the input steal focus from the demo
- Have output from a previous run ready as backup if live run is too slow
- The goal is to show scale and real-world complexity, not to impress with speed

---

## Part 5: Recap & Close (~5 min)

### Slide 29: What Just Happened — Recap (~1 min)

- We started with an empty project
- Added the SDK (one NuGet package)
- Registered a few tools (plain C# methods)
- Got an agent that reasons about input and takes actions
- Then we saw the same pattern at scale — an MVP generator with multiple phases
- Total new code for the simple agent: ~[X] lines
- **The pattern is always the same:** input → agent reasons → agent calls your tools → output

### Slide 30: What Can You Build With This? (~1 min)

- Any workflow where input arrives and needs judgment + action:
  - **Intake & triage** — support tickets, bug reports, sales leads
  - **Investigation & analysis** — production errors, deployment risk, dependency vulnerabilities
  - **Document analysis** — contracts, resumes, feedback
  - **Enrichment** — alerts, CRM updates, data pipelines
  - **Code generation & tooling** — commit messages, PR descriptions, test generation
  - **Q&A over internal knowledge** — onboarding assistants, codebase explorers
- Swap the tools, swap the domain. The SDK doesn't change.

### Slide 31: The Landscape — Where the SDK Fits (~1 min)

> **New slide.** Positions the SDK relative to other approaches. Shows you understand the broader ecosystem.

- **Copilot SDK** = "Copilot-as-a-service" — embed Copilot's brain into your existing apps. Single-agent, code-driven workflows. Best when your code owns the flow.
- **Agent frameworks** (Semantic Kernel, AutoGen, LangChain, etc.) = "Build your own agents from scratch" — multi-agent orchestration, complex routing, custom model selection. Best when the AI owns the flow.
- **They're not competitors.** You could use both — an agent framework orchestrating the workflow, with a Copilot SDK agent handling the coding-specific tasks.
- "Start with the SDK. If you outgrow it, you'll know — and your tools are portable."

### Slide 32: Call to Action / Close (~1 min)

- The SDK is available today
- Links / QR code:
  - SDK repo: https://github.com/github/copilot-sdk/
  - Cookbook & patterns: https://github.com/github/awesome-copilot/tree/main/cookbook/copilot-sdk
  - VS Code YouTube channel
  - Your blog: daninacan.com
  - Your GitHub / socials
- "Start with one workflow your team already does manually."
- "You don't need a platform team or a six-month roadmap."
- "If it took me 10 minutes on stage, imagine what you can do in an afternoon."

### Q&A (~3 min buffer)

- At 60 minutes, audiences expect Q&A. Don't cut it.
- If no questions, have 2–3 "questions I usually get" ready:
  - "What about rate limits?" → Copilot licensing covers it; BYOK has its own limits
  - "Can I use this in a CI pipeline?" → Yes, env var auth + CLI bundled in your container
  - "What models does it use?" → Whatever Copilot routes to (currently GPT-4o family); BYOK lets you pick

---

## New Slides Summary (What to Add to the PowerPoint)

| New Slide | Content | Insert After |
|---|---|---|
| Slide 7a: Non-determinism | Two contrasting completions; "feature not bug" | Current agent examples |
| Slide 16: Tool Design title | "The make-or-break skill" | SDK vs. prompting section |
| Slide 17: Good vs. Bad tools | Side-by-side code comparison | Tool design title |
| Slide 18: Rules of thumb | 5 rules for tool design | Good vs. bad |
| Slide 20: "How do I test this?" | Framing the testing challenge | Mid-talk pause |
| Slide 21: Deterministic tests | Tools, hooks, snapshots | Testing title |
| Slide 22: Non-deterministic | What you can't assert on | Deterministic tests |
| Slide 23: Testing strategy | 4-layer pyramid | Non-deterministic |
| Slide 24: Production title | "Building is easy, running is the question" | Testing section |
| Slide 25: Latency & UX | Streaming, progress, async | Production title |
| Slide 26: Cost & tokens | Napkin math, budgeting | Latency |
| Slide 27: Guardrails & CLI | Security, deployment, sessions, observability | Cost |
| Slide 28: Demo 2 intro | "A real side project" | Production gotchas |
| Slide 31: Landscape | SDK vs. agent frameworks positioning | "What can you build" |

**Total new slides: 14**
**Total slides in 60-min version: ~32** (up from ~20)

---

## Changes to Existing Slides

| Current Slide | Change |
|---|---|
| Slide 3 (Outline) | Update to reflect 60-min structure — add tool design, testing, production sections |
| Slides 5–7 (What is an agent?) | Expand speaker notes with step-by-step triage example; add more agent examples |
| Slide 8 (Why agent in app?) | Add enterprise value props: data residency, compliance, existing license |
| Slide 11 (Architecture) | Expand speaker notes explaining each layer; add "why the CLI" explanation |
| Slide 12 (SDK features) | Expand auth section with when-to-use-each guidance; expand BYOK callout |
| Slide 15 (Spectrum diagram) | Add decision flowchart (3 questions) |
| Slide 16 (Examples table) | Add 2 more rows (production error investigation, open-ended Q&A) |
| Slide 20 (Recap) | Expand to reference both demos; add line count |

---

## Demo Preparation Checklist

### Git Branches to Set Up
- [ ] `demo/simple-start` — empty project, NuGet added, no tools yet
- [ ] `demo/simple-one-tool` — one tool wired, agent runs
- [ ] `demo/simple-full` — all tools added, tool naming contrast ready
- [ ] `demo/poc-generator` — MVP generator pre-built, BYOK config ready to swap in

### Before the Talk
- [ ] Start the MVP generator app (Demo 2) so it's warmed up
- [ ] Verify CLI is installed and authenticated on the demo machine
- [ ] Test all git branch checkpoints
- [ ] Have backup recordings for both demos
- [ ] Verify Wi-Fi / network connectivity to Copilot APIs
- [ ] Set up a visible timer for the "10 minutes" Demo 1 claim

### Demo 1 Specific
- [ ] Tools return hardcoded/in-memory data (no external dependencies)
- [ ] Prepare the "bad tool name" version for the contrast demo
- [ ] Have 2–3 different inputs ready that trigger different tool selections
- [ ] Test the `await using` CopilotClient pattern

### Demo 2 Specific
- [ ] Short, simple markdown idea file as input (don't let input steal focus)
- [ ] Have output from a previous successful run as backup
- [ ] BYOK config file ready to swap in (if doing the portability moment)
- [ ] Identify 1–2 "non-obvious agent decisions" to highlight during the walkthrough

---

## Narrative Arc

The 60-minute version follows this emotional journey:

1. **"This sounds hard"** (slides 1–8) — Acknowledge the complexity of AI integration
2. **"Oh, it's actually simple"** (slides 9–15) — SDK makes it accessible
3. **"But there's real craft here"** (slides 16–18, tool design) — Simple doesn't mean trivial
4. **"Wow, that actually works"** (Demo 1) — Live proof, audience sees the 10-minute promise delivered
5. **"Okay, but what about real-world concerns?"** (testing, production) — Earn trust by being honest about challenges
6. **"This scales to real complexity"** (Demo 2) — Same pattern, production-grade application
7. **"I could do this on Monday"** (recap, call to action) — Audience leaves empowered, not overwhelmed

---

## Notes

- The 20-minute version is a highlight reel. The 60-minute version is a workshop-lite — the audience should leave knowing not just *what* the SDK does, but *how to use it well*.
- The two biggest additions are **tool design** and **testing** — these are the questions every engineer asks after seeing the basic demo. Answer them proactively.
- Don't rush the mid-talk pause. At 30 minutes in, the audience needs a breath. If nobody has questions, take a sip of water and transition naturally.
- The BYOK moment in Demo 2 is optional — only do it if time is comfortable. It's a nice-to-have, not essential to the story.
- Keep the assembly line analogy running throughout. It's your connective tissue between sections.
