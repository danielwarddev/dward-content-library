# AI Coaching Deck Skeleton Review

**Generated:** September 23, 2026  
**Updated:** September 26, 2026  
**Current context:** Review of slides 1-18 in `Lessons from a year of AI coaching.pptx`. Slides 19-28 are retained in the PowerPoint section named `Old slides` and are excluded from the content review.

---

## Review of the Updated Skeleton

### Verdict

This is a substantially stronger talk. It is no longer a chronology of one coaching engagement; it is a reusable model for making adoption stick. The sequence also has a real causal logic:

> **Permission -> Practices -> Patterns -> Performance**

- **Permission** creates organizational room to experiment.
- **Practices** determine whether faster output can be absorbed safely.
- **Patterns** turn experimentation into a repeatable way of working.
- **Performance** determines whether any of it produced value.

The distinction between **Practices** and **Patterns** is especially good. Practices are the engineering system AI enters; patterns are the AI-specific ways developers work inside that system. State that distinction explicitly on the framework slide because an audience could otherwise hear the words as synonyms.

### Highest-Priority Changes

#### 1. Hide the archived slides

The `Old slides` section organizes slides 19-28, but all ten slides are still visible in the normal slide show. Advancing once past the thank-you slide will reveal the old client-specific material. Keep the section for posterity, but hide those slides or present a custom show containing only slides 1-18.

#### 2. Replace the empty outline with the four-P framework

Slide 3 is currently an empty `Outline` slide, while slide 4 contains the actual framework. Remove slide 3 or turn it into the opening question:

> What has to be true for today's AI experiment to become tomorrow's ordinary work?

Then use slide 4 to reveal the four Ps with one short definition each. This gets to the thesis sooner and gives the audience a map they can retain.

#### 3. Make Performance a conclusion, not a list of measurement options

The first three sections increasingly make claims; Performance currently reopens the problem with `DORA`, `DX Core 4?`, user demos, baselines, and product value. Choose one clear conclusion:

> Measure outcomes, not AI activity.

Use a small scorecard beneath it:

- Delivery and stability
- Quality and maintainability
- Developer experience
- User or business outcomes

Establish a baseline when possible. Treat AI usage as diagnostic evidence about adoption friction, not as the target. This is also the natural place to restore Goodhart's law from the archived material.

#### 4. Give the recap a specific action

Do not end by merely repeating four nouns. Reassemble the model and ask the audience to apply it to one recurring workflow:

> Pick one useful workflow. Give people permission and access, ensure the engineering feedback exists, teach a repeatable AI pattern, and measure whether the outcome improves.

Keep that recap visible during questions; a separate blank `Thank you` slide gives away the most valuable screen in the deck.

### Section Review

#### Permission: strong idea, sharpen the promise

This section correctly combines the social and material sides of adoption: public leadership support, access, budget, time to learn, and space to share. That is stronger than treating tool access as the intervention.

The current wording needs tightening:

- `Leadership giving the mandate` conflicts slightly with `Permission`; mandate can sound like an enforced usage target.
- `Less red tape` could sound like bypassing governance. Prefer **clear guardrails and a fast path to approved tools and data**.
- `Give generous budgets` is memorable but subjective. The sharper claim is **provide reliable access that does not disappear halfway through real work**.
- Slide 7 is speaker-note prose. Reduce it to three ideas: **signal, access, and learning time**.

A good assertion title for the section is:

> **Permission becomes credible when leaders provide access and time.**

#### Practices: the right foundation, currently underweight

This section owns an important claim: AI amplifies the engineering system around it. It should receive at least two substantive slides, not only one after the divider.

1. **AI amplifies the system you already have.** Use the DORA finding and explain the upside/downside.
2. **The old practices matter more at higher speed.** Show small batches, version control, automated tests, CI/CD, fast feedback, documentation, standards, and usable internal platforms.

Avoid `you should have this stuff already`; it sounds scolding and implies organizations must finish engineering maturity before using AI. The practical message is that adoption and engineering improvement need to advance together.

#### Patterns: strongest and most concrete section

The progression from upskilling to a repeatable workflow is good. Slide 13 contains the section's most memorable material:

1. Give AI a way to do the work.
2. Give AI a way to check its work.
3. Give AI guardrails.

Slides 12 and 13 overlap. Combine them by placing the examples under that three-part model:

- **Do the work:** repository context, a plan, tools, and small increments
- **Check the work:** tests, builds, linters, and human review
- **Set guardrails:** concise repository instructions, standards, scope, and approval boundaries

`Use the terminal for a day` currently reads as a disconnected instruction. Keep it only if it introduces a concrete story with an observed lesson. Agent skills and `AGENTS.md` should remain examples of reusable context rather than becoming the core of a product-specific tutorial.

#### Performance: good questions, but answer them

The question `Is AI helping or hurting?` is an effective transition. Follow it with a confident measurement principle instead of another question-heavy slide. Performance should close the loop started by Permission: leaders fund an experiment, but usage and spend do not prove value.

Also fix the draft sentence `Can we measure of AI usage is helping? Hurting?` before the visual-design pass.

### Recommended Live Sequence

The current 18-slide count is workable for 20 minutes, but the content is uneven: Permission has two content slides, Practices one, Patterns three, and Performance two. A tighter 16-slide sequence would be:

1. Title and opening question
2. Brief credibility slide
3. Four-P framework
4. Permission divider
5. Permission: signal, access, and learning time
6. Practices divider
7. Practices: AI amplifies the existing system
8. Practices: feedback and delivery practices that make speed safe
9. Patterns divider
10. Patterns: learning happens in real work
11. Patterns: do, check, and guardrail loop
12. Performance divider
13. Performance: measure outcomes, not usage
14. Performance: baseline and balanced scorecard
15. Recap: apply all four Ps to one workflow
16. Questions with the four-P model still visible

This should land around 16-18 minutes once stories and DORA evidence are added, leaving enough room for transitions and live variation.

### Bottom Line

Keep the four-P model. It is clearer and more memorable than the earlier naming candidates, and the content maps to it without strain. The next pass should not add more topics. It should turn each draft bullet slide into one claim, one piece of evidence or example, and one implication for the audience.

---

## Overall Assessment

The deck has the ingredients for a strong talk: a credible enterprise setting, four different interventions, an honest measurement problem, and clear opinions about what worked. The skeleton is currently organized as a list of topics, though, rather than as an argument that accumulates evidence.

The most compelling version of the talk is built around this tension:

> The culture changed. I cannot prove which intervention caused it, and that may be the most useful lesson from the year.

That framing turns the lack of metrics from an apology into part of the story. It lets the talk distinguish what was directly observed, what people reported, and what remains a hypothesis.

## Final Title and Description

### Title

> **Making AI Adoption Stick: From Experiment to Everyday**

### Description

We all know we're supposed to be adopting AI into our work, but what does that actually look like in our day-to-day? Practically, what kind of changes should we expect to see, and how do we get the people around us to adopt it, too?

This problem is not only technical, but cultural. Once we give people access to new tools, how do we help them build useful habits around them? Not only that, but how do we know those habits are helping our goals, not hurting them?

This session will cover what does and doesn't work for making AI adoption stick, how to help people use these new tools, and AI workflows that increase speed without sacrificing quality.

### Longer Alternative

Organizations are investing heavily in AI, but licenses, new tools, and initial enthusiasm do not automatically change how work gets done. The hard part is turning experimentation into repeatable habits while preserving the feedback loops and engineering practices that protect quality.

This session examines the conditions behind durable AI adoption, including leadership support, learning in the context of real work, knowledge sharing, reliable access, and meaningful measures of progress. We'll explore why common approaches such as one-time training and usage dashboards often fall short, how organizational and technical constraints reinforce each other, and what teams can do differently.

You'll leave with a practical framework for identifying where adoption is stuck, evaluating progress without mistaking activity for outcomes, and deciding what to change next.

## Generalized Title Ideas

These titles remove the timeframe, coaching engagement, client scale, and case-study framing. They allow the talk to combine practical experience with broader industry research.

### Strongest Finalists

1. **From AI Access to AI Adoption: What Makes It Stick**
	- Best overall fit for the current material
	- Creates a clear distinction between buying tools and changing work
	- Broad enough for developers and engineering leaders

2. **Beyond the AI Rollout: What Effective Adoption Requires**
	- Strongest leadership-oriented option
	- Positions rollout as the beginning rather than the outcome
	- Naturally supports budget, training, culture, workflow, and quality sections

3. **Making AI Adoption Stick: Beyond Tools and Training**
	- Practical and accessible
	- Creates space to challenge licenses and workshops as sufficient solutions
	- Requires the talk to define what "stick" means

4. **AI Adoption Is a Systems Problem**
	- Shortest and most provocative finalist
	- Supports the argument that access, leadership, workflows, feedback, and engineering practices interact
	- Needs a strong defense because it is a categorical claim

5. **From Experimentation to Everyday Work: Building AI Habits That Last**
	- Strongest behavior-change option
	- Human and concrete without sounding like an enterprise case study
	- Slightly less direct about organizational adoption

### Broad and Neutral

- **AI Adoption in Practice: What Actually Changes**
- **What Effective AI Adoption Actually Requires**
- **Building the Conditions for Effective AI Adoption**
- **The Practices Behind Sustainable AI Adoption**
- **AI Adoption Beyond the Pilot**
- **How AI Becomes Part of Everyday Work**
- **From AI Rollout to Real Adoption**
- **Effective AI Adoption Without the Hype**

These are safest when the audience or conference positioning is still unknown. They promise synthesis and practical guidance without implying a specific client result.

### Provocative

- **You Can't Buy AI Adoption**
- **Your AI Rollout Isn't Adoption**
- **The Hard Part of AI Adoption Isn't the AI**
- **AI Adoption Doesn't Start With AI**
- **Stop Measuring AI Usage**
- **The Most Scalable AI Training May Be the Least Effective**

These are more memorable but require stronger evidence. In particular, "Stop Measuring AI Usage" must be defended as "do not mistake usage for outcomes," not "collect no usage data."

### Engineering-Focused

- **The Engineering System Behind Effective AI Adoption**
- **AI Adoption Needs Quality by Default**
- **Building Reliable AI-Assisted Workflows**
- **AI Adoption Without Sacrificing Quality**
- **From AI Output to Verified Delivery**
- **Making AI Work: Feedback Loops, Guardrails, and Engineering Practice**

These fit a developer or software-delivery conference. They shift attention away from organizational culture and toward the technical conditions that make AI-assisted work reliable.

### Behavior and Culture-Focused

- **From Awareness to Habit: Making AI Adoption Stick**
- **Building AI Habits That Last**
- **The Human Side of AI Adoption**
- **How Teams Learn to Work With AI**
- **Changing How We Work With AI**
- **AI Adoption Is Behavior Change**

These fit audiences interested in enablement, coaching, developer experience, or organizational change. They also preserve the most valuable part of the original talk without mentioning the engagement.

### Titles to Treat Carefully

- **What Actually Works in AI Adoption** implies stronger comparative evidence than the current talk has.
- **Proven AI Adoption Strategies** should be avoided without measured outcomes.
- **How to Transform Your Engineering Organization With AI** overpromises transformation and sounds promotional.
- **Lessons From Enterprise AI Adoption** removes the client but still frames the talk as a specific enterprise case study.
- **The Definitive Guide to AI Adoption** is too broad for the available evidence and a conference session.

### Recommendation

Use:

> **From AI Access to AI Adoption: What Makes It Stick**

It captures the talk's central distinction without revealing where the knowledge came from. It also gives the presentation a natural progression:

1. Access: tools, budget, and permission
2. Awareness: workshops, articles, and shared language
3. Application: real work and contextual support
4. Adoption: repeatable habits, feedback loops, and quality

For a more leadership-heavy event, use:

> **Beyond the AI Rollout: What Effective Adoption Requires**

For a more technical event, use:

> **The Engineering System Behind Effective AI Adoption**

## Highest-Priority Changes

### 1. State the Claim Before the Background

Slides 3-6 currently move through an empty outline, the definition of coaching, the goal, and the environment before the audience hears a lesson. Open with the surprising outcome or unresolved tension instead.

Recommended opening sequence:

1. Title
2. **"The culture changed. I can't prove why."**
3. Briefly establish the enterprise scale and year-long vantage point
4. Explain what "change culture" meant in observable terms
5. Show the interventions and timeline

Move the bio after the hook or reduce it to a 20-second spoken introduction. Remove the outline slide unless it eventually communicates a meaningful three-act journey.

### 2. Replace Topic Titles With Claims

Titles such as "Measuring," "What changed?", and "What worked well?" tell the audience what category is next but not what they should learn. Assertion titles will make the narrative understandable even when someone only sees the slide headings.

Examples:

- "What was our goal?" -> **"The goal was behavior change, not tool usage"**
- "What we tried" -> **"We tried four ways to change behavior"**
- "Measuring" -> **"The obvious measurements could not answer our question"**
- "What changed?" -> **"Culture changed before we could quantify delivery"**
- "What worked well?" -> **"Permission and proximity changed behavior"**
- "What didn't work?" -> **"Awareness did not become a habit"**
- "Did it work?" -> **"My honest answer: kind of"**

### 3. Make the Four Interventions Visible

The current deck names coaching, workshops, budget, and leadership encouragement, but the articles mentioned in the planning notes are absent. Show all four interventions together so the audience understands the experiment portfolio:

- Targeted team coaching
- Large workshops
- Internal articles
- Increased AI budget and organizational encouragement

A timeline or a simple matrix would work better than bullets. One useful visual arrangement is **depth versus reach**:

- Coaching: high depth, low reach
- Workshops: lower depth, high reach
- Articles: low direct contact, persistent availability
- Budget/leadership: broad enabling condition rather than instruction

Do not assign outcomes to the matrix until the supporting story is ready.

### 4. Define "Culture Changed" Through Observations

Slide 10 currently says only "Culture." That is the title's promised answer, so it should become one of the strongest sections. Use two or three concrete before-and-after observations, such as:

- Early questions were about access or basic prompting; later questions were about workflows, verification, and team standards.
- AI moved from isolated experimentation into ordinary engineering conversations.
- Developers became better at identifying when AI was and was not useful.
- Teams shared approaches with each other instead of depending entirely on a coach.
- Leaders moved from asking whether AI was available to asking how to make its use reliable.

Only include observations that actually occurred. Label them as recurring observations rather than company-wide measurements.

### 5. Separate the Conclusion Into Several Slides

Slide 13 currently contains at least four ideas:

- Confidence in the conclusions
- Whether AI requires new metrics
- DORA
- Conditions needed for successful adoption

Split these. The honest "kind of" answer deserves its own slide and a pause. The prerequisites should become three memorable lessons, not a nested bullet list.

Suggested lessons:

1. **Access is necessary, but it is not adoption.** Budget and leadership remove constraints and give permission to experiment.
2. **Behavior changes closest to real work.** Individual coaching appeared stronger than generic instruction because it happened inside current problems.
3. **Measure the delivery system, but observe the behavior too.** DORA can reveal system outcomes; it cannot attribute a change to coaching or explain whether habits changed.

## Factual and Reasoning Corrections

### Goodhart's Law

Slide 8 currently describes Goodhart's law as "what gets measured gets improved." That is not Goodhart's law and communicates almost the opposite warning.

Use:

> When a measure becomes a target, it ceases to be a good measure.

Connect it to AI adoption metrics: if suggestion acceptance, generated lines, or active days become targets, people can improve those numbers without improving delivery or quality.

### DORA Is Useful but Insufficient for This Claim

"Nothing! Just DORA" is memorable, but it is too absolute for the question the deck asks. DORA metrics can help assess software delivery performance. They do not establish that AI caused a change, measure whether coaching created a durable habit, or directly describe cultural change.

A more defensible line is:

> Do not invent AI productivity metrics. Keep measuring delivery and quality, then add qualitative evidence about how work changed.

That preserves the contrarian instinct without making DORA carry more than it can support.

### Budget Is an Enabler, Not Evidence of Success

The healthy-budget point is practical and worth keeping. Present it as a prerequisite: developers cannot build habits around a tool that becomes unavailable halfway through the month. Do not present increased spending itself as evidence that the rollout worked.

## Recommended Narrative

For a 20-minute session, build the talk around one argument:

> AI adoption sticks when leaders back their expectations with resources, teams build on strong engineering foundations, developers learn a disciplined workflow, and the organization judges success by outcomes.

The underlying ideas are:

1. **Leadership signal:** Leaders publicly make AI adoption a priority and clarify that thoughtful experimentation is wanted.
2. **Material access:** The organization funds enough access for AI to become dependable infrastructure rather than a scarce novelty. The relevant question is not simply "What does AI cost?" but "Does the value created exceed the cost?"
3. **Engineering foundation:** AI accelerates the system already present. Version control, small batches, automated tests, internal documentation, usable platforms, and fast feedback matter more with AI, not less.
4. **AI working practice:** Developers need the technical knowledge and repeatable workflows to use AI well. Context, plans, repository instructions, agent skills, incremental changes, automated checks, and human review turn access into capability.
5. **Outcome feedback:** The organization must determine whether AI improves delivery without harming stability, quality, maintainability, user outcomes, or developer experience.

These are five ideas, but they do not need five equal sections. Leadership signal and material access are two halves of **organizational commitment**: words establish priority, while funding makes the priority credible. The engineering foundation, AI working practice, and outcome feedback should remain distinct because each prevents a different failure.

### Recommended Section Names

The clearest labels are:

1. **Commitment:** Say it matters, then fund it.
2. **Foundation:** AI accelerates the engineering system you already have.
3. **Workflow:** Teach a repeatable way to work with AI.
4. **Feedback:** Measure whether the outcomes improved.

This is stronger than forcing consonance because each word names a genuinely different concept. The repeated one-word nouns still give the sections rhythm.

Goodhart's law connects **Commitment** and **Feedback**. Introduce the risk when discussing leadership: asking people to experiment can help, but targeting an amount of AI usage invites performative behavior. Resolve it under Feedback: keep measuring delivery, stability, quality, and user outcomes; use AI activity only to diagnose adoption friction.

DORA also has two jobs in this structure:

- Under **Foundation**, DORA research supports the claim that AI amplifies the strengths and weaknesses of the surrounding system.
- Under **Feedback**, DORA metrics keep attention on delivery and stability rather than AI activity.

### Other Naming Options

The labels below keep the same sequence in every set:

1. Leadership commitment backed by resources
2. Engineering readiness and foundations
3. A repeatable AI-assisted working practice
4. Evidence of outcomes

The strongest Thesaurus.com word families were **backing**, **sponsorship**, and **endorsement** for commitment; **bedrock**, **infrastructure**, **preparedness**, and **systems** for readiness; **craft**, **practice**, **method**, and **technique** for workflow; and **assessment**, **evidence**, **impact**, and **results** for outcomes. The sets below favor ordinary words that remain clear when spoken.

#### Strongest Candidates

| Set | Commitment and resources | Engineering foundation | Working practice | Outcome evidence | Why it works | Main weakness |
| --- | --- | --- | --- | --- | --- | --- |
| **I** | **Investment** | **Infrastructure** | **Iteration** | **Impact** | Tells a logical story from organizational input to observable effect. All four words are familiar and distinct. | "Iteration" emphasizes the development loop more than the full craft. |
| **E** | **Endorsement** | **Environment** | **Execution** | **Evidence** | Clean executive language; the final word supports the talk's honest measurement stance. | "Environment" is broader and less concrete than engineering foundation. |
| **R** | **Resolve** | **Readiness** | **Routine** | **Results** | Short, memorable, and easy to say. It frames adoption as something that becomes ordinary. | "Resolve" implies commitment but does not explicitly imply funding. |
| **P** | **Priority** | **Platform** | **Practice** | **Proof** | Very conversational. "Practice" captures both repeated workflow and developing skill. | "Proof" may promise stronger causal evidence than the talk has. |
| **M** | **Mandate** | **Maturity** | **Method** | **Measurement** | Preserves "Measurement" and gives every section a precise job. | "Mandate" can sound compulsory; "method" is accurate but plain. |
| **C** | **Commitment** | **Conditions** | **Craft** | **Calibration** | Preserves both preferred C words. "Calibration" makes measurement a feedback loop rather than a scoreboard. | "Conditions" needs concrete examples to signal engineering readiness. |
| **F** | **Funding** | **Foundations** | **Fluency** | **Feedback** | Plainspoken and closely tied to the content already in the deck. | "Funding" understates leadership's role; "fluency" emphasizes skill more than workflow. |
| **B** | **Backing** | **Bedrock** | **Behavior** | **Benchmarks** | Strong rhythm, with an especially clear first two terms. | "Behavior" can sound like management observing developers. |

#### Additional Noun Sets

These are viable alternatives with a more specific tone or a slightly looser fit.

| Set | Commitment and resources | Engineering foundation | Working practice | Outcome evidence | Character |
| --- | --- | --- | --- | --- | --- |
| **A1** | **Alignment** | **Architecture** | **Application** | **Assessment** | Formal and technically credible. |
| **A2** | **Advocacy** | **Access** | **Application** | **Assessment** | Strong on leadership permission and tool availability, but weaker on engineering foundations. |
| **B2** | **Buy-in** | **Base** | **Buildcraft** | **Benefits** | Compact and developer-oriented; "buildcraft" may feel invented. |
| **C2** | **Commitment** | **Capability** | **Craft** | **Consequences** | Direct and preserves the preferred words; the ending has a deliberately cautionary tone. |
| **C3** | **Conviction** | **Codebase** | **Craft** | **Calibration** | Concrete and memorable for a developer audience. "Codebase" excludes some platform and process concerns. |
| **D** | **Direction** | **Dependability** | **Discipline** | **Difference** | Emphasizes reliable engineering and deliberate practice. "Difference" is less obviously measurement. |
| **G** | **Guidance** | **Groundwork** | **Groove** | **Gains** | Warm and conversational; "groove" reinforces habitual use. It may be too casual for some conferences. |
| **L** | **Leadership** | **Landscape** | **Learning** | **Lift** | Accessible and positive. The middle terms are broader than the actual sections. |
| **S1** | **Sponsorship** | **Systems** | **Skills** | **Signals** | Maps neatly to organizational, technical, individual, and measurement concerns. "Signals" is intentionally non-causal. |
| **S2** | **Support** | **Stability** | **System** | **Scorecard** | Makes the engineering and measurement pieces concrete. "System" overlaps with "stability." |
| **T** | **Trust** | **Tooling** | **Technique** | **Traction** | Modern and energetic; good when the audience already accepts the investment case. "Trust" does not cover funding by itself. |
| **W** | **Will** | **Wherewithal** | **Workflow** | **Worth** | Preserves "Workflow" and has a satisfying input-to-value arc. "Wherewithal" is harder to process aloud. |

#### Action-Oriented Sets

Verbs make the four sections feel like a playbook rather than four conditions.

| Set | Leadership action | Engineering action | Workflow action | Measurement action | Note |
| --- | --- | --- | --- | --- | --- |
| **B** | **Back it** | **Build well** | **Blend it in** | **Benchmark outcomes** | The most natural action set; "blend it in" means integrate AI into real work. |
| **C** | **Commit** | **Construct** | **Cultivate** | **Calibrate** | Strong rhythm and a useful improvement-loop ending. The middle verbs need subtitles. |
| **E** | **Endorse** | **Engineer** | **Embed** | **Evaluate** | Precise, active, and easy to remember. This is the strongest verb set. |
| **I** | **Invest** | **Improve** | **Integrate** | **Inspect** | Clearly moves from resources to systems to daily work to evidence. "Inspect" sounds narrower than outcome measurement. |
| **P** | **Prioritize** | **Prepare** | **Practice** | **Prove** | Excellent stage rhythm. As with "Proof," "Prove" overstates certainty. |
| **S** | **Sponsor** | **Strengthen** | **Systematize** | **Study** | Faithful to the argument, though "systematize" is less conversational. |

#### Best Variants by Preferred Word

To preserve **Commitment**:

- **Commitment -> Conditions -> Craft -> Calibration**
- **Commitment -> Capability -> Craft -> Consequences**
- **Commitment -> Codebase -> Craft -> Calibration**

To preserve **Craft**:

- **Commitment -> Conditions -> Craft -> Calibration**
- **Conviction -> Codebase -> Craft -> Calibration**
- **Commitment -> Capability -> Craft -> Consequences**

To preserve **Measurement**:

- **Mandate -> Maturity -> Method -> Measurement**
- **Momentum -> Maturity -> Mechanics -> Measurement**
- **Mission -> Maturity -> Method -> Measurement**

To preserve **Workflow**:

- **Will -> Wherewithal -> Workflow -> Worth**
- **Welcome -> Wiring -> Workflow -> Worth**
- **Warrant -> Workbench -> Workflow -> Wins**

The last two W variants are deliberately more playful and are weaker semantically than the first.

#### Current Ranking

1. **Investment -> Infrastructure -> Iteration -> Impact**
2. **Endorsement -> Environment -> Execution -> Evidence**
3. **Resolve -> Readiness -> Routine -> Results**
4. **Commitment -> Conditions -> Craft -> Calibration**
5. **Priority -> Platform -> Practice -> Proof**
6. **Mandate -> Maturity -> Method -> Measurement**

The **I** set is the best complete noun framework. It is concise, creates a natural causal arc, and does not need strained vocabulary. The **E** set is the strongest for an executive audience. The **R** set is the easiest to remember and say. The revised **C** set is the best choice if preserving **Commitment** and **Craft** matters most. The verb set **Endorse -> Engineer -> Embed -> Evaluate** is stronger than most noun sets if the talk should feel explicitly actionable.

#### Most Conversational

1. **Set the priority**
2. **Build the foundation**
3. **Teach the workflow**
4. **Measure the outcome**

#### Best Three-Part Collapse

1. **Enablement:** Leadership signal, funding, access, and engineering conditions
2. **Practice:** Technical knowledge and repeatable AI-assisted workflows
3. **Evidence:** Delivery, stability, quality, user outcomes, and persistence of useful habits

This is compact, but it hides the important distinction between having AI tools and having an engineering system ready to absorb faster output.

This is no longer a chronology of one engagement. Firsthand experience becomes supporting evidence introduced with language such as "In my coaching work, I repeatedly observed..." Industry research tests whether those observations generalize. Do not mention the client, its size, dates, budget, internal rollout, or any uniquely identifying combination of details.

## Proposed Slide Sequence

Aim for **17-18 minutes of planned material**. The remaining time protects against transitions, laughter, technical delays, and a slower live delivery. Use the four ideas as the actual presentation sections, with roughly 3-4 minutes for each one.

| # | Assertion title | Purpose and content | Time |
| --- | --- | --- | ---: |
| 1 | **Making AI Adoption Stick: From Experiment to Everyday** | Open with the question: "What would have to be true for today's AI experiment to still be part of the work six months from now?" | 0:30 |
| 2 | **Why I care about this** | Keep the personal slide, but make it establish your perspective rather than client context: you have coached developers, taught AI-assisted development, and observed which approaches became everyday habits. | 0:45 |
| 3 | **Using AI is not the same as adopting it** | Define adoption as a repeatable workflow that helps an outcome without degrading quality. Preview the four sections: **Commitment, Foundation, Workflow, Feedback**. | 1:15 |
| 4 | **Commitment: leaders make experimentation legitimate** | Explain the cultural signal: leaders publicly say AI matters, clarify acceptable use, and give people room to learn. Introduce the Goodhart risk of turning encouragement into an AI-usage quota. | 1:30 |
| 5 | **Commitment: fund the priority** | Reliable access is necessary for habits to form. Frame spend as an investment question: if $1,000 of AI capacity creates $5,000 of value, the cost alone is not the useful decision criterion. | 1:30 |
| 6 | **Foundation: AI amplifies the system around it** | Introduce DORA's finding that AI magnifies existing strengths and weaknesses. Faster generation can mean faster value or faster technical debt. | 1:30 |
| 7 | **Foundation: old practices matter even more** | Highlight small batches, version control, automated tests, fast feedback, internal documentation and data, clear standards, and usable internal platforms. These make increased output safe to absorb. | 1:30 |
| 8 | **Workflow: habits form inside real work** | Contrast broad training with contextual application. Workshops can create awareness; developers build capability by applying AI to current work and receiving feedback. | 1:15 |
| 9 | **Workflow: use AI inside a controlled loop** | Show your preferred workflow: provide context and instructions -> make a plan -> work incrementally -> run automated checks -> review the code and result -> repeat. Mention agent skills as reusable context, not as a product tutorial. | 2:15 |
| 10 | **Feedback: faster generation can move the bottleneck** | Explain DORA's finding that higher AI adoption is associated with both greater throughput and greater instability. More output can increase verification and review work. | 1:30 |
| 11 | **Feedback: measure impact, not AI output** | Resolve Goodhart's law. Treat usage as diagnostic information, not the target. Continue measuring delivery and stability with DORA, plus quality, user outcomes, and persistence of useful workflows. | 2:00 |
| 12 | **Make one useful workflow ordinary** | Reassemble the four sections, then give one action: choose a recurring task, ensure the engineering feedback exists, teach a workflow in context, and measure whether the outcome improves. | 1:15 |

**Planned duration:** 16 minutes 45 seconds, leaving 3 minutes 15 seconds for transitions, elaboration, and live variation.

### Section Timeboxes

| Section | Slides | Planned time |
| --- | --- | ---: |
| Intro and personal context | 1-3 | 2:30 |
| Commitment | 4-5 | 3:00 |
| Foundation | 6-7 | 3:00 |
| Workflow | 8-9 | 3:30 |
| Feedback | 10-11 | 3:30 |
| Close | 12 | 1:15 |

### Evidence Boundaries

Visually distinguish the source of claims throughout the deck:

- **Observed in practice:** Patterns personally seen across coaching and enablement work. Use a concrete story, but remove organization, scale, timing, team, product, and internal-program details.
- **DORA found:** Findings from published research. Cite the report on the slide and avoid converting association into causation.
- **Recommendation:** Your synthesis of experience and research. Present it as guidance, not a universal law.

The most useful DORA material for this talk is:

- The 2025 report's central conclusion that AI acts as an amplifier of the surrounding organizational system. Use this under **Foundation** or **Conditions**, depending on the final naming choice.
- The AI Capabilities Model, especially a clear and communicated AI stance, AI-accessible internal data, quality internal platforms, working in small batches, and user-centric focus.
- The finding that higher AI adoption is associated with both increased delivery throughput and increased delivery instability.
- The recommendation to measure impact rather than narrow output measures and to move verification earlier in the workflow. Use this under **Feedback** or **Calibration**, depending on the final naming choice.

Sources:

- [DORA 2025 State of AI-assisted Software Development](https://dora.dev/research/2025/dora-report/)
- [DORA AI Capabilities Model](https://dora.dev/ai/capabilities-model/report/)
- [Balancing AI tensions: Moving from AI adoption to effective SDLC use](https://dora.dev/insights/balancing-ai-tensions/)

### What to Remove From the Original Skeleton

- Remove the environment and company-scale slide entirely.
- Remove the engagement-specific definition of AI coaching; define durable adoption instead.
- Remove the chronological pull-versus-push rollout story unless one sentence is needed to set up the workshop/coaching contrast.
- Combine budget and leadership into the broader idea of organizational commitment.
- Combine workshops, coaching, and articles into the practice and reinforcement section rather than giving each a case-study report card.
- Remove "Did it work? Kind of." It answers a client-specific evaluation question that the general talk no longer asks.
- Keep Goodhart's law as a callback: introduce the danger when discussing leadership mandates, then resolve it when discussing performance measures.
- Do not add a tour of all seven DORA capabilities. Show the model once, highlight the capabilities relevant to the four sections, and link to the full model in the resources.

## Visual Direction

The current template is highly readable and appropriately neutral for a skeleton. Keep the generous whitespace, but replace most bullet lists with a single idea plus a visual structure.

- Use the four section words as recurring visual anchors: **Commitment, Foundation, Workflow, Feedback**.
- Show the engineering prerequisites as an interconnected system rather than a checklist to explain the amplifier effect.
- Use one simple loop for the AI-assisted workflow; reveal each step in sequence instead of presenting implementation details.
- Visually connect the Permission and Performance slides so the Goodhart callback is obvious.
- Contrast an AI activity metric with a delivery or quality outcome on the Performance slide.
- Reduce the bio slide's competing logos and links unless all are necessary for the specific audience.

The deck does not yet need decorative polish. It first needs stories, assertions, and evidence boundaries; the visual language can then reinforce those choices.

## What Is Already Working

- The title clearly promises experience-based lessons rather than a feature demonstration.
- The client is described at an appropriate level for anonymity.
- Pull versus push is a useful way to explain the rollout's evolution.
- The contrast between individual coaching and large workshops is potentially the talk's strongest practical lesson.
- The measurement uncertainty is unusually candid and differentiates the talk from vendor-style success stories.
- "Kind of" sounds human and should remain in the talk.

## Questions to Answer Before the Next Draft

- What did "pull" and "push" mean operationally?
- What is one specific team-coaching story with a visible before and after?
- What happened after a large workshop that made it feel ineffective?
- What role did the articles actually play?
- What are two observable examples that support "culture changed"?
- Which conclusion has the highest confidence, and which remains a hypothesis?
- What would you measure from day one if repeating the engagement?

## Slide-Ready Content Options

### Example Claims

These are candidate assertion titles, not established facts. Keep only the ones supported by a concrete observation, story, or artifact.

#### Claims About the Overall Effort

- **The culture changed before we could prove that delivery changed.**
- **AI adoption was a behavior-change problem, not a tool-availability problem.**
- **You can buy access to AI, but you cannot buy adoption.**
- **The strongest evidence of adoption was not usage; it was how engineering conversations changed.**
- **The rollout succeeded first as permission to experiment, not as measurable productivity.**
- **After a year, I was more confident about how to enable AI than how to measure it.**

#### Claims About Coaching

- **Coaching worked best when it happened inside real work.**
- **A team-specific problem taught more than a generic prompt exercise.**
- **The deepest intervention had the smallest reach and the clearest visible effect.**
- **Good coaching made teams less dependent on the coach.**

#### Claims About Workshops

- **Large workshops created awareness, but awareness did not automatically become a habit.**
- **The most scalable intervention produced the shallowest visible change.**
- **A good workshop reaction was not evidence of changed behavior.**
- **Workshops answered questions people had in the room; coaching uncovered problems they had in the work.**

#### Claims About Budget and Leadership

- **Budget removed a constraint; leadership removed hesitation.**
- **A tool developers cannot reliably access cannot become part of their workflow.**
- **Leadership encouragement made experimentation legitimate, but it did not tell teams how to work differently.**
- **Access was necessary, but it was only the first layer of adoption.**

#### Claims About Measurement

- **DORA could tell us whether the delivery system changed, not why it changed.**
- **The easiest AI metrics to collect were the least useful for evaluating culture.**
- **We could observe changed behavior without being able to attribute company-wide outcomes.**
- **No baseline meant no honest productivity percentage.**

The strongest potential headline claim is:

> The culture changed. I cannot prove which intervention caused it.

The strongest potential practical claim is:

> Access creates opportunity, workshops create awareness, and coaching creates context. Durable adoption needs all three, but they do different jobs.

That second claim should include articles if they proved meaningful. If articles had no visible effect, their invisibility is itself worth discussing.

### The Four Interventions

Based on the planning discussion, the four interventions are:

1. **Targeted coaching with individual teams**
	- High-touch help applied to a team's current work
	- Initially pull-based with interested teams, then more push-based outreach
	- Intended to create depth, confidence, and reusable habits

2. **Large workshops**
	- One-to-many instruction for broader groups
	- Intended to create awareness, shared vocabulary, and basic capability at scale
	- Appears to have had less visible effect on day-to-day behavior than individual coaching

3. **Internal articles**
	- Asynchronous, reusable guidance
	- Intended to reinforce learning and reach people when a relevant need arose
	- Its effect may be difficult to observe unless people referenced or reused the material

4. **Increased AI budget and organizational encouragement**
	- More reliable access, fewer usage constraints, and explicit leadership permission to experiment
	- Intended to remove practical and cultural barriers
	- Best treated as an enabling condition rather than an educational intervention

Leadership encouragement belongs with the fourth intervention unless there was a distinct leadership program. Splitting budget and leadership into separate interventions would produce five and leave articles missing again.

A concise visual summary could be:

| Intervention | Primary job | Shape |
| --- | --- | --- |
| Budget and encouragement | Permission and access | Broad enablement |
| Workshops | Awareness and shared language | Broad instruction |
| Articles | Reinforcement and reference | Persistent, asynchronous support |
| Team coaching | Application and habit formation | Deep, contextual support |

### Concrete Observations of Culture Change

Culture is too abstract to put on a slide by itself. Use specific changes you personally witnessed. These are prompts to test against memory, not assumed facts.

#### The Questions Changed

- Early: "Are we allowed to use this?" or "What prompt should I write?"
- Later: "How should we verify this?", "How do we give it our standards?", or "Where should this fit in our workflow?"
- Why it matters: the conversation moved from access and novelty toward reliability and practice.

#### The Work Became More Concrete

- Early sessions used generic demonstrations or hypothetical prompts.
- Later sessions involved current code, active defects, tests, reviews, or recurring team tasks.
- Why it matters: AI moved closer to normal engineering work.

#### People Needed Different Help

- Early support focused on tool mechanics.
- Later support focused on context, decomposition, verification, and deciding when not to use AI.
- Why it matters: capability became more sophisticated even if total usage was unknown.

#### Experimentation Became More Legitimate

- Developers no longer needed to justify trying AI for every task.
- Managers encouraged experimentation or made time for it.
- Teams openly discussed failed attempts as well as successes.
- Why it matters: experimentation became socially safer.

#### Knowledge Began Moving Without the Coach

- Developers shared workflows, examples, or articles with colleagues.
- A team adapted something from coaching without asking for step-by-step help.
- People arrived at sessions because another team recommended them.
- Why it matters: knowledge transfer was no longer entirely coach-driven.

#### Skepticism Became More Specific

- Objections moved from "AI is useless" or "AI will do everything" toward bounded judgments about suitable tasks, quality, privacy, or review cost.
- Skeptical developers found narrow uses without becoming enthusiasts.
- Why it matters: the organization developed a more mature mental model rather than simple enthusiasm.

#### Constraints Moved

- Early constraints centered on access, budget, or permission.
- Later constraints centered on codebase quality, deployment friction, test feedback, and verification.
- Why it matters: the bottleneck shifted from obtaining AI to integrating it into the engineering system.

The best culture-change slide would show three paired observations:

| At the beginning | A year later |
| --- | --- |
| "Can we use it?" | "How do we verify it?" |
| Generic demos | Current team work |
| Coach distributes knowledge | Teams share and adapt knowledge |

Use the actual language you heard rather than these placeholders wherever possible.

### Conclusions for "Did It Work?"

Avoid forcing one yes-or-no answer. Evaluate success at different layers.

#### 1. Access: Yes

The increased budget and leadership encouragement appear to have removed practical and social barriers. Developers had a more reliable opportunity to experiment.

**Confidence:** High if access problems visibly decreased and leadership support was explicit.

#### 2. Awareness: Yes

Workshops, articles, and communication exposed more people to AI concepts and gave the organization shared language.

**Confidence:** Medium unless reach or readership is known. Awareness is not the same as adoption.

#### 3. Team Behavior: Partly

Individual coaching appears to have changed behavior for some teams because it was grounded in their actual work. Large workshops appear less likely to have produced durable habits.

**Confidence:** Medium, strengthened by a before-and-after coaching story and a contrasting workshop example.

#### 4. Company Culture: Probably

The questions, conversations, willingness to experiment, and sophistication of concerns may indicate a cultural shift.

**Confidence:** Medium if those patterns recurred across different teams and roles. Describe this as an observed pattern, not a measured company-wide result.

#### 5. Delivery Performance: Unknown

Without a baseline, comparison group, or attributable delivery data, the talk cannot responsibly claim that AI increased company-wide throughput or reduced lead time.

**Confidence:** High confidence in the uncertainty.

#### 6. Quality: Unknown or Mixed

Unless defects, rework, review burden, or other quality signals were observed, the talk cannot claim that quality was maintained. Specific stories can still show where verification practices improved or where AI created rework.

**Confidence:** Depends on available examples.

#### 7. The Coaching Program: Worth Doing, With Changes

A defensible conclusion may be that the program created value, especially through access, permission, and contextual coaching, but the next iteration should establish a baseline, define observable target behaviors, and follow up after interventions.

The slide-ready answer is:

> **Did it work?**
>
> - Access and permission: **yes**
> - Durable team behavior: **in some places**
> - Company-wide culture: **probably**
> - Delivery and quality impact: **we don't know**

That answer is more credible and useful than either a victory lap or "there were no metrics, so I learned nothing."

### A Strong Closing Conclusion

> We did not prove that AI made the company more productive. We did learn that adoption required reliable access, permission to experiment, and help applied directly to real work. The clearest changes appeared in how people approached problems and talked about quality, not in an AI dashboard.

---

## Notes

No substantive speaker notes were embedded in the current deck, so this review is based on visible slide content and structure. The PowerPoint contains 15 slides and uses a consistent 16:9 layout.