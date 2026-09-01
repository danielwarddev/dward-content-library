# Demo 1 "Wow" Ideas — Copilot SDK in 10 Minutes

**Generated:** 2026-05-26
**Context:** Brainstorming punch-up ideas for the first live demo of "Put An Agent Inside Your App" at NDC Copenhagen 2026. The current Demo 1 is very basic (create client, session, choose a model, send a prompt, add a tool). Goal: add wow factor while staying followable in ~10 minutes.

---

## Design constraints

- **Time budget:** ~10 minutes total. Each "beat" should be ≤90 seconds.
- **Followable:** audience should be able to type along or at least track the change visually.
- **Memorable:** at least one moment that gets a reaction (audible "ooh", laughter, or hands-up).
- **Story arc:** start tiny → escalate → show one surprising thing → land cleanly.

---

## The 15 ideas, ranked by wow-per-minute

### 1. The "wrong tool" reveal — break it on purpose
**Beat (60s):** Ship two tools with confusingly similar names (`GetUserOrders` and `GetUserOrderHistory`). Ask the agent something ambiguous. It picks one. Then rename one to be specific (`GetUserOpenOrders`) live. Re-run. It picks the other.
**Why it lands:** Audience SEES the contract live. "Tool names ARE the prompt" goes from claim to proof.
**Effort:** Low. **Wow:** High. **Risk:** None — both outcomes are interesting.
**Slot:** Best as the closer of Demo 1.

### 2. BYOK swap mid-demo
**Beat (45s):** Run the agent on Copilot. Change one config line. Re-run the same prompt against an OpenAI / Azure OpenAI / Anthropic key. Identical code, different brain.
**Why it lands:** Kills the #1 audience objection: "I'm locked in." The terracotta "your choice of model" promise becomes real.
**Effort:** Low (need env var pre-staged). **Wow:** High.
**Slot:** Pair with Idea #1 or use as the "and one more thing" closer.

### 3. Plug in an MCP server in one line
**Beat (60s):** `client.AddMcpServer("filesystem", ...)` — suddenly the agent has 10+ tools (read, write, list, glob) you never wrote. Ask it "summarize the files in this folder." It does.
**Why it lands:** "Free tools without writing tools" reframes the cost calculus. MCP is hot and underexplained.
**Effort:** Medium (need MCP server pre-installed, e.g., `@modelcontextprotocol/server-filesystem`). **Wow:** Very high — most of the room won't have done this.

### 4. Stream the agent's thinking + tool calls live
**Beat (45s):** Wire up the streaming API. Show tokens flowing in real-time, including "calling tool: GetSeverity('checkout')..." as it happens. Replace the boring "wait then result" with a live narration.
**Why it lands:** Production UX preview. Everyone has stared at a chat spinner — this is the antidote.
**Effort:** Low. **Wow:** Medium-high.

### 5. Plug the agent into YOUR API in 30 seconds
**Beat (60s):** A `localhost:5000` Web API is already running. Add a tool that does `httpClient.GetAsync(...)` against your `/orders` endpoint. Agent now drives your existing API.
**Why it lands:** ".NET devs go home and try this Monday." This is the "I get it now" moment for the .NET-leaning crowd.
**Effort:** Low. **Wow:** High (in the right audience).

### 6. Multi-turn session — show it remembers
**Beat (30s):** Reuse the same `CopilotClient` session across two prompts. "Find the most recent order." → "Now refund it." Watch it carry context. Then start a fresh session and ask "refund it" alone — confused agent.
**Why it lands:** Concretely answers "is this stateful?" without a slide.
**Effort:** Trivial. **Wow:** Medium.

### 7. Hook + live tool-call log
**Beat (45s):** Register an `OnToolCalled` hook that prints `[tool] name(args) -> result (elapsed)` in a colored side panel. Audience sees the reasoning loop in real time.
**Why it lands:** Demystifies the agent ("oh, it's just function calls"). Also doubles as the testing/observability pitch.
**Effort:** Low. **Wow:** Medium. Carries narrative weight into Part 4.

### 8. The agent infers structured parameters from prose
**Beat (30s):** Tool signature is `GetOrders(int daysBack, OrderStatus status)`. Prompt: "show me cancelled orders from the last two weeks." Agent calls `GetOrders(14, OrderStatus.Cancelled)`. No regex. No parsing.
**Why it lands:** "Schema-aware prompts" without saying those words. Pure magic for devs who haven't seen tool calling.
**Effort:** Trivial. **Wow:** High for newcomers.

### 9. Persona swap — same tools, different personality
**Beat (30s):** Same code, two system prompts. First run as "blunt senior SRE." Second as "polite customer success." Same question, very different output.
**Why it lands:** Separates "what the agent CAN do" (tools) from "how it BEHAVES" (instructions). Two-axis mental model.
**Effort:** Trivial. **Wow:** Medium.

### 10. Async parallel tool calls
**Beat (30s):** Two slow tools (`GetWeather`, `GetTraffic`). Ask one question that needs both. Show in the log that they fired concurrently and the round trip is ~1×, not 2×.
**Why it lands:** Performance question pre-empted. ".NET devs love `Task.WhenAll`" — show the SDK does it for them.
**Effort:** Low (add a `Task.Delay` in each tool). **Wow:** Medium.

### 11. Errors as data — graceful failure
**Beat (45s):** Throw an unhandled exception inside a tool. Agent dies / spins. Change tool to return `{ success: false, reason: "API rate-limited" }`. Re-run. Agent gracefully reports the failure and tries a different path.
**Why it lands:** Best-practice payoff in 45 seconds. Engineers nod.
**Effort:** Low. **Wow:** Medium. Bridges to Part 4 nicely.

### 12. Hot-swap models mid-session
**Beat (30s):** Send first prompt to `gpt-4o-mini` ("quick triage"), second prompt to `claude-sonnet` ("now write the customer reply") — same session, same tools, one config knob per call.
**Why it lands:** Routing by use-case is a real architectural pattern. Most attendees haven't seen it written this cleanly.
**Effort:** Low. **Wow:** Medium-high.

### 13. Tool that writes and runs code
**Beat (75s):** A `WriteCSharpFile(path, contents)` tool plus a `RunDotnetBuild()` tool. Prompt: "create a class `Greeter` with a `Hello` method and prove it compiles." Agent writes the file, runs build, reads errors if any, fixes them, retries.
**Why it lands:** Mini-Copilot in 30 lines. The "oh that's how Copilot CLI works under the hood" moment.
**Effort:** Medium. **Wow:** Very high. **Risk:** Most likely to misbehave on stage.
**Slot:** Use only if you're confident; great for the recorded version.

### 14. Wire it into a 20-line console chat UI
**Beat (30s):** Loop `Console.ReadLine()` → `client.SendPrompt(...)` → stream to console. Suddenly it's a real product, not a script.
**Why it lands:** Mentally removes the "this is just a demo" filter. People imagine shipping it.
**Effort:** Trivial. **Wow:** Low-medium but cumulative.

### 15. Confidence / structured output via records
**Beat (30s):** Return a `record TriageResult(string Severity, string Owner, double Confidence)`. Show typed result in a `Console.WriteLine`. Mention "now you can guardrail on `Confidence < 0.7`."
**Why it lands:** Sets up the production-realities section without spending time there. Engineers love types.
**Effort:** Low. **Wow:** Medium.

---

## Recommended 10-minute setlist

A tight arc that mixes "follow along" beats with a couple of "ooh" moments:

| # | Beat | Idea | Time |
|---|------|------|------|
| 0 | Open empty `Program.cs` + `dotnet add package` | (current) | 1:00 |
| 1 | Client → session → first prompt, no tools | (current) | 1:00 |
| 2 | Add one tool with a great description | (current) | 1:30 |
| 3 | Inferred parameters from natural prose | **#8** | 0:45 |
| 4 | Add a second tool, multi-turn session | **#6** | 1:00 |
| 5 | Streaming + on-tool-called hook | **#4 + #7** | 1:15 |
| 6 | The "wrong tool" reveal — rename live | **#1** | 1:30 |
| 7 | **And one more thing**: BYOK swap | **#2** | 0:45 |
| 8 | Buffer / Q&A handoff | — | 1:15 |

**Total:** ~10:00, with 75 seconds of buffer for stage slop.

The two big "ooh" moments are #6 (wrong tool reveal) and #7 (BYOK swap). Both are low risk and high payoff — they're the ones to rehearse hardest.

---

## Honorable mentions for Demo 2 (not Demo 1)

Save these for the more substantial second demo where you have room to breathe:

- **MCP server plug-in (#3)** — better as a Demo 2 pivot point so you can show the full toolbox
- **Tool writes & runs code (#13)** — this is basically Demo 2's premise
- **Persona swap (#9)** — works as a recap callback
- **Async parallel tool calls (#10)** — more visible when the tool count is bigger

---

## Notes

- Pre-stage **everything**: API keys in env vars, MCP server installed, dotnet template ready. Live `dotnet new` is fine; live `npm install -g` is not.
- Have a **fallback `.cs` file** on the desktop in case typing live derails. Open it with one Alt-Tab if needed.
- The "wrong tool" reveal works best if the audience has heard you say "tool names ARE the contract" earlier — make sure that line lands before the demo.
- Consider recording a flawless take ahead of time and keeping it as a backup video. NDC YouTube viewers won't know the difference; the live audience will appreciate that you tried.
