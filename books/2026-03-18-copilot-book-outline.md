# Effective GitHub Copilot: Book Outline & Content Mapping

**Generated:** March 18, 2026
**Context:** Analysis of all Copilot content in this repository to determine what a book could look like, what existing content maps to which chapters, and what new material would be needed.

---

## The Pitch (One Paragraph)

Most developers use GitHub Copilot as a fancy autocomplete. The ones who go further often trust it too much, wasting hours debugging AI-generated code that looked right but wasn't. This book takes you from wherever you are to genuinely effective — not by teaching you Copilot's buttons, but by teaching you the mental models, patterns, and workflows that make AI-assisted development actually productive. Written by a Microsoft MVP with over a decade of development experience and a year of coaching enterprise teams on AI adoption, it's the book the official docs can't be: opinionated, practical, and honest about when Copilot fails.

---

## Your Existing Content Inventory

Here's every Copilot-related file in this repo and what it contains:

| File | Content Summary | Book Relevance |
|---|---|---|
| [presentations/copilot-gap.md](../presentations/copilot-gap.md) | Two traps, feature demos, Rumsfeld model, context engineering | Core thesis of the book |
| [presentations/todo-ideas/copilot-mastery.md](../presentations/todo-ideas/copilot-mastery.md) | 7-level progression from autocomplete to agent skills | Direct chapter structure |
| [presentations/copilot-sdk.md](../presentations/copilot-sdk.md) | SDK overview, building agents, why/when | SDK chapter |
| [presentations/copilot-sdk-60min-outline.md](../presentations/copilot-sdk-60min-outline.md) | Detailed 60-min talk: agents, tools, testing, production | SDK chapter deep content |
| [presentations/ai-unit-testing.md](../presentations/ai-unit-testing.md) | AI test generation patterns, guardrails, what fails | Testing chapter |
| [workshops/github-copilot/one-pager.md](../workshops/github-copilot/one-pager.md) | 6-week curriculum overview | Overall book progression |
| [workshops/github-copilot/copilot-workshop-plan.md](../workshops/github-copilot/copilot-workshop-plan.md) | Full-day structured plan with detailed blocks | Multiple chapters |
| [workshops/github-copilot/copilot-workshop-3hr-plan.md](../workshops/github-copilot/copilot-workshop-3hr-plan.md) | Compressed hands-on plan | Exercise ideas |
| [workshops/github-copilot/copilot-workshop-multi-week.md](../workshops/github-copilot/copilot-workshop-multi-week.md) | 12-session curriculum with homework | Chapter sequencing & exercises |
| [workshops/github-copilot/copilot-workshop-ideas.md](../workshops/github-copilot/copilot-workshop-ideas.md) | 14+ topic areas with demo ideas | Fills gaps in other content |
| [workshops/github-copilot/copilot-workshop.md](../workshops/github-copilot/copilot-workshop.md) | Raw topic list (features, tools, workflows) | Checklist of what to cover |
| [workshops/workshop-planning-2026.md](../workshops/workshop-planning-2026.md) | Full-day and 2-day workshop plans, abstracts | Workshop-depth content |
| [blog/content-posts/research/copilot-sdk-vs-agent-framework.md](../blog/content-posts/research/copilot-sdk-vs-agent-framework.md) | SDK vs Agent Framework decision framework | SDK chapter |
| [blog/brainstorms/2026-02-09-copilot-sdk-blog-post-project-ideas.md](../blog/brainstorms/2026-02-09-copilot-sdk-blog-post-project-ideas.md) | 12 real-world SDK project ideas | SDK chapter examples |
| [blog/content-posts/research/copilot-sdk-practical-examples.md](../blog/content-posts/research/copilot-sdk-practical-examples.md) | Production use cases for the SDK | SDK chapter |
| [blog/brainstorms/2026-03-12-copilot-book-market-research.md](../blog/brainstorms/2026-03-12-copilot-book-market-research.md) | Existing books, publishers, gap analysis | Positioning |
| [blog/brainstorms/2026-03-12-copilot-course-market-research.md](../blog/brainstorms/2026-03-12-copilot-course-market-research.md) | Existing courses, platform landscape | Positioning |
| [.github/skills/post-ideas/ideas-backlog.md](../.github/skills/post-ideas/ideas-backlog.md) | "Missing Copilot Manual for .NET Teams" series idea | Book concept validation |
| [presentations/copilot-sdk-60min-expansion-ideas.md](../presentations/copilot-sdk-60min-expansion-ideas.md) | Error handling, session persistence | SDK chapter |
| [presentations/todo-ideas/copilot-sdk-demo-app-ideas.md](../presentations/todo-ideas/copilot-sdk-demo-app-ideas.md) | Demo app ideas for SDK | SDK chapter |
| [blog/content-posts/research/copilot-sdk-embedded-ai-ideas.md](../blog/content-posts/research/copilot-sdk-embedded-ai-ideas.md) | Embedded AI use cases | SDK chapter |
| [blog/content-posts/research/copilot-sdk-code-wrapped-ai-workflows.md](../blog/content-posts/research/copilot-sdk-code-wrapped-ai-workflows.md) | Code-wrapped AI workflows | SDK chapter |

---

## Proposed Book Structure

### Organizing Principle

The book is organized around a **progression of autonomy**: from you doing the work with AI helping, to AI doing the work with you verifying. Each part builds on the last, but chapters within a part can be read independently as reference.

This makes it work both as a read-through (for someone going from zero to expert) and as a reference (for someone who wants to look up "how do I write good custom instructions?").

---

## Part I: Foundations (Chapters 1–4)

_What AI is, what Copilot is, and the mental model that makes everything else work._

### Chapter 1: The Two Traps

**Thesis:** Most developers fall into one of two traps — "fancy autocomplete" or "magic wand." Both waste time and leave productivity on the table.

- The autocomplete trap: accepting ghost text and never going deeper
- The magic wand trap: pasting entire requirements and expecting working code
- Studies on AI productivity: what the research actually says (increases speed AND decreases quality if used wrong)
- The Copilot Gap: honest overview of where AI helps and hurts
- What this book will teach you (and what it won't)

**Sources from repo:** copilot-gap.md (core thesis), copilot-mastery.md (opening framing), workshop abstracts (the "80% missing" framing)

**New content needed:** Research citations, expanded examples of both traps from coaching experience

---

### Chapter 2: How Copilot Actually Works

**Thesis:** Understanding the mechanics — even at a high level — makes you dramatically better at using the tool. When you know *why* Copilot behaves a certain way, you stop fighting it and start working with it.

**The architecture: where your code actually goes**
- The proxy server model: your request goes to GitHub's proxy, not directly to an LLM
- What information is sent with each request (context, file content, metadata)
- Privacy implications: what GitHub/Microsoft can and can't see
- Enterprise vs. personal: how data handling differs by plan
- Why this architecture matters for latency and behavior

**How LLMs work (enough to be useful)**
- What an LLM is (without the math): tokens, prediction, probabilities
- Why Copilot sometimes "hallucinates" and what that actually means
- The context window: Copilot's short-term memory
- Context rot: why long conversations go sideways and when to start fresh

**Tokens and premium requests**
- What tokens are and why they matter for context length
- The two budget types: completion tokens (always-on) vs. premium requests (agentic features)
- Which features consume which budget — and how to avoid surprises
- Copilot plans: Free, Pro, Pro+, Business, Enterprise — what actually differs
- Practical tips for making your budget go further

**Sources from repo:** workshop-plan.md Block 2, copilot-workshop-3hr-plan.md Block 2, copilot-workshop-multi-week.md Session 1, copilot-workshop-ideas.md #3 (Free plan limitations)

**New content needed:** Diagram of the proxy request flow, side-by-side plan comparison table, updated token/premium request limits, context window mechanics illustration

---

### Chapter 3: The Principles of Effective AI Use

**Thesis:** Before you pick up the tool, you need to understand how to *think* about AI. These five principles surface in every chapter — this is the one you'll keep coming back to.

- **Trust but verify**: Always review AI output. Never blindly accept generated code.
- **Work in small batches**: Give Copilot focused, scoped tasks. Don't ask it to build everything at once.
- **Verification loops**: After each AI-generated change, read it, test it, understand it before moving on. (Referenced directly in Chapter 7: Ask, Edit, and Agent Mode and Chapter 12: Research-Plan-Implement.)
- **Don't vibe code**: Be intentional. Know what you want before asking. Know what you got before committing.
- **AI is a tool, not a replacement**: You are the developer. Copilot assists.
- What it looks and feels like when you're working *with* AI vs. fighting it
- A note on how these principles appear throughout the rest of the book

**Sources from repo:** copilot-workshop-multi-week.md (Core Principles section, woven through every session), one-pager.md (Goals section), workshop-planning-2026.md (workshop learning outcomes)

**New content needed:** Concrete short illustrations of each principle being violated and then applied, sidebar summaries for cross-referencing, a "principles at a glance" reference card

---

### Chapter 4: Setting Up for Success

**Thesis:** A properly configured environment makes everything that follows easier.

- Installing and signing in to Copilot in VS Code
- The Copilot UI: chat panel, agent dropdown, model dropdown, participants, tools
- The Copilot button (bottom right) and what it controls
- VS Code settings that matter for Copilot (auto-allow, workspace trust, etc.)
- Your first conversation: verifying everything works
- Quick tour of what's ahead (preview of the progression)

**Sources from repo:** copilot-workshop-plan.md Block 1 & Block 3, copilot-workshop.md (UI tour items), copilot-workshop-3hr-plan.md Block 1

**New content needed:** Screenshots, settings.json examples, model selection guidance

---

## Part II: Core Skills (Chapters 5–8)

_The features and techniques that form the foundation of effective Copilot use._

### Chapter 5: Inline Completions — More Than Tab

**Thesis:** Ghost text is the feature everyone knows, but most people use poorly. Small technique changes yield big results.

- Tab to accept, Esc to dismiss, Ctrl+→ for partial accept
- Multi-line suggestions and when they appear
- Comments as prompts: writing a comment and watching the suggestion
- Cycling through alternative suggestions
- Snoozing completions when they're distracting
- When inline completions shine vs. when to switch to chat

**Sources from repo:** copilot-mastery.md Level 1, copilot-workshop-plan.md Block 3

**New content needed:** Side-by-side examples of good vs. bad comment-prompts, specific scenarios where inline is the right choice

---

### Chapter 6: Chat — Your Coding Partner

**Thesis:** Chat is the most underused and most powerful daily-driver feature. Learning to have good conversations with Copilot is the single highest-leverage skill.

- Chat panel: when to use it over inline
- Asking questions, getting explanations, debugging
- Slash commands: /explain, /fix, /tests, /doc — when each matters
- Editing your previous message (the "click to edit" trick)
- Chat history: managing and referencing past conversations
- Inline chat (Ctrl+I): quick edits without the panel
- The quality of output is proportional to the context you provide

**Sources from repo:** copilot-mastery.md Level 2, copilot-workshop-plan.md Block 3, copilot-workshop-ideas.md #5 (learning), #13 (debugging)

**New content needed:** Extended debugging walkthrough, practical "conversation recipes" for common tasks

---

### Chapter 7: Ask, Edit, and Agent Mode

**Thesis:** Choosing the right mode before you start is the difference between a 2-minute task and a 20-minute fight.

- **Ask mode**: questions, explanations, suggestions without changes
- **Edit mode**: targeted changes to specific files you choose
- **Agent mode**: autonomous multi-step tasks, can run commands and edit multiple files
- Decision framework: when to use which mode
- Same task in 3 modes: demonstrating the behavioral differences
- Working in small batches with Agent mode
- Verification loops: read, test, understand before moving on

**Sources from repo:** copilot-mastery.md (Chat Modes section), copilot-workshop-multi-week.md Sessions 5-6, copilot-workshop-plan.md Block 6, one-pager.md Week 3

**Cross-reference:** The verification loop principle from Chapter 3 is applied concretely here — this is where that concept gets hands-on.

**New content needed:** Extended decision flowchart, detailed agent-mode walkthrough, specific "batch size" guidance

---

### Chapter 8: Context Engineering

**Thesis:** This is the skill that makes everything else work better. Great prompts with wrong context produce bad results. Mediocre prompts with right context produce good results.

- What is context engineering? Deliberately shaping what Copilot knows
- Adding context: #file, #selection, #editor, dragging files
- @workspace: searching your entire codebase for context
- @terminal: command-line help and context
- @vscode: IDE settings and features
- @github: issues, PRs, repo information
- Managing the context window: what gets included automatically
- When too much context hurts
- The art of the follow-up: refining results iteratively
- Prompting techniques: specificity, few-shot examples, negative instructions, breaking complex requests into steps

**Sources from repo:** copilot-mastery.md (Context Engineering + Level 3), copilot-workshop-plan.md Blocks 4 & 5, copilot-workshop-multi-week.md Sessions 3-4, copilot-workshop-ideas.md #4 (prompting), one-pager.md Week 2

**New content needed:** Before/after examples showing context impact, prompt library for common tasks, real prompting failures and how to fix them

---

## Part III: Customization (Chapters 9–11)

_Making Copilot work YOUR way — for your project, your team, your standards._

### Chapter 9: Custom Instructions

**Thesis:** This is where Copilot stops being generic and becomes your assistant. The most underinvested feature in most setups.

- `.github/copilot-instructions.md`: project-wide instructions
- What to include: coding standards, preferred libraries, project terminology, things to avoid
- Multiple instruction files and how they layer
- Before/after: how custom instructions change output quality
- Writing effective instructions (not too vague, not too specific)
- Real-world instruction file examples

**Sources from repo:** copilot-mastery.md Level 4, copilot-workshop-plan.md Block 5, copilot-workshop-multi-week.md Session 4, copilot-workshop.md (instructions), one-pager.md Week 2

**New content needed:** Template/starter instruction files for different project types, detailed examples of instructions that work vs. don't

---

### Chapter 10: Custom Prompts, Agents, and Skills

**Thesis:** Reusable, composable instructions let you encode expertise that Copilot can apply automatically — turning one-off knowledge into repeatable capability.

- `.prompt.md` files: reusable prompt templates
- Custom agents: building specialized assistants for specific tasks
- Agent skills: the automation endgame
  - Skill structure: name, description, detailed instructions, file references
  - Automatic detection: how Copilot decides to use a skill
  - Building a skill library: code review, PR descriptions, test generation, documentation
- The Copilot debug view: seeing what's actually being sent
  - How to access it
  - Full system prompt visibility
  - How skills and MCP servers are detected
  - Token counts and context usage
  - Debugging why Copilot isn't behaving as expected

**Sources from repo:** copilot-mastery.md Levels 5-6 + Debug View, copilot-workshop-multi-week.md Session 8, copilot-workshop.md (prompts, agents, skills), one-pager.md Week 4

**New content needed:** Step-by-step skill creation walkthrough, real skill files from your own repo, debug view screenshots and interpretation guide

---

### Chapter 11: MCP Servers — Extending Copilot's Reach

**Thesis:** MCP lets Copilot interact with the outside world — databases, APIs, browsers, internal tools. It's how you make Copilot truly useful for your specific workflow.

- What is MCP (Model Context Protocol)?
- How MCP works: Copilot only loads name and description, decides when to use
- Built-in MCP servers: Playwright, GitHub, etc.
- Adding MCP servers in .vscode configuration
- Practical MCP servers worth knowing: file system, databases, browser automation
- Security considerations: what MCP servers can access
- Building your own simple MCP server (brief intro)

**Sources from repo:** copilot-mastery.md Level 5, copilot-workshop-multi-week.md Session 7, copilot-workshop-ideas.md #12, copilot-workshop.md, one-pager.md Week 4

**New content needed:** Step-by-step MCP setup, specific server recommendations, security model explanation

---

## Part IV: Real-World Workflows (Chapters 12–15)

_Putting it all together: how effective developers actually use Copilot day-to-day._

### Chapter 12: The Research-Plan-Implement Workflow

**Thesis:** The most productive pattern for non-trivial tasks: have Copilot research first, plan second, implement third. Never jump straight to code generation.

- Why "implement this feature" is the wrong first prompt
- Research phase: understanding the problem space with AI
- Plan phase: creating an implementation plan collaboratively
- Implement phase: executing the plan in small batches
- Spec-driven development: writing specs that AI follows
- Verification loops: how to check AI's work at each step

**Sources from repo:** copilot-workshop-multi-week.md Session 9, one-pager.md Week 5, copilot-workshop.md (RPI, Spec Kit)

**New content needed:** Complete end-to-end walkthrough of a real feature built with RPI, comparison of with/without this workflow

---

### Chapter 13: Test Generation That Actually Works

**Thesis:** AI is notorious for bad tests — deleting failing tests, hardcoding values, testing implementation details. But with the right patterns, AI becomes a genuine testing ally.

- What developers expect vs. what actually happens
- Why AI struggles with tests (and what to do about it)
- Code patterns that help AI: good naming, Arrange-Act-Assert, single responsibility
- Guardrails: "don't test implementation details, just the result"
- Agent skills for test generation
- Using existing tests as context/examples
- Test-first: writing the test, then having AI implement the production code
- Tests as guardrails for AI-generated code

**Sources from repo:** ai-unit-testing.md (core content), copilot-workshop-ideas.md #8 (TDD with Copilot), one-pager.md Week 5

**New content needed:** Extended examples across test types (unit, integration, e2e), specific prompts that produce good tests, before/after of bad AI tests fixed

---

### Chapter 14: Working With Unfamiliar Codebases

**Thesis:** One of Copilot's most underappreciated strengths is helping you learn and navigate code you didn't write.

- Using AI to explore and document an unfamiliar project
- @workspace for codebase-wide questions
- Generating documentation for undocumented code
- Adding characterization tests to legacy code
- Building an upgrade/migration plan with AI
- Refactoring with Copilot's help

**Sources from repo:** one-pager.md (workshop scenario: inherited legacy app), copilot-workshop-ideas.md #7 (existing codebases), copilot-workshop-multi-week.md Session 4 homework

**New content needed:** Full worked example with a real legacy codebase, specific question sequences that work well for exploration

---

### Chapter 15: The Copilot CLI

**Thesis:** Copilot isn't just an IDE feature — the CLI brings AI assistance to your terminal, CI/CD pipelines, and automation scripts.

- Installing and configuring Copilot CLI
- `gh copilot explain`: understanding commands
- `gh copilot suggest`: generating commands
- Piping output to Copilot
- Practical use cases: git commands, Docker, CI/CD, system administration
- Coding Agent: autonomous work on GitHub issues (overview)
- Copilot Code Review on PRs

**Sources from repo:** copilot-workshop-ideas.md #10 (terminal), copilot-workshop.md (Coding Agent, Code Review), copilot-workshop-multi-week.md Session 11

**New content needed:** CLI examples for common developer tasks, Coding Agent walkthrough, Code Review configuration

---

## Part V: Advanced Topics (Chapters 16–18)

_For developers who want to go deeper._

### Chapter 16: When NOT to Use AI

**Thesis:** Knowing when AI hurts is as important as knowing when it helps. This chapter is the "Copilot Gap" — the honest chapter no other book has.

- The Rumsfeld model applied to AI: Known knowns, known unknowns, unknown unknowns
- Tasks where AI consistently struggles
- Security risks: AI-generated code that looks correct but isn't secure
- The critical thinking problem: AI as a crutch
- Recognizing when you're fighting the tool
- Building judgment: guidelines for when to stop using AI and think

**Sources from repo:** copilot-gap.md (core content), copilot-workshop-ideas.md #1 (what AI can/can't do), copilot-workshop-ideas.md #6 (common mistakes)

**New content needed:** Specific failure scenarios with code, security examples, the "I should have done this myself" stories from coaching

---

### Chapter 17: Hooks and Agent Orchestration

**Thesis:** Advanced Copilot features let you automate complex, multi-step workflows and add safety guardrails to AI actions.

- Hooks: running code before/after Copilot actions
- Agent orchestration: coordinating complex AI workflows
- Subagents: delegating specialized tasks
- Safety patterns: automated checks on AI output
- Building a sustainable AI-augmented development workflow

**Sources from repo:** one-pager.md Week 6, copilot-workshop-multi-week.md Session 11, copilot-workshop.md (hooks)

**New content needed:** Most of this chapter — hooks are new, practical examples needed

---

### Chapter 18: Building With the Copilot SDK

**Thesis:** When you need Copilot's capabilities inside your own application, the SDK lets you embed AI without building from scratch.

- What the Copilot SDK is and when to use it
- SDK vs. just prompting: decision framework
- Building a simple agent from scratch (walkthrough)
- Tool design: naming, descriptions, rules of thumb
- Testing AI agents: deterministic vs. non-deterministic approaches
- Production considerations: latency, cost, guardrails, observability
- A real-world example: PR description generator or codebase onboarding assistant

**Sources from repo:** copilot-sdk.md, copilot-sdk-60min-outline.md, copilot-sdk-vs-agent-framework.md, copilot-sdk-blog-post-project-ideas.md, copilot-sdk-practical-examples.md

**New content needed:** Updated code examples (SDK is evolving), end-to-end project walkthrough

---

## Appendices

### Appendix A: Prompt Library
A reference collection of proven prompts organized by task: debugging, code review, refactoring, test generation, documentation, exploration.

### Appendix B: Custom Instructions Templates
Starter copilot-instructions.md files for different project types (web API, frontend app, CLI tool, etc.).

### Appendix C: VS Code Settings Reference
Every VS Code setting that affects Copilot behavior, with recommended values and explanations.

---

## Content Coverage Assessment

### Content already well-developed (60%+ exists)
- Chapter 1 (The Two Traps) — copilot-gap.md is strong
- Chapter 3 (AI Philosophy) — core principles documented throughout all workshop curricula
- Chapter 5 (Inline Completions) — workshop plans cover this
- Chapter 6 (Chat) — workshop plans + copilot-mastery.md
- Chapter 7 (Ask/Edit/Agent) — workshop plans + mastery talk
- Chapter 8 (Context Engineering) — copilot-mastery.md + workshops
- Chapter 9 (Custom Instructions) — workshops + mastery talk
- Chapter 10 (Custom Prompts/Skills) — copilot-mastery.md Level 6
- Chapter 13 (Test Generation) — ai-unit-testing.md
- Chapter 18 (SDK) — extensive SDK content

### Content partially developed (30-60% exists)
- Chapter 2 (How Copilot Works) — workshop primers exist; proxy server/architecture section needs new writing
- Chapter 4 (Setup) — workshop setup blocks exist
- Chapter 11 (MCP Servers) — covered in talks but needs expansion
- Chapter 12 (RPI Workflow) — mentioned in workshops, needs full treatment
- Chapter 14 (Unfamiliar Codebases) — workshop scenario exists, needs expansion
- Chapter 15 (Copilot CLI) — mentioned throughout, needs dedicated content
- Chapter 16 (When NOT to Use AI) — copilot-gap.md seeds this

### Content that needs significant new writing
- Chapter 17 (Hooks & Agent Orchestration) — mostly new
- Appendices — all new but compilable from existing content

---

## How This Differs From Existing Books

| This Book | Most Existing Books |
|---|---|
| Starts with *when AI fails* (honest) | Start with *look how cool AI is* (hype) |
| Patterns-first, features-as-needed | Feature tour / tutorial walkthrough |
| Written by someone who coaches teams daily | Written by authors who learned Copilot for the book |
| "When NOT to use AI" is a full chapter | Limitations get a paragraph in chapter 1 |
| IDE-focused but includes CLI and SDK | IDE only |
| Workflow-oriented (RPI, verification loops) | Task-oriented (generate code, write tests) |
| Custom instructions/skills as first-class content | Listed as "advanced feature" in an appendix |

---

## Next Steps

1. **Decide on code language** — TypeScript or C# — based on publisher interest and market research
2. **Read 2-3 existing books** to understand what's covered and find differentiation gaps
3. **Draft a publisher proposal** — Manning is the strongest lead (no dedicated Copilot book), but O'Reilly and Pragmatic Bookshelf are also gaps
4. **Write a sample chapter** — Chapter 1 (The Two Traps) or Chapter 7 (Context Engineering) would be the strongest showcase pieces
5. **Build the code examples repo** — A companion repository with all examples from the book

---

## Notes

- The 6-week workshop curriculum (one-pager.md) maps almost 1:1 to the book's part structure — this is a good sign that the progression is natural
- The multi-week workshop (copilot-workshop-multi-week.md) is the most detailed content and could almost be directly adapted into chapters
- The "Copilot Mastery" talk (copilot-mastery.md) has the full feature progression that forms the book's spine
- The market research shows Manning, Pragmatic Bookshelf, Pearson/Addison-Wesley, and Wiley all lack a dedicated Copilot book
- Your Microsoft MVP status and coaching experience are genuine differentiators vs. every existing author
