# Copilot SDK Demo App Ideas — v2 (Investigation/Analysis Focus)

**Generated:** 2026-02-26  
**Context:** Brainstorming demo apps for the 20-minute "Copilot SDK" talk. This round focuses on demos where the agent **investigates across data through tool calls** — tasks that aren't practical with plain prompting because the data is too large, too spread out, or requires iterative reasoning to navigate.

---

## What Makes These Different From v1

The v1 ideas (#1–10) mostly had the agent classifying or routing a single input. That's useful but leaves the audience thinking "couldn't I just paste that into ChatGPT?"

These ideas are built around the thing the SDK uniquely enables: **the agent decides what to look at next.** It calls a tool, reads the result, reasons, and calls another tool. That loop — tool → reason → tool — is what plain prompting can't do, and it's the SDK's killer feature.

---

## The Key Pattern

```
Trigger event arrives (deterministic)
    → Agent investigates by calling tools iteratively (nondeterministic)
    → Agent produces a conclusion/recommendation (nondeterministic)
    → App takes action on the conclusion (deterministic)
```

This is your "assembly line with a smart station" slide in action. The line is deterministic; one station makes judgment calls and gathers its own data.

---

## Ideas

### 1. Deployment Risk Assessor ⭐

**The app:** A CI/CD webhook service that fires when a PR is merged to main (or a deploy is triggered). Before the deploy goes out, the agent evaluates risk.

**What the agent does:**

- Calls `GetChangedFiles(prId)` — sees which files/services were modified
- Calls `GetServiceDependencyMap(serviceName)` — checks what downstream services could be affected
- Calls `GetRecentIncidents(serviceName, days: 30)` — checks if this service has been flaky lately
- Calls `GetDeployHistory(serviceName, count: 5)` — checks if there have been recent rollbacks
- Synthesizes all of this into a risk score (low/medium/high) and a plain-English explanation: "This PR changes the payment service's retry logic. The payment service had 2 incidents in the last 30 days and a rollback last Tuesday. Downstream services: invoice-generator, receipt-emailer. **Risk: High. Recommend deploying during low-traffic window with feature flag.**"

**Why this can't be done with plain prompting:**

- The agent needs to iteratively pull data from 4 different "systems" and reason across all of them
- You can't paste your entire deployment history, dependency graph, and incident log into a prompt
- The agent decides _which_ services to look up based on what changed — not a fixed query

**Tools (4):**

- `GetChangedFiles(prId)` → list of file paths
- `GetServiceDependencyMap(serviceName)` → list of downstream services
- `GetRecentIncidents(serviceName, days)` → incident summaries
- `GetDeployHistory(serviceName, count)` → recent deploys + outcomes

**Demo flow:**

1. Show the app: "We have a deploy pipeline. Right now, deploys just go out. YOLO."
2. Wire up the agent with 4 tools.
3. Simulate a PR merge. Show the agent calling tools one by one, building up context.
4. Show the risk assessment output. "That's a judgment call based on data from 4 systems. No rules engine can do that."

**Audience reaction:** Every dev who's been burned by a Friday deploy will feel this.

---

### 2. Production Error Investigator ⭐

**The app:** A background service that receives error/exception events from production (think: an exception tracker webhook — stack trace, service name, timestamp, user context).

**What the agent does:**

- Calls `GetStackTrace(errorId)` — gets the full exception details
- Calls `GetRecentDeploys(serviceName, hours: 24)` — checks if something was deployed recently
- Calls `GetRelatedErrors(serviceName, timeWindow: "1h")` — checks if this is an isolated error or part of a spike
- Calls `GetServiceLogs(serviceName, timeWindow: "5m", aroundTimestamp)` — pulls surrounding log entries
- Calls `GetCodeSnippet(filePath, lineNumber)` — looks at the actual code where the error occurred
- Produces: "This NullReferenceException in OrderService.ProcessPayment (line 47) started 12 minutes ago. It correlates with deploy #382 (merged 45 min ago by @alice), which changed how nullable PaymentMethod is handled. 47 occurrences in the last hour, affecting enterprise-tier customers. **Likely cause: the new code path doesn't handle null PaymentMethod for legacy orders created before the migration.**"

**Why this can't be done with plain prompting:**

- You'd need to paste logs, stack traces, deploy history, code, and error counts into one prompt — impractical at scale
- The agent does what a senior engineer does: starts with the error, pulls threads, correlates, hypothesizes
- Each tool call informs the next — seeing a recent deploy makes the agent look at what changed

**Tools (5):**

- `GetStackTrace(errorId)` → exception details
- `GetRecentDeploys(serviceName, hours)` → deploy list
- `GetRelatedErrors(serviceName, timeWindow)` → error count + patterns
- `GetServiceLogs(serviceName, timeWindow, timestamp)` → log lines
- `GetCodeSnippet(filePath, lineNumber)` → source code around the error

**Demo flow:**

1. Show the app: "Errors come in, get logged. Someone on-call eventually looks at them."
2. Wire up 5 tools.
3. Fire an error event. Watch the agent pull the stack trace, notice a recent deploy, check the code, correlate with other errors.
4. Show the investigation report. "That's 15 minutes of senior engineer work done in 3 seconds."

**Audience reaction:** This is the demo where people pull out their phones to take a photo of the screen.

---

### 3. API Health Checker / Contract Drift Detector

**The app:** A scheduled service that runs periodically against your internal APIs to check for health and correctness.

**What the agent does:**

- Calls `GetRegisteredAPIs()` — gets the list of internal APIs
- Calls `GetAPISpec(apiName)` — fetches the OpenAPI/Swagger spec
- Calls `ProbeEndpoint(url, method, samplePayload)` — makes a real HTTP call and gets the response
- Compares the actual response shape against the spec
- Calls `GetLastKnownGoodResponse(apiName, endpoint)` — compares against a baseline
- Produces: "The /orders endpoint on OrderService is returning a 'discountCode' field that isn't in the spec (added since last Tuesday's deploy). The /users/{id} endpoint is returning 200 but the response body is missing the 'email' field that was there last week. **2 drift issues detected across 12 endpoints.**"

**Why this can't be done with plain prompting:**

- The agent needs to make live calls and compare results against specs — that requires tool execution
- Understanding whether a response shape "matches" a spec with optional/nullable fields requires judgment, not string comparison
- Identifying what drifted vs. what's intentionally changed requires context

**Tools (4):**

- `GetRegisteredAPIs()` → list of APIs
- `GetAPISpec(apiName)` → OpenAPI spec
- `ProbeEndpoint(url, method, payload)` → actual HTTP response
- `GetLastKnownGoodResponse(apiName, endpoint)` → baseline response

**Demo flow:**

1. Show the app: "We check our APIs are healthy. Currently that means... ping and hope."
2. Wire up tools. Fire the agent.
3. Show it probing endpoints, comparing against specs, finding drift.
4. "This catches the bugs that slip through because the API technically returns 200."

---

### 4. Dependency Vulnerability Triage

**The app:** A service that receives notifications from Dependabot/Snyk about new vulnerabilities in your dependencies.

**What the agent does:**

- Calls `GetVulnerabilityDetails(cveId)` — gets the CVE description, severity, attack vector
- Calls `GetDependencyUsage(packageName)` — finds which of your services use this package
- Calls `GetCodeUsage(serviceName, packageName)` — checks _how_ the package is used (does your code actually call the vulnerable function?)
- Calls `GetExposureContext(serviceName)` — is this service internet-facing? internal only? does it handle PII?
- Produces: "CVE-2026-1234 affects `json-parser` v2.3.1 (critical CVSS 9.1). Used by 3 services: UserAPI, ReportGenerator, InternalAdmin. **UserAPI is internet-facing and calls the vulnerable `parse()` function directly with user input — patch immediately.** ReportGenerator uses `parse()` but only on trusted internal data — medium priority. InternalAdmin imports the package but never calls the vulnerable function — low priority."

**Why this can't be done with plain prompting:**

- The agent needs to cross-reference a CVE with your actual codebase usage — can't paste all your code into a prompt
- Determining "does this code actually call the vulnerable function with untrusted input?" requires reading code + understanding the vulnerability
- Prioritization requires combining external threat data with internal architecture knowledge

**Tools (4):**

- `GetVulnerabilityDetails(cveId)` → CVE info
- `GetDependencyUsage(packageName)` → which services use it
- `GetCodeUsage(serviceName, packageName)` → how it's used in code
- `GetExposureContext(serviceName)` → is it internet-facing, PII, etc.

**Demo flow:**

1. "Dependabot says we have a critical vulnerability. Along with our 300 other open alerts."
2. Wire up tools. Feed in a CVE notification.
3. Agent traces from CVE → packages → services → code → exposure. Produces prioritized action plan.
4. "It just did what your security team does in a 2-hour meeting — in 5 seconds."

---

### 5. Database Query Performance Analyzer

**The app:** A monitoring service that receives slow query alerts (query text, execution time, table name, timestamp).

**What the agent does:**

- Calls `GetQueryPlan(queryText)` — gets the execution plan
- Calls `GetTableStats(tableName)` — row count, index info, last analyzed
- Calls `GetQueryFrequency(queryHash, hours: 24)` — how often this query runs
- Calls `GetRelatedSlowQueries(tableName, hours: 24)` — are other queries on this table also slow?
- Produces: "This query on `orders` table is doing a full table scan (2.3M rows) because the `WHERE customer_id = ?` predicate has no matching index. It runs 450 times/hour from OrderService. Two other queries on `orders` are also degrading — all started after last night's data migration added 800K rows. **Recommendation: Add index on `orders(customer_id)`. Expected improvement: table scan → index seek, ~200ms → ~3ms.**"

**Why this can't be done with plain prompting:**

- Needs live data: query plans, table statistics, query frequency — from your actual database
- The agent reasons about _why_ a query is slow by combining the plan with table context
- Correlating "other queries are also slow on this table" requires cross-referencing

**Tools (4):**

- `GetQueryPlan(queryText)` → execution plan
- `GetTableStats(tableName)` → table metadata + indexes
- `GetQueryFrequency(queryHash, hours)` → how often it runs
- `GetRelatedSlowQueries(tableName, hours)` → other slow queries on same table

---

### 6. Config Drift Detective

**The app:** A service that monitors application configuration across environments (dev, staging, prod) and fires when something seems off.

**What the agent does:**

- Calls `GetConfig(serviceName, environment)` for each environment
- Calls `GetRecentConfigChanges(serviceName, days: 7)` — what changed recently
- Calls `GetServiceHealth(serviceName, environment)` — is anything broken in that env?
- Cross-references and produces: "OrderService has `MAX_RETRY_COUNT=3` in prod but `MAX_RETRY_COUNT=10` in staging. This was changed in staging 3 days ago but never promoted. Staging also shows elevated timeout errors since the change. **The staging config change may be causing the timeout issues — 10 retries × 30s timeout = 5 min blocking. Recommend reverting staging to 3 before promoting to prod.**"

**Why this can't be done with plain prompting:**

- Agent compares configs across environments, notices drift, correlates with health data
- Determining whether drift is intentional or accidental requires contextual judgment
- Connecting "config Y changed" with "health metric Z degraded" requires multi-source reasoning

**Tools (3):**

- `GetConfig(serviceName, environment)` → config key-value pairs
- `GetRecentConfigChanges(serviceName, days)` → change audit log
- `GetServiceHealth(serviceName, environment)` → health metrics

---

## Comparison Matrix

| Criteria                     | 1. Deploy Risk   | 2. Error Investigator | 3. API Drift          | 4. Vuln Triage      | 5. Query Perf          | 6. Config Drift  |
| ---------------------------- | ---------------- | --------------------- | --------------------- | ------------------- | ---------------------- | ---------------- |
| **"Can't just prompt this"** | ✅ Very clear    | ✅ Very clear         | ✅ Clear              | ✅ Very clear       | ✅ Clear               | ✅ Clear         |
| **Iterative tool use**       | ✅ 4 calls       | ✅ 5 calls, chained   | ⚠️ 3-4, more parallel | ✅ 4 calls, chained | ✅ 4 calls             | ⚠️ 3 calls       |
| **Universally relatable**    | ✅ High          | ✅ Very high          | ⚠️ Medium (API teams) | ✅ High             | ⚠️ Medium (DB teams)   | ✅ High          |
| **Setup simplicity**         | ✅ Hardcode data | ✅ Hardcode data      | ⚠️ Needs mock APIs    | ✅ Hardcode data    | ⚠️ Needs mock DB stats | ✅ Hardcode data |
| **Demo wow factor**          | ✅ High          | ✅ Very high          | ✅ High               | ✅ High             | ✅ High                | ✅ Good          |
| **Audience "I need this"**   | ✅ High          | ✅ Very high          | ⚠️ Medium             | ✅ High (security)  | ⚠️ Medium              | ✅ High          |
| **Shows agent reasoning**    | ✅ Clear chain   | ✅ Best of the bunch  | ⚠️ Moderate           | ✅ Clear chain      | ✅ Clear               | ⚠️ Moderate      |

---

## Top Recommendations

### Best overall: **#2 — Production Error Investigator**

- Highest wow factor: the agent does what a senior engineer does during an incident
- Every dev has been woken up at 2 AM by an error alert — this is visceral
- The chained reasoning is the most visible: stack trace → "wait, there was a recent deploy" → "let me check the code" → "let me see if there's a pattern" → conclusion
- Easy to hardcode the tool responses for demo purposes
- The "before" is painfully relatable: "an error comes in, someone on-call opens 5 tabs and starts digging"
- The "after" is dramatic: the agent produces the investigation report in seconds

### Runner-up: **#1 — Deployment Risk Assessor**

- More universally relevant (everyone deploys, not everyone is on-call)
- Slightly simpler (4 tools vs. 5), cleaner for a time-constrained demo
- The risk score output is easy to show on one screen
- Great narrative: "Would you deploy this on a Friday? The agent can tell you why not."

### Best if audience skews security/platform: **#4 — Dependency Vulnerability Triage**

- "We have 300 Dependabot alerts" is a universal pain point
- The insight — "this CVE is critical, but your code doesn't actually call the vulnerable function" — is the kind of judgment that saves hours

---

## Notes

- All tools should return hardcoded/in-memory data for the demo. The point is the SDK wiring, not the data layer.
- For whichever idea you pick, prepare 2 inputs: one that produces a clear, actionable result, and one where the agent's reasoning is more nuanced (e.g., "this _looks_ risky but actually isn't because..."). The second one is what sells the audience.
- These ideas complement the v1 brainstorm — v1 is about classification/routing (the agent makes one decision), v2 is about investigation (the agent pulls threads). Pick based on what story you want to tell about the SDK.
