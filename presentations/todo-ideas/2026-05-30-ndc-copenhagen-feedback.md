# Feedback: "Put An Agent Inside Your App" — NDC Copenhagen 2026 (60 min)

**Generated:** 2026-05-30
**Context:** Reviewing the AI-revised NDC Copenhagen deck against the original 30–45 min version. Goal: make the hour-long version flow better, decide what to add/cut, and fix the two demo problems (short demo overran 10 min; long demo got cut short). Audience: mostly .NET devs. Core takeaway to land: *the Copilot SDK is easy — you can go back to your team and integrate it this week.*

---

## 1. The big-picture verdict

The NDC version did the right thing structurally — it added the three sections an hour needs (**Tool Design, Testing, Production**) plus a landscape slide. That skeleton is good; keep it.

The problem is the *voice*. Almost every slide now ends in a punchy one-liner ("Non-determinism is a feature, not a bug," "Test the process, not the prose," "Same SDK. Same tool pattern. Wildly different complexity ceiling."). Individually they're fine; stacked 25 times they read as AI-generated, they flatten your natural delivery, and they pre-empt the line *you* want to deliver out loud. **Rule of thumb: a slide should give the audience the noun; you give them the verb.** Strip ~80% of the bottom-of-slide taglines and move the good ones into your spoken delivery / speaker notes instead of printing them.

So: **keep the new NDC structure, restore the original's calmer slide voice.**

---

## 2. Recommended 60-minute time budget

You have ~55 min of content + ~5 min Q&A. Demos are where you lost control last time, so budget them explicitly and protect them.

| Block | Topic | Minutes |
|---|---|---|
| Intro | Title, who you are, the premise, outline | 4 |
| Concept | What is an agent? (LLM → tools → loop) | 6 |
| Why | Why an agent in *your* app (data/flow/auth) | 4 |
| SDK | What it is, how it works, CLI location/auth | 7 |
| When | SDK vs. prompting | 3 |
| Tool Design | Names/descriptions, bad-vs-good, rules | 6 |
| **Demo 1** | Agent from scratch | **8** (hard cap) |
| Break/breath | "Questions so far?" | 2 |
| Testing | What you can/can't assert + layers | 6 |
| Production | Latency/UX, cost, guardrails | 5 |
| **Demo 2** | MVP generator (pre-baked, see §5) | **8** |
| Close | Recap, what you can build, resources, thanks | 4 |
| Q&A | | 5 |

**Recommendation: ~16 min of live demo total (8 + 8).** That's plenty to be credible without becoming a tightrope walk. Everything beyond that should be pre-recorded or pre-generated output you *talk over*.

---

## 3. Flow improvements (in running order)

- **Move "Why bother?" before the SDK deep-dive — which the NDC version already does. Keep that.** The original buried "why an agent in my app" mid-deck; the new order (agent → why → SDK) is better. Don't regress it.
- **Merge the two "what is an agent" arcs.** The NDC deck spends slides 5–8 on agent concept (LLM, loop, in-practice, non-determinism). For a .NET audience that's slightly long before they've seen code. Tighten to 3 slides: (1) LLM + tools + loop diagram, (2) one concrete worked example (the triage trace is great), (3) the "what agents do in practice" grid. Drop the standalone non-determinism slide as a slide — make it a 20-second spoken point during the loop diagram.
- **Put a clear "Part 1 / Part 2 / Part 3" spine in.** The NDC deck has PART 02/03/04 dividers but the numbering is inconsistent (there's no PART 01 shown). Either number all sections or use named dividers only. Pick one.
- **The "Halftime / Questions so far?" slide is a good idea — keep it**, but place it right after Demo 1 (a natural exhale) rather than mid-theory.
- **End on the takeaway, not a generic "Thank you."** Your stated goal is "you can do this on Monday." Make the penultimate slide literally *"Your Monday: pick one manual workflow your team does, wrap 3 tools around it."* That's the line you want ringing in their ears. The Resources slide can follow.

---

## 4. Subjects to add, keep, trim, or avoid

### Add / lean into (great for a .NET crowd, and reinforce "this is easy")
- **A NuGet-first "hello agent" moment.** For .NET devs, `dotnet add package` + ~15 lines is the single most disarming thing you can show. Make that the literal opening of Demo 1.
- **One real production story or metric from your own use.** "I use the MVP generator for X; it saves me Y." One credible anecdote beats five taglines.
- **A 1-slide mental model: "your tools = your agent's API surface = your security boundary."** This is the idea that makes architects comfortable. The NDC "guardrails" slide gestures at it; promote it to a first-class concept.

### Keep
- Bad-vs-good tool definition slide (slide 18) — this is the most valuable single slide in the deck for a dev audience. Keep it, just trim the code so it fits without wrapping.
- The SDK ↔ CLI ↔ Copilot architecture diagram.
- SDK-vs-prompting examples table.
- The four-layer testing strategy.

### Trim
- **The CLI-location × auth 2×2 (slide 13).** Lots of detail for a config concern. Compress to "runs locally / bundled / remote; auth = signed-in, OAuth, env vars, or BYOK" in one line and move on. They'll read docs for specifics.
- **The "Landscape" slide (SK / AutoGen / LangChain).** It's useful but it's a *defensive* slide. Cut it to 30 seconds or move to backup/appendix and only pull it up if asked. It competes with your "this is easy" message by introducing heavier frameworks.
- **Cost "napkin math" slide.** Keep the *point* (descriptions are tokens), drop the multiplication. For a .NET/Copilot-licensed crowd, "it's bundled in your Copilot license" is the headline; metered cost is the footnote.

### Avoid
- Stacking more punchy quips (the core thing you disliked).
- Spending time defending non-determinism philosophically. State it once, show it in the demo (same input → different tool order → same outcome), move on.
- Going deep on JSON-RPC internals — mention it exists, don't dwell.

---

## 5. Fixing the demos (your two biggest pain points)

### Demo 1 — "Agent in 10 minutes" overran last time
The format itself is the risk: a live countdown invites Murphy's Law. Fixes:

1. **Pre-stage everything that isn't the point.** Have the project created, NuGet restored, and the first tool written *before* you start the clock. The "wow" is the agent reasoning over tools — not `dotnet new` and a restore spinner. Start the timer at "here's one tool; watch it work."
2. **Cut Demo 1 to two beats, not three.** Currently it's (a) one tool, (b) add tools → agent picks, (c) break a tool name → recover. Beat (c) is the best one — keep (a) and (c), cut (b) or fold it into (c). Breaking a tool name and watching the agent misfire, then fixing it, *is* the whole tool-design lesson made visceral.
3. **Have a recorded fallback.** A 90-second screen recording of the exact same flow that you can cut to if anything hangs. NDC rooms are big; a stalled `dotnet restore` in front of 300 people is brutal.
4. **Rename the framing.** "10 minutes or less" is a self-imposed trap. Consider "from nothing to a working agent — live" without the literal timer, OR keep the timer but make it a *generous* 8 and start it after setup. The audience won't hold you to a number you don't print.

### Demo 2 — got cut short, couldn't show all real-world use cases
Root cause: the MVP generator is a *long-running* generation. Watching it run live eats minutes and is undemoable in a big room. Fixes:

1. **Don't run it live end-to-end.** Pre-generate 2–3 finished outputs *before* the talk. Walk through the *already-built* result: "I fed it this markdown, here's the tool trace, here's the working app + tests it produced." You control the time exactly.
2. **Show the tool trace / phases, not the wait.** The interesting part is the Plan → Generate → Verify orchestration and the tool-call log — not the spinner. Show the log of which tools fired in what order; that ties straight back to your Testing section.
3. **To showcase *multiple* real-world use cases without multiple long demos:** keep ONE deep demo (MVP generator) and replace the others with a fast "same pattern, different domain" montage — 3 short pre-baked tool-trace screenshots (triage, doc review, data enrichment) on a single slide. You *say* "same input → reason → tools → output" once and point at three examples. That gives you breadth without running three demos.
4. **Have a hard "if I'm behind, skip to here" marker** in your notes so you never get *cut off* — you decide what to drop, not the clock.

**Net:** Demo 1 = small, live, pre-staged, with a recorded fallback. Demo 2 = pre-generated, talk over the artifact + trace. Breadth of use cases = static montage slide, not more live demos.

---

## 6. Landing the takeaway ("you can do this Monday")

Everything above ladders up to this. Concrete ways to reinforce it:

- **Open and close with it.** Premise slide → "by the end you'll believe you can ship this in a sprint." Final slide → the specific Monday action.
- **Anchor on Copilot licensing.** For a .NET enterprise crowd, "if your company has Copilot Business/Enterprise, you already have everything — no new vendor, no new bill, no new auth" is the line that removes the last objection. The NDC deck has this (slide 9) — make it louder and repeat it at the close.
- **Show the smallness on screen once.** A single slide with the ~15-line C# agent, unedited. Let them photograph it. "This is the whole thing" does more for your thesis than any tagline.
- **Give them a starting recipe, not a platform.** "Pick one workflow your team does by hand → write 3 tools → wrap the agent." Repeatable, unintimidating, memorable.

---

## Notes

- This is feedback only — no slides were changed. When you're ready, I'd suggest revising the NDC deck in place: keep its section structure, strip the taglines, apply the trims in §4, and rebuild the two demo sections per §5.
- Want me to mark up the deck slide-by-slide with specific edits, or draft the revised speaker notes (where the cut taglines can live as *spoken* lines)? Either is a good next step.
