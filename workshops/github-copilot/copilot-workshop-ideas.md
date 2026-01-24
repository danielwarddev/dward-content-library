# GitHub Copilot Workshop: Content Ideas & Demo Projects

## Additional Content Ideas

### Foundational Concepts (Expand Current Outline)

1. **"What AI Can and Can't Do" Section**

    - Set realistic expectations upfront
    - AI as a tool, not a replacement
    - The "trust but verify" mindset
    - When Copilot shines vs when it struggles

2. **Privacy & Security Considerations**

    - What code gets sent to GitHub/OpenAI?
    - Public vs private repository handling
    - Sensitive data awareness (API keys, credentials)
    - Content exclusions for enterprise (mention briefly)

3. **Copilot Free Plan Limitations**
    - Monthly completion limits
    - Chat request limits
    - Feature availability comparison with Pro
    - How to maximize the free tier

### Productivity Techniques (New Section)

4. **The Art of Good Prompts**

    - Specific vs vague prompts (side-by-side examples)
    - Providing context: "I'm building a REST API that..."
    - Asking for alternatives: "Give me 3 ways to..."
    - Iterative refinement: "That's close, but can you..."

5. **Copilot for Learning**

    - "Explain this code to me like I'm a junior dev"
    - "What are the pros/cons of this approach?"
    - "What edge cases am I missing?"
    - Using `/explain` and `/doc` commands

6. **Common Mistakes & How to Avoid Them**
    - Blindly accepting suggestions without reading
    - Not providing enough context
    - Asking overly complex questions in one prompt
    - Ignoring the confidence signals

### Advanced Techniques (Expand Current Outline)

7. **Working with Existing Codebases**

    - Using `@workspace` effectively
    - Asking about unfamiliar code
    - Refactoring with Copilot's help
    - Finding bugs and security issues

8. **Test-Driven Development with Copilot**

    - Writing tests first, letting Copilot implement
    - Generating test cases from implementation
    - Edge case discovery

9. **Documentation Generation**
    - README generation
    - API documentation
    - Code comments and JSDoc/XMLDoc
    - Commit message generation

### Tools & Integrations (New Section)

10. **GitHub Copilot in the Terminal**

    -   `gh copilot explain` for command explanations
    -   `gh copilot suggest` for command generation
    -   Piping output to Copilot

11. **Copilot Edits Deep Dive**

    -   Multi-file editing workflows
    -   When to use Edit mode vs Agent mode
    -   Reviewing and accepting/rejecting changes

12. **MCP Servers Worth Knowing**
    -   File system MCP
    -   Database MCPs (Postgres, SQLite)
    -   Browser/Playwright MCP for web automation
    -   Building your own simple MCP server (advanced, optional)

### Real-World Workflows (New Section)

13. **Debugging with Copilot**

    -   Attaching error messages to chat
    -   "Why is this failing?" workflows
    -   Using the debug console integration

14. **Code Review Assistance**

    -   "Review this code for issues"
    -   Security vulnerability detection
    -   Performance suggestions

15. **Pair Programming with AI**
    -   When to lean on Copilot heavily vs code yourself
    -   Building intuition for AI assistance
    -   Staying engaged and learning (not just copy-paste)

---

## Demo Project Ideas for Attendees

### Beginner-Friendly (Recommended for Mixed Audience)

#### Option A: Task/Todo CLI Application

**Why it works:**

-   Simple domain everyone understands
-   Covers CRUD operations
-   Can be done in any language
-   Easy to extend with features

**Progression:**

1. Create basic task structure/class
2. Add tasks, list tasks, complete tasks
3. Save/load from JSON file
4. Add categories or priorities
5. (Stretch) Add due dates and reminders

**Copilot skills demonstrated:**

-   Code generation from natural language
-   File I/O patterns
-   Data structure suggestions
-   Error handling

---

#### Option B: Simple REST API

**Why it works:**

-   Practical skill for any developer
-   Clear request/response patterns
-   Natural for Copilot to assist with

**Progression:**

1. Set up minimal web server (Express/ASP.NET Minimal API)
2. Create GET endpoint for a resource
3. Add POST endpoint with validation
4. Add error handling
5. (Stretch) Add simple authentication

**Copilot skills demonstrated:**

-   Boilerplate generation
-   Route handling
-   Middleware patterns
-   Inline suggestions for common patterns

---

#### Option C: Utility Script Collection (Lowest Barrier)

**Why it works:**

-   No project structure needed
-   Immediate results
-   Real-world useful outputs

**Examples to build:**

-   File renaming script (batch rename with pattern)
-   CSV to JSON converter
-   Web scraper for a simple page
-   Markdown link checker
-   Git stats reporter

**Copilot skills demonstrated:**

-   Quick prototyping
-   Working with files and I/O
-   Parsing and data transformation

---

### Intermediate Options (If Audience Skews Experienced)

#### Option D: Refactoring Challenge

**Setup:** Provide a deliberately messy codebase
**Task:** Use Copilot to:

1. Understand what the code does
2. Identify issues
3. Refactor step by step
4. Add tests

**Why it works:**

-   Realistic scenario
-   Shows Copilot's analysis capabilities
-   Less "blank page" anxiety

---

#### Option E: Add Feature to Existing Project

**Setup:** Provide a working starter project
**Task:** Add a specific feature using Copilot

**Example:** Given a basic note-taking app:

-   Add search functionality
-   Add export to Markdown
-   Add tagging system

---

## Hands-On Exercise Ideas (Throughout Workshop)

### Quick Exercises (5-10 minutes each)

1. **First Contact:** Ask Copilot to explain a piece of code you provide
2. **Prompt Battle:** Same task, compare different prompt approaches
3. **Bug Hunt:** Given broken code, use Copilot to find and fix bugs
4. **Test Generation:** Given a function, generate comprehensive tests
5. **Documentation Dash:** Generate docs for an undocumented function

### Longer Labs (20-30 minutes)

1. **MCP Setup:** Install and configure an MCP server, then use it
2. **Custom Instructions:** Write copilot-instructions.md for a project
3. **Agent Mode Build:** Build a small feature entirely in agent mode
4. **CLI Challenge:** Solve a series of terminal tasks with Copilot CLI

---

## Content That Could Be Cut (If Running Long)

**Priority Cuts (Remove First):**

-   Coding Agent (newer feature, could be briefly mentioned)
-   Custom agents (advanced, not essential for beginners)
-   Advanced RPI/Spec Kit discussion
-   Hooks

**Secondary Cuts:**

-   Deep dive on MCP internals
-   Copilot Code Review on PRs (more relevant for teams)
-   Multiple model comparisons

**Keep At All Costs:**

-   Basic chat/inline usage
-   Prompting techniques
-   Context and instructions
-   Hands-on project time
-   Edit vs Agent mode basics

---

## Resources to Share with Attendees

1. **GitHub Copilot Docs:** https://docs.github.com/en/copilot
2. **Free Plan Details:** https://docs.github.com/en/copilot/get-started/plans
3. **VS Code Copilot Extension:** Marketplace link
4. **awesome-copilot repo** (from your notes)
5. **Your copilot-instructions.md examples** (if you're sharing)
6. **Cheat sheet** (consider creating a 1-pager for attendees)

---

## Possible Workshop Themes/Titles

-   "From Zero to AI Pair Programmer: A GitHub Copilot Workshop"
-   "Unlock Your Coding Superpowers with GitHub Copilot"
-   "Practical AI-Assisted Development: A Hands-On Copilot Workshop"
-   "GitHub Copilot: The Complete Developer's Guide"
