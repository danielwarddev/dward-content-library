# GitHub Universe 2026 — Submission Ideas & Abstracts

8 talk ideas mapped to the 2026 tracks, structured to drop directly into the [offline form](github-universe-2026-offline-form.md). Each entry has:

- **Title** — within the 75-character limit
- **Abstract** — within the 600-character limit (follows Kent Beck's four-sentence structure)
- **Session details** — within the 2,500-character limit, covering problem / 3 takeaways / resources / unique angle
- **Form metadata** — track, session type, products, topics, level, audience, industries

Recommended final 3 to submit: **#6 Dark Matter Devs**, **#7 Daily Driver**, **#5 Trust but Mutate** (covers all three tracks; strongest differentiation; leans hardest on the enterprise-coach moat).

A reusable bio draft is in [Speaker bio](#speaker-bio) at the bottom.

---

## 1. The Copilot Gap

**Source deck:** [presentations/copilot-gap.md](../presentations/copilot-gap.md)
**Why this fits Universe:** Universe 2025 had lots of "look what's possible" Copilot talks. This one names the *enterprise* failure mode: licensed devs stuck on autocomplete or magic-wand mode. Hits the committee's stated ask for "tradeoffs, lessons learned, and concrete changes teams made."

### 1. Session title (≤75 chars)

> The Copilot Gap: What Enterprise Devs Are Quietly Missing

*(57 chars)*

### 2. Abstract (≤600 chars)

> Most enterprise developers with a Copilot license fall into one of two traps: fancy autocomplete or magic wand. After a year coaching dozens of teams as an enterprise AI coach, I've seen the same patterns repeat — skipped features, missing context, and quiet reluctance that never shows up in seat-utilization dashboards. The gap between "I have Copilot" and "I get value from Copilot" closes with four habits, none of them about prompting harder. You'll leave knowing which features your team is underusing, when not to reach for AI, and a context pattern you can teach a teammate today.

*(~590 chars)*

### 3. Session details (≤2,500 chars)

> **The problem.** Enterprise Copilot rollouts are the largest AI deployments in software, and the dirty secret is that most licensed developers aren't actually getting much from them. They fall into one of two traps: "fancy autocomplete" (accept the gray text, ignore everything else) or "magic wand" (one prompt, walk away, complain when it's wrong). Studies show AI raises productivity *and* lowers critical thinking; neither trap is on the winning side of that line. After a year as an enterprise AI coach embedded with dozens of teams, I'll show what's quietly missing for the developers who never make it onto your internal demo reels.
>
> **3 key things attendees will learn:**
> 1. The four Copilot habits that separate developers who get real value from those who don't — and which one is almost always the missing piece.
> 2. A simple decision model (the "Rumsfeld model") for when to use AI, when to stay hands-on, and when to walk away — with concrete examples for each.
> 3. A context-engineering pattern (Agent Skills, custom prompts, repo-level instructions) that they can ship to their team the same week.
>
> **Resources used.** Live demo using GitHub Copilot in VS Code on a real codebase, walking through Agent Skills, custom prompts, and the chat debug log. Side-by-side comparison of "autocomplete-only" vs. "context-engineered" workflows on the same task. Short illustrated diagrams for the decision model. No slideware-only sections.
>
> **What makes this approach unique.** Most Copilot talks come from enthusiasts demoing the latest feature. This one comes from a year inside the *enterprise* trenches — the developers who never tweet about Copilot, never join the AI Slack channel, and quietly decide whether the rollout actually worked. The talk names the failure modes by their real names, shows what changes behavior (not just dashboards), and gives leaders an honest signal of which habits to push.

### Form metadata

- **Track:** Build faster, stay in flow
- **Session type:** Breakout Session (40 minutes)
- **GitHub products:** GitHub Copilot, VS Code
- **Topics:** AI: Agents; AI: MCP and other integrations; Code quality, review, and completion; IDE Integration; Productivity; Education
- **Session level:** 200 — Intermediate
- **Target audience:** Enterprise — Developer; Enterprise — Engineering Leadership; Educators
- **Industries:** Applicable to all

---

## 2. Ship a Copilot Agent in 10 Minutes

**Source decks:** [presentations/copilot-sdk.md](../presentations/copilot-sdk.md), [presentations/copilot-sdk-60min-outline.md](../presentations/copilot-sdk-60min-outline.md)
**Why this fits Universe:** GitHub ships the SDK. A Universe stage is the highest-leverage place on earth to show practitioners what to actually build with it — and which decisions separate "demo" from "production."

### 1. Session title (≤75 chars)

> Ship a Custom Copilot Agent Before Your Next Standup

*(52 chars)*

### 2. Abstract (≤600 chars)

> Building a custom AI agent used to mean a dedicated team, a vector database project, and a quarter of runway — so most teams shipped a chatbot wrapper and called it done. The GitHub Copilot SDK collapses that effort into an afternoon, but only if you know which decisions actually matter. On stage, I'll go from empty repo to a working agent embedded in a real app in under 10 minutes, then break down which choices made it production-shaped instead of demo-shaped. You'll leave with the SDK decision flowchart, tool-design rules of thumb, and a repo to fork tonight.

*(~580 chars)*

### 3. Session details (≤2,500 chars)

> **The problem.** Every team wants a custom AI agent that understands their domain, tools, and workflows. Until recently, getting one meant a multi-quarter project most teams couldn't justify, so they shipped a thin chatbot wrapper around a foundation model and watched it underperform. The GitHub Copilot SDK changes the economics — a working agent is now an afternoon's work — but the SDK doesn't make the design decisions for you, and the wrong ones turn a 10-minute demo into a 6-month maintenance burden.
>
> **3 key things attendees will learn:**
> 1. When to use the Copilot SDK vs. plain prompting vs. a heavyweight agent framework — with a decision flowchart and concrete examples for each path.
> 2. The tool-design rules of thumb (naming, descriptions, granularity) that make the difference between an agent that works once and one that's reliable in production.
> 3. How to wire auth, BYOK, and basic guardrails so the agent is safe to put in front of real users without a security review blocking the launch.
>
> **Resources used.** Live coding from an empty repo to a working agent embedded in a real application in under 10 minutes (C#, but the SDK ships in multiple languages). Side-by-side contrast of two tool designs — one that fails, one that works — to make the rules of thumb concrete. Short architecture diagrams for SDK internals and auth flows. A public companion repo attendees can fork during or after the session.
>
> **What makes this approach unique.** Most agent talks either stay at the marketing layer ("agents are powerful!") or dive straight into framework comparisons. This one is a build-on-stage with a year of enterprise coaching behind it, so the design choices come with battle scars: which tool descriptions confuse the model, where latency and cost actually bite, when the SDK is overkill, and what to test before letting an agent touch production. The goal is for everyone in the room to leave with a credible plan for the agent they've been wanting to build.

### Form metadata

- **Track:** Build faster, stay in flow
- **Session type:** Sandbox Session (45 minutes) — *Alt: Ship & Tell (15 min) for a lightning version*
- **GitHub products:** GitHub Copilot, VS Code, Codespaces
- **Topics:** AI: Agents; AI: MCP and other integrations; Custom integrations and APIs; IDE Integration; Productivity
- **Session level:** 200 — Intermediate
- **Target audience:** Enterprise — Developer; Open Source Developer or Maintainer; Startups
- **Industries:** Applicable to all

---

## 3. How and Why to Get Started with Automated Testing in the Age of AI

**Source deck:** [presentations/ai-unit-testing.md](../presentations/ai-unit-testing.md)
**Why this fits Universe:** Trust in AI-generated code is *the* recurring committee theme this year. Tests are the most concrete place that trust breaks — and the on-ramp for teams that never built the habit is one almost no talk covers.

### 1. Session title (≤75 chars)

> How and Why to Get Started with Automated Testing in the Age of AI

*(67 chars)*

### 2. Abstract (≤600 chars)

> Many teams wonder whether automated testing is worth the effort or time. With AI accelerating work across the board, though, the stakes are higher than ever. Studies show that AI doesn't just help you ship faster, but it helps you ship bugs faster, too. Engineering practices are the foundation for scalable AI, and with modern AI tools lowering the barrier to entry, it's never been easier to build helpful, readable tests. This session covers practical prompting and coding patterns to stop AI from giving you false confidence, and have it write tests you actually trust instead.

*(~572 chars)*

### 3. Session details (≤2,500 chars)

> With AI helping teams move faster than ever, it can be easy to let good engineering practices fall by the wayside for the sake of velocity, especially if those practices weren't being followed regularly before AI came around.
>
> Before diving into how to use AI to generate quality tests, this talk covers the why first, and how AI has changed those reasons. That means talking about how defects affect velocity, how to find bottlenecks in your SDLC, and what it means to have "confident green" tests. The real question to ask yourself: if you see your test suite pass, do you have the confidence to deploy to production immediately? If the answer is anything other than yes, this talk is for you.
>
> Among teams already writing tests, many using AI have run into its classic failure modes. To make a failing test pass, AI might delete the assertion, hardcode the expected value, or remove the offending production code altogether, rather than fix it properly. The result is a suite that is green, growing, and quietly useless. Teams either babysit every AI-generated test or accept the output, build false confidence in their pipeline, and find out the hard way.
>
> Finally, we cover 10 practical coding and prompting techniques you can use with your teams today to get the results you want from GitHub Copilot, including feedback loops, blackbox tests, and the conventions that make AI generate tests worth keeping. Every technique is demonstrated live on a real codebase, with before-and-after examples showing what changes when you apply them. A public companion repo with all patterns and starter configurations will be available to copy the same day.

### Form metadata

- **Track:** Build faster, stay in flow
- **Session type:** Breakout Session (40 minutes)
- **GitHub products:** GitHub Copilot, VS Code, Actions
- **Topics:** AI: Agents; Testing and related practices; Code quality, review, and completion; Productivity; CI/CD
- **Session level:** 200 — Intermediate
- **Target audience:** Enterprise — Developer; Enterprise — Engineering Leadership; Open Source Developer or Maintainer
- **Industries:** Applicable to all

---

## 4. Measuring Copilot Adoption That Sticks

**Source decks:** [presentations/measure-developer-productivity.md](../presentations/measure-developer-productivity.md) + new enterprise-coach material
**Why this fits Universe:** This is the talk leaders are *desperate* for. 33% of 2025 attendees were managers/directors. Track 3 explicitly asks "Which metrics looked useful but didn't improve outcomes, and why?" — that's this talk's spine.

### 1. Session title (≤75 chars)

> Your Copilot Dashboard Is Lying: Measuring AI Adoption That Sticks

*(66 chars)*

### 2. Abstract (≤600 chars)

> Every enterprise Copilot rollout I've coached has the same dashboard: seat utilization, suggestions accepted, lines generated. Every one of those metrics can be green while developer behavior hasn't actually changed. After a year embedded with dozens of teams, I can tell you which signals predict real adoption, which reward gaming, and the one qualitative measure that beats every dashboard combined. This isn't a DORA-vs-SPACE debate — it's the instrumentation, survey questions, and coaching loops that turn a paid pilot into a habit.

*(~570 chars)*

### 3. Session details (≤2,500 chars)

> **The problem.** Leaders rolling out GitHub Copilot at scale all face the same question: is this working? The default answer comes from the built-in dashboards — seats activated, suggestions accepted, lines generated — and every one of those numbers can look healthy while the underlying developer behavior hasn't moved. Worse, the easiest metrics to chase are the easiest to game; teams learn what the dashboard rewards and optimize for that, not for actual productivity or code quality. Leaders end up with green metrics, ambiguous outcomes, and no clear next move.
>
> **3 key things attendees will learn:**
> 1. Which Copilot adoption metrics actually predict sustained behavior change — and which ones look useful but mostly reflect license rollout, not real adoption.
> 2. The qualitative signal (and the specific survey question behind it) that consistently beats every dashboard for telling leaders the truth about adoption.
> 3. The coaching-loop pattern — lightweight, repeatable, and team-led — that turns a flatlining pilot into a durable habit, with concrete examples of what worked and what backfired.
>
> **Resources used.** Anonymized data and patterns from a year of enterprise coaching across dozens of teams. Side-by-side comparison of two real rollouts — one whose dashboards looked great but where behavior didn't change, one whose dashboards looked modest but where adoption stuck — and what was different. A printable scorecard attendees can take to their next leadership review. No vendor pitches, no "trust me" claims; every recommendation tied back to observed outcomes.
>
> **What makes this approach unique.** Most metrics talks are framework debates (DORA vs. SPACE vs. DX) and most Copilot talks are feature tours. This one sits in the gap: a leader-focused, evidence-based talk on what actually moves with Copilot at enterprise scale, from someone who has watched the difference between a green dashboard and real adoption play out repeatedly. It gives leaders an honest playbook and gives developers cover to work in ways that aren't trivially gameable.

### Form metadata

- **Track:** Automate and scale with confidence
- **Session type:** Breakout Session (40 minutes)
- **GitHub products:** GitHub Copilot, GitHub Enterprise Cloud
- **Topics:** AI: Agents; Productivity; Data (analytics, management, privacy); Education; Collaboration
- **Session level:** 300 — Advanced
- **Target audience:** Enterprise — Engineering Leadership; Enterprise — Developer
- **Industries:** Applicable to all

---

## 5. Self-Healing Tests with GitHub Agentic Workflows + Mutation Testing

**Source deck:** [presentations/testing-your-tests-stryker.md](../presentations/testing-your-tests-stryker.md) + AI testing material
**Why this fits Universe:** Almost no Universe 2025 talk took the "verify the AI output mechanically *and close the loop*" angle, and even fewer made the leadership argument behind it: AI adoption only scales on top of good engineering practices. This talk does both, and uses GitHub Agentic Workflows as the concrete delivery mechanism — a Universe-native technology in the spotlight.

### 1. Session title (≤75 chars) — pick one

Brainstorm pool (counts in parens). Mix-and-match the four themes — *quality by default*, *AI adoption*, *Agentic Workflows*, *mutation testing / self-healing / trust but mutate*:

**Lead with "Quality by Default":**
- Quality by Default: Self-Healing Tests on GitHub for AI-Era Code *(63)*
- Quality by Default: Mutation Testing in GitHub Agentic Workflows *(64)*
- Quality by Default: How AI Adoption Survives Mutation Testing *(62)*
- Quality by Default: The Workflow That Earns AI's Trust *(54)*
- Building Quality by Default with GitHub Agentic Workflows *(57)*

**Lead with "Trust, but Mutate":**
- Trust, but Mutate: Self-Healing Tests with GitHub Agentic Workflows *(66)*
- Trust, but Mutate: Quality by Default for the AI Era *(52)*
- Trust, but Mutate: The Agentic Workflow Behind AI Adoption *(58)*

**Lead with "Self-Healing":**
- Self-Healing Tests: How GitHub Agentic Workflows Earn AI's Trust *(64)*
- Self-Healing Test Suites with GitHub Agentic Workflows *(54)*

**Lead with "AI adoption":**
- AI Adoption Needs Quality by Default — Here's the Workflow *(58)*
- Mutation-Tested by Default: Scaling AI Adoption on GitHub *(57)*
- Why AI Adoption Stalls Without Quality by Default *(50)* — *(thesis-only, no demo hook)*

**Compound / two-part (use a colon):**
- Quality by Default: Trust, but Mutate with GitHub Agentic Workflows *(66)*
- Self-Healing Tests: Quality by Default for AI-Generated Code *(60)*

Working pick (replace once you've decided):

> Trust, but Mutate: Self-Healing Tests with GitHub Agentic Workflows

*(66 chars)*

### 2. Abstract (≤600 chars)

> AI adoption at scale doesn't fail on the AI — it fails on the engineering practices underneath it. Coverage looks green, AI-generated tests pass, and the suite still misses real bugs because AI is unusually good at writing tests that assert almost nothing. Mutation testing is the mechanical lie-detector for that, and once you wire it into a GitHub Agentic Workflow, the suite improves itself on every commit: mutate, find weak tests, let an agent fix them, re-mutate. You'll leave with a working workflow and the thresholds I actually use.

*(~595 chars)*

### 3. Session details (≤2,500 chars)

> **The problem.** Every leader trying to scale AI adoption hits the same wall: AI accelerates whatever the codebase already is. If the test suite is mostly coverage theater, AI happily writes more of it. If reviews are rubber-stamps, AI ships more code through them. The honest takeaway from a year of enterprise coaching is that *AI adoption requires quality by default* — practices baked into the repo so the easy path is the right path. Tests are the most concrete place to prove this works, because mutation testing gives you a mechanical, automated truth-teller that doesn't depend on human discipline.
>
> **3 key things attendees will learn:**
> 1. Why "quality by default" is the precondition for AI adoption that actually scales — and why training programs and policy docs are the wrong layer to enforce it.
> 2. How to build a self-healing test loop using GitHub Agentic Workflows + mutation testing: mutate the code, surface every test that didn't catch a kill, hand the gaps to an agent, re-mutate, repeat — running on every commit, with no human in the inner loop.
> 3. Where to place the loop in your SDLC so it speeds developers up instead of blocking them: mutation-score thresholds, partial runs on PRs vs. full sweeps on main, and the cost/coverage tradeoffs that matter at enterprise scale.
>
> **Resources used.** Live demo of the full self-healing loop running as a GitHub Agentic Workflow on a real codebase: Copilot writes the production code, the workflow mutates it, surviving mutants are routed back to an agent that strengthens the failing tests, the workflow re-mutates until the score crosses threshold. Side-by-side mutation-score deltas before and after. Public companion repo with the Agentic Workflow definition, Stryker config, and Agent Skills. Honest discussion of where the loop costs more than it saves.
>
> **What makes this approach unique.** Most "trust AI tests" talks stop at human review. Most adoption talks stop at training. This one collapses both: a concrete, demoable mechanism that ships quality by default into every repo it runs on, using a Universe-native technology (Agentic Workflows) as the delivery layer. Attendees leave with a working pattern *and* the leadership argument for why this is the shape AI adoption needs to take to actually scale.

### Form metadata

- **Track:** Secure every commit *(secondary fit: Automate and scale with confidence — the "AI adoption needs quality by default" thesis lives there too)*
- **Session type:** Breakout Session (40 minutes) — *Alt: Sandbox (45 min) for hands-on*
- **GitHub products:** GitHub Copilot, Actions, GitHub Code Security
- **Topics:** AI: Agents; Testing and related practices; Code quality, review, and completion; CI/CD; DevOps and DevSecOps; Platform engineering
- **Session level:** 300 — Advanced
- **Target audience:** Enterprise — Developer; Enterprise — Engineering Leadership; Open Source Developer or Maintainer
- **Industries:** Applicable to all

---

## 6. Building for Dark Matter Devs

**Source:** New talk — built on enterprise coach experience
**Why this fits Universe:** Universe leaders constantly ask "how do I roll this out to *everyone*, not just the early adopters?" Almost every answer in 2025 was a training program. This talk argues the opposite: stop training, change the defaults. Fresh, contrarian-but-defensible angle the committee explicitly invites.

### 1. Session title (≤75 chars)

> Building for Dark Matter Devs: AI Adoption Without Training

*(58 chars)*

### 2. Abstract (≤600 chars)

> The loudest 10% of your engineers tweet about Copilot, ship Agent Skills, and pack your internal demos. The other 90% — the dark matter of your org — never go to conferences, never join the AI Slack channel, and quietly write code the same way they did in 2019. Every adoption playbook tries to pull those devs into enthusiasm; after a year coaching at enterprise scale, I'm convinced that fails by design. The move is to stop changing developers and start changing what's already in their repos. I'll show the defaults that worked, the ones that backfired, and how to ship them.

*(~595 chars)*

### 3. Session details (≤2,500 chars)

> **The problem.** Every leader rolling out Copilot has met both populations: the enthusiasts who don't need any help, and the silent majority who never opt in. Standard playbooks (lunch-and-learns, training tracks, internal Slack communities, office hours) reach the enthusiasts — who needed the least help — and miss the developers whose behavior actually moves the org-wide numbers. Those are the dark matter devs: invisible to your enablement metrics, decisive to your rollout's outcome, and *not* reachable by any approach that requires them to show up.
>
> **3 key things attendees will learn:**
> 1. Why most enterprise AI rollouts plateau at the same percentage — and what's structurally different about the developers who never adopt, regardless of how much training you offer.
> 2. The default-on tooling moves that change behavior without ever asking developers to opt in: repo templates, Agent Skills shipped at the org level, CI defaults, automated review bots, and language-specific Copilot instructions baked into bootstraps.
> 3. The defaults that backfired — the well-intentioned ones that increased noise, undermined trust, or just got disabled the first time they got in someone's way — and the design heuristics that separate them from the ones that stuck.
>
> **Resources used.** Anonymized adoption-curve data from a year of enterprise coaching, with before/after comparisons for each default change. Live walk-through of a repo template + Agent Skills + Actions workflow combo that ships sensible AI defaults to every new repo in the org. Honest "these backfired" section with specific examples and what the rollback looked like. Printable rollout-checklist attendees can take to their next platform-team meeting.
>
> **What makes this approach unique.** Most adoption talks are about enablement (training, evangelism, communities). This one is contrarian: the developers who decide whether your rollout worked are precisely the ones your enablement program won't reach, so the lever has to be the environment, not the people. The talk gives leaders a concrete way to move adoption metrics for developers who never voluntarily change their habits, without becoming the platform-team-as-bottleneck.

### Form metadata

- **Track:** Automate and scale with confidence
- **Session type:** Breakout Session (40 minutes)
- **GitHub products:** GitHub Copilot, GitHub Enterprise Cloud, Actions, Projects and Issues
- **Topics:** AI: Agents; Platform engineering; Productivity; Education; DevOps and DevSecOps; Governance and compliance
- **Session level:** 200 — Intermediate
- **Target audience:** Enterprise — Engineering Leadership; Enterprise — Developer; Educators
- **Industries:** Applicable to all

---

## 7. From Cool Demo to Daily Driver

**Source:** New talk — companion to #2 (SDK) but product-shaped, not raw-agent-shaped
**Why this fits Universe:** #2 shows *how* to use the SDK; this one shows *what to build with it that survives contact with real users.* The committee specifically wants stories about "what worked, what didn't, and why" — the gap between "agent demo" and "assistant my coworkers actually open on Monday" is exactly that.

### 1. Session title (≤75 chars)

> From Cool Demo to Daily Driver: Custom Copilot Assistants That Stick

*(68 chars)*

### 2. Abstract (≤600 chars)

> Most custom AI agents die the same way: a working demo, a Slack announcement, a spike of curiosity, and a usage chart that flatlines by week three. Building an *assistant* — not just an agent — means making product decisions the SDK doesn't make for you: where it lives, how it surfaces, what it refuses to do, and how it earns the next prompt. I'll take a custom assistant from "works on my machine" to "my coworkers open it without being asked" live on stage with the Copilot SDK, and be honest about the three design choices that made or broke adoption every time.

*(~580 chars)*

### 3. Session details (≤2,500 chars)

> **The problem.** The Copilot SDK makes it easy to build a custom agent. It does *not* make it easy to build one your coworkers actually use. The pattern I've watched repeat: a team builds an impressive demo, announces it in Slack, sees a spike of curiosity, and then watches usage flatline within three weeks. The agent works; the *assistant* doesn't, because no one made the product decisions that turn a working tool into a daily habit.
>
> **3 key things attendees will learn:**
> 1. The product-shaped questions to answer *before* you write a single tool: where the assistant lives (IDE, Slack, web, CLI), how it gets discovered, what it should refuse to do, and how each of those choices changes the SDK design.
> 2. The three design decisions that decided adoption every time I've coached a team through this — with concrete examples of what each one looked like when it worked and when it didn't.
> 3. The lightweight feedback loop that catches abandonment early (within days, not quarters) and tells you which feature to ship next — without standing up a full analytics stack.
>
> **Resources used.** Live build with the GitHub Copilot SDK: starting from a working agent and turning it into an assistant by making the product decisions on stage, with the SDK code changing alongside. Side-by-side comparison of two real assistants — one that flatlined, one that stuck — and a teardown of why. Public companion repo that ships with the boring-but-essential parts already done (telemetry hooks, refusal patterns, surface integrations). Honest postmortems from real coached teams.
>
> **What makes this approach unique.** Most custom-agent talks stop at "it works." This one starts there and asks the harder question every leader cares about: will anyone use it next month? It treats agent-building as a product problem, not just an engineering one, and it brings a year of coached teams' wins and failures to back the recommendations. Attendees leave with a checklist they can apply to the next assistant they build, and the credibility to push back when leadership wants the demo without the design.

### Form metadata

- **Track:** Build faster, stay in flow
- **Session type:** Sandbox Session (45 minutes)
- **GitHub products:** GitHub Copilot, VS Code, Codespaces, Actions
- **Topics:** AI: Agents; AI: MCP and other integrations; Custom integrations and APIs; Productivity; Collaboration; IDE Integration
- **Session level:** 200 — Intermediate
- **Target audience:** Enterprise — Developer; Enterprise — Engineering Leadership; Startups
- **Industries:** Applicable to all

---

## 8. Lessons Learned From a Year of AI Coaching at the Enterprise

**Source:** [presentations/enterprise-ai-coaching-lessons.md](../presentations/enterprise-ai-coaching-lessons.md)
**Why this fits Universe:** Track 3 explicitly asks for "what changed once AI became part of your ways of working" and "what guardrails helped maintain consistency, quality, and trust." This is a genuine lessons-learned talk — honest about what's still open — which is rarer and more credible than another vendor-deck playbook. The 33% manager/director audience at Universe is the exact room for it.

### 1. Session title (≤75 chars)

> Lessons Learned From a Year of AI Coaching at the Enterprise

*(61 chars)*

### 2. Abstract (≤600 chars)

*Four-sentence structure: problem → why it matters → startling sentence → implication*

> Someone in your org has heard the 20% productivity number, and now you're on the hook for it. Leaders rolling out enterprise AI face two compounding pressures they can't actually verify: gains that were promised and the fear of falling behind if the answer is no. After a year coaching dozens of teams, I don't have the answer — but I have a graveyard of things we tried that didn't work, a handful of surprises that moved behavior, and the experiments still running. You'll leave with real results, honest failures, and the questions worth asking before you double down.

*(~575 chars)* ✓

**The startling sentence:** *"...I don't have the answer — but I have a graveyard of things we tried that didn't work..."* — the honesty is the hook, and naming the 20% number gives the room permission to admit they're in the same fog.

### 3. Session details (≤2,500 chars)

> **The problem.** Every leader running an enterprise Copilot rollout is navigating two compounding pressures: someone in their leadership chain has seen the 20% productivity number and wants to know if it's real, and the FOMO of falling behind competitors who seem to have this figured out is real but unverifiable. Both pressures push toward confident dashboards and polished narratives — exactly the wrong response when the honest answer is "we're still figuring it out." Without real signal from real experiments, leaders can't tell whether what they're doing is working or whether their competitors are in the same fog.
>
> **3 key things attendees will learn:**
> 1. What we tried and what happened — each of the major enterprise interventions (training, champions, dashboards, defaults), what we expected, what actually happened, and what we think it means. Framed as experiments, not prescriptions.
> 2. What surprised us — the moves that worked when we didn't expect them to, the ones that backfired in ways we didn't anticipate, and the signal that turned out to be more predictive than any dashboard metric.
> 3. What we're still figuring out — the experiments currently running, the questions I still can't answer confidently, and what I'd change on day one if I were starting the engagement over.
>
> **Resources used.** Anonymized patterns from a year of coaching across dozens of teams in one of the largest Copilot rollouts currently running. Three short case studies: the experiment that worked, the one that backfired, the one that surprised us. A list of the open questions we're still investigating. No finished playbook, no vendor pitches — the value is in the honest accounting of what happened.
>
> **What makes this approach unique.** Most "AI adoption" talks are written with the benefit of hindsight bias and a polished outcome. This one is honest that the work is ongoing, the picture is incomplete, and some of the most interesting questions are still open. That honesty is the differentiator — it makes the things that *did* move the needle credible, and it gives the audience something they can actually calibrate against their own uncertain experience.

### Form metadata

- **Track:** Automate and scale with confidence
- **Session type:** Breakout Session (40 minutes)
- **GitHub products:** GitHub Copilot, GitHub Enterprise Cloud
- **Topics:** AI: Agents; Productivity; Education; Collaboration; Platform engineering; Governance and compliance
- **Session level:** 200 — Intermediate
- **Target audience:** Enterprise — Engineering Leadership; Enterprise — Developer; Educators
- **Industries:** Applicable to all

---

- **Submit 3, not 7.** Universe explicitly warns against portfolio-bombing. Updated recommendation given the new ideas:
  - **Primary (leader-track moat):** #6 *Dark Matter Devs* — *replaces* #4 as the leader pick. Same coach-built credibility, but the contrarian "defaults, not training" angle is sharper and more memorable than yet-another-metrics talk. Hold #4 in reserve.
  - **Primary (demo + product story):** #7 *Custom Copilot Assistant People Actually Open* — *replaces* #2. Same SDK demo muscle, but the "daily driver vs. cool demo" framing answers the question Universe leadership actually has. Keep #2 as the Ship & Tell fallback if they want a 15-min slot.
  - **Differentiator:** #5 *Continuous Test Improvement Loop* — almost no overlap with 2025 program; the *self-improving* framing is stronger than the original guardrail-only pitch.
- Backups for community/regional CFPs: #1 *Copilot Gap*, #3 *AI Test Generation*, #4 *Measuring Copilot Adoption*, and the original #2 framing.
- Record the optional 5-min sample video for whichever talk is most demo-heavy (likely #7 or #5).
- Run all three abstracts past a non-industry friend per the submission guide.

## Next actions

- [ ] Pick the final 3 (defaults: #6, #7, #5)
- [ ] Draft detailed outlines for each in [presentations/](../presentations/)
- [ ] Finalize bio (see below) per the [submission guide](github-universe-2026-submission-guide.md) formula
- [ ] Record 5-min sample video
- [ ] Submit via online form by **May 1, 2026 11:59 pm PT**
- [ ] Update [_submission-progress.md](_submission-progress.md)

---

## Speaker bio

*Draft — apply the guide's formula: name + descriptor + credibility + roles + accolades + humanizing personal note. Refine before submitting.*

> Dan Ward is a software engineer turned enterprise AI coach who has spent the past year embedded inside one of the largest GitHub Copilot rollouts in the wild, watching what actually changes developer behavior (and what just changes the dashboards). He writes regularly about Copilot, testing, and developer productivity at daninacan.com, has spoken at [TODO: list relevant conferences], and quietly believes the best metric for an AI rollout is whether the developers who never tweet about it are using it. Outside of work, he [TODO: humanizing detail \u2014 e.g., is a competitive Pok\u00e9mon TCG player / runs a side-project agent on the SDK / etc.].

### Form metadata reminders

- Pronouns, employer-approval, travel-support, and demographic fields all need answers per speaker
- GitHub handle: handle only (no `@`)
- Headshot: 512x512 minimum, 2048x2048 max, PNG/JPEG, uploaded via the online form
- Previous-talk video link: strongly encouraged \u2014 use a YouTube/Vimeo link to one of your existing recordings if available, otherwise record a 5-min sample
