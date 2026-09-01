# From Autocomplete to Autopilot: Mastering GitHub Copilot

## Abstract

Most developers use GitHub Copilot as a fancy autocomplete and never discover the 90% of features that could transform their workflow. This matters because teams are leaving massive productivity gains on the table while fighting the tool instead of leveraging it.

**In this session, you'll see how to progress from basic code completion to building custom "skills" that automate entire categories of development tasks—turning Copilot from a typing assistant into an intelligent team member that knows your codebase, your standards, and your preferences.**

Attendees will leave with practical techniques they can apply immediately, from mastering context-aware chat to creating reusable skills that encode their team's expertise.

## Session Format

-   30-60 minutes depending on conference
-   Heavily demo-driven with conceptual explanations
-   Can lengthen/cut content depending on slot

---

## Talk Structure

### Opening (5-8 min)

-   **Personal context:** Experience as a coach and consultant helping teams with AI adoption
    -   Seen many teams use Copilot poorly on either extreme:
        -   "It's just autocomplete, I barely notice it"
        -   "Let me paste my entire codebase and ask it to build everything"
    -   Both approaches lead to frustration and wasted time
-   Quick show of hands: Who uses Copilot? Who uses it beyond autocomplete?
-   The "Copilot iceberg" - most people only see the tip
-   Preview the journey: autocomplete → chat modes → agents → context engineering → custom instructions → skills → full automation

---

### Chat Modes & Agent Dropdown (5-7 min)

_"Choosing how Copilot thinks"_

-   **The agent dropdown** - what it is and when to use each mode
-   **Ask mode** - quick questions, explanations, suggestions without changes
-   **Edit mode** - make targeted changes to specific files
-   **Agent mode** - autonomous multi-step tasks, can run commands and make multiple edits
-   When to use which mode
-   **Demo:** Same task in different modes - showing the difference in behavior

**Key tip:** Picking the right mode upfront saves time and gets better results

---

### Level 1: The Basics Most People Know (5-8 min)

_"Fancy Autocomplete"_

-   **Tab completion** - the default experience
-   **Ghost text suggestions** - accepting partial suggestions
-   **Inline chat** (`Ctrl+I`) - ask for code changes right in the editor
-   **Demo:** Quick inline generation of a method

**Key tip:** You can reject/cycle through suggestions, partial accept with `Ctrl+→`

---

### Level 2: Copilot Chat - Your Coding Partner (8-10 min)

_"Having a conversation about your code"_

-   **Chat panel** - longer conversations, explanations, debugging
-   **Context is king:**
    -   `#file` - reference specific files
    -   `#selection` - current selection
    -   `#editor` - visible code
    -   Dragging files into chat
-   **Slash commands:** `/explain`, `/fix`, `/tests`, `/doc`
-   **Demo:** Debugging a failing test by adding context, generating tests for existing code

**Key tip:** The quality of output is directly proportional to the context you provide

---

### Context Engineering (8-10 min)

_"The skill that makes everything else work better"_

-   **What is context engineering?** - deliberately shaping what Copilot knows
-   **Prompting techniques:**
    -   Be specific about what you want (format, style, constraints)
    -   Provide examples of desired output
    -   Break complex requests into steps
    -   Tell it what NOT to do
-   **Managing context window:**
    -   What gets included automatically
    -   How to add/remove context deliberately
    -   When too much context hurts
-   **The art of the follow-up** - refining results iteratively
-   **Demo:** Same prompt, different context - dramatic difference in output quality

**Key tip:** Great prompts + right context = reliable results

---

### Level 3: Agents - Copilot Gets Specialized (8-10 min)

_"Experts on demand"_

-   **`@workspace`** - searches your entire codebase for context
-   **`@terminal`** - helps with command-line tasks
-   **`@vscode`** - VS Code settings and features
-   **`@github`** - issues, PRs, repo information
-   **Demo:** Using `@workspace` to understand an unfamiliar codebase, `@terminal` to build a complex command

**Key tip:** Agents dramatically expand what Copilot can "see" and do

---

### Level 4: Custom Instructions - Teaching Copilot Your Standards (8-10 min)

_"Making Copilot work YOUR way"_

-   **`.github/copilot-instructions.md`** - project-wide instructions
-   What to include:
    -   Coding standards and conventions
    -   Preferred libraries/patterns
    -   Project-specific terminology
    -   Things to avoid
-   **Demo:** Before/after showing how custom instructions change output quality

**Key tip:** This is where Copilot stops being generic and becomes YOUR assistant

---

### Level 5: MCP Servers - Extending Copilot's Reach (5-8 min)

_"Giving Copilot new superpowers"_

-   What is MCP (Model Context Protocol)?
-   Built-in MCP servers (Playwright, GitHub, etc.)
-   Adding MCP servers for:
    -   Database access
    -   API documentation
    -   Internal tools
-   **Demo:** Using Playwright MCP to interact with a web page from chat

**Key tip:** MCP lets Copilot interact with the outside world

---

### Level 6: Agent Skills - The Automation Endgame (8-10 min)

_"Copilot does the thinking for you"_

-   What are skills? (Reusable, domain-specific instruction sets)
-   Skill structure:
    -   Name and description (for automatic detection)
    -   Detailed instructions
    -   File references
-   Building a skill library for your team:
    -   Code review skill
    -   PR description skill
    -   Test generation skill
    -   Documentation skill
-   **Demo:** Creating a skill that automates a repetitive task (e.g., generating consistent test files, writing commit messages)

**Key tip:** Skills let you encode expertise that Copilot can apply automatically

---

### Bonus: The Copilot Debug View (3-5 min)

_"Peek behind the curtain"_

-   **How to access it:** Copilot Chat Debug view in VS Code
-   **What you can see:**
    -   The full system prompt being sent
    -   How MCP servers are being picked up
    -   How skills are detected and included
    -   Token counts and context usage
-   **Why it matters:**
    -   Debug why Copilot isn't behaving as expected
    -   Understand what context is actually being sent
    -   Optimize your instructions and skills
-   **Demo:** Walking through the debug view while using a skill

**Key tip:** When something isn't working, the debug view tells you why

---

### Closing (3-5 min)

-   Recap the progression: autocomplete → chat modes → agents → context engineering → custom instructions → MCP → skills
-   Start simple, add complexity as you get comfortable
-   The goal: Copilot should feel like a knowledgeable team member, not a typing assistant
-   Resources for learning more

---

## Timing Guide

| Section             | Short (30 min) | Medium (45 min) | Full (60 min) |
| ------------------- | -------------- | --------------- | ------------- |
| Opening             | 3 min          | 5 min           | 8 min         |
| Chat Modes          | 3 min          | 5 min           | 7 min         |
| Basics              | 3 min          | 5 min           | 8 min         |
| Chat Partner        | 5 min          | 8 min           | 10 min        |
| Context Engineering | Cut            | 5 min           | 10 min        |
| Agents              | 5 min          | 7 min           | 10 min        |
| Custom Instructions | 5 min          | 7 min           | 10 min        |
| MCP Servers         | Cut            | 3 min           | 8 min         |
| Skills              | 4 min          | 7 min           | 10 min        |
| Debug View          | Cut            | Cut             | 5 min         |
| Closing             | 2 min          | 3 min           | 5 min         |

---

## Demo Ideas

1. **Chat modes comparison** - Same refactoring task in Ask vs Edit vs Agent mode
2. **Context matters** - Generate tests with no context vs full context
3. **Custom instructions magic** - Before/after adding project instructions
4. **Skill in action** - Trigger a skill automatically by describing a task
5. **Debug view walkthrough** - Show what Copilot is actually seeing

---

## Title Alternatives

-   From Autocomplete to Autopilot: Mastering GitHub Copilot _(current)_
-   The Copilot Progression: From Tab to Total Automation
-   Beyond Tab Complete: The GitHub Copilot Features You're Missing
-   Copilot Unlocked: A Developer's Guide to AI-Assisted Coding
-   Level Up Your Copilot: From Suggestions to Skills

---

## Notes

-   Target audience: Developers who use Copilot as autocomplete but haven't explored deeper features
-   Angle: Practical, hands-on progression through features
-   Differentiator: Real experience from coaching teams + the skills/automation endgame
