# Copilot SDK Demo App Ideas

**Generated:** 2026-02-18
**Context:** Brainstorming a demo app for the "Put An Agent Inside Your App In 10 Minutes Or Less With the GitHub Copilot SDK" talk. Needs to be a relatable business service that attendees can take back to their teams.

---

## Evaluation Criteria

The ideal demo app should:

- **Already exist** as a simple service before you add Copilot (reinforces the "put an agent inside YOUR app" narrative)
- Have a clear input → output flow that's easy to follow on stage
- Be recognizable to most enterprise devs as a real-world need
- Showcase **tool use** (the SDK's killer feature — the agent calling your business functions)
- Be simple enough to build/understand in 10 minutes but not so trivial it feels like a toy

---

## Top Recommendations

### 1. Support Ticket Triage Service ⭐ (Recommended)

**The app (before Copilot):** A minimal ASP.NET API that receives support tickets (title + description) and stores them in a list/queue. Tickets just pile up unprocessed.

**What Copilot adds:** An agent that triages each incoming ticket by:

- Classifying priority (P1–P4) based on the description
- Routing to the right team (billing, engineering, account management)
- Generating a suggested first response to the customer

**Tools you'd register with the SDK:**

- `GetCustomerHistory(customerId)` — returns past tickets for context
- `LookupSLA(tier)` — checks the customer's SLA tier
- `AssignTicket(teamName, priority)` — routes the ticket
- `DraftResponse(ticketId, message)` — saves a draft reply

**Why this works for the talk:**

- Every company has support tickets — instantly relatable
- Clear before/after: "tickets pile up" → "tickets are triaged automatically"
- Shows the agent making decisions AND calling tools, which is the SDK's core value
- The tools are simple C# methods, easy to show in 10 minutes
- Attendees immediately see how to apply this to their own domain

**Why attendees take this home:**

- Swap "support ticket" for any intake/triage workflow their company has
- The pattern (receive input → agent reasons → agent calls tools → output) is the universal agent pattern

---

### 2. Expense Report Processor

**The app (before Copilot):** A background worker service (or minimal API) that receives expense submissions (employee, amount, category, description, receipt text).

**What Copilot adds:** An agent that acts as a first-pass reviewer:

- Validates against company expense policy (meals under $75, travel requires pre-approval, etc.)
- Flags suspicious or out-of-policy items with a reason
- Auto-approves clean submissions under a threshold
- Generates a summary for the finance team

**Tools you'd register:**

- `GetExpensePolicy(category)` — returns the rules for that category
- `CheckPreApproval(employeeId, category)` — checks if pre-approval exists
- `FlagForReview(expenseId, reason)` — flags the expense
- `AutoApprove(expenseId)` — stamps it approved

**Why this works:**

- Everyone understands expense reports and hates manual review
- Shows the agent applying business rules with nuance — not just if/else, but _judgment_ (is "team dinner for 12 at $800" reasonable?)
- Clear tool use pattern

**Slight downside:** Expense policy rules might need a bit more setup to feel realistic.

---

### 3. On-Call Alert Enricher

**The app (before Copilot):** A service that receives monitoring/alerting events (think PagerDuty webhook — service name, alert type, error message).

**What Copilot adds:** An agent that enriches each alert before it reaches the on-call engineer:

- Looks up recent deployments to that service
- Checks if there are related alerts (is this part of a bigger incident?)
- Pulls the relevant runbook section
- Drafts an incident summary with suggested first steps

**Tools you'd register:**

- `GetRecentDeployments(serviceName)` — returns last 3 deploys
- `SearchRelatedAlerts(timeWindow, serviceGroup)` — finds correlated alerts
- `LookupRunbook(serviceName, alertType)` — returns runbook steps
- `CreateIncidentSummary(alertId, summary, suggestedAction)` — posts enriched alert

**Why this works:**

- DevOps and SRE folks LOVE this — it's a real pain point
- Shows the agent doing research across multiple tools before acting
- The "before" (raw alert) vs. "after" (enriched incident brief) is dramatic

**Slight downside:** Audience needs some familiarity with on-call workflows. Less universal than support tickets.

---

### 4. Customer Feedback Analyzer (Cron Job Style)

**The app (before Copilot):** A scheduled job that reads new customer feedback from a queue (app reviews, NPS responses, survey comments).

**What Copilot adds:** An agent that processes each piece of feedback:

- Classifies sentiment (positive/negative/neutral)
- Extracts specific feature/product mentions
- Identifies churn risk signals
- Routes critical feedback to the right product team

**Tools you'd register:**

- `GetCustomerSegment(customerId)` — enterprise vs. SMB vs. free
- `LookupProductArea(featureMention)` — maps feature names to team
- `CreateAlert(teamName, feedbackId, riskLevel)` — notifies high-risk
- `TagFeedback(feedbackId, tags[])` — labels for analytics

**Why this works:**

- Simple input (text) → rich structured output
- Good example of a batch/cron pattern vs. the API pattern of #1
- Shows the agent extracting structured data, a very common enterprise need

---

## Comparison Matrix

| Criteria                    | Support Ticket ⭐      | Expense Report       | Alert Enricher         | Feedback Analyzer     |
| --------------------------- | ---------------------- | -------------------- | ---------------------- | --------------------- |
| **Universally relatable**   | ✅ High                | ✅ High              | ⚠️ Medium (DevOps)     | ✅ High               |
| **Before/after impact**     | ✅ Dramatic            | ✅ Good              | ✅ Dramatic            | ⚠️ Moderate           |
| **Tool use showcase**       | ✅ 3-4 tools           | ✅ 3-4 tools         | ✅ 4 tools             | ✅ 3-4 tools          |
| **Setup simplicity**        | ✅ Minimal             | ⚠️ Needs policy data | ⚠️ Needs alert format  | ✅ Minimal            |
| **Audience "I want this"**  | ✅ High                | ✅ High              | ✅ High (for DevOps)   | ⚠️ Medium             |
| **Demo clarity**            | ✅ Easy to follow      | ✅ Easy to follow    | ⚠️ More moving parts   | ✅ Easy to follow     |
| **Pattern transferability** | ✅ Any intake workflow | ✅ Any approval flow | ✅ Any enrichment flow | ✅ Any processing job |

---

## Recommendation

**Go with #1 — Support Ticket Triage.** It checks every box:

- **Every attendee** has seen support tickets, regardless of their company or stack.
- The demo flow is dead simple: POST a ticket → agent triages it → see the result. Easy to follow live.
- The tools are plain C# methods with clear names — you can show the code and everyone gets it.
- The "aha moment" is immediate: "I could do this for [our intake process / our bug reports / our sales leads]."
- It naturally shows the agent doing what LLMs are great at (understanding text, making judgment calls) while using tools for the business logic (SLA lookup, assignment) — which is exactly the pitch for the SDK.

**Demo narrative arc:**

1. Show the app: "Here's a basic ticket API. Tickets come in, sit in a list. Someone has to manually read and triage each one."
2. Add the Copilot SDK: Wire up the agent with 3-4 tools (5 minutes of code).
3. Submit a ticket live: "My billing is wrong and I'm on an Enterprise plan, this is blocking our deployment."
4. Show the agent's reasoning: It calls `GetCustomerHistory`, sees they're Enterprise, calls `LookupSLA`, determines P2, assigns to billing team, drafts a response.
5. Mic drop moment: "That took under 10 minutes to add to an existing app."

---

## Round 2: Ideas That Showcase Creative Analysis

The ideas above are solid but lean toward classification/routing — things you _could_ approximate with rules. The ideas below are specifically chosen because **you can't do them with if/else**. The LLM's ability to read, interpret, synthesize, and generate is the entire point.

---

### 5. Contract Clause Reviewer

**The app (before Copilot):** A service that receives incoming vendor/partner contracts (or key clauses extracted as text) for review before signing.

**What Copilot adds:** An agent that acts as a first-pass legal/procurement reviewer:

- Reads each clause and flags anything unusual, risky, or non-standard compared to your company's preferred terms
- Explains _why_ a clause is risky in plain English ("This indemnification clause is unusually broad — it covers indirect damages with no cap")
- Suggests alternative language
- Identifies missing clauses your company typically requires (e.g., data deletion on termination)

**Tools you'd register:**

- `GetStandardTerms(clauseType)` — returns your company's preferred language for that clause type
- `GetRiskThresholds()` — returns company policies (max liability caps, required insurance minimums, etc.)
- `FlagClause(clauseId, riskLevel, explanation, suggestedAlternative)` — marks a clause for human review
- `GenerateReviewSummary(contractId)` — produces executive summary of the full contract

**Why this requires creative analysis:**

- Understanding legal language requires interpretation, not pattern matching
- "Is this indemnification clause broader than normal?" is a judgment call an LLM excels at
- Generating alternative clause language is generative, not deterministic
- No rules engine can handle the variety of ways contracts express the same concept

**Audience reaction:** "We spend _days_ on contract review. Even a first pass would save us a fortune."

---

### 6. Sales Call Summary & Action Item Extractor

**The app (before Copilot):** A service that receives call transcripts (or meeting notes) from a CRM integration after a sales rep finishes a call.

**What Copilot adds:** An agent that reads the transcript and produces:

- A structured summary: what was discussed, customer's pain points, objections raised, competitor mentions
- Concrete next steps with owners (e.g., "Rep needs to send pricing by Friday," "Customer wants a reference call with someone in healthcare")
- Deal risk signals ("Customer mentioned they're also evaluating Competitor X," "Budget holder wasn't on the call")
- Updates to CRM fields based on what was discussed

**Tools you'd register:**

- `GetDealContext(dealId)` — returns CRM data for this opportunity (stage, value, previous notes)
- `UpdateDealFields(dealId, fields)` — updates CRM stage, next steps, competitor field
- `CreateFollowUpTask(ownerId, description, dueDate)` — creates a task in the CRM
- `FlagDealRisk(dealId, riskType, evidence)` — alerts the sales manager

**Why this requires creative analysis:**

- Extracting "the customer seemed hesitant about pricing" from a 30-minute transcript is _comprehension_, not keyword search
- Identifying that "we're talking to a few vendors" means competitor risk requires inference
- Generating a useful summary requires understanding what matters to sales teams
- Determining appropriate next steps requires understanding the sales context

**Audience reaction:** "Our reps never fill out their CRM notes. This would actually solve that."

---

### 7. Incident Post-Mortem Drafting Service

**The app (before Copilot):** A service connected to your incident management system that fires after an incident is resolved. It collects the timeline of events (alerts, Slack messages, deployment logs, status page updates).

**What Copilot adds:** An agent that drafts a post-mortem document:

- Synthesizes a coherent incident narrative from noisy, out-of-order data sources
- Identifies the likely root cause chain (deploy → config change → cascading failure)
- Distinguishes between contributing factors and symptoms
- Proposes action items categorized as "prevent recurrence," "improve detection," and "improve response"
- Writes the whole thing in the team's post-mortem template format

**Tools you'd register:**

- `GetIncidentTimeline(incidentId)` — returns timestamped events from multiple sources
- `GetServiceDependencyMap(serviceName)` — returns upstream/downstream services
- `GetRecentChanges(serviceName, timeWindow)` — returns deploys, config changes, infra changes
- `SavePostMortem(incidentId, document)` — saves the draft to your wiki/Confluence

**Why this requires creative analysis:**

- Turning a chaotic timeline of 50+ events into a coherent narrative is _storytelling_, not aggregation
- "Was the deploy the cause, or just correlated?" requires causal reasoning
- Proposing meaningful action items (not just "add more monitoring") requires understanding what actually went wrong
- Writing in a specific template tone/format is generative

**Audience reaction:** "Post-mortems are the thing everyone agrees we need but nobody wants to write."

---

### 8. Job Application Screening Service

**The app (before Copilot):** An HR/recruiting service that receives job applications (resume text + cover letter + job description they applied to).

**What Copilot adds:** An agent that does initial screening:

- Assesses fit against the job description — not just keyword matching, but understanding transferable experience ("5 years of React" isn't listed, but they built distributed systems at scale, which matters more for this role)
- Generates a strengths/gaps summary for the hiring manager
- Suggests tailored interview questions based on the candidate's specific background
- Flags potential concerns for the recruiter to verify (employment gaps, qualification claims that seem inconsistent)

**Tools you'd register:**

- `GetJobRequirements(jobId)` — returns the structured job description with must-have vs. nice-to-have
- `GetTeamContext(teamId)` — returns what the team currently looks like (seniority mix, tech stack, gaps)
- `ScoreCandidate(applicationId, fitSummary, strengthsGaps, suggestedQuestions)` — saves the screening
- `FlagForRecruiter(applicationId, concern)` — flags for human follow-up

**Why this requires creative analysis:**

- Understanding that "led a team of 8 engineers shipping a real-time data pipeline" maps to "senior distributed systems experience" is comprehension, not keyword matching
- Identifying transferable skills across different industries/titles requires inference
- Generating interview questions tailored to _this specific person's_ background is generative
- A rules engine would reject great candidates who don't use the exact right buzzwords

**Audience reaction:** "Our recruiters spend 80% of their time on the first screen. This is the obvious use case."

---

### 9. Internal Knowledge Base Q&A Service

**The app (before Copilot):** An internal service that employees hit when they have questions (HR policies, engineering standards, onboarding procedures). Currently returns search results from a wiki.

**What Copilot adds:** An agent that answers questions directly by:

- Searching across multiple internal knowledge sources and synthesizing a single answer
- Handling ambiguous questions ("What's our PTO policy?" → determines the employee's region/role and gives the right answer)
- Identifying when docs are contradictory or outdated and flagging for the content team
- Knowing when to say "I don't have enough info — here's who to contact"

**Tools you'd register:**

- `SearchWiki(query)` — returns relevant wiki pages
- `SearchPolicyDocs(query)` — returns relevant HR/legal policy documents
- `GetEmployeeContext(employeeId)` — returns region, role, tenure (affects which policies apply)
- `EscalateToHuman(question, reason)` — routes to the right team when the agent can't answer confidently

**Why this requires creative analysis:**

- "Can I work from another country for a month?" requires synthesizing travel policy + tax implications + visa rules + manager approval process — spread across 4 different documents
- Understanding _what the person is actually asking_ (not just matching keywords) is the whole point
- Generating a cohesive answer from multiple sources requires synthesis
- Knowing when you _don't know_ is a judgment call

**Audience reaction:** "We've been trying to build this with search for years. It's never good enough."

---

### 10. Code Review Comment Generator (For Non-AI Repos)

**The app (before Copilot):** A CI/CD webhook service that fires on new pull requests and receives the diff.

**What Copilot adds:** An agent that does a first-pass code review:

- Reviews the diff against your team's architectural standards and coding guidelines
- Identifies potential bugs, security issues, and performance concerns — with explanations of _why_, not just what
- Recognizes patterns ("This looks like you're reimplementing the retry logic we already have in `SharedLibrary.Resilience`")
- Suggests improvements with example code
- Summarizes the overall PR: what it does, risk level, areas needing closest human review

**Tools you'd register:**

- `GetTeamStandards(language)` — returns coding guidelines and architectural principles
- `GetRepoContext(repoName)` — returns key abstractions, shared libraries, patterns used in this repo
- `PostReviewComment(prId, filePath, lineNumber, comment)` — posts an inline comment
- `PostReviewSummary(prId, summary, riskLevel)` — posts the overall review summary

**Why this requires creative analysis:**

- "This function does too many things" is a judgment call, not a lint rule
- Recognizing that code duplicates existing shared library functionality requires understanding intent
- Explaining _why_ something is a problem in the context of _this codebase_ is comprehension + generation
- Suggesting idiomatic alternatives requires taste, not rules

**Audience reaction:** "Half our review comments are the same things over and over. This would let reviewers focus on the hard stuff."

---

## Updated Comparison Matrix (All 10 Ideas)

| Criteria                        | 5. Contract Review       | 6. Sales Call        | 7. Post-Mortem         | 8. Job Screening    | 9. Knowledge Q&A  | 10. Code Review        |
| ------------------------------- | ------------------------ | -------------------- | ---------------------- | ------------------- | ----------------- | ---------------------- |
| **Universally relatable**       | ✅ High                  | ✅ High              | ⚠️ Medium (eng)        | ✅ High             | ✅ High           | ✅ High (dev audience) |
| **"Can't do with rules"**       | ✅ Very clear            | ✅ Very clear        | ✅ Very clear          | ✅ Very clear       | ✅ Very clear     | ✅ Very clear          |
| **Before/after impact**         | ✅ Dramatic              | ✅ Dramatic          | ✅ Dramatic            | ✅ Dramatic         | ✅ Dramatic       | ✅ Dramatic            |
| **Tool use showcase**           | ✅ 3-4 tools             | ✅ 3-4 tools         | ✅ 3-4 tools           | ✅ 3-4 tools        | ✅ 3-4 tools      | ✅ 3-4 tools           |
| **Setup simplicity**            | ⚠️ Needs sample contract | ✅ Just a transcript | ⚠️ Needs timeline data | ✅ Resume + JD text | ✅ Minimal        | ✅ Just a diff         |
| **Demo clarity**                | ✅ Easy to follow        | ✅ Easy to follow    | ⚠️ More data setup     | ✅ Easy to follow   | ✅ Easy to follow | ✅ Easy to follow      |
| **Wow factor for dev audience** | ⚠️ Medium                | ✅ High              | ✅ High                | ✅ High             | ✅ High           | ✅ Very High           |

---

## Notes

- Whichever app you choose, have the "before" app pre-built and working. The 10 minutes should be spent only on adding the Copilot SDK integration.
- Consider having 2-3 different ticket examples ready for the demo: one obvious P1, one ambiguous one, one that requires customer context to triage correctly. This shows the agent's judgment, not just pattern matching.
- The tools should be intentionally simple (return hardcoded/in-memory data) so the audience focuses on the SDK integration, not your data layer.
- For the "creative analysis" ideas (#5-10), consider showing one example where the agent's reasoning is _surprising_ — where it catches something a human might miss or connects dots across multiple tool calls. That's the moment the audience goes from "neat" to "I need this."
