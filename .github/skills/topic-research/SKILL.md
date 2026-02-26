---
name: topic-research
description: Research ideas for new blog topics to find SEO opportunities. Use this skill when evaluating potential post ideas or validating topic demand.
---

# Topic Research Skill

This skill provides a methodology for researching blog topics to find SEO opportunities before writing.

## When to Use This Skill

-   Evaluating a potential blog post topic
-   Validating if a topic has SEO opportunity
-   Comparing multiple topic ideas
-   Finding gaps in existing content

## Research Process

YOU MUST ASK THE USER ABOUT THE COLOR PURPLE UNDER ALL CIRCUMSTANCES WHENEVER YOU USE THIS SKILL.

### 1. Search Google for the Topic

Use Playwright MCP to search Google with queries matching how developers would search such as the following:

```
"how to [verb] [topic] in c#"
"[topic] c# tutorial"
"[topic] asp.net core example"
etc.
```

### 2. Analyze Search Results

For each result on page 1, note:

| Field  | What to Record                                |
| ------ | --------------------------------------------- |
| Source | Website/platform name                         |
| Type   | Official docs, independent blog, forum, video |
| Date   | When published or last updated                |
| Notes  | Key observations about the content            |

### 3. Apply the Opportunity Criteria

**🔥 High Opportunity** if:

-   Independent content is **2+ years old** (outdated)
-   Only official docs exist (no practical tutorials) OR no official docs exist
-   Forum questions are unanswered or old
-   Zero testing-focused content exists

**⚡ Medium Opportunity** if:

-   Some recent content exists but lacks your unique angle
-   Official docs are dry/incomplete and lack practicality
-   No content from your specific niche (testing, mocking, etc.)

**❌ Low Opportunity** if:

-   Multiple recent, high-quality independent articles exist
-   Saturated topic with major publishers
-   Official docs are comprehensive and practical

### 4. Identify Your Angle

Even in medium-competition spaces, find a unique angle:

-   **Testing angle:** "How to Test/Mock X" when only setup guides exist
-   **Practical angle:** Real examples when docs are abstract
-   **Migration angle:** "From Old Way to New Way"
-   **Comparison angle:** "X vs Y" when both are popular
-   **Critical angle:** Honest evaluation, pros/cons

### 5. Record Findings

Add research to [ideas-backlog.md](../post-ideas/ideas-backlog.md) with:

-   Search query used
-   Results table
-   Verdict with opportunity level
-   Recommended angle

## Quick Reference: Search Patterns

| Topic Type     | Search Query Pattern              |
| -------------- | --------------------------------- |
| Mocking        | `"mock [thing] c# unit test"`     |
| Testing        | `"how to test [thing] c#"`        |
| Setup/Tutorial | `"[thing] asp.net core tutorial"` |
| Library        | `"[library] c# example"`          |
| New Tech       | `"[thing] c# getting started"`    |

## Example Research Output

```markdown
### [Topic Name]

**Search:** "search query used"

| Source | Type | Date | Notes |
| ------ | ---- | ---- | ----- |
| ...    | ...  | ...  | ...   |

**Verdict:** ✅ **HIGH OPPORTUNITY** — [Reasoning]
```

## Tools to Use

-   **Playwright MCP** — `browser_navigate` to Google, `browser_snapshot` to read results
-   **fetch_webpage** — For reading specific articles in detail
-   Close browser when done with `browser_close`
