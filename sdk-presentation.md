<!-- Slide number: 1 -->
# Put An Agent Inside Your App In 10 Minutes Or Less With the GitHub Copilot SDK

<!-- Slide number: 2 -->

![A black background with blue text Description automatically generated](Picture6.jpg)
# Who am I?

![A blue and white diamond with letters Description automatically generated](Picture3.jpg)
https://leantechniques.com
Software developer, consultant
Microsoft .NET MVP
Co-organizer of the San Antonio/Austin .NET User Group
🌐 daninacan.com
      @danielwarddev
       daniel-ward-dev
       danielwarddev.bsky.social

![A blue and white logo Description automatically generated](Picture4.jpg)

![A black background with a black square Description automatically generated with medium confidence](Picture8.jpg)

![A blue and black logo Description automatically generated](Picture5.jpg)

![](Graphic9.jpg)

![A blue butterfly on a black background Description automatically generated](Picture10.jpg)

<!-- Slide number: 3 -->
# Outline
GitHub Copilot SDK
What’s an agent?
How the SDK works + features
Why use the SDK?
Coding demo –“10 minutes or less”
Coding demo – realistic example

<!-- Slide number: 4 -->
# What is the GitHub Copilot SDK?
Open-source SDK to call GitHub Copilot from code
Code snippet here

<!-- Slide number: 5 -->
# What is an agent?
Agent

LLM

<!-- Slide number: 6 -->
# What is an agent?

Agent
Python sandbox
Asking about math?
Answer
LLM
Prompt
LLM
Yes
No

<!-- Slide number: 7 -->
# What is an agent?

Agent
Answer
Prompt

<!-- Slide number: 8 -->
# Agent examples

<!-- Slide number: 9 -->
# Why would I want an agent in my app?

<!-- Slide number: 10 -->
# What is the GitHub Copilot SDK?
Open-source SDK to call GitHub Copilot from code
Official: Typescript, Python, Go, C#
Unofficial: Java, Rust, Clojure, C++
Talks to Copilot CLI through JSON-RPC

<!-- Slide number: 11 -->
App

JSON RPC
Copilot CLI
Copilot SDK

<!-- Slide number: 12 -->
# Copilot SDK features
Need CLI installed on the host machine. Optionally bundle with app
Everything Copilot normally has in the CLI – agents, skills, MCP, etc.
Some features are not available by design
Export to file, interactive UI, YOLO mode, more
Supports BYOK – use API key from OpenAI, Azure, Anthropic, etc.
Auth – signed in CLI user, GitHub OAuth, env vars, BYOK

<!-- Slide number: 13 -->
# Tool calling
Normal code that you register as tools to the LLM

![](Picture3.jpg)

![](Picture4.jpg)

<!-- Slide number: 14 -->
# Wait! Can’t I just do that with prompts?
Yes!
But…
App workflow vs. prompt workflow
There’s no playbook for this yet

<!-- Slide number: 15 -->
Creative analysis
Normal prompting
Copilot SDK
User owns the flow
Task is completely exploratory; there’s no “correct flow”
- Less reliable
+ Less setup

App owns the flow
Put deterministic flow/guardrails around AI work
+ More reliable
- More setup

<!-- Slide number: 16 -->
# Some examples
| Use case | SDK or prompting? | Reason |
| --- | --- | --- |
| Triage incoming defects | SDK | Fixed flow; AI pieces things together |
| Pair programming/code review | Prompting | Context heavy; back-and-forth |
| In-app product recommendations | SDK | AI embedded in the data flow |
| Brainstorming product names | Prompting | No tools needed; conversation is the process |

<!-- Slide number: 17 -->

![Computer script on a screen](Picture16.jpg)
# Coding Demo
Requirements
Copilot license (free)
CLI installed

<!-- Slide number: 18 -->

![Computer script on a screen](Picture16.jpg)
# Demo app
MVP generator
Input
Markdown file describing the app and its requirements
Optional additional files for context
Output
Working C# app complete with tests, UI, etc.

<!-- Slide number: 19 -->
Phase 1:
Planning
Phase 2:
Generation
Phase 3:
Verification
🛠️Locate idea file
🤖Generate slug
🛠️ Validate slug regex
🛠️ Copy over scripts, create folder
🤖 Generate implementation plan + spec files
🛠️ Validate spec count (between 0 and max)
🛠️Loop over each spec file
🤖 Implement the spec fully as code, verify tests pass + builds
🤖 Verify all user flows work as expected
🤖 Generate README

<!-- Slide number: 20 -->
# Recap
https://github.com/github/copilot-sdk/
Getting Started
Lots of code samples
https://github.com/github/awesome-copilot/tree/main/cookbook/copilot-sdk
Practical examples/patterns
VS Code Youtube channel