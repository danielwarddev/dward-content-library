# Workshop Planning 2026

**Created:** January 23, 2026
**Goal:** Submit workshops to Beer City Code (1-day) and NDC Oslo (2-day)

---

## 📅 Timeline & Strategy

| Conference         | Workshop Length      | Deadline     | Event Date      | Role              |
| ------------------ | -------------------- | ------------ | --------------- | ----------------- |
| **Beer City Code** | 5-7 hours (1 day)    | Mar 1, 2026  | Aug 14, 2026    | **Trial run**     |
| **NDC Oslo**       | 14-16 hours (2 days) | Feb 22, 2026 | Sep 14-15, 2026 | **Full workshop** |

**Strategy:** Use Beer City Code as your first workshop experience, then expand/refine for NDC Oslo one month later.

---

## 🧪 OPTION A: Testing Workshop

Your strongest option - builds on 4 existing talks you've delivered multiple times.

### Beer City Code Version (5-7 hours)

**Title:** "Confident .NET Testing: From Unit Tests to TestContainers"

**Schedule (6 hours + breaks):**

| Time        | Topic                                            | Source Talk                   |
| ----------- | ------------------------------------------------ | ----------------------------- |
| 9:00-9:30   | Intro & Environment Setup                        | —                             |
| 9:30-10:45  | xUnit Deep Dive: Theories, Fixtures, Parallelism | xunit-expanded                |
| 10:45-11:00 | ☕ Break                                         |                               |
| 11:00-12:00 | Effective Mocking with Moq/NSubstitute           | testing-your-tests-stryker    |
| 12:00-1:00  | 🍕 Lunch                                         |                               |
| 1:00-2:00   | Mutation Testing with Stryker                    | testing-your-tests-stryker    |
| 2:00-2:15   | ☕ Break                                         |                               |
| 2:15-3:45   | Integration Testing with TestContainers          | no-more-sqlite-testcontainers |
| 3:45-4:00   | ☕ Break                                         |                               |
| 4:00-4:45   | Capstone: Testing a Complete API                 | All combined                  |
| 4:45-5:00   | Wrap-up, Q&A, Resources                          |                               |

**Learning Outcomes:**

- Write parameterized tests with xUnit theories
- Apply effective mocking strategies
- Use mutation testing to find weak tests
- Replace SQLite with real databases in tests using TestContainers
- Build a testing strategy for microservices

**Prerequisites:**

- C# and .NET experience
- Basic unit testing knowledge
- Docker Desktop installed

---

### NDC Oslo Version (2 days, 14-16 hours)

**Title:** "Mastering .NET Testing: From Unit Tests to Contract Testing"

**Day 1: Unit Testing Mastery (7-8 hours)**

| Time        | Topic                                  |
| ----------- | -------------------------------------- |
| 9:00-9:30   | Intro, Goals, Environment Check        |
| 9:30-10:45  | xUnit Fundamentals & Advanced Patterns |
| 10:45-11:00 | ☕ Break                               |
| 11:00-12:30 | Hands-On: Refactoring Messy Tests      |
| 12:30-1:30  | 🍕 Lunch                               |
| 1:30-2:45   | Mocking Strategies (Moq & NSubstitute) |
| 2:45-3:00   | ☕ Break                               |
| 3:00-4:00   | Testing Async Code & IAsyncEnumerable  |
| 4:00-4:15   | ☕ Break                               |
| 4:15-5:15   | Mutation Testing with Stryker          |
| 5:15-5:30   | Day 1 Wrap-up                          |

**Day 2: Integration & Contract Testing (7-8 hours)**

| Time        | Topic                                          |
| ----------- | ---------------------------------------------- |
| 9:00-9:15   | Day 1 Recap & Questions                        |
| 9:15-10:30  | Why SQLite/In-Memory Databases Lie to You      |
| 10:30-10:45 | ☕ Break                                       |
| 10:45-12:00 | TestContainers Deep Dive                       |
| 12:00-1:00  | 🍕 Lunch                                       |
| 1:00-2:15   | Hands-On: Containerized Integration Tests      |
| 2:15-2:30   | ☕ Break                                       |
| 2:30-3:45   | Contract Testing with Pact                     |
| 3:45-4:00   | ☕ Break                                       |
| 4:00-5:00   | Capstone: Complete Test Suite for Microservice |
| 5:00-5:30   | CI/CD Integration, Resources, Q&A              |

**Additional NDC Content (vs Beer City):**

- +Testing async/IAsyncEnumerable patterns
- +Contract testing with Pact (full module)
- +CI/CD integration strategies
- +Extended hands-on time

---

## 🤖 OPTION B: AI/Copilot Workshop

Higher risk, higher reward. Hot topic but requires more prep.

### Beer City Code Version (5-7 hours)

**Title:** "Effective AI Coding: Mastering GitHub Copilot for Real Development"

**Schedule (6 hours + breaks):**

| Time        | Topic                                                  | Source      |
| ----------- | ------------------------------------------------------ | ----------- |
| 9:00-9:30   | Intro: AI Coding Landscape                             | copilot-gap |
| 9:30-10:45  | Copilot Features Deep Dive (completions, chat, inline) | copilot-gap |
| 10:45-11:00 | ☕ Break                                               |             |
| 11:00-12:00 | Prompt Engineering for Code                            | New content |
| 12:00-1:00  | 🍕 Lunch                                               |             |
| 1:00-2:00   | Hands-On: Test Generation & Refactoring with Copilot   | copilot-gap |
| 2:00-2:15   | ☕ Break                                               |             |
| 2:15-3:30   | Custom Instructions & Context Management               | New content |
| 3:30-3:45   | ☕ Break                                               |             |
| 3:45-4:30   | When NOT to Use AI (The Copilot Gap)                   | copilot-gap |
| 4:30-5:00   | Building AI-Augmented Habits, Q&A                      |             |

**Learning Outcomes:**

- Use all Copilot features effectively (not just autocomplete)
- Write prompts that generate useful code
- Configure custom instructions for your workflow
- Know when AI helps vs. when it hurts productivity
- Build sustainable AI-assisted development habits

**Prerequisites:**

- Active GitHub Copilot subscription
- VS Code or compatible IDE
- Comfortable with at least one programming language

---

### NDC Oslo Version (2 days, 14-16 hours)

**Title:** "From Copilot to Agents: Building AI-Powered Development Workflows"

**Day 1: Mastering AI Coding Assistants (7-8 hours)**

| Time        | Topic                                              |
| ----------- | -------------------------------------------------- |
| 9:00-9:30   | The AI Coding Revolution: What's Real, What's Hype |
| 9:30-10:45  | GitHub Copilot Deep Dive                           |
| 10:45-11:00 | ☕ Break                                           |
| 11:00-12:00 | Prompt Engineering for Developers                  |
| 12:00-1:00  | 🍕 Lunch                                           |
| 1:00-2:15   | Hands-On: AI-Assisted Feature Development          |
| 2:15-2:30   | ☕ Break                                           |
| 2:30-3:45   | Custom Instructions & Workspace Context            |
| 3:45-4:00   | ☕ Break                                           |
| 4:00-5:00   | The Copilot Gap: When AI Fails                     |
| 5:00-5:30   | Day 1 Wrap-up                                      |

**Day 2: Agentic Coding & AI Applications (7-8 hours)**

| Time        | Topic                                       |
| ----------- | ------------------------------------------- | ---------------------------------- |
| 9:00-9:15   | Day 1 Recap                                 |
| 9:15-10:30  | Copilot Agent Mode & Autonomous Coding      |
| 10:30-10:45 | ☕ Break                                    |
| 10:45-12:00 | Building with Microsoft Agent Framework     | ai-getting-started-agent-framework |
| 12:00-1:00  | 🍕 Lunch                                    |
| 1:00-2:15   | Hands-On: Building an AI-Powered Dev Tool   |
| 2:15-2:30   | ☕ Break                                    |
| 2:30-3:45   | RAG Patterns for Code Understanding         |
| 3:45-4:00   | ☕ Break                                    |
| 4:00-5:00   | Capstone: AI-Augmented Development Workflow |
| 5:00-5:30   | Future of AI Coding, Resources, Q&A         |

**Additional NDC Content (vs Beer City):**

- +Agent Mode deep dive
- +Microsoft Agent Framework hands-on
- +RAG patterns for codebases
- +Building AI dev tools

---

## ⚖️ Comparison: Which to Submit?

| Factor                       | Testing Workshop                        | AI/Copilot Workshop      |
| ---------------------------- | --------------------------------------- | ------------------------ |
| **Your Comfort Level**       | ⭐⭐⭐⭐⭐ High                         | ⭐⭐⭐ Medium            |
| **Content Readiness**        | 80% exists in talks                     | 40% exists in talks      |
| **Topic Demand**             | Steady, reliable                        | 🔥 Hot right now         |
| **Risk of Content Changing** | Low                                     | High (AI evolves fast)   |
| **Competition**              | Medium                                  | High (everyone doing AI) |
| **Differentiation**          | Unique combo (Stryker + TestContainers) | Need strong angle        |
| **Prep Time Needed**         | 40-60 hours                             | 80-100 hours             |
| **Reusability**              | Very high                               | Medium (needs updates)   |

---

## 🎯 My Recommendation

### Submit BOTH to Beer City Code!

Beer City Code lets you submit multiple sessions. Submit:

1. **Testing Workshop** (5-7 hours) - Your strongest bet
2. **AI/Copilot Workshop** (5-7 hours) - Higher risk, higher reward
3. **2-3 regular 50-min talks** - They want you to do 2 sessions anyway

Let them pick. If they choose Testing, great - you have maximum confidence. If they choose AI/Copilot, you'll be pushed to grow.

### For NDC Oslo

Submit whichever one you do at Beer City Code - you'll have refined it by September!

If Beer City Code picks Testing → Submit expanded Testing to NDC Oslo
If Beer City Code picks AI/Copilot → Submit expanded AI/Copilot to NDC Oslo
If neither → Still submit Testing to NDC Oslo (your strongest material)

---

## 📝 Draft Abstracts

### Testing Workshop Abstract (Beer City Code)

**Title:** Confident .NET Testing: From Unit Tests to TestContainers

**Abstract:**

Your test suite should give you confidence, not false hope. Yet many .NET teams discover their "passing" tests missed critical bugs—often because they're testing against SQLite or in-memory databases that behave nothing like production.

This hands-on workshop transforms how you approach testing in C#. We'll start with xUnit patterns most developers never learn—parameterized theories, fixture management, and parallel execution strategies. You'll master mocking with Moq and NSubstitute, learning when each approach shines.

Then we'll tackle a controversial question: are your tests actually testing anything? Using mutation testing with Stryker, we'll find the gaps in test suites that look comprehensive but aren't.

The afternoon focuses on integration testing done right. We'll explore why in-memory databases lie to you, then dive into TestContainers—spinning up real PostgreSQL and SQL Server instances in Docker for tests that match production behavior.

**You'll leave with:**

- Advanced xUnit patterns for cleaner, faster tests
- Mocking strategies that don't create brittle tests
- Stryker configured to find your test suite's blind spots
- TestContainers setup for realistic integration tests
- A testing strategy you can apply Monday morning

**Prerequisites:** C# experience, basic unit testing knowledge, Docker Desktop installed

---

### AI/Copilot Workshop Abstract (Beer City Code)

**Title:** Effective AI Coding: Mastering GitHub Copilot for Real Development

**Abstract:**

Everyone has Copilot. Few use it well. Most developers are still treating AI as fancy autocomplete, missing 80% of what it can do—while also trusting it for things it does poorly.

This workshop goes beyond the basics to make you genuinely productive with AI coding assistants. We'll explore every Copilot feature—completions, chat, inline edits, agents—with hands-on exercises that reveal when each approach works best.

You'll learn prompt engineering specifically for code: how to frame requests, provide context, and iterate on results. We'll build custom instructions that make Copilot understand your codebase and conventions.

But this isn't an AI hype session. We'll spend significant time on "The Copilot Gap"—tasks where AI assistants actively hurt productivity. Understanding these limitations is what separates effective AI users from those who waste hours debugging AI-generated code.

**You'll leave with:**

- Mastery of all Copilot features (not just autocomplete)
- Prompt engineering techniques for code generation
- Custom instructions configured for your workflow
- Clear mental model of when AI helps vs. hurts
- Sustainable AI-assisted development habits

**Prerequisites:** GitHub Copilot subscription, VS Code or compatible IDE, any programming language experience

---

---

## 🎤 50-Minute Talks for Beer City Code

Beer City Code wants out-of-town speakers to do **2 sessions**. Submit 3-4 talks alongside your workshops to maximize acceptance chances.

### Talk 1: The Copilot Gap (Pairs with AI Workshop)

**Title:** The Copilot Gap: What You're Missing With AI Coding Assistants

**Abstract:**

Many developers fall into two camps with GitHub Copilot: using it as fancy autocomplete or as a magic wand that should implement everything in a few prompts.

Both approaches leave productivity on the table. Studies show Copilot can increase productivity and lower frustration—but also that it can reduce critical thinking and produce less secure code. The difference isn't the tool; it's how you use it.

This session reveals the practical tooling most developers overlook in GitHub Copilot, demonstrates how to use these features effectively to get results you actually want, and—crucially—identifies when AI is the wrong tool for the job. You'll leave knowing how to stay on the productive side of AI assistance.

**Format:** 50 minutes | **Level:** All levels

---

### Talk 2: No More SQLite (Pairs with Testing Workshop)

**Title:** No More SQLite: How to Write Tests With EF Core Using TestContainers

**Abstract:**

Integration tests are crucial to ensuring your app's reliability. But traditional options for testing with EF Core—SQLite, in-memory providers, or shared dev databases—each introduce challenges with maintainability and confidence. Worse, they can secretly make tests pass with false positives, hiding bugs until they hit production.

This session introduces TestContainers, a library that solves these problems by spinning up real databases in Docker containers for each test run. After walking through common approaches and their pitfalls, I'll demonstrate with live coding how to implement TestContainers in real integration tests using EF Core.

While examples use C#, TestContainers supports 10+ languages, so the knowledge transfers to other ecosystems.

**Format:** 50 minutes | **Level:** Intermediate | **Prerequisites:** Basic unit/integration testing knowledge

---

### Talk 3: Testing Your Tests with Stryker (Pairs with Testing Workshop)

**Title:** Testing Your Tests: Mutation Testing in C# with Stryker

**Abstract:**

Testing your code is essential to creating quality software—but are you sure your tests are testing what you think they are?

A misleading test can be worse than no test at all. On the surface, it appears to protect your application, while actually giving false confidence and leaving code paths untested. Branches you assume work correctly may silently produce bugs, undiscovered until production data is damaged.

Mutation testing offers a solution. Without writing additional code, we can test our tests, uncovering blind spots that code coverage metrics miss entirely. This session demonstrates mutation testing in C# using Stryker, with live coding showing how the tool works and the insights it reveals.

**Format:** 50 minutes | **Level:** Intermediate

---

### Talk 4: Hearing and Being Heard (Soft Skills Variety)

**Title:** Hearing and Being Heard: Getting the Entire Team to Speak

**Abstract:**

Many of us have been on teams where the same few people speak every meeting, while others rarely say a word. Often, we fall into one of those categories ourselves.

This matters more than you might think. Teams where participation isn't equal miss critical information, make worse decisions, and burn out their most vocal members. But how do you fix it? Should quiet team members be required to speak? Called on directly? What if they truly have nothing to say?

Regardless of your role, this talk gives you practical actions to help your team feel psychologically safe and get the feedback, opinions, and concerns of all members—not just the loudest ones.

**Format:** 50 minutes | **Level:** All levels

---

## 📝 Refined Workshop Abstracts (Final Versions)

### Testing Workshop - Beer City Code (5-7 hours)

**Title:** Confident .NET Testing: From Unit Tests to TestContainers

**Abstract:**

Your test suite should give you confidence, not false hope. Yet many .NET teams discover their "passing" tests missed critical bugs—often because they're testing against SQLite or in-memory databases that behave nothing like production.

This hands-on workshop transforms how you approach testing in C#. We'll start with xUnit patterns most developers never learn: parameterized theories that eliminate repetitive test code, fixture management that speeds up test suites, and parallel execution strategies that cut CI time in half.

You'll master mocking with Moq and NSubstitute, learning patterns that make tests readable and maintainable rather than brittle.

Then we'll tackle a controversial question: are your tests actually testing anything? Using mutation testing with Stryker, we'll find the gaps in test suites that look comprehensive but aren't. Code coverage lies; mutation testing doesn't.

The afternoon focuses on integration testing done right. We'll explore exactly why in-memory databases give false confidence, then dive deep into TestContainers—spinning up real PostgreSQL and SQL Server instances in Docker for tests that behave like production.

By day's end, you'll have a complete testing strategy: unit tests that catch real bugs, mutation testing to verify test quality, and integration tests you can actually trust.

**What you'll learn:**

- Advanced xUnit patterns (theories, fixtures, parallelism)
- Effective mocking that doesn't create brittle tests
- Mutation testing with Stryker to find test blind spots
- TestContainers for production-realistic integration tests
- A testing strategy you can implement Monday morning

**Prerequisites:** C# and .NET experience, basic unit testing knowledge, Docker Desktop installed

**Duration:** 6 hours (including breaks)

---

### Testing Workshop - NDC Oslo (2 days, 14-16 hours)

**Title:** Mastering .NET Testing: From Unit Tests to Contract Testing

**Abstract:**

Most .NET teams write tests. Few write tests they actually trust. This two-day workshop changes that.

Day one builds your unit testing foundation properly. Beyond basic assertions, you'll master xUnit's advanced patterns: parameterized theories, collection fixtures, and parallel execution. We'll cover mocking strategies with both Moq and NSubstitute, including testing async patterns and IAsyncEnumerable. Then we'll challenge your entire test suite with mutation testing using Stryker—because code coverage metrics lie, but mutants don't.

Day two tackles the hard problems. We'll dissect why SQLite and in-memory databases give false confidence, then go deep on TestContainers—real databases running in Docker for each test. You'll build integration tests that catch the bugs your unit tests miss. Finally, we'll implement contract testing with Pact, validating service boundaries without brittle end-to-end tests.

You'll leave with a complete testing strategy: unit tests that catch real bugs, mutation testing to verify quality, integration tests you trust, and contracts that keep microservices compatible.

**What you'll learn:**

- Advanced xUnit patterns (theories, fixtures, parallelism)
- Mocking strategies with Moq and NSubstitute
- Testing async code and IAsyncEnumerable
- Mutation testing with Stryker
- TestContainers for realistic database tests
- Contract testing with Pact for microservices
- CI/CD integration strategies

**Prerequisites:** C# and .NET experience, basic unit testing knowledge, Docker Desktop installed

**Duration:** 2 days (~14-16 hours including breaks)

---

### AI/Copilot Workshop - Beer City Code (5-7 hours)

**Title:** Effective AI Coding: Mastering GitHub Copilot for Real Development

**Abstract:**

Everyone has Copilot. Few use it well.

Most developers treat AI as fancy autocomplete, missing 80% of what it can do—while simultaneously trusting it for things it does poorly. The result? Hours wasted debugging AI-generated code that looked right but wasn't.

This workshop makes you genuinely productive with AI coding assistants. We'll explore every Copilot feature: completions, chat, inline edits, and the new agent capabilities. Through hands-on exercises with real codebases, you'll discover when each approach works best.

You'll learn prompt engineering specifically for code: how to frame requests, provide context, and iterate toward working solutions. We'll build custom instructions that make Copilot understand your codebase, your conventions, and your preferences.

But this isn't an AI hype session. We'll spend significant time on "The Copilot Gap"—the tasks where AI assistants actively hurt productivity. Understanding these limitations separates developers who are genuinely faster from those who just feel faster.

**What you'll learn:**

- All Copilot features (not just autocomplete)
- Prompt engineering techniques for code generation
- Custom instructions for your workflow
- When AI helps vs. when it hurts productivity
- Sustainable AI-assisted development habits

**Prerequisites:** GitHub Copilot subscription, VS Code or compatible IDE, comfortable with at least one programming language

**Duration:** 6 hours (including breaks)

---

### AI/Copilot Workshop - NDC Oslo (2 days, 14-16 hours)

**Title:** From Copilot to Agents: Mastering AI-Powered Development

**Abstract:**

AI coding tools are evolving faster than developers can keep up. Copilot isn't just autocomplete anymore—it's chat, inline edits, agents, and autonomous coding. But most developers are still using 2023 techniques with 2026 tools.

This two-day workshop takes you from Copilot user to AI-augmented developer.

Day one builds your foundation. You'll master every Copilot feature through hands-on exercises, learn prompt engineering specifically for code, and build custom instructions that make AI understand your codebase. We'll also confront "The Copilot Gap"—tasks where AI hurts more than it helps—because knowing limitations matters as much as knowing capabilities.

Day two goes deeper. We'll explore Copilot's agent mode for autonomous multi-file changes, then build AI-powered development tools using Microsoft's Agent Framework. You'll implement RAG patterns for codebase understanding and create an AI assistant that actually knows your code. The capstone integrates everything into a sustainable AI-augmented development workflow.

You'll leave with both the skills to use today's tools effectively and the foundation to adapt as AI capabilities evolve.

**What you'll learn:**

- Complete GitHub Copilot mastery
- Prompt engineering for developers
- Custom instructions and workspace context
- The Copilot Gap: when AI fails
- Agent mode and autonomous coding
- Building with Microsoft Agent Framework
- RAG patterns for code understanding
- Sustainable AI-augmented workflows

**Prerequisites:** GitHub Copilot subscription, VS Code, programming experience, basic familiarity with AI concepts helpful but not required

**Duration:** 2 days (~14-16 hours including breaks)

---

## ✅ Submission Checklist

### NDC Oslo Workshops (Deadline: Feb 22, 2026)

- [ ] Submit: **Mastering .NET Testing** (2-day workshop)
- [ ] Submit: **From Copilot to Agents** (2-day workshop)
- [ ] Include speaker bio and past speaking experience (mention NDC Oslo 2024!)
- [ ] Add links to videos/slides from previous talks

### Beer City Code (Deadline: Mar 1, 2026)

- [ ] Submit: **Confident .NET Testing** (5-7 hour workshop)
- [ ] Submit: **Effective AI Coding** (5-7 hour workshop)
- [ ] Submit: **The Copilot Gap** (50-min talk)
- [ ] Submit: **No More SQLite** (50-min talk)
- [ ] Submit: **Testing Your Tests with Stryker** (50-min talk)
- [ ] Submit: **Hearing and Being Heard** (50-min talk) - soft skills variety
- [ ] Include speaker bio
- [ ] Submit by Mar 1

### After Acceptance (if selected)

- [ ] Create detailed outline with timing
- [ ] Build exercise repository
- [ ] Develop slide deck for each module
- [ ] Create solutions for all exercises
- [ ] Dry run with colleagues or local meetup
- [ ] Prepare backup plans for common issues

---

## 📊 Summary: What to Submit

### NDC Oslo Workshops (by Feb 22)

| Submission             | Type           |
| ---------------------- | -------------- |
| Mastering .NET Testing | 2-day workshop |
| From Copilot to Agents | 2-day workshop |

### Beer City Code (by Mar 1)

| Submission                      | Type              |
| ------------------------------- | ----------------- |
| Confident .NET Testing          | 5-7 hour workshop |
| Effective AI Coding             | 5-7 hour workshop |
| The Copilot Gap                 | 50-min talk       |
| No More SQLite (TestContainers) | 50-min talk       |
| Testing Your Tests (Stryker)    | 50-min talk       |
| Hearing and Being Heard         | 50-min talk       |

**Total: 2 workshops + 4 talks** - They'll pick what they want, and you're covered whether they choose the testing or AI track!

---

_Document created: January 23, 2026_
_Last updated: January 23, 2026_
