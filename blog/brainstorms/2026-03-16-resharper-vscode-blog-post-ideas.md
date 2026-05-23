# ReSharper for VS Code / Editors — Blog Post Brainstorm

**Generated:** March 16, 2026
**Context:** JetBrains asked for a blog post about their ReSharper extension for VS Code and compatible editors. Can be paid or sponsored. Single post, broad overview, with an AI angle.

---

## Recommended Angle

**"One Extension, Every Editor: How ReSharper Follows Your C# Code Wherever You Go"**

Frame this around YOUR real story: you jump between Visual Studio, VS Code, Rider, and Kiro. That's actually the perfect setup for this post because ReSharper's biggest differentiator vs. C# Dev Kit is exactly this — it works across VS Code, Cursor, Kiro, Windsurf, Google Antigravity, and more. You're the target user.

The AI hook fits naturally: "I write code in Kiro/VS Code with AI assistance, but who's checking the AI's work? ReSharper is."

---

## Title Options (Ranked)

1. **"How ReSharper Keeps My C# Code Clean Across Every Editor I Use"** — personal, matches your title formula loosely, SEO-friendly
2. **"ReSharper Outside Visual Studio: The C# Superpowers You Didn't Know You Had in VS Code, Cursor, and Kiro"** — curiosity-driven, highlights the multi-editor angle
3. **"I Tried ReSharper in VS Code and Kiro — Here's What Surprised Me"** — engagement bait but authentic if you genuinely find surprises
4. **"The Best C# Extension for VS Code Isn't From Microsoft"** — bold/contrarian, high click potential, could ruffle feathers
5. **"How to Level Up AI-Generated C# Code with ReSharper in VS Code"** — AI angle front and center, SEO for "AI-generated C# code"

---

## Recommended Post Structure

### Hook (2-3 paragraphs)
- You jump between editors constantly (VS, VS Code, Rider, Kiro) — that's normal now in the AI era
- The problem: your code quality tooling shouldn't change just because your editor did
- Enter ReSharper — 20+ years of C# intelligence, now available everywhere you code

### Section 1: Works Everywhere (The Killer Differentiator)
- Highlight that it installs in VS Code, Cursor, Kiro, Windsurf, Google Antigravity
- Contrast with C# Dev Kit which is limited to VS Code
- Show screenshots of it running in at least 2 different editors you actually use (VS Code + Kiro)
- Mention it's on both VS Code Marketplace AND Open VSX Registry

### Section 2: The AI Guardrails Angle
- AI tools generate C# code fast, but not always clean
- Show an example: paste some AI-generated code, let ReSharper light it up with suggestions
- Demo the **quick-fix for scope** feature (file/folder/project/solution) — JetBrains called this "the most underrated feature"
- Story: "I asked Copilot to generate a service class. ReSharper caught 4 things: old syntax, missing null checks, unused using, naming convention violation. One click → fix all across the project."

### Section 3: Solution Explorer — More Than a File Tree
- NuGet package manager built in (no terminal needed)
- Source generators shown as a dedicated node with all generated files visible
- For developers coming from Visual Studio or Rider, this feels familiar and productive

### Section 4: Navigation That Actually Impresses
- **Navigate to external sources** — this is the showstopper feature
  - Downloads real source files from symbol servers OR decompiles the DLL
  - Show a concrete example: Ctrl+Click into an ASP.NET Core middleware method → see the actual Microsoft source
- Find usages across the entire solution
- Go to type/symbol/file search

### Section 5: Refactorings & Code Analysis
- Available refactorings: Rename, Extract Method, Extract Property, Extract Local Function, Introduce Variable
- Quick demo of Extract Method on a chunk of code
- Code analysis with real-time inspections
- **Scope-based quick fixes** (reinforce from Section 2): apply a fix to an entire project/solution at once
  - Example: "Convert all old-style C# to modern syntax across 50 files in seconds"

### Section 6: Unit Testing (Brief — Your Audience Cares)
- Built-in test runner for NUnit, xUnit, MSTest
- Browse tests, run selections, see detailed output
- Navigate from failed test directly to source
- Brief mention that this rounds out the "full IDE experience in a lightweight editor"

### Section 7: Licensing — The Free Tier Is Generous
- Free for non-commercial use (learning, open source, content creation, hobby projects)
- Content creation is explicitly covered — bloggers, streamers, tutorial makers
- Commercial use requires a paid license (ReSharper, dotUltimate, or All Products Pack)
- Also supports .NET Framework projects, not just modern .NET

### Wrap-Up
- For developers who live in multiple editors (or are exploring AI-first editors like Kiro/Cursor), ReSharper removes the "but I lose my tooling" objection
- Link to install: marketplace + Open VSX
- Link to JetBrains docs for getting started

---

## Key Features to Demo (Priority Order)

| # | Feature | Why It Matters | Demo Complexity |
|---|---------|---------------|-----------------|
| 1 | Multi-editor compatibility | THE differentiator vs. C# Dev Kit | Screenshot comparison |
| 2 | Quick-fix for scope (file/project/solution) | "Underrated" per JetBrains, huge time saver | Before/after code |
| 3 | Navigate to external sources | Genuinely impressive, hard to replicate | Screenshot of decompiled source |
| 4 | AI code quality checking | Timely hook, matches market trend | Paste AI code → show suggestions |
| 5 | Solution Explorer + NuGet + Source Generators | Familiar for VS/Rider users | Screenshot |
| 6 | Refactorings (Extract Method, etc.) | Core productivity | Quick GIF or screenshot |
| 7 | Unit test runner | Matches your blog's audience | Brief mention |

---

## Engagement & SEO Notes

- **Internal linking opportunity:** Link to your existing testing posts (mocking HttpClient, TestContainers) as "here's what I test — here's how ReSharper helps me write it cleaner"
- **Differentiation:** Your blog doesn't have IDE/extension review content — this is unique and could attract a different search audience
- **CTA:** Encourage readers to try it with the free non-commercial license
- **Estimated length:** ~200-300 lines of markdown (your sweet spot)
- **Screenshots:** Plan for 5-7 screenshots minimum (install, solution explorer, code analysis, navigation, refactoring, test runner, multi-editor)

---

## What NOT to Cover (Keep It Focused)

- Don't deep-dive into every code inspection — just show the highlights
- Don't compare feature-for-feature with Rider (different product, different audience)
- Don't spend time on installation steps — link to JetBrains docs instead
- Don't cover XAML/Blazor/Razor unless you have a natural use case with them

---

## Notes

- JetBrains specifically asked you to highlight: wide editor compatibility, Solution Explorer (NuGet + source generators), refactorings, navigate to external sources, and quick-fix for scope
- The AI angle is your own editorial hook — makes it timely and relevant rather than just a feature list
- Your authentic multi-editor workflow is genuinely the best framing for this post
