# Building: The Other Track

**Generated:** August 31, 2026
**Context:** Companion to [workshop-on-ramp-plan.md](workshop-on-ramp-plan.md). That document covers the
income plan (selling a half-day GitHub Copilot workshop to reach $1k/mo). This one covers the *building*
track — the preferred work — and how to pursue it without it becoming a year of unpaid effort with
nothing to show.

---

## The Mistake in the Existing SaaS Research

`project-ideas/research/saas-research/2026-02-28-idea-research.md` recommends FieldForms, RetainerPilot,
and SeatCheck — field services, agencies, SaaS spend management. Its own "Founder Expertise?" column reads
*No (learnable)*, *Adjacent*, *Adjacent*.

Those markets were selected by **pricing gap**, which is a good way to find a real problem and a poor way
to find *the right* problem for this situation. Selling forms software to HVAC companies means cold outreach
to contractors with no existing relationship — the exact motion being avoided, with none of the existing
advantages intact.

## Build Where You Already Stand

The unfair advantage is not .NET skill. It's that within a few months the workshop puts you in rooms watching
enterprise developers adopt Copilot in real time, repeatedly, across multiple companies — with the buyer's
contact details already in hand.

- **The workshop is the research instrument.** Log what people get stuck on in every session. After 3–4
  sessions the patterns are obvious. Observed problems, not guessed ones.
- **Sell to the same buyer.** The manager who bought the workshop has budget, a trigger event, and trust.
  Individual devs pay badly for tools; teams and companies don't. Don't go find a new market.
- **Make the first build free.** A small tool given away at the workshop costs nothing to distribute,
  improves the workshop, and generates real usage from the exact ICP — which is how the paid thing gets
  identified without betting a year on a guess.
- **This shape is already started:** `project-ideas/copilot-session-viewer/` has six specs written, and
  `project-ideas/copilot-conversation-visualizer/` is specced as a VS Code extension.

This is also the progression already written in `project-ideas/playbooks/consulting-playbook.md`:
consulting → productized service → reusable product → SaaS.

## "Can I Just Build Solo and Throw Spaghetti at the Wall?"

**Partly.** There is a viable solo-builder pathway, but it isn't "if you build it, they will come," and it
isn't random.

### Why pure spaghetti fails

From `project-ideas/playbooks/saas-playbook.md`: *"The attempts are not independent lottery tickets. Ten
products based on weak assumptions can produce ten products nobody encounters or needs."* Ten random builds
are one bad assumption repeated ten times.

### The real hermit pathway: platform distribution

Pick categories where a marketplace does the customer-finding:

| Channel | Fit |
| ------- | --- |
| **VS Code / GitHub / JetBrains Marketplace, NuGet** | Home turf. People actively search these. Extension work already specced. |
| **SEO-led free tools** | Existing blog already ranks. A utility page answering a real query is distribution without hustle. Badly underexploited given the writing volume. |
| **Steam** | Genuine discovery engine, and clearly desired (`project-ideas/game-ideas/`). But revenue is brutally power-lawed — most solo titles earn under $1k lifetime. Do it for enjoyment, not as the income plan. |

### Spaghetti works if it has a spine

Two variables decide it — neither is luck:

1. **Cycle time.** Six months per attempt means five attempts take three years and motivation dies first.
   Two to four weeks per attempt means five attempts take a season. Ship embarrassingly small.
2. **One market, every time.** Ten tools for .NET/Copilot developers compound — shared code, growing
   audience, accumulating reputation, sharper instincts. Ten tools across ten markets reset to zero each time.

> Throw a lot of spaghetti. Throw it all at the same wall.

### The actual failure mode to guard against

Building 2 hrs/night with zero external signal for months. It doesn't die from failure — it dies because
nothing happens and interest fades. Ship each thing publicly, even tiny, even free. The blog and user group
provide a launch audience most solo builders would kill for; use it as a feedback loop, not just a megaphone.

### Realistic expectation

A few hundred dollars per month in year one, with a real chance of zero. Acceptable **only because** the
workshops are carrying the $12k. Building does not have to earn its keep yet.

---

## Finding What to Build

The instrument already exists and is unused: **Google Search Console.**

daninacan.com has years of data showing the exact phrases people typed to reach the site, with volume and
ranking position. That is a ranked list of real problems held by the exact target audience — not guesses.

**How to mine it:**

- Look for queries that are **tasks**, not questions. "Convert X to Y," "generate," "compare," "check,"
  "validate" → these become **tools**. "What is," "why," "how does" → these become **posts**.
- Sort by impressions where ranking is poor. High demand, weak coverage.
- Repeat queries across months indicate durable problems rather than news spikes.

**Three independent problem feeds, once running:**

| Feed | Signal |
| ---- | ------ |
| Search Console (blog + testingwithdot.net) | What people type when they have the problem |
| Workshop observation | What developers physically get stuck on, live |
| Free tool usage | What people actually reach for once given the option |

Nothing gets built without appearing in at least one of these.

---

## testingwithdot.net

An Astro Starlight docs site at `C:\repos\testing-with-dotnet-site\` covering .NET testing — frameworks
(xUnit, NUnit, MSTest, TUnit), assertion libraries, mocking libraries, concepts, and how-do-i pages, with
C#/F#/VB code variants. **Not yet live.**

### The honest counterpoint on AI

Reference and docs sites are the content category *most* exposed to AI substitution. "How do I mock
HttpClient in C#" — the highest-traffic blog query — is now answered inline by Copilot. So "there's still a
place for human content" is true but uneven:

- **Being eaten:** syntax reference, API listings, basic how-to.
- **Durable:** opinionated, experience-backed judgment. *Which* of four assertion libraries to use and why.
  The mistakes teams make with Testcontainers. Tradeoffs that require having done it.

Lean the site toward judgment and curation, not syntax lookup, and it survives.

### What it's a funnel for — ranked

1. **An email list.** The real answer. Search traffic arrives with an active problem — the best possible
   moment to capture someone. Neither daninacan.com nor this site has a list today.
2. **The testing coaching offer — not the Copilot workshop.** `blog/work-with-me-draft.md` already contains
   two products: the Copilot workshop and ".NET Technical Coaching – Testing Focus." There are now two
   content assets. Pair them: testingwithdot.net → testing coaching. Don't force it to sell Copilot work.
3. **A paid .NET testing course.** This **reverses** the earlier anti-course argument, which was about
   *Copilot* content decaying quarterly. .NET testing fundamentals have a 3–5 year shelf life. If a recorded
   course ever gets made, it should be this topic, with the site as top-of-funnel.
4. **Tool vendor sponsorship.** A canonical .NET testing reference is attractive to JetBrains, Docker/
   Testcontainers, SmartBear/Pact, Stryker, and the TUnit/AwesomeAssertions maintainers. Small money, for a
   thing being built anyway.

### The risk

**It isn't live.** A never-shipped project is worth zero regardless of quality. Publishing it with half the
current content beats finishing it.


---

## Diagrams

See [ecosystem-map.md](ecosystem-map.md) for how the assets, audience, partners, and offers connect, and [mindmap.md](mindmap.md) for open brainstorming.

---

# SMART Goals

**Added:** September 1, 2026

Building is the preferred work but carries none of the income burden. These goals are therefore about
**establishing signal and shipping cadence**, not revenue.

## 30-Minute Rule: The One Thing to Do First

The building track is far too large for 30 minutes. Extracted sub-task: **open Google Search Console and
export the top 100 queries.** It is the correct first move because it converts "I don't know what to build"
into a ranked list of real problems, using data already sitting there, in one sitting.

> **SMART Goal B0 — Get the signal**
>
> Open Google Search Console for daninacan.com and export the top 100 queries by impressions to a file in
> this repo by **end of day Thursday, September 3, 2026**, tagging each as *task* (candidate tool) or
> *question* (candidate post) — turning "I don't know what to build" into a ranked list of observed problems.
>
> - **Measure:** A file with 100 tagged queries.
> - **Time cost:** ~30 minutes.

## The Sequence After That

> **SMART Goal B1 — Ship testingwithdot.net**
>
> Publish testingwithdot.net with its current content by **Sunday, September 20, 2026**, resisting any new
> sections before launch — because an unshipped site is worth zero and its query data is a second problem
> feed that can't start collecting until it's live.
>
> - **Measure:** Site is live at the domain and indexed in Search Console.
> - **Rule:** No new pages before launch. Publish what exists.

> **SMART Goal B2 — Start the email list**
>
> Add a single email capture form to daninacan.com and testingwithdot.net by **Sunday, October 4, 2026**,
> and reach **50 subscribers by December 31, 2026** — closing the largest structural gap in
> [ecosystem-map.md](ecosystem-map.md), where four content assets currently feed nothing.
>
> - **Measure:** Form live on both sites; subscriber count.
> - **Note:** No newsletter obligation yet. Collecting addresses is the goal.

> **SMART Goal B3 — Ship one free tool**
>
> Build and publish one free tool addressing a *task* query identified in Goal B0, scoped to **two weeks of
> evenings**, shipped publicly by **Sunday, November 15, 2026** — proving the cycle-time rule and generating
> the third problem feed (usage data).
>
> - **Measure:** Tool is public, announced on the blog and to the user group, usage observable.
> - **Constraint:** If it can't ship in two weeks of evenings, the scope is wrong. Cut, don't extend.

> **SMART Goal B4 — Turn the loop twice**
>
> Ship three small public things (tools, extensions, or utility pages) serving the same .NET/Copilot
> audience between now and **June 30, 2027**, each scoped to ≤3 weeks of evenings — testing the
> "spaghetti with a spine" hypothesis with enough attempts to learn something.
>
> - **Measure:** 3 shipped and publicly announced.
> - **Checkpoint:** If none attracts repeat usage by June 2027, the constraint is problem selection, not
>   execution — go back to the Signals, not to more building.

## Notes on These Goals

- **Only B0 needs to happen now**, and it takes half an hour.
- **None of these carry a revenue target.** That's deliberate — the workshops carry the $12k. Attaching
  income pressure here converts the enjoyable work into a second job.
- **B1 and B2 are the highest-leverage items** and neither is really "building." Shipping the site and
  starting the list unlock everything downstream.
