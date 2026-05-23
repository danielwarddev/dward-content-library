# How and Why to Get Started with Automated Testing in the Age of AI

**Generated:** April 8, 2026
**Format:** 1-hour talk with ~10-20 min coding demo (TypeScript/Vitest, GitHub Copilot)
**Audience:** Mixed — developers who test, developers who don't, managers evaluating testing investment
**Related:** [ai-unit-testing.md](ai-unit-testing.md) (existing focused talk), [ai-unit-testing-abstract-ideas.md](ai-unit-testing-abstract-ideas.md)

---

## Core Thesis

Testing is worth the investment even without AI. AI makes it dramatically easier to start. But AI can't replace good testing fundamentals — you still need to understand what good tests look like to get good results from AI.

---

## Outline

### Opening (~3 min)

- Hook: "Raise your hand if you've ever asked AI to write tests and gotten something you wouldn't trust in production." (Audience connection, establishes the problem space)
- The tension: AI is supposed to be great at repetitive, pattern-based tasks — tests should be its sweet spot. So why do so many developers distrust AI-generated tests?
- Preview the three acts: Why test → What AI does with tests → How to make AI + testing actually work

---

### Act 1: Why Automated Testing Still Matters (~12-15 min)

The goal of this section is to build the case for testing *independent of AI*. Important for the "we don't test" crowd and managers evaluating the investment.

#### 1a. The Data Case

**DORA Research (10+ years, 39,000+ professionals surveyed):**
- Test automation is a **core capability** in the DORA model, categorized under "Fast feedback." It is one of the capabilities that *predict* software delivery performance (the four key metrics: lead time, deploy frequency, change fail rate, recovery time), which in turn *predicts* organizational performance and well-being.
- DORA's research shows that automated testing drives: **improved software stability, reduced team burnout, and lower deployment pain.**
- Teams that rely on manual testing have bottlenecks: manual regression testing is time-consuming, unreliable (humans are poor at repetitive tasks), and creates long feedback cycles that make it harder for developers to learn to build quality code.
- DORA explicitly states: "Running tests continuously as part of a pipeline contributes to quick feedback for developers, a short lead time from check-in to release, and a low error rate in production environments. Developers have most of their work validated in **a matter of minutes, instead of days or weeks.**"
- Key DORA finding: When **developers** are primarily responsible for creating and maintaining automated tests, performance improves. When other groups own test automation, test suites are frequently broken and developers write code that's hard to test.
- Source: https://dora.dev/capabilities/test-automation/ — cite the DORA Accelerate State of DevOps Reports (2014-2024)

**The Accelerate Book (Forsgren, Humble, Kim):**
- The academic research behind DORA, published in *Accelerate* (2018), statistically proves that continuous delivery practices (including test automation) predict both software delivery performance AND organizational performance (profitability, market share, productivity).
- Key finding: "There is no tradeoff between speed and stability" — elite teams deploy more often AND have lower failure rates. Testing is a key enabler of this.

**Google Web Server Team case study (via Martin Fowler / Mike Bland):**
- The GWS team at Google was struggling to make changes to a C++ application serving Google's home page — fear of bugs was the barrier to velocity.
- After investing in unit testing: **"unit test coverage and development momentum went up, while defect, production rollback, and emergency release counts went down."**
- New team members became productive **far more quickly** because tests let them understand the system one unit at a time and detect unexpected side effects.
- Experienced developers who had grown cautious could make and accept changes quickly, no longer relying on expensive system/manual tests with feedback cycles of hours or days.
- Key quote: **"Over time, unit testing discipline allowed the team to move faster and do more. Unit tests are just as much about improving productivity as catching bugs."**
- This led to Google-wide adoption of a unit testing culture through the "Testing Grouplet" volunteer effort.
- Source: https://martinfowler.com/articles/testing-culture.html

**Shift-left economics (NIST / industry data):**
- The cost of detecting and fixing defects **increases exponentially** as software moves through development phases.
- Fixing bugs in production can be **up to 30x more expensive** than catching them during coding.
- NIST study (2002) estimated that software bugs cost the U.S. economy **$59.5 billion annually**, and that improved testing could reduce this by about a third.
- Kent Beck quote: *"Most defects end up costing more than it would have cost to prevent them. Defects are expensive when they occur, both the direct costs of fixing the defects and the indirect costs because of damaged relationships, lost business, and lost development time."*

**The "go slow to go fast" principle:**
- Teams that invest in testing move slower initially but dramatically faster over time. Teams that skip testing accumulate compound-interest technical debt.
- Mike Bland on Google's experience: Early on, "unit testing felt like a cost and some people worried that the time spent writing that second representation of behavior could be spent writing new code." But eventually, "as people experienced what it meant to cast aside the fear of change, they came to see this side-effect as easily outweighing those lines of code."
- The GWS Team's experience proves: **adding more developers actually allowed the team to move faster** — the opposite of the Brook's Law nightmare where adding people slows things down — because tests provided the safety net.

> **Audience interaction**: Show of hands — "How many of you are currently doing automated testing on your team?" Follow up: "Of those who aren't — what's the #1 reason?" (Captures the objections you'll address in 1c)

#### 1b. The Human Case

- **Tests as documentation**: A well-written test suite tells a new developer what the system is *supposed to do* more reliably than comments or docs. The Google experience confirms this: "existing tests will answer many questions that new contributors may have, saving your time and focus."
- **Tests as confidence**: Refactoring without tests is surgery without anesthesia. You *can* do it, but why would you? Google's GWS team found that the "mitigation of fear led to the expansion of their joy in programming" — they could make progress without being held back by chronic high-priority bugs.
- **Tests as communication**: Tests encode team decisions about expected behavior. They're a shared contract.
- **Tests as productivity**: "You can be more productive since you can iterate on code much quicker: You don't need to start up some heavyweight server if you can just run a unit test instead." — Running through a few tries takes minutes with a server, seconds with unit tests.

#### 1c. Common Objections (and Rebuttals)

| Objection | Rebuttal |
|---|---|
| "We don't have time to write tests" | You don't have time to manually verify every scenario on every deploy either |
| "The code changes too fast" | If your tests break with every change, you're testing implementation, not behavior |
| "Manual testing is enough" | Manual testing doesn't scale. You can run 500 unit tests in 2 seconds. |
| "Our codebase isn't testable" | This is real — and Act 3 addresses how AI can help make legacy code more testable |

#### 1d. Testing ROI Calculator (~2 min, visual)

Back-of-napkin math for managers and skeptics:

| Scenario | Without Tests | With Tests |
|---|---|---|
| Bug found in production | ~4-8 hours to triage, reproduce, fix, deploy hotfix | ~15 min (test catches it before merge) |
| Bugs per month (typical team) | 5-10 reach production | 1-2 reach production |
| Monthly cost of production bugs | 20-80 hours of firefighting | 2-4 hours |
| Dev onboarding time | Weeks of cautious exploration | Days (tests document expected behavior) |

"If your team ships 5 bugs to production per month at 4 hours each, that's 20 hours/month of reactive work. At a blended rate of $100/hour, that's $24,000/year — just in direct fix time, not counting customer impact, lost trust, or opportunity cost."

Key message: Testing isn't free, but not testing is more expensive. The question isn't "can we afford to test?" — it's "can we afford not to?"

#### 1e. The Testing Pyramid (Quick Visual)

- **Unit tests**: Fast, isolated, cheap. The foundation.
- **Integration tests**: Verify components work together. Database calls, API interactions.
- **E2E tests**: Simulate real user flows. Slowest, most brittle, but highest confidence for critical paths.
- Key point: You need all three layers, but the proportions matter.

> **Audience interaction**: Quick poll — "How would you describe your team's current testing?" (No tests / Some tests but inconsistent / Solid coverage / We TDD everything) — Note: this may be better placed as the opening of Act 1 rather than the end, to gauge the room early.

---

### Act 2: What AI Actually Does With Tests (~10-12 min)

The goal of this section is to name the specific failure modes so the audience recognizes them from their own experience.

#### 2a. The Promise

- Tests are repetitive, pattern-based, and formulaic — exactly the kind of work AI should excel at.
- AI can see your whole codebase and generate tests for patterns it recognizes.
- The pitch: "What if you could generate a full test suite for existing code in minutes?"

> **Audience interaction**: "For those of you who HAVE used AI to write tests — what went wrong? What surprised you?" (Take 2-3 responses from the audience. This primes them for the failure modes you're about to present and makes them feel seen.)

#### 2b. The Reality: Common AI Testing Failure Modes

Walk through each with a quick code example (slides, not demo):

1. **The Test Deleter**: "Fix this failing test" → AI deletes the test or comments out the assertion
2. **The Hardcoder**: AI generates tests with hardcoded expected values that happen to match current output — not actually verifying logic
3. **The Implementation Tester**: Tests that break when you refactor internals, even though behavior is unchanged (testing *how* not *what*)
4. **The Over-Mocker**: AI mocks so aggressively that the test only verifies the mocks
5. **The Happy Path Only**: AI generates tests for the obvious cases, misses edge cases and error handling
6. **The Coincidence Passer**: Tests that pass but don't actually assert anything meaningful

#### 2c. Why This Happens

- AI optimizes for "code that compiles and passes" — not "code that verifies behavior"
- Without clear context about *intent*, AI pattern-matches on structure but misses meaning
- Training data includes a lot of bad tests — AI has learned from our worst habits too
- The fundamental issue: **AI doesn't know what your code is supposed to do; it only knows what it currently does**

#### 2d. The Trust Gap

- If developers can't trust AI-generated tests, they stop using AI for testing entirely
- Worse: some teams accept faulty tests, building false confidence
- This is a solvable problem — which brings us to Act 3

---

### Act 3: Making AI + Testing Actually Work (~20-25 min including demo)

The goal of this section is to give concrete, actionable techniques the audience can apply immediately.

#### 3a. Code Patterns That Help AI Write Better Tests (~5 min, slides)

These are practices that are good regardless of AI — AI just makes them more obviously valuable.

- **Clear naming**: `calculateMonthlyPayment()` vs `calc()` — AI can infer what to test when names signal intent
- **Single Responsibility**: Functions that do one thing produce tests that test one thing
- **Pure functions where possible**: No side effects = trivially testable, AI or not
- **Behavior over implementation**: If your production code exposes clear inputs and outputs, AI tests verify behavior naturally

#### 3b. Test Structure That Constrains AI (~3 min, slides)

- **Arrange-Act-Assert**: Give AI this structure as a pattern and it follows it
- **One assertion per test** (or one logical concept): Prevents AI from writing kitchen-sink tests
- **Descriptive test names**: `it('returns 0 when cart is empty')` signals to AI what the assertion should be
- **Existing test examples**: AI copies the patterns in your codebase. If your existing tests are good, new AI tests will be too.

#### 3c. AI Features That Help (~5 min, slides + quick demo)

- **Custom instructions / Agent skills**: Encode your testing standards so AI follows them every time (show a `.github/copilot-instructions.md` or agent skill example)
- **Context feeding**: Pointing AI at existing tests, type definitions, and interfaces as reference
- **Test-first with AI**: Write the test first, then let AI implement the code to pass it — flips the script entirely
- **Chat-driven test generation**: Using Copilot Chat to say "generate tests for this file" with specific guidance

#### 3d. Coding Demo (~10-20 min, probably split across 3a-3c)

**Option A: Interwoven demo** (snippets between slides)
- Mini-demo 1 (after 2b): Show AI failing — give it a poorly-structured function, watch it produce bad tests (~3 min)
- Mini-demo 2 (after 3b): Same logic, better code structure — AI produces dramatically better tests (~5 min)
- Mini-demo 3 (after 3c): Use agent skills + Copilot agent mode to generate a full test suite for a small module (~5-7 min)

**Option B: Single longer demo block** (after 3c)
- Complete walkthrough: Start with untested code → show AI's first attempt → improve code patterns → show AI's second attempt → add agent skills → show AI's third attempt
- Narrative arc: "bad → better → great"

**Demo scenarios to consider:**
- A shopping cart or checkout calculation (relatable, has edge cases)
- An API response transformer (integration-testable)
- A form validation module (lots of test cases, good for showing AI generating many tests)

#### 3e. Testing Legacy Code With AI (~5-7 min)

This section pays off the "our codebase isn't testable" objection from Act 1.

- **Characterization tests**: AI can help you write tests that capture *current* behavior before you refactor. You don't need to know what the code is *supposed* to do — just document what it *actually* does right now. This creates a safety net for change.
- **AI as the fresh eyes**: AI is particularly good at generating tests for code *someone else wrote* — because it approaches the code without assumptions about intent. It asks the same questions a new team member would.
- **Refactoring toward testability**: AI can suggest extracting pure functions, reducing coupling, and breaking up god-classes. Ask it: "How would I refactor this function to make it easier to test?"
- **The strategy**: Don't stop to retrofit a comprehensive test suite for your whole legacy codebase. Instead: (1) write characterization tests for the code you're about to change, (2) require tests for all new code, (3) incrementally improve coverage over time. (This is exactly what DORA recommends for brownfield systems.)
- **Bridge to Google's story**: "Google didn't start with a testing culture either. They retrofitted it — and it worked. If Google can do it with millions of lines of C++, you can do it with your codebase."

> **Audience interaction**: "Who here works on a codebase that has little to no tests?" (Normalize it — this is extremely common and not shameful. Then frame this section as the path forward.)

#### 3f. Beyond Unit Tests: AI for Integration and E2E (~3-5 min)

- AI for integration test scaffolding: generating test setup, mock servers, database seeding
- AI for Playwright/E2E test generation: describe user flows in natural language → AI generates test scripts
- Where AI helps most at each layer of the pyramid (unit: volume; integration: boilerplate; E2E: translation from specs)

---

### Closing (~3-5 min)

#### Key Takeaways (The Three Things)

1. **Testing is worth the investment** — the data proves it, and the cost of not testing compounds over time
2. **AI makes it dramatically easier to start** — but only if you give it the right signals
3. **The fundamentals still matter** — good naming, clear structure, and testing behavior over implementation help both AI and humans

#### The Call to Action

- "Pick one untested module this week. Write one test by hand. Then ask AI to write five more."
- For managers: "Give your team permission to invest in testing. AI lowers the barrier, but someone has to walk through the door."

#### The AI Testing Maturity Model (Quick Visual)

A simple framework to help attendees self-assess and set goals:

| Level | Description | What It Looks Like |
|---|---|---|
| **0 — No Tests** | No automated testing at all | "We test manually before release" |
| **1 — Some Tests** | A few tests exist but aren't maintained or trusted | Flaky CI, tests often skipped |
| **2 — Consistent Testing** | Team writes tests as part of development | Good coverage, tests run in CI |
| **3 — AI-Assisted** | AI generates tests, developers review and refine | Using Copilot/similar for test generation, have testing guidelines |
| **4 — AI-First Testing** | AI generates tests proactively; testing workflow is AI-integrated | Agent skills encode standards, test-first with AI, AI catches gaps |

"Most teams are at Level 0-1. This talk gives you everything you need to get to Level 3. Level 4 is where we're headed."

> **Audience interaction**: "Based on what you've seen today, where does your team fall on this scale? Where do you want to be in 6 months?" (Closing reflection moment)

#### Resources slide

- Link to slides/repo
- DORA State of DevOps report (https://dora.dev/research/)
- DORA Test Automation capability page (https://dora.dev/capabilities/test-automation/)
- "Goto Fail, Heartbleed, and Unit Testing Culture" by Mike Bland (https://martinfowler.com/articles/testing-culture.html)
- *Accelerate* by Forsgren, Humble, Kim
- Copilot documentation on custom instructions / agent skills
- Any blog posts or follow-up content

---

## Timing Estimate

| Section | Minutes | Notes |
|---|---|---|
| Opening | 3 | |
| Act 1: Why Testing Matters | 15-18 | Research data + ROI calculator + audience poll |
| Act 2: What AI Does With Tests | 10-12 | Code examples on slides + audience input |
| Act 3: AI + Testing That Works | 25-30 | Includes demo + legacy code section |
| Closing (with maturity model) | 5-7 | Maturity model visual + call to action |
| **Total** | **58-67** | May need to trim; audience interaction adds natural flex time |

---

## Open Questions / Decisions

- [ ] Interwoven demo (Option A) vs single demo block (Option B)?
- [ ] Include the integration/E2E section (3f) or keep the demo focused on unit tests? (May need to cut for time now that legacy code section is promoted)
- [ ] Should the demo repo be public for attendees to reference after?
- [ ] How much overlap to keep with the existing "From Liability to Lifeline" talk? Could this be the "long version" and that be the "short version"?
- [ ] Which audience interaction moments to keep if running tight on time? (The Act 1 opener and Act 2 opener are highest-value)

---

## Additional Section Ideas (Didn't Make the Cut, But Worth Considering)

- **"What AI Can't Test"**: Briefly address the limits — AI can't test your *requirements*, only your *implementation*. If the requirements are wrong, perfect tests still ship the wrong thing. Keeps the talk honest.
- **Comparison of AI Tools for Testing**: Brief comparison of Copilot vs Cursor vs others for test generation. Probably too commercial / likely to go stale.

## Audience Interaction Summary

All interactions are designed for hand-raising / brief verbal input (no polling tool needed):

| When | Interaction | Purpose |
|---|---|---|
| Act 1 opener | "How many of you are currently doing automated testing?" + "What's the #1 reason you aren't?" | Gauge the room, surface objections early |
| End of Act 1 | "How would you describe your team's current testing?" (levels) | Self-assessment, transition to Act 2 |
| Act 2 opener | "For those who've used AI to write tests — what went wrong?" | Prime them for failure modes, make them feel seen |
| Act 3e (Legacy) | "Who works on a codebase with little to no tests?" | Normalize the situation, frame the path forward |
| Closing | "Where does your team fall on the maturity model? Where do you want to be?" | Reflection, commitment to action |

---

## Notes

This talk is a superset of the existing "From Liability to Lifeline" talk. Act 1 is entirely new — the existing talk assumes the audience already values testing. Acts 2 and 3 expand on the core material from the existing talk with broader scope (integration/E2E, not just unit) and a manager-friendly framing.

The three-act structure mirrors a classic persuasion arc: **Why should I care?** → **What's the current reality?** → **What should I do about it?**
