# GitHub Copilot Workshop: Structured Plan

**Target Duration:** 6-8 hours (with flexibility)  
**Format:** Single day, mixed presentation and hands-on  
**Audience:** Mixed skill levels, individual developers  
**Prerequisites:** Laptop with VS Code installed, GitHub account

---

## Schedule Overview

| Block | Topic                     | Duration | Type         |
| ----- | ------------------------- | -------- | ------------ |
| 1     | Welcome & Setup           | 45 min   | Mixed        |
| 2     | AI Fundamentals           | 30 min   | Presentation |
| 3     | Copilot Basics            | 60 min   | Mixed        |
| —     | **Break**                 | 15 min   | —            |
| 4     | Prompting Like a Pro      | 45 min   | Mixed        |
| 5     | Context & Instructions    | 45 min   | Mixed        |
| —     | **Lunch**                 | 60 min   | —            |
| 6     | Edit, Agent & Plan Modes  | 60 min   | Mixed        |
| 7     | Hands-On Project (Part 1) | 45 min   | Lab          |
| —     | **Break**                 | 15 min   | —            |
| 8     | Advanced Features         | 45 min   | Mixed        |
| 9     | Hands-On Project (Part 2) | 45 min   | Lab          |
| 10    | Wrap-Up & Resources       | 15 min   | Presentation |

**Total: ~7.5 hours** (including breaks and lunch)

---

## Detailed Session Plans

---

### Block 1: Welcome & Setup (45 min)

**Goals:** Everyone is set up and ready to code with Copilot

#### Content:

| Topic                                                    | Time   | Notes                                    |
| -------------------------------------------------------- | ------ | ---------------------------------------- |
| Welcome, introductions, agenda overview                  | 10 min | Set expectations for the day             |
| Quick poll: Experience levels, languages used            | 5 min  | Helps you adapt pacing                   |
| GitHub account & Copilot sign-up (for those who need it) | 10 min | Point to free plan, walk through quickly |
| VS Code Copilot extension installation                   | 10 min | Walk through marketplace, signing in     |
| Verify setup: "Ask Copilot something"                    | 5 min  | Everyone confirms it's working           |
| Install Copilot CLI (optional, brief)                    | 5 min  | `gh extension install github/gh-copilot` |

**Possible Cut:** Skip Copilot CLI setup, cover later or provide as take-home

---

### Block 2: AI Fundamentals (30 min)

**Goals:** Demystify AI/LLMs so attendees understand what's happening under the hood

#### Content:

| Topic                                        | Time   | Notes                                     |
| -------------------------------------------- | ------ | ----------------------------------------- |
| What is AI? What is an LLM?                  | 10 min | High-level, non-technical explanation     |
| Tokens, context windows, and why they matter | 10 min | Explain why prompts get "forgotten"       |
| Vectors and embeddings (conceptual)          | 5 min  | Why Copilot understands code semantically |
| What Copilot can/can't do                    | 5 min  | Set realistic expectations                |

**Tip:** Use analogies—"tokens are like words to the AI", "context window is short-term memory"

**Possible Cut:** Reduce vectors/embeddings to a 1-minute mention if running behind

---

### Block 3: Copilot Basics (60 min)

**Goals:** Master the fundamental Copilot interactions

#### Content:

| Topic                                           | Time   | Notes                                    |
| ----------------------------------------------- | ------ | ---------------------------------------- |
| **Copilot UI Tour**                             | 15 min |                                          |
| → Chat panel location and basic usage           | 5 min  |                                          |
| → Agent dropdown, model dropdown                | 5 min  | Explain different models available       |
| → Participants, prompts, tools                  | 5 min  |                                          |
| **Inline Completions**                          | 15 min |                                          |
| → Tab to accept, Esc to dismiss                 | 5 min  | Live demo                                |
| → Ghost text and multi-line suggestions         | 5 min  |                                          |
| → Comments as prompts                           | 5 min  | Write a comment, watch suggestion appear |
| **Chat Fundamentals**                           | 15 min |                                          |
| → Asking questions                              | 5 min  |                                          |
| → Code explanations                             | 5 min  |                                          |
| → Editing your previous message                 | 5 min  | Click to edit trick                      |
| **Quick Exercise**                              | 15 min |                                          |
| → Attendees: Generate a function from a comment | 7 min  |                                          |
| → Attendees: Ask Copilot to explain some code   | 8 min  |                                          |

---

### ☕ Break (15 min)

---

### Block 4: Prompting Like a Pro (45 min)

**Goals:** Transform attendees from basic users to effective prompters

#### Content:

| Topic                                    | Time   | Notes                                 |
| ---------------------------------------- | ------ | ------------------------------------- |
| **Prompting Techniques**                 | 25 min |                                       |
| → Be specific (show good vs bad prompts) | 5 min  | Side-by-side comparison               |
| → Provide context ("I'm building a...")  | 5 min  |                                       |
| → Few-shot examples                      | 5 min  | Show input/output examples            |
| → Ask for clarifying questions           | 5 min  | "Ask me questions before you start"   |
| → "Be honest with me" / uncertainty      | 5 min  | Encourage Copilot to flag uncertainty |
| **Prompt Battle Exercise**               | 15 min |                                       |
| → Same task, different prompt approaches | 10 min | Attendees try, compare results        |
| → Group share: What worked best?         | 5 min  |                                       |
| **Slash Commands Overview**              | 5 min  |                                       |
| → `/explain`, `/fix`, `/tests`, `/doc`   | 5 min  | Quick demo of each                    |

---

### Block 5: Context & Instructions (45 min)

**Goals:** Understand how to give Copilot project-level context

#### Content:

| Topic                                               | Time   | Notes                                   |
| --------------------------------------------------- | ------ | --------------------------------------- |
| **Context Window Deep Dive**                        | 10 min |                                         |
| → What counts as context?                           | 5 min  | Open files, chat history, instructions  |
| → Context rot: why start new conversations          | 5 min  |                                         |
| **Copilot Instructions**                            | 20 min |                                         |
| → Root-level `.github/copilot-instructions.md`      | 10 min | Create one live                         |
| → Multiple instruction files                        | 5 min  |                                         |
| → What to put in instructions                       | 5 min  | Coding standards, project context, etc. |
| **Using @workspace**                                | 10 min |                                         |
| → When to use it                                    | 5 min  |                                         |
| → How it searches your codebase                     | 5 min  |                                         |
| **Exercise**                                        | 5 min  |                                         |
| → Create a copilot-instructions.md for demo project | 5 min  | Quick exercise                          |

---

### 🍽️ Lunch Break (60 min)

---

### Block 6: Edit, Agent & Plan Modes (60 min)

**Goals:** Understand when to use each mode and how they differ

#### Content:

| Topic                                    | Time   | Notes                 |
| ---------------------------------------- | ------ | --------------------- |
| **Ask Mode**                             | 5 min  |                       |
| → When to use: Questions, explanations   | 5 min  | Default chat behavior |
| **Edit Mode**                            | 15 min |                       |
| → When to use: Targeted file changes     | 5 min  |                       |
| → Multi-file editing                     | 5 min  | Live demo             |
| → Reviewing and accepting changes        | 5 min  | Show diff view        |
| **Agent Mode**                           | 25 min |                       |
| → When to use: Complex, multi-step tasks | 5 min  |                       |
| → How it differs from Edit               | 5 min  | Autonomous execution  |
| → Terminal access and tool use           | 5 min  |                       |
| → Live demo: Build a feature with Agent  | 10 min | End-to-end demo       |
| **Ctrl+I Inline Chat**                   | 5 min  |                       |
| → Quick edits without opening chat panel | 5 min  |                       |
| **Plan Mode** ⚠️ _Possible Cut_          | 10 min |                       |
| → Planning complex changes               | 5 min  |                       |
| → When to use it                         | 5 min  |                       |

**Possible Cut:** Plan Mode can be briefly mentioned or skipped entirely

---

### Block 7: Hands-On Project Part 1 (45 min)

**Goals:** Apply skills learned so far to build something

#### Recommended Project: Task/Todo CLI or Utility Scripts

| Activity                              | Time   | Notes                                 |
| ------------------------------------- | ------ | ------------------------------------- |
| Introduce project options             | 5 min  | CLI app, REST API, or utility scripts |
| Setup: Create project folder, init    | 5 min  |                                       |
| **Build Phase 1**                     | 30 min |                                       |
| → Create basic structure with Copilot | 10 min |                                       |
| → Implement core functionality        | 15 min |                                       |
| → Checkpoint: Does it run?            | 5 min  |                                       |
| Float for Q&A and help                | 5 min  | Walk around, assist stragglers        |

**Facilitator Notes:**

-   Have a working solution ready to show if people get stuck
-   Encourage using Ask mode when confused, Agent mode when building

---

### ☕ Break (15 min)

---

### Block 8: Advanced Features (45 min)

**Goals:** Exposure to power-user features

#### Content:

| Topic                                        | Time   | Notes                 |
| -------------------------------------------- | ------ | --------------------- |
| **MCP (Model Context Protocol)**             | 15 min |                       |
| → What is MCP and how it works               | 5 min  | "Plugins for Copilot" |
| → Loading MCP servers in `.vscode/mcp.json`  | 5 min  |                       |
| → Demo: Add a simple MCP server              | 5 min  | GitHub or filesystem  |
| **Custom Prompts**                           | 5 min  |                       |
| → Creating reusable prompts                  | 5 min  |                       |
| **Chat History & Debug View**                | 5 min  |                       |
| → Finding past conversations                 | 3 min  |                       |
| → Debug view for troubleshooting             | 2 min  |                       |
| **Copilot CLI**                              | 5 min  |                       |
| → `gh copilot explain`                       | 3 min  |                       |
| → `gh copilot suggest`                       | 2 min  |                       |
| **Agent Skills** ⚠️ _Possible Cut_           | 10 min |                       |
| → What are skills                            | 5 min  |                       |
| → How to use them                            | 5 min  |                       |
| **Hooks** ⚠️ _Possible Cut_                  | 5 min  |                       |
| → Automating actions based on Copilot output | 5 min  | Brief mention         |

**Possible Cuts:** Skills, Hooks, and deep MCP dive can be trimmed

---

### Block 9: Hands-On Project Part 2 (45 min)

**Goals:** Complete and enhance project, apply advanced features

| Activity                           | Time   | Notes                   |
| ---------------------------------- | ------ | ----------------------- |
| **Build Phase 2**                  | 30 min |                         |
| → Add features to project          | 15 min | Search, save/load, etc. |
| → Add error handling with Copilot  | 5 min  |                         |
| → Generate tests for code          | 5 min  |                         |
| → Add documentation                | 5 min  |                         |
| **Show & Tell (Optional)**         | 10 min |                         |
| → Volunteers share what they built | 10 min | Celebrate successes     |
| **Q&A and troubleshooting**        | 5 min  |                         |

---

### Block 10: Wrap-Up & Resources (15 min)

| Topic                                 | Time  | Notes                              |
| ------------------------------------- | ----- | ---------------------------------- |
| Recap: Key takeaways                  | 5 min | Top 3-5 things to remember         |
| What we didn't cover (for self-study) | 3 min | Coding Agent, Code Review, etc.    |
| Resources                             | 5 min | Docs, awesome-copilot, cheat sheet |
| Final Q&A                             | 2 min |                                    |

---

## Topics Marked for Potential Cutting

If running behind schedule, cut in this order:

### Priority Cuts (Remove First)

1. **Hooks** - Brief mention at most (save 5 min)
2. **Agent Skills** - Can be take-home reading (save 10 min)
3. **Plan Mode** - Mention as "also exists" (save 10 min)
4. **Deep MCP internals** - Keep basic setup, skip internals (save 5 min)

### Secondary Cuts

5. **Copilot CLI setup in Block 1** - Move to take-home (save 5 min)
6. **Custom Prompts deep dive** - Brief mention (save 3 min)
7. **Show & Tell in Block 9** - Skip if behind (save 10 min)

### Never Cut

-   Basic chat/inline usage (Block 3)
-   Prompting techniques (Block 4)
-   Context and instructions (Block 5)
-   Edit vs Agent modes (Block 6) - though can trim Plan
-   Hands-on project time (Blocks 7 & 9)

---

## Optional Add-Ons (If Running Ahead)

If you finish early or have a faster-moving group:

1. **Coding Agent Preview** (15-20 min)

    - What it is and how it works
    - Demo if available

2. **Custom Agents** (10-15 min)

    - Building your own agent
    - Use cases

3. **Copilot Code Review** (10 min)

    - How it works on PRs
    - Brief demo

4. **RPI/Spec Kit** (10 min)

    - Advanced usage patterns
    - For attendees who want to go deeper

5. **Rumsfeld Model Discussion** (5-10 min)
    - Known knowns, known unknowns, unknown unknowns
    - How this applies to AI-assisted development

---

## Pre-Workshop Checklist

### For You (Facilitator)

-   [ ] Test all demos on a clean machine
-   [ ] Prepare backup slides in case of internet issues
-   [ ] Have working project solution ready
-   [ ] Create attendee cheat sheet / handout
-   [ ] Test MCP server setup process
-   [ ] Prepare USB drive with offline resources (just in case)

### For Attendees (Send in Advance)

-   [ ] Install VS Code
-   [ ] Create GitHub account (if needed)
-   [ ] Sign up for Copilot Free (or have Pro)
-   [ ] Install Copilot extension (or do in workshop)
-   [ ] Bring laptop charger
-   [ ] Have a language runtime installed (Node.js, .NET, Python)

---

## Pacing Tips

-   **If running behind:** Cut marked optional sections, reduce exercise times
-   **If running ahead:** Add optional add-ons, extend hands-on time, more Q&A
-   **Energy dip after lunch:** Start with the interactive Agent demo to re-engage
-   **Mixed skill levels:** Pair experienced devs with beginners during exercises
-   **Keep engagement:** Ask questions, have people share screens, celebrate wins

---

## Time Budget Summary

| Category           | Time         |
| ------------------ | ------------ |
| Presentation/Demo  | ~3.5 hours   |
| Hands-On Exercises | ~1.5 hours   |
| Labs (Project)     | ~1.5 hours   |
| Breaks + Lunch     | ~1.5 hours   |
| **Total**          | **~8 hours** |

**Minimum Viable Workshop (if need to compress to 6 hours):**

-   Reduce lunch to 45 min
-   Cut all "Possible Cut" items
-   Reduce each hands-on block by 10 min
-   Skip Show & Tell
