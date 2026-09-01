# GitHub Copilot Workshop: Multi-Week Paid Training Program

**Generated:** March 17, 2026
**Format:** 12 sessions + bonus capstone, 1.5 hours each
**Schedule:** 2 sessions/week over 6 weeks (see pacing options below)
**Delivery:** Remote (video calls) — see in-person notes where applicable
**Audience:** Beginners (assume no prior Copilot experience)
**Copilot Plan:** Copilot Business
**Prerequisites (sent 1 week before start):** Laptop with VS Code, GitHub account with Copilot Business license active, a language runtime (Node.js, .NET, or Python)

---

## Program Overview

### What Makes This Different from a One-Day Workshop

A multi-week format lets participants **practice between sessions**, **build muscle memory**, and **apply techniques to real work** before learning the next layer. Each session builds on the last, with homework that reinforces skills and prepares for the next topic. By the end, attendees aren't just aware of Copilot — they've been using it effectively for weeks.

### Core Principles (Woven Throughout Every Session)

These aren't one-off topics — they're recurring themes reinforced in every session:

1. **Trust but Verify** — Always review AI output. Never blindly accept.
2. **Work in Small Batches** — Give Copilot focused, scoped tasks. Don't ask it to build the whole thing at once.
3. **Verify Loops** — After each AI-generated change, read it, test it, understand it before moving on.
4. **Don't Vibe Code** — Be intentional. Know what you want before asking. Understand what you got back.
5. **AI is a Tool, Not a Replacement** — You are the developer. Copilot assists.

### Session Format (Every Session)

| Segment | Duration | Description |
|---------|----------|-------------|
| Recap & Homework Review | 10 min | Quick review of last session + share homework experiences |
| Teaching & Demo | 35 min | New concepts with live demonstrations |
| Guided Exercise | 25 min | Hands-on practice with instructor guidance |
| Independent Practice | 15 min | Attendees work on exercises independently |
| Wrap-up & Homework | 5 min | Key takeaways, homework assignment, preview next session |

---

## Pacing Options

| Option | Schedule | Total Duration | Best For |
|--------|----------|---------------|----------|
| **Standard (Recommended)** | 2x/week for 6 weeks + capstone | 7 weeks | Maximum retention, time to practice between sessions |
| **Accelerated** | 3x/week for 4 weeks + capstone | ~5 weeks | Teams that want faster completion |
| **Intensive** | Daily for 2.5 weeks + capstone | ~3 weeks | Boot-camp style, less practice time |

**Recommendation:** 2x/week (e.g., Tuesday/Thursday) gives the best balance. Attendees have time to practice, do homework, and absorb before the next session.

---

## Schedule at a Glance

| Week | Session | Title | Key Topics |
|------|---------|-------|------------|
| 1 | 1 | AI Foundations & Copilot Setup | What is AI/LLMs, setup, UI tour, first chat |
| 1 | 2 | Your First Day with Copilot | Inline completions, chat basics, code generation |
| 2 | 3 | Prompting That Actually Works | Prompt techniques, specificity, few-shot, iterative |
| 2 | 4 | Teaching Copilot About Your Project | Context windows, instructions, @workspace |
| 3 | 5 | Ask, Edit & Agent Modes | When to use each mode, multi-file edits |
| 3 | 6 | Agent Mode Mastery | Agent deep dive, small batches, verify loops |
| 4 | 7 | MCP Servers: Extending Copilot | What is MCP, setup, practical MCP servers |
| 4 | 8 | Custom Prompts, Agents & Skills | .prompt.md, custom agents, agent skills |
| 5 | 9 | RPI & Agent Orchestration | Research-Plan-Implement, orchestrating complex work |
| 5 | 10 | Responsible AI-Assisted Development | Not vibe coding, reviewing output, debugging |
| 6 | 11 | Enterprise Features & CLI | Copilot CLI, Coding Agent, Code Review, Hooks |
| 6 | 12 | Integration: Putting It All Together | Full workflow using all skills learned |
| Bonus | 13 | Capstone Project | Build a real project end-to-end (extended session) |

---

## Detailed Session Plans

---

### Week 1: Getting Started

---

#### Session 1: AI Foundations & Copilot Setup (90 min)

**Goals:** Everyone is set up, understands what AI is and isn't, and has talked to Copilot

| Topic | Time | Type | Notes |
|-------|------|------|-------|
| **Welcome & Program Overview** | 10 min | Presentation | |
| → Introductions + quick poll: AI experience | 5 min | | Show of hands or Zoom poll |
| → What we'll cover over 6 weeks | 3 min | | Set expectations for the journey |
| → Core principles introduction | 2 min | | Trust but verify, small batches, no vibe coding |
| **AI Fundamentals** | 25 min | Presentation | |
| → What is AI? What is an LLM? | 8 min | | High-level, use analogies |
| → Tokens, context windows, why they matter | 8 min | | "Context window is short-term memory" |
| → What Copilot can and can't do | 5 min | | Set realistic expectations |
| → Copilot Business features overview | 4 min | | What their plan includes |
| **Setup & Verification** | 15 min | Hands-on | |
| → Verify VS Code + Copilot extension | 7 min | | Troubleshoot any issues |
| → Sign in, verify Copilot Business license | 5 min | | Confirm everyone has access |
| → Smoke test: Ask Copilot a question | 3 min | | Everyone confirms it works |
| **Copilot UI Tour** | 20 min | Demo | |
| → Chat panel, sidebar location | 5 min | | |
| → Agent dropdown, model dropdown | 5 min | | Explain available models |
| → Participants, slash commands, tools | 5 min | | Quick flyover |
| → Copilot icon in bottom-right status bar | 3 min | | Settings, snoozing completions |
| → Chat history + editing previous messages | 2 min | | |
| **First Exercise** | 15 min | Hands-on | |
| → Ask Copilot to explain a code snippet (provided) | 7 min | | Give them a code block to paste |
| → Ask Copilot to write a simple function | 8 min | | "Write a function that..." |
| **Wrap-up** | 5 min | | |
| → Key takeaway: Copilot is a conversation partner | 2 min | | |
| → Homework assignment | 3 min | | |

**Homework:**
- Watch: [Short video on how LLMs work — TBD link] (10-15 min)
- Task: Ask Copilot 5 different questions about code you're curious about. Note which answers were helpful and which weren't.

**In-Person Note:** Setup issues are easier to resolve in-person. For remote, consider a 15-min optional "office hours" before Session 1 for setup help.

---

#### Session 2: Your First Day with Copilot (90 min)

**Goals:** Master inline completions and chat basics — the daily-driver features

| Topic | Time | Type | Notes |
|-------|------|------|-------|
| **Recap & Homework Review** | 10 min | Discussion | |
| → What surprised you about Copilot's answers? | 5 min | | |
| → Quick recap of AI fundamentals | 5 min | | |
| **Inline Completions** | 25 min | Mixed | |
| → Tab to accept, Esc to dismiss | 5 min | | Live demo |
| → Ghost text, multi-line suggestions | 5 min | | |
| → Comments as prompts | 5 min | | Write a comment, watch suggestion appear |
| → Snoozing completions | 2 min | | When they get in the way |
| → **Principle: Read Before You Accept** | 3 min | | First verify loop lesson |
| → Exercise: Generate 3 functions from comments | 5 min | | |
| **Chat for Code Generation** | 20 min | Mixed | |
| → Asking for code with context | 7 min | | "Write a function that takes X and returns Y" |
| → Code explanations ("Explain this code") | 5 min | | |
| → Applying chat suggestions to your code | 5 min | | Copy, insert, apply |
| → **Principle: Small Batches** | 3 min | | Ask for one thing at a time |
| **Guided Exercise: Build a Small Utility** | 25 min | Hands-on | |
| → Introduce sample project (provided repo) | 5 min | | Clone the starter repo |
| → Build a utility function using inline + chat | 15 min | | Step-by-step, instructor-guided |
| → Review: Did Copilot get it right? | 5 min | | Practice verify loop |
| **Independent Practice** | 5 min | Hands-on | |
| → Add another utility function on their own | 5 min | | |
| **Wrap-up** | 5 min | | |
| → Key takeaway: Copilot is best at focused tasks | 2 min | | |
| → Homework assignment | 3 min | | |

**Homework:**
- Task: In the sample project, add 2 more utility functions using only inline completions and chat. For each one, write down what you asked and whether you had to modify Copilot's output.

---

### Week 2: Prompting & Context

---

#### Session 3: Prompting That Actually Works (90 min)

**Goals:** Transform attendees from "can I get Copilot to do this?" to "I know how to ask for exactly what I need"

| Topic | Time | Type | Notes |
|-------|------|------|-------|
| **Recap & Homework Review** | 10 min | Discussion | |
| → Share: What did you modify in Copilot's output? | 5 min | | Reinforces verify loop |
| → Quick wins and frustrations | 5 min | | |
| **Why Prompting Matters** | 5 min | Presentation | |
| → Garbage in, garbage out | 3 min | | |
| → The prompt IS the skill | 2 min | | |
| **Prompting Techniques** | 30 min | Mixed | |
| → Specific vs vague (side-by-side demo) | 5 min | | Same task, different prompts |
| → Provide context: "I'm building a REST API that..." | 5 min | | |
| → Few-shot examples: Show input/output patterns | 5 min | | |
| → Ask for clarifying questions: "Before you start..." | 5 min | | Game-changer |
| → "Be honest with me" / flag uncertainty | 3 min | | |
| → Iterative refinement: "Close, but change X..." | 4 min | | Building on responses |
| → Asking for alternatives: "Give me 3 ways to..." | 3 min | | |
| **Prompt Battle Exercise** | 15 min | Hands-on | |
| → Same coding task given to everyone | 3 min | | Explain the challenge |
| → Attendees try different prompt approaches | 7 min | | |
| → Share results: What worked best? | 5 min | | Screen share or paste in chat |
| **Slash Commands Overview** | 5 min | Demo | |
| → `/explain`, `/fix`, `/tests`, `/doc` | 5 min | | Quick demo of each |
| **Independent Practice** | 15 min | Hands-on | |
| → Given a coding challenge, practice prompt patterns | 15 min | | Provide 2-3 challenges of varying difficulty |
| **Principle Reinforcement** | 5 min | Discussion | |
| → How prompting relates to "not vibe coding" | 3 min | | Intentional prompts = intentional code |
| → Homework assignment | 2 min | | |

**Homework:**
- Watch: [Video on prompt engineering for developers — TBD link] (10 min)
- Task: Take a feature in the sample project and implement it using at least 3 different prompting techniques. Document which approach gave the best result.

---

#### Session 4: Teaching Copilot About Your Project (90 min)

**Goals:** Understand context and make Copilot project-aware through instructions

| Topic | Time | Type | Notes |
|-------|------|------|-------|
| **Recap & Homework Review** | 10 min | Discussion | |
| → Which prompting technique worked best for you? | 5 min | | |
| → Lessons from prompt experimentation | 5 min | | |
| **Context Window Deep Dive** | 15 min | Presentation | |
| → What counts as context? (open files, chat history, instructions) | 5 min | | |
| → Context rot: why conversations "forget" | 5 min | | |
| → When to start a new conversation | 3 min | | |
| → **Principle: Fresh context = better results** | 2 min | | |
| **Copilot Instructions** | 25 min | Mixed | |
| → What are instruction files and why they matter | 5 min | | |
| → Root-level `.github/copilot-instructions.md` | 7 min | | Create one live in the sample project |
| → Multiple instruction files (sub-folder patterns) | 5 min | | |
| → What to put in instructions (coding standards, project context, conventions) | 5 min | | |
| → Exercise: Write instructions for the sample project | 3 min | | Start during session, finish as homework |
| **Using @workspace** | 10 min | Mixed | |
| → What it does (searches your codebase) | 3 min | | |
| → When to use it vs when it's overkill | 4 min | | |
| → Demo: Ask @workspace questions about the sample project | 3 min | | |
| **Guided Exercise** | 20 min | Hands-on | |
| → Write a `copilot-instructions.md` for the sample project | 10 min | | |
| → Test it: Ask Copilot something and see if instructions influence the answer | 5 min | | |
| → Iterate on instructions based on results | 5 min | | |
| **Wrap-up** | 5 min | | |
| → Key takeaway: Instructions are your long-term prompt | 2 min | | |
| → Homework assignment | 3 min | | |

**Homework:**
- Task: Refine your `copilot-instructions.md` — add at least 5 specific rules or conventions. Test each one by asking Copilot a relevant question.

---

### Week 3: Modes & Agent Mastery

---

#### Session 5: Ask, Edit & Agent Modes (90 min)

**Goals:** Know which mode to use for which situation

| Topic | Time | Type | Notes |
|-------|------|------|-------|
| **Recap & Homework Review** | 10 min | Discussion | |
| → Share your copilot-instructions.md — what worked? | 5 min | | |
| → Any surprising behaviors from instructions? | 5 min | | |
| **The Three Modes** | 10 min | Presentation | |
| → Overview: Ask, Edit, Agent — one slide summary | 5 min | | |
| → Decision framework: When to use which | 5 min | | Quick-reference chart |
| **Ask Mode** | 10 min | Demo | |
| → Best for: Questions, explanations, brainstorming | 3 min | | |
| → Demo: Explore unfamiliar code | 4 min | | |
| → Limitations: Can't modify files directly | 3 min | | |
| **Edit Mode** | 20 min | Mixed | |
| → Best for: Targeted, scoped changes | 3 min | | |
| → Single-file edits (live demo) | 5 min | | |
| → Multi-file editing workflow | 5 min | | |
| → Reviewing diffs: Accept/reject changes | 4 min | | |
| → **Principle: Review every diff** | 3 min | | Verify loop in action |
| **Agent Mode Introduction** | 15 min | Demo | |
| → Best for: Complex, multi-step tasks | 3 min | | |
| → How it differs: Autonomous, uses terminal, creates files | 5 min | | |
| → Quick demo: Scaffold a feature | 7 min | | Preview — deep dive next session |
| **Guided Exercise** | 15 min | Hands-on | |
| → Same task, three ways: Ask → Edit → Agent | 15 min | | Compare the experience |
| **Ctrl+I Inline Chat** | 5 min | Demo | |
| → Quick targeted edits without opening chat | 5 min | | |
| **Wrap-up** | 5 min | | |

**Homework:**
- Task: In the sample project, implement a small feature three times: once with Ask mode (copy-paste), once with Edit mode, once with Agent mode. Write a short note about which felt best and why.

---

#### Session 6: Agent Mode Mastery (90 min)

**Goals:** Use Agent mode effectively with discipline — small batches, verify loops, intentional prompts

| Topic | Time | Type | Notes |
|-------|------|------|-------|
| **Recap & Homework Review** | 10 min | Discussion | |
| → Which mode did you prefer? | 5 min | | |
| → Any Agent mode surprises (good or bad)? | 5 min | | |
| **Agent Mode Deep Dive** | 20 min | Demo | |
| → How Agent works under the hood | 5 min | | Tools, terminal access, file creation |
| → Live demo: Build a feature end-to-end | 10 min | | Narrate what Agent is doing and why |
| → When NOT to use Agent | 5 min | | Small changes, sensitive code, security-critical |
| **Working in Small Batches with Agent** | 15 min | Mixed | |
| → Why "build me this entire app" fails | 5 min | | Show a bad example |
| → Breaking work into scoped requests | 5 min | | "First, create the data model" → verify → "Now add the API endpoint" |
| → Demo: Same feature, big-bang vs small-batch | 5 min | | See the quality difference |
| **The Verify Loop** | 15 min | Mixed | |
| → What is a verify loop? | 3 min | | Request → Review → Test → Accept/Iterate |
| → Reading Agent's diffs carefully | 5 min | | What to look for |
| → Running and testing after each step | 4 min | | Don't stack 5 changes before testing |
| → **Principle: If you can't explain it, don't ship it** | 3 min | | |
| **Guided Exercise: Feature Build with Discipline** | 20 min | Hands-on | |
| → Instructor provides a feature spec | 3 min | | |
| → Build it with Agent mode in 3-4 small batches | 12 min | | Pause and verify between each |
| → Review: What did Agent get right/wrong? | 5 min | | |
| **Independent Practice** | 5 min | Hands-on | |
| → Start another feature using small-batch approach | 5 min | | |
| **Wrap-up** | 5 min | | |

**Homework:**
- Task: Implement a new feature in the sample project using Agent mode. Break it into at least 3 separate requests, verifying between each. Document the requests you made and what you had to fix.

---

### Week 4: Customization & Extensibility

---

#### Session 7: MCP Servers — Extending Copilot's Reach (90 min)

**Goals:** Understand MCP, set up servers, and use them in real workflows

| Topic | Time | Type | Notes |
|-------|------|------|-------|
| **Recap & Homework Review** | 10 min | Discussion | |
| → How did small-batch Agent mode go? | 5 min | | |
| → What did you have to fix after Agent? | 5 min | | |
| **What is MCP?** | 15 min | Presentation | |
| → Model Context Protocol explained ("plugins for Copilot") | 5 min | | |
| → How it works: name + description → Copilot decides when to use | 5 min | | |
| → MCP vs built-in tools | 3 min | | |
| → Security considerations | 2 min | | What gets sent where |
| **Setting Up MCP Servers** | 20 min | Mixed | |
| → `.vscode/mcp.json` configuration | 5 min | | Walk through the file format |
| → Adding your first MCP server (GitHub MCP) | 8 min | | Live setup + demo |
| → Verifying MCP servers are loaded | 3 min | | Check in VS Code |
| → VS Code settings for auto-allowing tools | 4 min | | Workspace-level trust |
| **Practical MCP Servers** | 15 min | Demo | |
| → Filesystem MCP | 4 min | | Reading/writing files outside workspace |
| → Database MCPs (Postgres, SQLite) | 4 min | | Query a database from chat |
| → Playwright MCP for browser automation | 4 min | | Web scraping, testing |
| → When MCP is overkill | 3 min | | Don't add servers you won't use |
| **Guided Exercise: Add & Use an MCP Server** | 20 min | Hands-on | |
| → Set up an MCP server in the sample project | 10 min | | Step-by-step with instructor |
| → Use it to complete a task Copilot couldn't do alone | 7 min | | |
| → Verify the results (verify loop!) | 3 min | | |
| **Independent Practice** | 5 min | Hands-on | |
| → Try another MCP server from a provided list | 5 min | | |
| **Wrap-up** | 5 min | | |

**Homework:**
- Watch: [Short video on MCP architecture — TBD link] (10 min)
- Task: Add at least one MCP server to the sample project and use it to accomplish something in chat. Note what worked and what didn't.

---

#### Session 8: Custom Prompts, Agents & Skills (90 min)

**Goals:** Create reusable customizations that make Copilot work the way your team works

| Topic | Time | Type | Notes |
|-------|------|------|-------|
| **Recap & Homework Review** | 10 min | Discussion | |
| → MCP server experiences | 5 min | | |
| → Any setup gotchas worth sharing? | 5 min | | |
| **Custom Prompts (.prompt.md)** | 20 min | Mixed | |
| → What are reusable prompt files? | 3 min | | |
| → Creating a `.prompt.md` file | 5 min | | Live demo |
| → Use cases: code review template, boilerplate generation, commit message style | 5 min | | |
| → Exercise: Create a custom prompt for a common team task | 7 min | | |
| **Custom Agents** | 20 min | Mixed | |
| → What are custom agents? | 3 min | | Specialized configurations for specific workflows |
| → Creating a custom agent | 7 min | | Live demo |
| → Agent configuration: instructions, tools, MCP access | 5 min | | |
| → When to create an agent vs use a prompt | 5 min | | Decision framework |
| **Agent Skills** | 20 min | Mixed | |
| → What are skills and why they exist | 5 min | | Domain-specific knowledge packages |
| → How skills work (description files, when they're invoked) | 5 min | | |
| → Creating a skill for the sample project | 7 min | | Live demo |
| → Best practices: When to use skills vs instructions vs prompts | 3 min | | Comparison chart |
| **Guided Exercise: Build Your Customization Stack** | 15 min | Hands-on | |
| → Create 1 custom prompt + 1 custom agent or skill | 12 min | | |
| → Test them with a real task | 3 min | | |
| **Wrap-up** | 5 min | | |

**Homework:**
- Task: Create at least 2 custom prompts and 1 custom agent or skill for the sample project. Test each one and refine based on results.

---

### Week 5: Advanced Workflows

---

#### Session 9: RPI & Agent Orchestration (90 min)

**Goals:** Learn the Research-Plan-Implement workflow and how to orchestrate multi-agent work

| Topic | Time | Type | Notes |
|-------|------|------|-------|
| **Recap & Homework Review** | 10 min | Discussion | |
| → Share a custom prompt or agent you created | 5 min | | |
| → What customizations felt most useful? | 5 min | | |
| **The RPI Workflow** | 25 min | Mixed | |
| → What is RPI? Research → Plan → Implement | 5 min | | |
| → **Research phase**: Ask Copilot to investigate before coding | 7 min | | "Research how authentication works in this project" |
| → **Plan phase**: Have Copilot create a plan before writing code | 7 min | | "Create a step-by-step plan for adding feature X" |
| → **Implement phase**: Execute the plan in small batches | 6 min | | Ties back to Week 3 principles |
| **Live Demo: RPI End-to-End** | 15 min | Demo | |
| → A non-trivial feature using full RPI cycle | 12 min | | Research → Plan → Verify plan → Implement in steps |
| → Highlighting where verify loops fit in | 3 min | | Between each phase transition |
| **Agent Orchestration** | 15 min | Mixed | |
| → What is agent orchestration? | 3 min | | Coordinating multiple agents/tools for complex tasks |
| → Chaining requests: Output of one step feeds the next | 5 min | | |
| → Using custom agents + MCP + instructions together | 5 min | | The full stack working in concert |
| → When orchestration helps vs overcomplicates | 2 min | | |
| **Guided Exercise: RPI a Feature** | 20 min | Hands-on | |
| → Instructor gives feature requirement | 3 min | | |
| → Research phase (5 min) → Review findings | 5 min | | |
| → Plan phase (5 min) → Review plan | 5 min | | |
| → Start implementation | 7 min | | Finish as homework |
| **Wrap-up** | 5 min | | |

**Homework:**
- Task: Complete the RPI feature implementation. Then pick a new feature and do the full RPI cycle on your own from scratch. Document each phase.

---

#### Session 10: Responsible AI-Assisted Development (90 min)

**Goals:** Build lasting habits for quality — the "how to use AI well" session

| Topic | Time | Type | Notes |
|-------|------|------|-------|
| **Recap & Homework Review** | 10 min | Discussion | |
| → How did the full RPI cycle feel? | 5 min | | |
| → Where did the plan vs reality diverge? | 5 min | | |
| **The Vibe Coding Problem** | 15 min | Presentation | |
| → What is vibe coding? (prompting blindly, accepting everything) | 5 min | | |
| → Real examples of vibe coding gone wrong | 5 min | | Security holes, wrong logic, tech debt |
| → The cost of AI-generated code you don't understand | 5 min | | Maintenance, debugging, ownership |
| **Building Review Habits** | 20 min | Mixed | |
| → How to read AI-generated diffs effectively | 5 min | | What to look for |
| → Common AI mistakes to watch for | 5 min | | Hallucinated APIs, outdated patterns, subtle logic errors |
| → Security awareness: AI and injection, secrets, auth | 5 min | | |
| → Testing AI output: When to write tests first | 5 min | | TDD with Copilot |
| **Debugging with Copilot** | 15 min | Mixed | |
| → Attaching error messages to chat | 5 min | | |
| → "Why is this failing?" workflows | 5 min | | |
| → Chat debug view for troubleshooting Copilot itself | 5 min | | When Copilot isn't working as expected |
| **Privacy & Security Considerations** | 5 min | Presentation | |
| → What gets sent to GitHub (Copilot Business policies) | 3 min | | |
| → Content exclusions for enterprise | 2 min | | |
| **Guided Exercise: Code Review Challenge** | 15 min | Hands-on | |
| → Provide AI-generated code with intentional issues | 5 min | | |
| → Attendees review and find the problems | 7 min | | Practice the verify loop |
| → Discuss findings as a group | 3 min | | |
| **Independent Practice** | 5 min | Hands-on | |
| → Generate code with Agent, then do a thorough review | 5 min | | |
| **Wrap-up** | 5 min | | |

**Homework:**
- Task: Generate a feature with Agent mode, then write a review of the code as if you were reviewing a colleague's PR. Note every issue you find. Practice the mindset of "I own this code."

---

### Week 6: Enterprise Features & Integration

---

#### Session 11: Enterprise Features & Developer Tools (90 min)

**Goals:** Explore CLI, Coding Agent, Code Review, Hooks, and other power features

| Topic | Time | Type | Notes |
|-------|------|------|-------|
| **Recap & Homework Review** | 10 min | Discussion | |
| → Share a finding from your code review homework | 5 min | | |
| → Most common AI mistakes found | 5 min | | |
| **Copilot CLI** | 15 min | Mixed | |
| → Installing `gh copilot` extension | 3 min | | |
| → `gh copilot explain` — understanding commands | 5 min | | |
| → `gh copilot suggest` — generating commands | 5 min | | |
| → Terminal integration in VS Code | 2 min | | |
| **Coding Agent (GitHub-side)** | 10 min | Demo | |
| → What it is: Async, runs as a PR | 3 min | | |
| → When to use it (issues, small tasks, low-stakes changes) | 4 min | | |
| → Demo or walkthrough | 3 min | | Show if available, screenshots otherwise |
| **Copilot Code Review on PRs** | 10 min | Demo | |
| → How it works automatically on PRs | 3 min | | |
| → What it catches vs what it misses | 4 min | | |
| → Integrating with team workflow | 3 min | | |
| **Hooks** | 10 min | Mixed | |
| → What are hooks? (Automating actions on Copilot output) | 3 min | | |
| → Practical examples: Auto-format, auto-lint, auto-test | 4 min | | |
| → Setting up a basic hook | 3 min | | |
| **Plan Mode** | 5 min | Demo | |
| → When to use Plan mode for complex changes | 3 min | | |
| → Quick demo | 2 min | | |
| **Guided Exercise: CLI + Enterprise Features** | 20 min | Hands-on | |
| → Use Copilot CLI to solve 3 terminal challenges | 10 min | | |
| → Set up a hook in the sample project | 5 min | | |
| → Explore one enterprise feature in depth | 5 min | | Attendee choice |
| **Independent Practice** | 5 min | Hands-on | |
| **Wrap-up** | 5 min | | Preview integration session |

**Homework:**
- Task: Write down your ideal Copilot workflow — which features, modes, MCP servers, prompts, and skills would you use day-to-day? Bring this to Session 12.

---

#### Session 12: Putting It All Together (90 min)

**Goals:** Integrate all skills into a complete workflow, demonstrate mastery

| Topic | Time | Type | Notes |
|-------|------|------|-------|
| **Recap & Workflow Discussion** | 15 min | Discussion | |
| → Share your ideal workflow from homework | 7 min | | |
| → Discussion: Common patterns and team workflow ideas | 8 min | | |
| **Complete Workflow Demo** | 20 min | Demo | |
| → Instructor builds a feature using the full stack | 15 min | | Instructions → RPI → Agent → MCP → Verify → Test |
| → Narrate decision points: "Here I chose Edit because..." | 5 min | | |
| **Integration Exercise** | 40 min | Hands-on | |
| → Feature spec provided | 5 min | | Non-trivial, requires multiple skills |
| → Attendees implement using any/all techniques learned | 30 min | | Instructor floats, assists |
| → Quick share: What approach did you take? | 5 min | | |
| **Program Retrospective** | 10 min | Discussion | |
| → What was most valuable? | 3 min | | |
| → What would you change? | 3 min | | |
| → What will you use daily? | 4 min | | |
| **Resources & Next Steps** | 5 min | Presentation | |
| → GitHub Copilot Docs | 1 min | | docs.github.com/en/copilot |
| → Copilot Business admin resources | 1 min | | For team leads |
| → awesome-copilot repo | 1 min | | |
| → Capstone details (if opted in) | 2 min | | |

**Homework (optional, for capstone participants):**
- Start thinking about your capstone project. Pick something relevant to your real work or a personal project. Come with a written feature spec.

---

### Bonus: Capstone Project Session (Extended)

---

#### Session 13: Capstone — Build Something Real (2.5–3 hours)

**Goals:** Apply everything learned to build a real project from scratch

**Note:** This session is longer — schedule it as a half-day or split into two back-to-back sessions.

| Topic | Time | Type | Notes |
|-------|------|------|-------|
| **Capstone Kickoff** | 15 min | Presentation | |
| → Review expectations | 5 min | | |
| → Share project ideas, get feedback | 10 min | | Ensure scope is appropriate |
| **RPI: Research & Plan** | 30 min | Hands-on | |
| → Research phase for capstone project | 15 min | | |
| → Plan phase: Create implementation plan | 15 min | | |
| **Build Phase 1: Foundation** | 40 min | Hands-on | |
| → Scaffold project with Agent mode | 15 min | | |
| → Core data model / structure | 15 min | | |
| → Checkpoint: Does it run? | 10 min | | |
| **Break** | 15 min | | |
| **Build Phase 2: Features** | 40 min | Hands-on | |
| → Add primary features using all techniques | 30 min | | |
| → Add tests | 10 min | | |
| **Build Phase 3: Polish** | 20 min | Hands-on | |
| → Error handling, edge cases | 10 min | | |
| → Documentation (README, comments) | 10 min | | |
| **Show & Tell** | 20 min | Presentation | |
| → Volunteers present what they built | 15 min | | Celebrate wins |
| → Group feedback and discussion | 5 min | | |
| **Certificates & Wrap-Up** | 10 min | Presentation | |
| → Final takeaways | 3 min | | |
| → Certificate of completion (if applicable) | 2 min | | |
| → Feedback survey | 5 min | | |

**In-Person Note:** Capstone works especially well in-person — the energy of building together and show-and-tell is hard to replicate remotely. For remote, use breakout rooms for small-group building and bring everyone back for show-and-tell.

---

## Capstone Project Options

### Option A: CLI Application (Beginner-Friendly)
- Task manager, file organizer, or data converter
- Exercises: code gen, testing, documentation, error handling

### Option B: REST API (Intermediate)
- Minimal API with 3-5 endpoints, validation, error handling
- Exercises: scaffolding, edit mode refinement, test generation

### Option C: Refactoring Challenge (Experienced)
- Provide a messy codebase; clean it up with Copilot
- Exercises: code understanding, systematic refactoring, test-first approach

### Option D: Your Own Project (Advanced)
- Bring a real project or idea from your work
- Must scope to something achievable in 2-3 hours
- Requires instructor approval of scope

---

## Sample Project Requirements

The provided sample project should be set up before Session 1 and have these characteristics:

- **Language-agnostic structure** (or provide versions in Node.js, .NET, and Python)
- **Simple but real**: A utility library, small API, or CLI tool
- **Pre-built foundation**: Project structure, basic config, 1-2 working features
- **Room to grow**: Clear places to add features, tests, docs
- **Intentional gaps**: Missing error handling, no tests, sparse docs — things Copilot can help with
- **Pre-configured `.github/copilot-instructions.md`**: A starter version attendees will improve
- **Pre-configured `.vscode/mcp.json`**: At least one MCP server ready to go (for Session 7)

---

## Pricing & Packaging Notes

### Suggested Packaging

| Package | Sessions | Includes | Notes |
|---------|----------|----------|-------|
| **Core Program** | Sessions 1-12 | 18 hours of instruction + homework | The main offering |
| **Core + Capstone** | Sessions 1-13 | 18 hrs + 2.5-3 hr capstone | Recommended upsell |
| **Essentials** | Sessions 1-6 only | 9 hours — foundations + modes | Budget option, covers the basics |

### Deliverables to Include

- [ ] Pre-configured sample project (Git repo)
- [ ] Session recordings (if remote — get permission)
- [ ] Slide decks / reference materials for each session
- [ ] Copilot cheat sheet (1-pager)
- [ ] Custom prompts & instructions templates
- [ ] Resource list with links
- [ ] Certificate of completion (optional)
- [ ] Post-program office hours (1 session, 2 weeks after completion — optional upsell)

### In-Person vs Remote Considerations

| Aspect | Remote | In-Person |
|--------|--------|-----------|
| Setup issues | Harder to debug — add pre-session office hours | Easier — walk to their desk |
| Engagement | Use polls, chat, breakout rooms | Natural interaction, easier to read the room |
| Hands-on help | Screen share, remote control | Look over shoulder, point at screen |
| Capstone energy | Lower — use breakout rooms | Higher — build together, show & tell works great |
| Recording | Easy — record Zoom/Teams | Need camera setup |
| Travel cost | None | Factor into pricing |
| Scheduling | More flexible | Requires room booking |

---

## Facilitator Prep Checklist

### Before Program Start
- [ ] Sample project built, tested, and pushed to a repo
- [ ] All demos tested on a clean machine
- [ ] MCP server setup process verified
- [ ] Homework assignments finalized with clear instructions
- [ ] Video links selected and tested for homework assignments
- [ ] Backup plan for internet/tool outages
- [ ] Attendee welcome email with prerequisites
- [ ] Communication channel set up (Slack, Teams, etc.) for between-session questions

### Before Each Session
- [ ] Review previous session's homework submissions (if collected)
- [ ] Test all demos for this session
- [ ] Prepare any new code/files needed
- [ ] Have backup examples ready in case demo fails

### After Each Session
- [ ] Send session summary + homework via email/Slack
- [ ] Note any topics that need more time or clarification
- [ ] Adjust pacing for next session if needed
