# How Developers Use AI in Testing: A Broad Survey

**Generated:** 2026-04-14  
**Context:** Research for a presentation on how developers are using AI across all testing levels (unit, integration, e2e). Language-agnostic, broad survey of patterns rather than deep dives.

---

## TL;DR

AI is reshaping testing workflows at every level — from generating unit tests to scaffolding e2e suites. The most effective patterns treat AI as a **drafting assistant** rather than an autonomous tester. Developers who get the best results provide strong context (requirements, examples, types) and maintain a tight human feedback loop. The riskiest anti-pattern is blindly accepting AI-generated tests, which creates a false sense of coverage without actually verifying behavior.

---

## 1. Unit Test Generation

### 1.1 The "Generate Tests for This" Pattern

The most common entry point. Developers highlight a function or class and ask the AI to generate tests. Every major tool supports this: Copilot's `/tests` command, Cursor's inline chat, Claude Code, Cline, etc.

**What works well:**
- Pure functions with clear inputs/outputs → AI produces high-quality test cases
- CRUD operations, serialization, validation logic
- Data transformation functions where AI can infer edge cases (empty arrays, null, boundary values)
- Repetitive test boilerplate (Arrange-Act-Assert scaffolding, test fixture setup)

**What doesn't work well:**
- Complex business logic with domain-specific rules the AI can't infer
- Tests for code with heavy side effects (database writes, API calls) — AI tends to mock incorrectly or over-mock
- AI often generates tests that pass trivially (testing that the mock returns what you told it to return)
- AI sometimes generates tests that reimplement the production code rather than testing behavior

### 1.2 TDD with AI (Red-Green-Refactor)

Source: Birgitta Böckeler & Paul Sobocinski, Thoughtworks (MartinFowler.com, 2023)

TDD is arguably **more** important with AI, not less — it provides the fast feedback loop needed to validate AI-generated code. The Thoughtworks team found:

**Red phase (write a failing test):**
- Write the test name yourself using Given-When-Then or descriptive naming → signals intent to the AI
- AI is good at completing test body once it sees the pattern from a name
- Provide context at the top of the test file: acceptance criteria, ASCII mockups, interface descriptions
- _Watch out:_ Copilot often tries to auto-complete multiple tests at once — these are usually low-quality; accept them selectively

**Green phase (make it pass):**
- AI excels here, especially when the test clearly specifies expected behavior
- The "delete and regenerate" technique is the most effective way to update implementation: delete the function body completely, let AI re-infer from the tests
- Works remarkably well because the test suite now serves as a specification

**Refactor phase:**
- AI is weakest here — refactoring requires taste, architectural judgment, and understanding of the broader system
- AI tends to make "safe" changes (rename, extract) but struggles with meaningful restructuring
- Developers report best results when they describe the desired structure and let AI do the mechanical work

### 1.3 Backfilling Tests (After-the-Fact)

When AI jumps ahead and writes implementation before tests, the "backfilling" pattern emerges:

1. Let AI generate the implementation
2. Ask AI to generate tests for the existing implementation
3. **Critically review** — these tests tend to be tautological (testing what the code does rather than what it should do)
4. Supplement with manually-written edge case tests

This is the most common real-world pattern because most developers don't follow strict TDD. The key risk: **AI generates tests that mirror the implementation's bugs**, creating a false green suite.

### 1.4 Edge Case Discovery

One of AI's strongest testing capabilities. Developers ask:
- "What edge cases am I missing for this function?"
- "What inputs could break this?"
- "Generate property-based test cases for this"

AI is surprisingly good at suggesting boundary conditions, off-by-one scenarios, empty/null inputs, Unicode edge cases, timezone issues, and concurrency gotchas that developers forget.

### 1.5 Test Refactoring and Maintenance

- Updating tests after signature changes or refactors
- Converting between testing frameworks (Jest → Vitest, NUnit → xUnit)
- Modernizing test syntax (e.g., moving from `should`-style to `expect`-style)
- Reducing duplication in test files via parameterized tests

---

## 2. Integration Test Generation

### 2.1 API Integration Tests

AI helps scaffold integration tests for HTTP APIs:
- Generating request/response fixtures from OpenAPI specs or example calls
- Creating test setups with in-memory databases or Docker containers
- Writing tests for authentication flows, pagination, error responses

**Key challenge:** AI often generates tests that rely on real external services instead of properly containerized/mocked dependencies. Developers must guide the test infrastructure choices.

### 2.2 Database Integration Tests

- AI can scaffold tests that seed data, run operations, and assert state
- Works best when given the schema and a couple example tests to follow
- Tends to struggle with transaction isolation and cleanup between tests

### 2.3 Message Queue / Event-Driven Tests

- AI can generate pub/sub test scaffolding but frequently gets timing/async wrong
- Developers report needing to heavily edit AI-generated async test code for proper awaiting, timeouts, and ordering assertions

---

## 3. End-to-End (E2E) Test Generation

### 3.1 Playwright / Cypress Test Scaffolding

AI is increasingly used to:
- Generate page object models from component source code
- Write user journey tests from natural language descriptions ("test that a user can sign up, verify email, and log in")
- Convert manual test scripts into automated Playwright/Cypress code

**What works:**
- Happy-path flows with clear UI elements
- Form validation tests
- Navigation and routing tests

**What struggles:**
- Complex multi-step workflows with conditional branching
- Tests involving file uploads, drag-and-drop, or canvas interactions
- Handling flaky selectors — AI often uses fragile CSS selectors instead of data-testid attributes
- Proper wait strategies (AI defaults to arbitrary timeouts instead of waiting for elements/network)

### 3.2 Visual Regression Testing

Emerging pattern: feeding screenshots or Figma designs to multimodal AI models and asking them to:
- Identify visual differences
- Generate visual regression test baselines
- Compare current vs. expected UI state

Still very early, but tools like Applitools are integrating AI for this.

### 3.3 AI-Powered Test Repair

When e2e tests break due to UI changes, AI can:
- Analyze the failure and suggest updated selectors
- Identify whether the failure is a real bug or a test maintenance issue
- Auto-suggest fixes for broken locators

---

## 4. Cross-Cutting Patterns

### 4.1 Test-as-Specification

The most powerful meta-pattern: using tests as the primary way to communicate intent to AI.

**How it works:**
1. Write detailed test names/descriptions
2. Include acceptance criteria as comments in test files
3. Let AI use the test suite as context for generating/modifying implementation

This turns the test suite into a "prompt" — and well-structured tests produce dramatically better AI-generated code. Developers who invest in test quality see compounding returns from AI assistance.

### 4.2 The Confidence Calibration Framework

From Birgitta Böckeler (Thoughtworks): Developers should constantly assess their confidence in AI-generated tests via:

- **Speed of feedback loop:** Can I verify this test works quickly? (Unit tests → fast, infra tests → slow)
- **Reliability of feedback loop:** Did I write the test, or did AI? If AI generated both test and implementation, confidence should be LOW
- **Margin of error:** Is this security-critical? Business-critical? If high stakes → extra scrutiny
- **Recency of the tech:** Is the framework/API recent enough that the AI's training data may be wrong?

Quote: _"GitHub Copilot is not a traditional code generator that gives you 100% what you need. But in 40-60% of situations, it can get you 40-80% of the way there."_

### 4.3 The "Timebox the AI" Pattern

Give the AI a mental timebox. If it can't produce a useful test in ~2 minutes of prompting, write it yourself. Developers report wasting significant time trying to coerce AI into correct complex test scenarios when hand-writing would have been faster.

### 4.4 AI for Test Infrastructure

Less discussed but highly effective:
- Generating Docker Compose files for test environments
- Writing CI pipeline configurations with proper test stage separation
- Creating test data factories and builders
- Scaffolding test utilities (custom matchers, assertion helpers)

### 4.5 Mutation Testing with AI

Emerging pattern:
- Use traditional mutation testing tools (Stryker, pitest) to identify surviving mutants
- Feed surviving mutants to AI and ask it to write tests that would catch them
- Creates a powerful feedback loop between automated analysis and AI generation

### 4.6 Contract Testing

AI can help generate:
- Consumer-driven contract tests from API specs
- Pact/PactFlow contract files
- Schema validation tests from example payloads

---

## 5. Where AI Testing Falls Short

### 5.1 The "Vibe Testing" Anti-Pattern

Term coined in parallel with "vibe coding" — accepting AI-generated tests without reviewing them, creating illusory coverage.

Signs of vibe testing:
- Tests that assert implementation details rather than behavior
- Tests where the assertion is trivially true
- Tests that mock everything, testing only the wiring
- 100% code coverage with zero meaningful assertions
- Tests that just confirm the code compiles and doesn't throw

### 5.2 Quality of Generated Code in Tests

From Erik Doernenburg (Thoughtworks, 2026):
- AI agents write code that "works" but introduce subtle quality issues
- Generated test code often uses non-idiomatic patterns
- AI tends to take "quick fix" approaches (e.g., using empty strings instead of proper null/optional handling)
- The "vibe fix" pattern: AI fixes a test failure in a way that compiles but misses the actual semantic issue

### 5.3 The "Test the Tests" Problem

Birgitta Böckeler's insight: _"If the AI generated the test(s), how confident am I in my ability to review the efficacy of those tests?"_

AI-generated tests need more review than AI-generated production code because:
- Bad production code fails visibly (crashes, wrong output)
- Bad test code fails invisibly (passes when it shouldn't, doesn't actually test what it claims)

### 5.4 On-Call Litmus Test

From Böckeler: _"If you were on call for the application you're working on, at which point would you be ok with deploying a 1,000 or 5,000 LOC change set?"_ She notes: _"For me personally, the minimum I want to still care about and be on top of is the test code."_

---

## 6. Practitioner Tips and Heuristics

| Tip | Source |
|-----|--------|
| Provide acceptance criteria as comments at the top of test files | Thoughtworks (TDD with Copilot) |
| Use Given-When-Then naming — AI reads it as a specification | Thoughtworks (TDD with Copilot) |
| Delete implementation and regenerate from tests when refactoring | Thoughtworks (TDD with Copilot) |
| Write one test, let AI generate the rest following your pattern | Widespread community pattern |
| Ask AI for edge cases AFTER writing your own core tests | Böckeler (unreliability memo) |
| If AI generates both code + tests, treat coverage as unverified | Böckeler (confidence framework) |
| Use AI for test boilerplate/fixtures, write assertions yourself | Common recommendation |
| Timebox AI interactions — if not helpful in 2 min, write manually | Böckeler (unreliability memo) |
| Have AI convert manual QA scripts into automated e2e tests | Emerging enterprise pattern |
| Pair humans with AI: one writes tests, other writes implementation | Variation on TDD + AI |

---

## 7. Tool Landscape (Mid-2026)

| Tool / Feature | Testing Capability |
|---|---|
| **GitHub Copilot** `/tests` | Inline test generation for highlighted code |
| **GitHub Copilot Agent Mode** | Full test file generation with project context |
| **Cursor** | Test generation with codebase-wide context |
| **Claude Code** | Strong at TDD workflows, test refactoring |
| **Cline / Roo Code** | Agent-based test generation with tool use |
| **Codium / Qodo** | Dedicated AI testing tool — generates meaningful tests with behavior analysis |
| **Diffblue Cover** | AI-powered unit test generation for Java (enterprise) |
| **CodiumAI PR Agent** | Generates test suggestions during PR review |
| **Stryker + AI** | Mutation testing combined with AI test generation |
| **Playwright + AI** | Emerging: AI-assisted e2e test creation from page snapshots |
| **Copilot Coding Agent** | Cloud-based agent that can run tests and iterate autonomously |

---

## 8. Key Themes for a Presentation

1. **AI makes TDD more valuable, not less** — Tests are the feedback loop that validates AI output
2. **The "test as spec" pattern** — Well-written tests are the best prompt for AI-generated code
3. **Confidence calibration is a new skill** — Developers must learn to assess when to trust AI tests
4. **Beware vibe testing** — Coverage numbers lie when tests are unreviewed
5. **AI is best at the boring parts** — Boilerplate, fixtures, repetitive assertions, edge case enumeration
6. **AI is worst at the judgment parts** — Test design, what to test, architectural test decisions
7. **The on-call litmus test** — Would you deploy this AI-generated change without reviewing the tests?
8. **Delete and regenerate > edit** — When using TDD with AI, regenerating from tests produces better code than incremental editing

---

## Sources

- Sobocinski, P. & Böckeler, B. (2023). "TDD with GitHub Copilot." MartinFowler.com — Exploring Gen AI series.
- Böckeler, B. (2023). "How to tackle unreliability of coding assistants." MartinFowler.com.
- Böckeler, B. (2025). "I still care about the code." MartinFowler.com.
- Doernenburg, E. (2026). "Assessing internal quality while coding with an agent." MartinFowler.com.
- Thoughtworks Technology Radar Vol. 33 (Nov 2025). Techniques: AI-assisted test-first development, curated shared instructions, pre-commit hooks.
- GitHub Blog (2024). "Using GitHub Copilot in your IDE: Tips, tricks, and best practices." Kedasha Kerr.
- Community patterns aggregated from dev.to, Hacker News, and practitioner reports (2024–2026).

---

## Notes

- This survey intentionally covers breadth over depth. Each section could be a standalone talk or blog post.
- The field is moving fast — tool capabilities from even 6 months ago may be outdated.
- Security-sensitive test generation (auth flows, encryption, access control) is an area where AI is particularly risky and warrants its own dedicated research.
- Consider interviewing attendees during the presentation about their own AI testing experiences — this topic benefits heavily from practitioner stories.
