# Final Decisions

These were the final decisions made based on the research below/

## Title

Zero to Hero with GitHub Copilot: What Works in Real Projects

## Abstract

Many developers either underuse GitHub Copilot, using it as a fancy autocomplete, or put too much trust into it, having it implement entire features without verifying its work. In this hands-on workshop, you'll learn how effective teams use GitHub Copilot for real results. Based on enterprise experience coaching teams on AI adoption, we'll cover GitHub Copilot's features, effective prompting techniques, and practical workflows for using AI reliably and productively. Bring your laptop and come ready to code!

## Bio

Daniel is a Microsoft .NET MVP and software consultant at Lean TECHniques. He helps teams deliver high-quality software while adopting modern practices such as effective CI/CD, automated testing, AI usage, and product management. With experience spanning multiple industries, including finance, retail, and agriculture, he has served as a technical coach, agile coach, and tech lead, with a primary background as a software developer.

# GitHub Copilot Workshop: 3-Hour Plan (Geeks && Tech Tuesdays)

**Generated:** February 14, 2026  
**Context:** Trimmed version of the full-day workshop for Geeks && Tech Tuesdays at Geekdom, San Antonio  
**Audience:** Intermediate+ developers  
**Prerequisites (sent ahead):** Laptop with VS Code, GitHub account, Copilot extension installed, a language runtime (Node.js, .NET, or Python)

---

## Title Options

Pick the one that feels right for the Geeks && Drinks vibe:

| #   | Title                                                            | Why It Works                                               |
| --- | ---------------------------------------------------------------- | ---------------------------------------------------------- |
| 1   | **Your New Favorite Coworker: Mastering GitHub Copilot**         | Personality, slightly playful, implies daily-use value     |
| 2   | **Code Smarter, Ship Faster: Hands-On with GitHub Copilot**      | Action-oriented, clear value prop, signals hands-on format |
| 3   | **From Prompt to Production: A GitHub Copilot Deep Dive**        | Developer-y, implies going beyond basics, matches audience |
| 4   | **Pair Programming with AI: A Hands-On GitHub Copilot Workshop** | Classic framing, immediately understood, clear format      |
| 5   | **The AI-Powered IDE: Getting the Most from GitHub Copilot**     | Practical, appeals to devs who already have Copilot        |

**Recommendation:** Option 1 or 2 — they're catchy and match the casual, community-driven Geeks && Drinks tone. Option 3 is the safest if you want something more professional.

---

## Description Options

### Option A (Conversational)

GitHub Copilot can do a lot more than autocomplete your code. In this 3-hour hands-on workshop, you'll learn how to prompt effectively, use Agent mode for complex tasks, wire up MCP servers, and build project-level instructions that make Copilot actually understand your codebase. Whether you've been using Copilot for a while or just getting started, you'll leave with techniques you can use on Monday morning. Come ready to code!

### Option B (Punchy)

You've got Copilot installed — but are you actually getting your money's worth? In this hands-on workshop, we'll go beyond Tab-to-accept and into the features that make Copilot a real productivity multiplier: agent mode, custom instructions, MCP integrations, and prompting techniques that actually work. Bring your laptop and let's build something together.

### Option C (Structured)

Stop guessing and start shipping. This 3-hour workshop covers the GitHub Copilot features that matter most for working developers: effective prompting, edit vs. agent modes, Copilot instructions, MCP servers, and more. You'll get hands-on time building with Copilot and walk away with a workflow you can immediately apply to your own projects. Laptop required — come ready to code!

**Recommendation:** Option B — it hooks experienced devs who may feel like they're underusing Copilot, which matches your intermediate+ audience.

---

## Schedule Overview (3 Hours)

| Block | Topic                          | Duration    | Type         |
| ----- | ------------------------------ | ----------- | ------------ |
| 1     | Welcome & Verify Setup         | 10 min      | Mixed        |
| 2     | AI Quick Primer                | 10 min      | Presentation |
| 3     | Copilot Core Skills            | 25 min      | Mixed        |
| 4     | Prompting That Works           | 20 min      | Mixed        |
| —     | **Break**                      | 10 min      | —            |
| 5     | Context, Instructions & Modes  | 25 min      | Mixed        |
| 6     | Agent Mode Deep Dive           | 20 min      | Mixed        |
| 7     | Hands-On Build                 | 30 min      | Lab          |
| —     | **Break**                      | 10 min      | —            |
| 8     | Advanced: MCP & Power Features | 10 min      | Mixed        |
| 9     | Wrap-Up & Resources            | 10 min      | Presentation |
|       | **Total**                      | **180 min** |              |

---

## Detailed Session Plans

---

### Block 1: Welcome & Verify Setup (10 min)

**Goals:** Confirm everyone is ready, set expectations

| Topic                                         | Time  | Notes                                     |
| --------------------------------------------- | ----- | ----------------------------------------- |
| Welcome, quick introductions                  | 3 min | Who you are, what you'll cover            |
| Quick poll: How are you using Copilot today?  | 2 min | Show of hands — helps you gauge the room  |
| Verify setup: "Ask Copilot something in chat" | 3 min | Quick smoke test, troubleshoot if needed  |
| Copilot plans overview                        | 2 min | Free vs Pro — what they'll have access to |

**What got cut from the full version:** Copilot CLI install, extended introductions, step-by-step sign-up walkthrough (sent as pre-reqs)

---

### Block 2: AI Quick Primer (10 min)

**Goals:** Shared mental model — enough to understand _why_ Copilot behaves the way it does

| Topic                         | Time  | Notes                                            |
| ----------------------------- | ----- | ------------------------------------------------ |
| LLMs in 2 minutes             | 2 min | "Next token prediction, trained on code"         |
| Tokens and context windows    | 4 min | Why prompts get "forgotten", why context matters |
| What Copilot can and can't do | 4 min | Set expectations — trust but verify              |

**What got cut:** Vectors/embeddings deep dive, extended "What is AI" section. Intermediate devs don't need this.

---

### Block 3: Copilot Core Skills (25 min)

**Goals:** Ensure everyone has a solid baseline, even experienced users pick up something

| Topic                                        | Time   | Notes                                    |
| -------------------------------------------- | ------ | ---------------------------------------- |
| **UI Tour (fast)**                           | 5 min  |                                          |
| → Chat panel, agent dropdown, model dropdown | 3 min  | Point out what's there, don't belabor it |
| → Participants, tools, slash commands        | 2 min  | Quick fly-by                             |
| **Inline Completions**                       | 5 min  |                                          |
| → Tab/Esc, ghost text, comments as prompts   | 5 min  | Quick demo, they know this mostly        |
| **Chat Fundamentals**                        | 5 min  |                                          |
| → Asking questions, code explanations        | 3 min  |                                          |
| → Editing previous messages                  | 2 min  | Useful trick many miss                   |
| **Quick Exercise**                           | 10 min |                                          |
| → Generate a function from a comment         | 5 min  |                                          |
| → Ask Copilot to explain unfamiliar code     | 5 min  | Provide a code snippet if needed         |

**What got cut:** Extended UI tour, detailed slash command walkthrough. Intermediate devs explore these on their own.

---

### Block 4: Prompting That Works (20 min)

**Goals:** Level up their prompting — this is the highest-ROI skill

| Topic                                           | Time   | Notes                            |
| ----------------------------------------------- | ------ | -------------------------------- |
| **Good vs Bad Prompts**                         | 5 min  | Side-by-side live demo           |
| → Vague ("make this better") vs specific        | 3 min  |                                  |
| → Providing context ("I'm building a...")       | 2 min  |                                  |
| **Power Techniques**                            | 10 min |                                  |
| → Few-shot examples                             | 3 min  | Show input/output pattern        |
| → "Ask me clarifying questions before starting" | 3 min  | Game-changer for complex tasks   |
| → "Be honest with me" / flag uncertainty        | 2 min  |                                  |
| → Iterative refinement                          | 2 min  | "That's close, but change X..."  |
| **Mini Exercise: Prompt Battle**                | 5 min  |                                  |
| → Same task, try different approaches           | 5 min  | Quick compare, share what worked |

**What got cut:** Extended slash commands section (covered briefly in Block 3), longer prompt battle exercise, group share portion.

---

### ☕ Break (10 min)

---

### Block 5: Context, Instructions & Modes (25 min)

**Goals:** Understand how to make Copilot project-aware + know which mode to use when

| Topic                                               | Time   | Notes                                   |
| --------------------------------------------------- | ------ | --------------------------------------- |
| **Context Window Awareness**                        | 5 min  |                                         |
| → What counts as context (open files, history, etc) | 3 min  |                                         |
| → Context rot — why new conversations matter        | 2 min  |                                         |
| **Copilot Instructions**                            | 10 min |                                         |
| → `.github/copilot-instructions.md`                 | 5 min  | Create one live, show what to put in it |
| → Multiple instruction files / skills               | 3 min  | Brief mention of the pattern            |
| → `@workspace` — when and how                       | 2 min  |                                         |
| **Ask vs Edit vs Agent**                            | 10 min |                                         |
| → Ask: Questions, explanations (default)            | 2 min  |                                         |
| → Edit: Targeted, multi-file changes                | 3 min  | Quick demo, show diff view              |
| → Agent: Complex, multi-step, autonomous            | 5 min  | This gets its own deep dive next        |

**What got cut:** Plan Mode (mention as "also exists"), separate 60-min modes block, extended @workspace dive, instructions exercise (folded into hands-on).

---

### Block 6: Agent Mode Deep Dive (20 min)

**Goals:** This is the headliner — show them what Agent can really do

| Topic                                          | Time   | Notes                                        |
| ---------------------------------------------- | ------ | -------------------------------------------- |
| **How Agent Differs from Edit**                | 3 min  | Autonomous execution, terminal access, tools |
| **Live Demo: Build a Feature End-to-End**      | 12 min |                                              |
| → Start with a clear prompt                    | 2 min  | "Build me a REST endpoint that..."           |
| → Watch Agent plan, create files, run commands | 5 min  | Let it cook — narrate what's happening       |
| → Review and accept/reject changes             | 3 min  | Show diff view, partial acceptance           |
| → Ctrl+I inline chat for quick fixes           | 2 min  | Show as complement to Agent                  |
| **When NOT to use Agent**                      | 2 min  | Small changes, sensitive code                |
| **Tips: Getting better results from Agent**    | 3 min  | Be specific, break into steps, verify        |

**What got cut:** Separate 10-min Ctrl+I block (folded in), Plan Mode deep dive.

---

### Block 7: Hands-On Build (30 min)

**Goals:** Apply everything — this is where it clicks

| Activity                                 | Time   | Notes                                 |
| ---------------------------------------- | ------ | ------------------------------------- |
| **Introduce the challenge**              | 3 min  | See project options below             |
| **Build with Copilot**                   | 22 min |                                       |
| → Use Agent mode to scaffold the project | 7 min  |                                       |
| → Add features using Edit + Agent        | 10 min |                                       |
| → Generate tests or docs                 | 5 min  |                                       |
| **Float for Q&A and help**               | 5 min  | Walk around, assist, answer questions |

#### Recommended Project Options (Attendee Choice)

**Option A: Utility Script Collection** (Lowest barrier — recommended for mixed languages)

- File renaming script, CSV-to-JSON converter, or Markdown link checker
- No project structure needed, immediate results

**Option B: Simple REST API** (Great for intermediate devs)

- Minimal API in their language of choice (Express, ASP.NET Minimal API, FastAPI)
- Create 2-3 endpoints, add error handling

**Option C: Refactoring Challenge** (Best for experienced devs)

- Provide a deliberately messy file
- Use Copilot to understand, refactor, and add tests

**Facilitator Notes:**

- Have a working solution ready to show if people get stuck
- Encourage Agent mode for scaffolding, Edit mode for refinements
- Create a `copilot-instructions.md` as part of the exercise (ties back to Block 5)

---

### ☕ Break (10 min)

---

### Block 8: Advanced — MCP & Power Features (10 min)

**Goals:** Exposure to what's next — give them a reason to explore after the workshop

| Topic                                        | Time  | Notes                                       |
| -------------------------------------------- | ----- | ------------------------------------------- |
| **MCP (Model Context Protocol)**             | 5 min |                                             |
| → What it is: "Plugins for Copilot"          | 2 min | One-sentence explanation                    |
| → Demo: Load a server in `.vscode/mcp.json`  | 3 min | GitHub or Playwright MCP — quick and visual |
| **Custom Prompts**                           | 2 min |                                             |
| → Creating reusable `.prompt.md` files       | 2 min | Brief, show an example                      |
| **Quick Mentions (60 seconds each)**         | 3 min |                                             |
| → Copilot CLI (`gh copilot explain/suggest`) | 1 min | "This exists, try it later"                 |
| → Coding Agent (GitHub-side, async)          | 1 min | "Coming soon / preview"                     |
| → Copilot Code Review on PRs                 | 1 min | "Works on your PRs automatically"           |

**What got cut from the full version:** Hooks, Agent Skills deep dive, Chat Debug View, custom agents, RPI/Spec Kit. All of these are mentioned in the resources handout for self-study.

---

### Block 9: Wrap-Up & Resources (10 min)

| Topic                                             | Time  | Notes                                      |
| ------------------------------------------------- | ----- | ------------------------------------------ |
| **Key Takeaways** (Top 5)                         | 3 min |                                            |
| 1. Prompting is a skill — be specific             |       |                                            |
| 2. Use instructions to teach Copilot your project |       |                                            |
| 3. Agent mode for building, Edit for refining     |       |                                            |
| 4. Start new conversations to avoid context rot   |       |                                            |
| 5. Trust but verify — always review the output    |       |                                            |
| **What We Didn't Cover** (self-study list)        | 2 min | Hooks, Skills, Coding Agent, Custom Agents |
| **Resources**                                     | 3 min |                                            |
| → GitHub Copilot Docs                             |       | docs.github.com/en/copilot                 |
| → Free Plan Details                               |       | Link to plans page                         |
| → awesome-copilot repo                            |       |                                            |
| → Your copilot-instructions.md examples           |       | Share your own if comfortable              |
| **Final Q&A**                                     | 2 min |                                            |

---

## What Got Cut (Full Day → 3 Hours)

For reference, here's what was removed and why:

| Cut Item                  | Reason                                  | Self-Study? |
| ------------------------- | --------------------------------------- | ----------- |
| Extended setup / sign-up  | Sent as pre-reqs                        | N/A         |
| AI Fundamentals deep dive | Audience is intermediate+               | No          |
| Vectors & embeddings      | Not needed for effective usage          | Optional    |
| Plan Mode                 | Mentioned briefly, not demoed           | Yes         |
| Copilot CLI setup         | Quick mention only, try at home         | Yes         |
| Hooks                     | Too niche for 3 hours                   | Yes         |
| Agent Skills deep dive    | Too niche for 3 hours                   | Yes         |
| Custom Agents             | Advanced topic, save for blog/follow-up | Yes         |
| RPI / Spec Kit            | Power-user content                      | Yes         |
| Hands-On Part 2           | Combined into a single 30-min build     | N/A         |
| Show & Tell               | No time, fun but not essential          | N/A         |
| Lunch                     | 3-hour format doesn't need it           | 🍕          |
| Extended prompt battle    | Shortened to 5-min mini exercise        | N/A         |
| Chat Debug View           | Niche troubleshooting tool              | Yes         |

---

## Time Budget Summary

| Category           | Time         |
| ------------------ | ------------ |
| Presentation/Demo  | ~1 hr 45 min |
| Hands-On Exercises | ~50 min      |
| Breaks             | ~20 min      |
| Wrap-Up            | ~10 min      |
| **Total**          | **3 hours**  |

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
> - [ ] **A language runtime** — Node.js, .NET, or Python (whichever you're comfortable with)
> - [ ] **Laptop charger** — 3 hours is a long time on battery
>
> If you run into any issues, don't worry — we'll do a quick setup check at the start. See you there!

---

## Notes

- The full-day plan lives in [copilot-workshop-plan.md](copilot-workshop-plan.md) if you want to expand back to 6-8 hours for a different event.
- Agent Mode is the headliner for this audience — intermediate devs will be blown away by what it can do autonomously.
- Consider having a messy code file ready as a backup hands-on option for experienced devs who finish the main project early.
- The Geeks && Drinks crowd is casual and community-driven — keep the energy conversational, not lecture-y.

---

## Additional Brainstorm: "Zero to Hero" Style

Extra options inspired by your "zero to hero" direction.

### More Title Options

| #   | Title                                                              | Style / Angle                                |
| --- | ------------------------------------------------------------------ | -------------------------------------------- |
| 1   | **Zero to Copilot Hero: Build Faster in 3 Hours**                  | Direct transformation, very clear value      |
| 2   | **Zero to Hero with GitHub Copilot**                               | Short, catchy, broad                         |
| 3   | **From Zero to Shipping: GitHub Copilot for Real-World Devs**      | Outcome-oriented, practical                  |
| 4   | **Copilot Hero Mode: From First Prompt to Finished Feature**       | Playful + technical                          |
| 5   | **Prompt to Hero: Master GitHub Copilot in One Session**           | Memorable and CTA-friendly                   |
| 6   | **Zero to AI Pairing Hero: Hands-On GitHub Copilot**               | Emphasizes pair-programming framing          |
| 7   | **From Tab-Complete to Team Superpower: GitHub Copilot Deep Dive** | Speaks to devs already using basic features  |
| 8   | **Copilot Hero in 3 Hours: Prompt, Build, Ship**                   | Time-boxed promise + action verbs            |
| 9   | **Beyond Autocomplete: Your Zero-to-Hero Copilot Workshop**        | Contrasts beginner usage with advanced usage |
| 10  | **Build Like a Hero: Practical GitHub Copilot for Developers**     | Friendly, community-event tone               |

### More Description Options

#### Option D (Zero-to-Hero Core)

Still using Copilot like fancy autocomplete? Let's fix that. In this fast-paced, hands-on workshop, you'll go from zero-to-hero with practical workflows for prompting, Agent mode, MCP tools, and project-level instructions. You'll build features live, learn when to use Ask vs Edit vs Agent, and leave with a playbook you can use on real projects immediately. Bring your laptop and join us!

#### Option E (Transformation + Outcome)

Go from "I have Copilot installed" to "I can ship with it confidently." This 3-hour workshop is built for developers who want real results: stronger prompts, faster implementation, better refactoring, and smarter debugging using GitHub Copilot. We'll practice on real coding tasks so you walk away with a repeatable workflow—not just tips. Join us and level up your dev speed.

#### Option F (Playful Hero Tone)

Ready to unlock Hero Mode in your IDE? In this hands-on GitHub Copilot workshop, you'll learn how to turn vague prompts into useful output, use Agent mode for multi-step tasks, and connect Copilot to real project context so responses get dramatically better. If you want to build faster without sacrificing quality, this session is for you. Come code with us!

#### Option G (Professional + Clean)

GitHub Copilot is most powerful when you know how to guide it. In this focused 3-hour workshop, you'll learn the workflows that matter most: prompting techniques, context and instructions, Agent mode execution, and practical MCP integration. You'll apply each concept in hands-on exercises and leave with a clear process for using Copilot effectively in day-to-day development. Save your seat and bring your laptop.

### Quick Picks

- **Strongest catchy title:** **Zero to Copilot Hero: Build Faster in 3 Hours**
- **Strongest professional title:** **From Zero to Shipping: GitHub Copilot for Real-World Devs**
- **Strongest broad-audience description:** Option E
- **Strongest community-vibe description:** Option F
