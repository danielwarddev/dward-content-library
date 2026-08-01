# My notes

- Use context7 + maybe jira?
- Superwhisper?
- Maybe just demo jira/trello - needs api key to set up, too much trouble
- also github mcp server
- frontend-design skill? plugins?
- github mcp, fork the project and then have it review pr comments?
- use cloud agent for something?

# Final Decisions

These were the final decisions made based on the research below/

## Title

Zero to Hero with GitHub Copilot: What Works in Real Projects

## Abstract

Many developers either underuse GitHub Copilot, using it as a fancy autocomplete, or put too much trust into it, having it implement entire features without verifying its work. In this hands-on workshop, you'll learn how effective teams use GitHub Copilot for real results. Based on enterprise experience coaching teams on AI adoption, we'll cover GitHub Copilot's features, effective prompting techniques, and practical workflows for using AI reliably and productively. Bring your laptop and come ready to code!

## Bio

Daniel is a Microsoft .NET MVP and software consultant at Lean TECHniques. He helps teams deliver high-quality software while adopting modern practices such as effective CI/CD, automated testing, AI usage, and product management. With experience spanning multiple industries, including finance, retail, and agriculture, he has served as a technical coach, agile coach, and tech lead, with a primary background as a software developer.

# GitHub Copilot Workshop: 3-Hour Plan (Geeks && Tech Tuesdays) — v2

**Generated:** February 14, 2026
**Updated:** April 11, 2026
**Context:** Trimmed version of the full-day workshop for Geeks && Tech Tuesdays at Geekdom, San Antonio
**Audience:** Intermediate+ developers, most have AI coding tool experience (Cursor, Claude Code, Codex, Antigravity, etc.)
**Facilitator stack:** VS Code + GitHub CLI (attendees follow along in whatever they prefer)
**Free tier constraint:** Workshop fits within the free tier's 50 premium requests. Mention the budget and let attendees manage it themselves.
**Prerequisites (sent ahead):** Laptop with VS Code, GitHub account, Copilot extension installed, GitHub CLI installed, Node.js runtime

---

## Schedule Overview (3 Hours)

| Block | Topic                                    | Duration    | Type         |
| ----- | ---------------------------------------- | ----------- | ------------ |
| 1     | Setup, Plans & Copilot Experiences       | 15 min      | Mixed        |
| 2     | Feature Tour: What Makes Copilot Unique  | 30 min      | Demo         |
| 3     | Live Build Demo                          | 15 min      | Demo         |
| —     | **Break**                                | 10 min      | —            |
| 4     | Hands-On Build (Part 1)                  | 45 min      | Lab          |
| —     | **Break**                                | 10 min      | —            |
| 5     | GitHub Platform & CLI Features           | 10 min      | Demo         |
| 6     | Hands-On Build (Part 2)                  | 35 min      | Lab          |
| 7     | Wrap-Up & Resources                      | 10 min      | Presentation |
|       | **Total**                                | **180 min** |              |

**Time breakdown:**

| Category           | Time         |
| ------------------ | ------------ |
| Presentation/Demo  | ~70 min      |
| Hands-On Building  | ~90 min      |
| Breaks             | ~20 min      |

---

## Detailed Session Plans

---

### Block 1: Setup, Plans & Copilot Experiences (15 min)

**Goals:** Get everyone signed up & ready, establish the landscape of Copilot experiences

| Topic                                            | Time   | Notes                                                    |
| ------------------------------------------------ | ------ | -------------------------------------------------------- |
| Welcome, quick intros                            | 2 min  | Who you are, what you'll cover, "this is hands-on heavy" |
| Verify setup / sign-up time                      | 8 min  |                                                          |
| → GitHub account + Copilot Free plan             | 3 min  | Walk through sign-up for anyone who hasn't               |
| → Copilot VS Code extension installed            | 2 min  | Quick smoke test: "Ask Copilot something in chat"        |
| → GitHub CLI installed (`gh`)                    | 3 min  | `gh auth login`, verify `gh copilot` works               |
| **Copilot plan differences**                     | 2 min  | Free (50 premium/mo) vs Pro vs Enterprise — quick slide  |
| **The three Copilot experiences**                | 3 min  |                                                          |
| → VS Code (local agent) — today's main focus     | 1 min  | Where most people will work                              |
| → GitHub CLI (`gh copilot`) — a few CLI-only gems| 1 min  | We'll use this for rubber duck + explain/suggest         |
| → Cloud agent (on GitHub.com) — async, autonomous| 1 min  | Brief mention, demo later                                |

**Key framing:** "Most of you have used Cursor, Claude Code, or similar tools. This workshop isn't 'intro to AI coding' — it's about features and workflows that are unique to the Copilot ecosystem. We'll go fast on the basics and deep on what's different."

---

### Block 2: Feature Tour — What Makes Copilot Unique (30 min)

**Goals:** Speed tour of Copilot-specific features. Demo-heavy, fast-paced. Not teaching "what is AI chat" — showing what's *different* about Copilot.

| Topic                                              | Time   | Notes                                                        |
| -------------------------------------------------- | ------ | ------------------------------------------------------------ |
| **Quick UI Orientation**                           | 3 min  | Chat panel, model picker, agent mode — just enough to navigate |
| **Model Families**                                 | 3 min  |                                                              |
| → GPT-4o, Claude, o-series reasoning models, etc.  | 2 min  | Show the model picker, explain trade-offs (speed vs quality) |
| → Premium vs base models, 50-request budget        | 1 min  | "Pick your moments for premium"                              |
| **Agent Mode + Autopilot**                         | 5 min  |                                                              |
| → Agent mode basics (for those from other tools)    | 2 min  | Autonomous execution, terminal access, file creation         |
| → Autopilot mode / bypass approvals                | 3 min  | Demo: flip it on, show hands-free execution. When to use/not |
| **Fleet Mode**                                     | 3 min  |                                                              |
| → What it is: multi-model orchestration             | 1 min  | Quick explanation                                            |
| → Demo: show it dispatching to different models     | 2 min  | Show the UI indicators                                       |
| **Custom Instructions**                            | 5 min  |                                                              |
| → `.github/copilot-instructions.md`                | 2 min  | Create one live — "Use TypeScript, prefer functional style"  |
| → Instruction files with `applyTo` scoping          | 1 min  | "Instructions for tests only", "Instructions for API code"   |
| → Skills (`.prompt.md` files)                       | 2 min  | Show a reusable prompt template, briefly explain when to use |
| **Custom Agents (`.agent.md`)**                    | 2 min  |                                                              |
| → What they are: specialized personas/tool configs  | 1 min  | Show an example agent file                                   |
| → When to use vs. instructions vs. skills           | 1 min  | Quick decision tree                                          |
| **MCP Servers**                                    | 4 min  |                                                              |
| → What it is: "Plugins that give Copilot tools"     | 1 min  |                                                              |
| → Demo: wire up a server in `.vscode/mcp.json`      | 3 min  | Pick something visual — Playwright MCP or similar            |
| **Speed Round (quick demos)**                      | 5 min  |                                                              |
| → Vision: paste a screenshot into chat              | 2 min  | "Build this UI" from a mockup image                          |
| → Hooks: auto-actions on tool execution             | 1 min  | Brief example — auto-lint after file edit                    |
| → Copilot code review (request locally in VS Code)  | 2 min  | Show how to trigger review from within VS Code               |

**Facilitator notes:**
- This block is a montage — keep energy high, don't go deep on any one feature. The goal is "oh, I didn't know it could do that."
- Have all demos pre-staged. Don't type setup commands live — have `.vscode/mcp.json`, instruction files, etc. ready to show.
- End with: "You'll get to try all of these during the hands-on build."

---

### Block 3: Live Build Demo (15 min)

**Goals:** Build the demo project from scratch using Agent mode so attendees see the end-to-end workflow they're about to replicate.

| Topic                                             | Time   | Notes                                                      |
| ------------------------------------------------- | ------ | ---------------------------------------------------------- |
| **Introduce the project**                         | 2 min  | Show what we're building (screenshot or quick sketch)      |
| **Scaffold with Agent mode**                      | 8 min  |                                                            |
| → Start with a clear, detailed prompt              | 1 min  | Narrate why the prompt is structured this way              |
| → Agent runs: creates files, installs deps, etc.   | 4 min  | Let it cook — narrate what's happening, show autopilot     |
| → Review and accept changes                        | 3 min  | Show diff view, point out what to check                    |
| **Add a feature with instructions + prompting**   | 5 min  |                                                            |
| → Create `copilot-instructions.md` for the project | 2 min  | Ties back to Block 2                                       |
| → Prompt for a new feature, show iterative workflow | 3 min  | "That's close, but change X..." — show refinement          |

**Key message:** "That took me 15 minutes with Copilot. Now you're going to do it — and you'll have more time to go further."

**Demo project:** TBD — see [demo-project-ideas.md](demo-project-ideas.md) for options. Should be a full-stack React (Vite) + Express project in TypeScript.

---

### ☕ Break (10 min)

---

### Block 4: Hands-On Build — Part 1 (45 min)

**Goals:** Attendees scaffold and build the core project using Copilot Agent mode.

| Activity                                          | Time   | Notes                                                |
| ------------------------------------------------- | ------ | ---------------------------------------------------- |
| **Introduce the challenge + starter prompt**      | 3 min  | Give them the prompt (or a starting point)            |
| **Build Phase 1: Core App**                       | 37 min |                                                      |
| → Scaffold the project with Agent mode             |        | Full-stack: React + Express, TypeScript              |
| → Get the basic app running in the browser         |        | API endpoints + React UI rendering data              |
| → Create a `copilot-instructions.md`               |        | They write project-specific instructions             |
| **Float for Q&A and help**                        | 5 min  | Walk around, assist, help troubleshoot               |

**Milestone check:** By end of Part 1, everyone should have a running app with at least the basic features visible in the browser.

**Tips to share with attendees:**
- Start a new conversation if Copilot seems confused (context rot)
- Be specific in prompts — describe what you want, not just the feature name
- Use autopilot mode for scaffolding, switch back to approval mode for refinements
- Watch your premium request budget — use base model for simple tasks

---

### ☕ Break (10 min)

---

### Block 5: GitHub Platform & CLI Features (10 min)

**Goals:** Cover features that live outside VS Code — CLI and GitHub.com. Short and punchy.

| Topic                                            | Time   | Notes                                                      |
| ------------------------------------------------ | ------ | ---------------------------------------------------------- |
| **GitHub CLI: Rubber Duck Mode**                 | 3 min  |                                                            |
| → `gh copilot` interactive rubber duck            | 2 min  | Live demo: reason through a problem in the terminal        |
| → `gh copilot explain` / `gh copilot suggest`     | 1 min  | Quick examples — "explain this error", "suggest a command" |
| **Coding Agent (Cloud)**                         | 3 min  |                                                            |
| → What it is: async agent on GitHub.com           | 1 min  | "Assign an issue to Copilot, it opens a PR"               |
| → When to use: low-context tasks, bulk changes    | 1 min  | Good for: migrations, docs, simple features               |
| → How it differs from local agent                 | 1 min  | Local = interactive, cloud = fire-and-forget               |
| **Copilot Code Review on PRs**                   | 2 min  |                                                            |
| → Auto-review on GitHub PRs                       | 1 min  | Show a PR with Copilot review comments                     |
| → Requesting review locally (recap from Block 2)  | 1 min  | Quick reminder                                             |
| **GitHub Spark** (optional, if time)             | 2 min  |                                                            |
| → Quick demo: natural language → hosted micro-app  | 2 min  | "Here's what it can do" — don't go deep                    |

---

### Block 6: Hands-On Build — Part 2 (35 min)

**Goals:** Extend the project with advanced features. Try out the power features from Block 2.

| Activity                                          | Time   | Notes                                                |
| ------------------------------------------------- | ------ | ---------------------------------------------------- |
| **Introduce Part 2 challenges**                   | 3 min  | See challenge list below                             |
| **Build Phase 2: Advanced Features**              | 27 min |                                                      |
| → Add a feature using a skill (`.prompt.md`)       |        | Provide a sample skill file they can use             |
| → Wire up an MCP server                            |        | Have a simple one ready to go                        |
| → Try vision: paste a UI mockup, have Copilot build it |    | Provide a mockup image if they don't have one        |
| → Try CLI rubber duck on a problem they hit        |        | Encourage using `gh copilot` for debugging           |
| → Extend with hooks (stretch goal)                 |        | Auto-format or auto-lint on file changes             |
| **Float for Q&A and help**                        | 5 min  | Walk around, help with advanced features             |

**Part 2 Challenge Menu (pick any):**
Attendees should try at least 2-3 of these during the time:

1. **Create a `.prompt.md` skill** — Write a reusable prompt for generating a specific type of component (e.g., "generate a React form component with validation")
2. **Add an MCP server** — Wire up a provided MCP server in `.vscode/mcp.json` and use its tools in a Copilot conversation
3. **Vision-driven feature** — Paste a UI screenshot/mockup into chat and have Copilot build or improve a component to match it
4. **Custom agent** — Create a `.agent.md` file for a specialized workflow (e.g., a "reviewer" agent that focuses on code quality)
5. **Hooks** — Set up a hook that auto-runs a linter or formatter after Copilot edits a file
6. **CLI rubber duck** — Use `gh copilot` in the terminal to debug an issue or reason through an architecture decision
7. **Freestyle** — Add any feature you want to the project using whatever Copilot features you choose

---

### Block 7: Wrap-Up & Resources (10 min)

| Topic                                                  | Time  | Notes                                              |
| ------------------------------------------------------ | ----- | -------------------------------------------------- |
| **Key Takeaways** (Top 5)                              | 3 min |                                                    |
| 1. Copilot is an ecosystem, not just chat               |       | VS Code + CLI + Cloud Agent + PR Review            |
| 2. Instructions, skills, and agents make it project-aware|      | Invest in these for your real projects              |
| 3. Autopilot for scaffolding, approval mode for precision|      | Know when to trust, when to verify                  |
| 4. MCP servers extend what Copilot can do               |       | "Plugins" unlock domain-specific workflows          |
| 5. Start new conversations to avoid context rot         |       | The most common mistake                             |
| **What We Didn't Cover** (self-study list)             | 2 min | Copilot Workspace, Copilot Extensions, deep MCP    |
| **Resources**                                          | 3 min |                                                    |
| → GitHub Copilot Docs                                  |       | docs.github.com/en/copilot                         |
| → Free Plan Details                                    |       | Link to plans page                                 |
| → Copilot Customization Docs                           |       | Instructions, skills, agents docs                  |
| → MCP Servers directory                                |       | Link to awesome-mcp-servers or similar             |
| → Your example files                                   |       | Share your instructions/skills/agents if comfortable|
| **Final Q&A**                                          | 2 min |                                                    |

---

## Feature Coverage Map

Quick reference for which features are covered where:

| Feature                              | Block 2 (Tour) | Block 3 (Demo) | Block 4 (Lab) | Block 5 (Platform) | Block 6 (Lab) |
| ------------------------------------ | :-------------: | :-------------: | :-----------: | :-----------------: | :-----------: |
| Agent mode + autopilot               | Demo            | Demo            | Practice      |                     | Practice      |
| Model families / fleet mode          | Demo            |                 | Practice      |                     |               |
| Custom instructions                  | Demo            | Demo            | Practice      |                     |               |
| Skills (`.prompt.md`)                | Demo            |                 |               |                     | Practice      |
| Custom agents (`.agent.md`)          | Demo            |                 |               |                     | Practice      |
| MCP servers                          | Demo            |                 |               |                     | Practice      |
| Vision (images in chat)              | Demo            |                 |               |                     | Practice      |
| Hooks                                | Demo            |                 |               |                     | Practice      |
| Code review (local)                  | Demo            |                 |               | Recap               |               |
| CLI rubber duck                      |                 |                 |               | Demo                | Practice      |
| CLI explain / suggest                |                 |                 |               | Demo                | Practice      |
| Coding Agent (cloud)                 |                 |                 |               | Demo                |               |
| Code review (PRs)                    |                 |                 |               | Demo                |               |
| GitHub Spark                         |                 |                 |               | Demo                |               |

---

## What Changed from v1

| v1 (Feb 2026)                         | v2 (Apr 2026)                                      | Why                                                    |
| ------------------------------------- | --------------------------------------------------- | ------------------------------------------------------ |
| Edit mode taught + demoed             | Removed — no longer exists                           | Feature deprecated                                     |
| `@workspace` usage                    | Removed                                              | No longer needed                                       |
| Basic chat fundamentals (20+ min)     | Quick UI tour (3 min)                                | Audience already uses AI coding tools                  |
| Prompting block (20 min)              | Woven into demo + hands-on                           | Less lecture, more practice                            |
| AI Quick Primer (10 min)              | Removed                                              | Audience doesn't need it                               |
| 50 min hands-on                       | 90 min hands-on                                      | "Workshop is mostly building"                          |
| CLI mentioned in passing              | CLI features demoed (rubber duck, explain/suggest)   | CLI-only features are unique and valuable              |
| —                                     | Added: Fleet mode                                    | New feature                                            |
| —                                     | Added: Autopilot / bypass approvals                  | New feature                                            |
| —                                     | Added: Custom agents (`.agent.md`)                   | New feature                                            |
| —                                     | Added: Skills (`.prompt.md`)                         | New feature                                            |
| —                                     | Added: Hooks                                         | New feature                                            |
| —                                     | Added: Vision                                        | New feature                                            |
| —                                     | Added: Coding Agent (cloud)                          | New feature                                            |
| —                                     | Added: GitHub Spark                                  | New feature                                            |
| —                                     | Added: Code review (local + PR)                      | New feature                                            |
| —                                     | Added: Copilot experiences framing (VS Code/CLI/cloud) | Unique to Copilot ecosystem                          |
| —                                     | Added: CLI install + account signup time             | Free tier workflow                                     |

---

## Pre-Workshop Email (Send to Attendees)

> **Subject: Get Ready for the GitHub Copilot Workshop!**
>
> Hey! Looking forward to the workshop on [DATE]. To make sure we hit the ground running, please have these ready:
>
> - [ ] **VS Code** installed ([download](https://code.visualstudio.com/))
> - [ ] **GitHub account** ([sign up](https://github.com/signup) if needed)
> - [ ] **Copilot extension** installed in VS Code (search "GitHub Copilot" in Extensions)
> - [ ] **Copilot plan** — Free tier works! ([sign up here](https://docs.github.com/en/copilot/get-started/plans))
> - [ ] **GitHub CLI** installed ([download](https://cli.github.com/)) — run `gh auth login` to authenticate
> - [ ] **Node.js** installed (v18+ recommended) ([download](https://nodejs.org/))
> - [ ] **Laptop charger** — 3 hours is a long time on battery
>
> Don't worry if you primarily use Cursor, Claude Code, or another AI tool — this workshop focuses on features unique to the GitHub Copilot ecosystem, and we'll get you oriented quickly. If you run into setup issues, we'll have a few minutes at the start to troubleshoot. See you there!

---

## Notes

- The full-day plan lives in [copilot-workshop-plan.md](copilot-workshop-plan.md) if you want to expand back to 6-8 hours for a different event.
- **Demo project is TBD** — see [demo-project-ideas.md](demo-project-ideas.md) for full-stack React + Express options. Should be decided before the workshop and tested end-to-end.
- Have all demo files pre-staged (instructions, MCP config, skill files, agent files, a UI mockup image for vision). Don't fumble with setup during the feature tour.
- The Part 2 "challenge menu" approach lets faster attendees explore advanced features while slower ones continue building the core app.
- Consider providing a sample MCP server config and a `.prompt.md` skill file as handouts so attendees don't have to write them from scratch during the lab.
- The Geeks && Drinks crowd is casual and community-driven — keep the energy conversational, not lecture-y.
