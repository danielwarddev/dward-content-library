# Lessons From a Year of AI Coaching - Talk Content Ideas

**Generated:** September 21, 2026
**Context:** Content and structure ideas for a presentation about a year-long, anonymized enterprise AI coaching engagement.

---

## Recommended Core Message

This should be a behavior-change talk, not a tour of AI features or prompting techniques.

The strongest candidate thesis is:

> AI adoption is not budget allocated, licenses activated, or training delivered. It is a repeatable change in how people work that survives after the coaching ends without degrading quality.

That claim gives the talk tension without deciding in advance which intervention worked. It also creates a useful distinction between **activity** (money spent, licenses assigned, training attendance, article views, and suggestions accepted) and **change** (new capabilities, different workflows, faster feedback, and maintained quality).

## Narrative Arc

### 1. Start With Two Snapshots

Show the same ordinary development task at the beginning and end of the year. Avoid a flashy greenfield demo. Use something recognizable, such as investigating an unfamiliar service, changing existing behavior, or diagnosing a failing test.

- **Before:** The developer asks AI for code, receives a large answer, manually sorts through it, and either distrusts it or accepts too much.
- **After:** The developer uses AI to explore first, constrains the task, asks for a plan, makes a small change, runs mechanical checks, and reviews the result.
- **Point:** The durable change was not faster typing. It was a shorter, more deliberate feedback loop.

Then introduce the scale and boundaries of the experience without identifying the client: over a year, dozens of teams, a rollout from no approved AI tooling to broad availability, and enough elapsed time to observe what survived after the novelty wore off.

### 2. Explain the Initial Theory of Change

State what everyone expected at the beginning. This gives the audience a baseline against which each lesson can be judged.

- Give developers access to a capable tool.
- Coach individual teams on their real work.
- Teach larger groups through workshops.
- Publish articles that people can use asynchronously.
- Track utilization and acceptance metrics.
- Expect usage to spread and delivery to accelerate.

Ask the audience to predict which intervention had the greatest effect. Return to their answer later.

### 3. Show the Adoption Curve Over Time

Organize the year into phases rather than presenting disconnected lessons:

1. **Novelty:** Curiosity, broad experimentation, dramatic demos, and inflated expectations.
2. **Friction:** Weak results on real codebases, trust problems, security questions, and uneven manager support.
3. **Selection:** Developers retain the workflows that consistently save effort and abandon the rest.
4. **Normalization:** AI becomes part of some engineering systems and remains an optional novelty in others.

For each phase, show what leaders saw, what developers experienced, and what the coaches changed in response.

## The Four Interventions

Use the same five-part structure for every intervention:

> What we invested -> who it reached -> what behavior changed -> whether it lasted -> what happened to delivery and quality

Do not force a winner if the evidence cannot isolate one. The company increased its AI budget while coaching, workshops, and articles were all happening, so simple before-and-after comparisons cannot establish causality.

### Targeted Coaching With Individual Teams

- **Expected mechanism:** Applying AI to current team work makes the advice relevant and produces fast feedback.
- **Reach measures:** Teams coached, sessions per team, roles represented, and coaching hours.
- **Behavior measures:** New workflows attempted, workflows still used after 30/60/90 days, and whether the team can adapt the workflow without the coach.
- **Outcome measures:** Time or effort on the specific coached task, completion rate, blocked time, and rework.
- **Quality counter-signals:** Review rounds, defects, rollbacks, failed checks, and how much generated work was discarded.
- **Story to tell:** Follow one team from its original workflow through coaching and then revisit it after support ended.

### Workshops With Larger Groups

- **Expected mechanism:** One-to-many instruction creates broad awareness and a shared vocabulary at lower cost per person.
- **Reach measures:** Eligible audience, registrations, attendance, completion, and cost or coaching hours per attendee.
- **Behavior measures:** Participants who try one taught workflow within two weeks and still use one after 30/60/90 days.
- **Outcome measures:** Improvement on the type of task practiced in the workshop, not organization-wide productivity.
- **Quality counter-signals:** Overconfidence, inappropriate use cases, review burden, and generated work later replaced.
- **Story to tell:** Contrast positive workshop feedback with evidence of what participants actually did later.

### Articles

- **Expected mechanism:** Searchable, asynchronous guidance supports people when a relevant need arises.
- **Reach measures:** Unique readers from the intended audience, search entrances, and repeat readers. Raw page views alone are weak evidence.
- **Behavior measures:** Readers who report applying a technique, visits to linked examples or templates, and repeated use of the described workflow.
- **Outcome measures:** Resolved support questions, reduced repeated questions, or successful completion of the task the article addresses.
- **Quality counter-signals:** Outdated guidance, misapplication without coaching, and support requests caused by ambiguity.
- **Story to tell:** Trace one article from publication to a concrete downstream action, or show honestly that readership could not be connected to behavior.

### Increased AI Budget

- **Expected mechanism:** More licenses, model access, and tooling remove availability and capacity constraints.
- **Input measures:** Total spend, spend per eligible developer, licenses available, and premium request capacity.
- **Reach measures:** Activated seats and teams with access.
- **Behavior measures:** Sustained active use, active days rather than one-time activation, breadth of workflows, and retention after 30/60/90 days.
- **Efficiency measures:** Cost per sustained active user or team and cost per validated workflow adopted.
- **Quality counter-signals:** Increased output without increased delivery, larger review queues, rework, incidents, and cost growth without durable use.
- **Story to tell:** Show why spending enabled adoption but was not itself evidence of value.

## What to Measure

Use a balanced scorecard rather than searching for one perfect metric.

| Layer | Question | Candidate measures |
| --- | --- | --- |
| Investment | What did we put in? | Spend, licenses, coaching hours, workshop hours, articles published |
| Reach | Who encountered it? | Teams coached, attendance, intended readers, seats activated |
| Activation | Did they try it? | First meaningful use, first taught workflow attempted |
| Habit | Did behavior persist? | Repeat use and workflows retained after 30/60/90 days |
| Capability | Can they do something useful now? | Tasks completed with AI, self-sufficiency, appropriate decisions not to use AI |
| Delivery | Did work improve? | Task time, blocked time, lead time, throughput, deployment frequency |
| Quality | Did improvement come at a cost? | Rework, review rounds, escaped defects, failed checks, rollbacks, change failure rate |
| Experience | Is the change sustainable for people? | Confidence, trust, cognitive load, perceived usefulness, willingness to continue |

The most useful provisional north-star measure is:

> Percentage of teams with at least one repeatable AI-assisted workflow still in use after 60 days, with no material degradation in the quality measure paired with that workflow.

This is harder to collect than utilization, but it measures the change the talk claims to be about. Report the numerator and denominator so a high percentage from a small coached group is not mistaken for company-wide adoption.

### Questions Worth Asking Developers

Ask about recent, observable behavior instead of attitudes in the abstract:

- In the last two weeks, what task did AI materially help you complete?
- What did you do differently from your pre-AI workflow?
- Which AI-assisted workflow have you used more than once?
- When did you deliberately choose not to use AI, and why?
- How much of the output did you substantially revise or discard?
- What check gave you confidence that the result was correct?
- Would you keep using this workflow if coaching and encouragement stopped tomorrow?

Pair survey responses with a small number of interviews or work artifacts. A dashboard can show frequency; a concrete story can show whether the activity was valuable.

### How to Compare the Interventions

Do not compare raw totals because the interventions had different goals and reach. Compare each on:

- **Conversion:** Of the people reached, how many tried a meaningful workflow?
- **Retention:** Of those who tried it, how many were still using it after 30/60/90 days?
- **Depth:** How many distinct useful workflows did they adopt?
- **Cost:** What investment was required per retained team or workflow?
- **Transfer:** Could participants apply the approach to a new task without help?
- **Quality:** Did paired quality indicators remain stable or improve?

If historical data is incomplete, use a retrospective evidence ladder: available telemetry, existing delivery and quality trends, artifacts, a short survey, and interviews. Label retrospective self-report as such.

### Measurement Traps

- Treating increased budget as an outcome rather than an input
- Treating licenses assigned or seats activated as adoption
- Treating workshop satisfaction as behavior change
- Treating article views as successful application
- Using suggestion acceptance or lines generated as productivity
- Measuring individuals in ways that encourage gaming or feel like surveillance
- Comparing unlike teams without accounting for task and codebase differences
- Claiming AI caused organization-level changes while several interventions and other changes overlapped
- Reporting speed without a quality counter-signal

Put a convincingly green dashboard on screen, then explain what it cannot tell the audience. This can be one of the talk's most memorable moments.

## If There Are No Historical Metrics

Do not retrofit precise numbers onto an engagement that was not designed as a study. Reframe the talk as a field report based on repeated qualitative observations:

> I cannot tell you that coaching improved delivery by a specific percentage. I can tell you which patterns I repeatedly observed across teams, where those patterns did not hold, and what I would measure next time.

That boundary increases credibility. The talk's evidence can come from six sources.

### 1. Repeated Patterns Across Teams

Use recurrence rather than invented precision. Describe a pattern as:

- **Isolated:** Observed in one team or situation
- **Recurring:** Observed independently in several teams
- **Widespread:** Observed across different team types, roles, or parts of the organization
- **Mixed:** Observed often, but with meaningful counterexamples

Avoid percentages unless a real denominator exists. "I saw this repeatedly across different teams" is stronger and more honest than an unsupported "most developers."

### 2. Before-and-After Stories

Use concrete workflow changes you personally witnessed:

- The kinds of questions teams asked early versus later
- Whether developers brought hypothetical prompts or actual work
- Whether they needed step-by-step coaching or could select and adapt a workflow themselves
- Whether AI use moved from isolated experimentation into ordinary planning, coding, testing, or review
- Whether teams continued a practice after your direct involvement decreased

These stories establish observable change without claiming organization-wide causation.

### 3. Artifacts

Look for surviving evidence of changed behavior:

- Workshop materials that teams reused or adapted
- Articles that were referenced in later conversations
- Prompts, instructions, examples, or checklists teams saved
- Pull requests or tests that demonstrate a changed workflow
- Internal questions that evolved from "How do I use this?" to "How do we make this reliable?"
- Team practices that existed after coaching ended

Sanitize all artifacts and combine examples when necessary to protect the client.

### 4. Triangulation

A conclusion is stronger when it appears through more than one lens. Compare:

- What developers said
- What team leads or managers noticed
- What you directly observed during coaching
- What appeared in work products or recurring questions

Present agreement as corroboration, not proof. Present disagreement too; it often contains the more useful lesson.

### 5. Contrasting and Negative Cases

Actively include cases that challenge the neat version of the story:

- A coached team whose behavior did not change
- A workshop participant who adopted AI without further support
- A well-read article that produced no visible action
- A team that used AI more but did not appear to deliver more effectively
- A skeptical developer who found one durable use case

These examples show the audience that the lessons survived contact with contradictory evidence.

### 6. A Retrospective Pulse Check

Historical metrics may not exist, but lightweight evidence can still be collected now. Interview a small, varied sample of developers, team leads, and leaders using the same questions:

- What do you do with AI now that you did not do a year ago?
- Which intervention, if any, changed how you work?
- Which practice continued after coaching or training ended?
- What did you try and abandon?
- Where did AI save effort, and where did it create rework?
- What can you point to that makes you believe this?
- What would have happened without the coaching, workshop, article, or additional access?

Do not present this convenience sample as representative of the whole company. Use it to test your recollection, find counterexamples, and sharpen the stories.

## A Qualitative Evidence Ledger

Before building slides, create a simple ledger for every potential lesson:

| Claim | What I observed | Other supporting lens | Counterexample | Scope | Confidence |
| --- | --- | --- | --- | --- | --- |
| Example: Coaching tied to current work appeared to persist longer than generic instruction | Teams reused a workflow after sessions ended | Leads described less need for help | One coached team stopped using it | Recurring, not company-wide | Medium |

Only put a strong claim on stage when you can describe its evidence and scope. Use confidence labels such as:

- **High confidence:** Repeated direct observation, corroborated by another source, with few counterexamples
- **Medium confidence:** Recurring observation with incomplete corroboration or meaningful exceptions
- **Low confidence/current hypothesis:** Plausible interpretation based on limited examples

This ledger can become the talk's organizing device: **what I expected, what I observed, how confident I am, and what I would test next.**

## Observable Signals Available Without Analytics

Even without dashboards, the following signals can support the narrative:

- Questions became more specific and grounded in current work.
- Teams needed less help to recover from weak AI output.
- Developers could explain when not to use AI.
- Practices spread beyond the person who received coaching.
- Teams reused material without prompting from the coach.
- AI appeared in ordinary engineering conversations rather than only AI-specific events.
- Developers discussed verification and context, not only generation.
- Skeptics found narrow, repeatable uses even if they never became enthusiasts.
- Leaders shifted from asking about access to asking about workflow, quality, or constraints.
- Some practices remained visible after the novelty period or coaching ended.

Use these as prompts for recalling examples, not as claims that all of them occurred.

- Show how repository instructions, templates, automated tests, linters, CI checks, and documented workflows reduced the amount every individual had to remember.
- Compare opt-in advice with defaults embedded in the place where work happens.
- Explain why this reached developers who did not attend optional events.
- Make clear that guardrails should constrain the output, not surveil the person.

## What Actually Changed

Frame the changes in layers so the audience can distinguish personal skill from organizational capability.

### Individual Work

- Developers moved from asking for finished code to using AI for exploration, planning, implementation, and verification as separate steps.
- More work began with examples, constraints, and relevant context rather than a longer generic prompt.
- Developers learned where AI was predictably useful and where checking it cost more than doing the work directly.
- The best users became better reviewers of AI output, not merely better prompt writers.

### Team Work

- Useful prompts and instructions became shared assets instead of personal tricks.
- Teams discussed acceptable AI use during normal engineering work instead of isolating it in an AI-specific channel.
- Existing definitions of done, review standards, and test practices became more important because output volume increased.
- Teams with fast, reliable feedback could experiment more safely than teams whose test suites and build pipelines were already weak.

### Organizational Work

- Adoption shifted from a communications problem to a work-design problem.
- The organization had to decide which behaviors it wanted, not merely which tool it had purchased.
- Platform and enablement teams became responsible for useful defaults and paved paths.
- Leaders needed outcome signals and developer stories in addition to vendor telemetry.

## Workflows That Held Up

Present a small number of workflows with concrete before-and-after examples. A useful shared loop is:

1. **Explore:** Ask AI to locate the controlling code path, explain constraints, and surface uncertainty.
2. **Plan:** Define a small change and the check that would prove or disprove it.
3. **Implement:** Keep the change reviewable and aligned with existing patterns.
4. **Verify:** Run tests, analyzers, builds, or other deterministic checks.
5. **Review:** Inspect the diff and challenge assumptions that automated checks cannot cover.
6. **Capture:** Turn repeated guidance into repository instructions, templates, or automation.

Pair that loop with examples from different types of work:

- Understanding an unfamiliar codebase
- Diagnosing a defect
- Adding tests around existing behavior
- Making a small feature change
- Reviewing or explaining a pull request
- Automating a repetitive maintenance task

The key point is that the workflow should survive a change in model or vendor.

## Quality as the Multiplier

This deserves a dedicated section because it connects AI adoption to engineering fundamentals.

- AI accelerates both strong and weak development systems.
- A fast test suite, static analysis, small pull requests, clear architecture, and reproducible builds make AI output cheaper to verify.
- Weak feedback loops turn generation speed into review queues, rework, and false confidence.
- The practical unit of productivity is not code generated; it is useful, verified change delivered.

A compelling visual would show two teams receiving the same AI acceleration. One has quick feedback and absorbs the extra output; the other has slow reviews and unreliable tests, so work piles up downstream.

## Three Anonymized Case Studies

Build the middle of the talk around three stories rather than a long list of advice.

### The Expected Win

A team adopted a deliberate workflow and improved a specific kind of work. Include the initial friction, the intervention, the observed change, and what made you believe the change persisted.

### The Backfire

An intervention looked reasonable but produced resentment, shallow compliance, or no sustained change. This is the best place to discuss surveillance, mandates, or misleading metrics.

### The Surprise

One intervention performed differently from expectations. Possibilities include depth beating reach, an article influencing work long after publication, increased access failing to create habits, or a workshop creating awareness without sustained use. Choose only what the evidence supports.

For each story, include enough texture to feel real while changing or aggregating details that could identify the client.

## Evidence to Bring

Use evidence to support observations without overstating causality:

- A timeline of interventions and observed behavior shifts
- Aggregated attendance or repeat-engagement patterns
- An anonymized before-and-after workflow
- Sanitized examples of weak and improved AI interactions
- Trend direction rather than precise numbers when exact figures are sensitive
- A quote reconstructed from themes across several interviews, clearly labeled as a composite
- Quality counter-signals such as review burden, escaped defects, rework, or test failures
- One example where the available evidence remained ambiguous

Label observations precisely: **measured**, **reported by participants**, **observed repeatedly**, or **current hypothesis**. This honesty will strengthen the talk.

## Audience Participation

Use interaction to make the organizational lessons concrete:

- Opening poll: "How is your organization currently deciding whether AI adoption is working?"
- Prediction: rank training, champions, dashboards, manager support, and defaults by expected impact.
- Mid-talk scenario: show a green adoption dashboard and ask what decision the audience can safely make from it.
- Closing reflection: ask attendees which part of their development system would become the bottleneck if code output doubled tomorrow.

## A Practical Takeaway

End with a one-page experiment card rather than a universal maturity model:

- Behavior we want to change
- Current friction
- Small intervention
- Leading signal
- Quality counter-signal
- Review date
- What would cause us to stop or revise the experiment

This matches the talk's honest framing: attendees leave able to run a better experiment, not pretending they received a finished enterprise playbook.

## Suggested 45-60 Minute Shape

| Segment | 45 min | 60 min |
| --- | ---: | ---: |
| Opening snapshots and context | 5 | 7 |
| Initial assumptions and adoption curve | 5 | 7 |
| Three experiments/case studies | 15 | 22 |
| What changed at individual, team, and organizational levels | 7 | 8 |
| Durable workflow and quality multiplier | 8 | 10 |
| Takeaway, confidence boundaries, and close | 5 | 6 |

If the slot is short, preserve the three case studies and remove breadth. The stories are the evidence for the lessons.

## Closing

Return to the opening task and show what changed. Then land on two statements:

- **Most confident:** AI adoption should be evaluated as durable behavior change with delivery and quality considered together.
- **Least confident:** The available measures still make it difficult to attribute organization-level delivery changes directly to AI.

A possible final line:

> A successful rollout is not one where everyone uses AI. It is one where people can do valuable work they could not do before, and the system can tell whether that work is good.

## Details to Gather Before Building Slides

- The most ordinary task with a credible before-and-after story
- Three interventions with enough evidence for the expected win, backfire, and surprise
- What happened after the initial novelty period
- Which changes persisted without continued coaching
- A defensible definition of "increasing delivery" for this client
- Quality signals that were watched alongside delivery signals
- Exact claims the client would consider confidential
- Whether the client must approve anonymized stories or slides

---

## Notes

The current title promises broad lessons and observed change, so the talk should reveal both what changed and how that conclusion was reached. Avoid turning it into a comprehensive adoption framework or a product feature demo. The experience is most differentiated when it stays candid about failed experiments, ambiguous evidence, and the gap between visible AI activity and durable behavior change.

Before tailoring the abstract or emphasis further, identify the target conference and its audience. A leadership conference, a developer conference, and a vendor event will reward substantially different versions of this material.