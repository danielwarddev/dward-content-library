# Expansion Ideas: 20 min → 60 min

# Notes

* Show error handling with try catch https://github.com/github/awesome-copilot/blob/main/cookbook/copilot-sdk/dotnet/error-handling.md
* Note multiple sessions is perfectly fine
* Resuming sessions https://github.com/github/awesome-copilot/blob/main/cookbook/copilot-sdk/dotnet/persisting-sessions.md
* Start timer before simple demo
* Start MVP app before presentation starts

# "Put An Agent Inside Your App with the GitHub Copilot SDK"

The core structure stays intact. The 40 extra minutes come from:
- Deepening existing sections that were surface-level in the 20-min version
- Several completely new sections
- A significantly expanded two-part demo
- Show await using copilot client for dispose
- Show tool usage, choosing from multiple tools
- Note good practices around tool names
- Possible to get the resulting JSON from the attributes?

---

## Revised Timing Budget

| Section | 20-min version | 60-min version |
|---|---|---|
| Intro & problem | ~2 min | ~3 min |
| What is an agent? | ~1.5 min | ~5 min |
| Why the Copilot SDK? | ~2 min | ~3 min |
| SDK vs. prompting | ~1.5 min | ~3 min |
| Architecture & how it works | ~1.5 min | ~4 min |
| **NEW: Tool design deep dive (slides)** | — | ~4 min |
| **Demo 1: Simple agent from scratch** | ~9 min | ~12 min |
| *Mid-talk pause / Q&A* | — | ~2 min |
| **NEW: Testing agents** | — | ~5 min |
| **NEW: Production gotchas** | — | ~4 min |
| **Demo 2: POC generator (real-world)** | — | ~10 min |
| Recap & close | ~2 min | ~3 min |
| **Q&A** | — | ~5 min (buffer) |
| **Total** | **~20 min** | **~60 min** |

---

## Existing Sections to Expand

### What is an Agent? (1.5 min → 5 min)
The current slides show the loop visually but don't go deep. Add:
- Walk through the thought → action → observation loop with a concrete example (e.g., "triage this bug report")
  - LLM thinks: "I need to look up open defects first" → calls `GetOpenDefects` → sees 3 results → thinks: "I should check severity next" → calls `GetSeverity` → final answer
  - This is what makes an agent an agent — it's reasoning between steps, not running a script
- Show two contrasting completions for the same input to make non-determinism tangible early
- Explain single-step vs. multi-turn agentic loops — and which the SDK supports

### Why the Copilot SDK? (2 min → 3 min)
Currently focused on "you already have licenses." Add:
- Concrete callout for enterprise: data residency, no training on your data, same compliance posture as the rest of your Copilot usage
- The "you bring the tools, Copilot brings the reasoning" framing is still the core value prop

### SDK vs. Prompting (1.5 min → 3 min)
The assembly line analogy is good — make it bigger. Add:
- A decision flowchart the audience can actually use: "Ask these 3 questions to know which to choose"
  1. Does the AI drive the flow, or does your code drive the flow?
  2. Do you need repeatable, auditable steps?
  3. Are you embedding AI into an existing product?
- Add a real example of something that looks like it needs the SDK but actually doesn't (and vice versa)

### Architecture & How It Works (1.5 min → 4 min)
The JSON-RPC diagram is already there. Expand it:
- Auth options explained in detail with when you'd use each:
  - Signed-in CLI user (local dev / demos)
  - GitHub OAuth (apps with user identity)
  - Env vars / service account (CI, server apps)
  - BYOK (when you want a different model endpoint)
- BYOK callout: show the config lines that switch from Copilot to Azure OpenAI or Anthropic — makes the architecture feel flexible, not locked in
- What the CLI is actually doing under the hood (briefly) — helps demystify "why do I need a CLI installed?"

---

## New Sections to Add

### Tool Design Deep Dive — Slides (~4 min) ⭐

This is where agents succeed or fail in practice. Cover in slides, then reinforce live in Demo 1:
- **The agent reads your tool name and description to decide whether to call it.** Bad names = wrong tools called (or right tools ignored).
- Side-by-side "good vs. bad" examples on a slide:
  - Bad: `ProcessData(string input)` with no description
  - Good: `GetOpenDefectsForComponent(string componentName)` — "Returns a list of open defects assigned to the given component name. Use when the user asks about bugs or issues in a specific part of the system."
- Rules of thumb:
  - One tool, one job. Don't `GetAndProcessAndSave`.
  - Return structured data, not prose — the agent reasons better over structure
  - Idempotency: if the agent calls the same tool twice, what happens? Design for it.
  - Surface errors as structured results, not thrown exceptions — give the agent something to reason about
- **Then in Demo 1:** live contrast of a vague tool description vs. a specific one — audience sees the difference in agent behavior in real time

### Testing AI Agents (~5 min)

Frequently asked question that nobody has a clean answer to. Give the audience something they can actually use:
- **What you can test deterministically:**
  - Your tools themselves — they're just C# methods, standard unit tests apply
  - Hooks/interceptors: verify that specific tools were called (or weren't) for a given input
  - Approval-style tests: capture the sequence of tool calls for a happy-path run and assert against it
- **What you can't test deterministically:**
  - The exact response text
  - The exact order of tool calls in multi-step flows
- **Logging is your foundation:** Log the full tool call sequence for every agent run. You can't debug what you didn't record.
- **Approvals pattern:** Treat a recorded tool-call trace as a snapshot. If the trace changes, the test fails and you review it intentionally — same idea as snapshot testing for UI.
- Mention: eval frameworks (promptfoo, braintrust) exist for scoring LLM outputs, but you can go a long way with logging + hooks + unit testing before you need them.

### Production Gotchas (~4 min)

The "gotchas" slide in the 20-min version is 30 seconds. This should be its own section:
- **Latency:** Agent calls can take 3–15 seconds. Design your UX for it (streaming, progress indicators, async patterns). Show how the SDK supports streaming.
- **Cost:** Every tool call adds tokens. Budgeting: number of tools × average tokens per call × calls per day. Show a napkin-math example.
- **Guardrails:** The agent can only do what your tools allow. Your tools ARE your guardrails. If you don't give it a "delete" tool, it can't delete. This is a feature — lean into it for security conversations.
- **CLI dependency in prod:** Options — bundle the CLI with your app, use a sidecar container, or use BYOK to skip the CLI entirely. Pick one intentionally.
- **Observability:** Same point as in the testing section — log everything. Tool names, inputs, outputs, elapsed time. Show a simple logging wrapper.

---

## Demo Restructure: Two-Part

### Demo 1: Simple Agent from Scratch (~12 min)
The talk's title promise — get a working agent into an empty project in under 10 minutes, with a couple extra minutes of live depth.

**Step 1: Empty project → working agent (~5 min)**
- `dotnet new console`, add the NuGet package, wire up one tool, run it
- This satisfies the "10 minutes or less" premise of the talk title

**Step 2: Add more tools + the "aha moment" (~4 min)**
- Add 2–3 more tools
- Run the same input — now the agent chooses *which* tool(s) to call
- Run a different input that causes *different* tool calls
- This is the moment the audience realizes it's reasoning, not pattern-matching

**Step 3: Live tool naming contrast (~3 min)** *(reinforces the Tool Design slide)*
- Rename one tool to be vague, remove its description, rerun
- Show degraded behavior — wrong tool called, or no tool called
- Restore it, behavior recovers
- Audience walks away knowing this isn't magic — it's engineering

---

### Demo 2: POC Generator (~10 min)
A real side project: feed it a markdown description of an idea, it generates a working POC.

**Why this demo works well here:**
- It's a realistic, complex use case — not a toy
- Shows multiple tools working together in a non-trivial flow
- The audience can immediately imagine applying this to their own domain
- Contrast with Demo 1: same SDK, same tool pattern, wildly different complexity ceiling

**Suggested walkthrough:**
- Show the markdown input (brief — don't get lost in it)
- Show the tools it has registered: file I/O, code generation, validation, etc.
- Run it live
- Highlight 1–2 moments where the agent made a non-obvious decision (chose a tool you didn't expect, self-corrected, etc.)
- **BYOK moment:** Switch config to a different model endpoint, rerun — same output, different backend. Drives home the portability of the SDK.

---

## Structural Notes

- **Mid-talk pause after Demo 1 (~30 min in).** Natural checkpoint — the audience has seen a complete working agent. Good moment to ask "any questions so far?" before shifting to testing/production topics.
- **Git branches as demo checkpoints:**
  - `demo/simple-start` — empty project, NuGet added, no tools yet
  - `demo/simple-one-tool` — one tool wired, agent runs
  - `demo/simple-full` — all tools added, naming contrast included
  - `demo/poc-generator` — pre-built, BYOK config ready to swap in
  - If something breaks or you run ahead/behind, `git checkout` to the right branch instantly.
- **Leave 5 min at the end for Q&A.** At 60 minutes, audiences expect it. Don't cut it.
