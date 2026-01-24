---
name: document-output
description: Automatically creates markdown documents when responding with lists, multiple ideas, comparisons, or substantial content. Ensures the user gets persistent, reviewable information.
---

# Document Output Skill

This skill ensures that when the AI generates substantial list-based content, comparisons, or multiple ideas, it automatically creates a markdown document instead of (or in addition to) displaying inline content.

## When to Use This Skill

This skill is **ALWAYS active** and should be applied automatically without user prompting.

### Trigger Criteria

Automatically create a markdown document when any of the following conditions are met:

1. **Numbered Lists of Ideas**: User asks for "X ideas," "X suggestions," "X examples," "X ways to..." (e.g., "10 blog post ideas," "5 ways to improve...")
2. **Resource Lists**: User asks for websites, tools, resources, books, courses, etc. (e.g., "10 websites for...", "best tools for...")
3. **Comparisons**: Comparing and contrasting two or more concepts, tools, approaches, or ideas
4. **Pros/Cons Analysis**: Evaluating advantages and disadvantages of something
5. **Multiple Options**: Presenting several options or alternatives for the user to evaluate
6. **Research Summaries**: Summarizing findings from research that includes multiple data points
7. **Brainstorming Sessions**: Any creative ideation that produces multiple outputs
8. **Step-by-Step Guides**: Multi-step processes or tutorials with substantial content
9. **Large amounts of content**: In general, any response that has a large amount of output to parse.

### Threshold Guidelines

Create a document when:

-   The response contains **5 or more distinct items** in a list
-   The response would be **longer than ~500 words**
-   The content is something the user would likely want to **reference later**
-   The content involves **evaluation or decision-making**

## How to Implement

### 1. Create the Document

-   Save the markdown file in a logical location within the workspace
-   Use a descriptive filename with date prefix when appropriate
-   Include proper markdown formatting (headers, lists, tables, etc.)

### 2. Suggested File Locations

| Content Type        | Suggested Location                                 |
| ------------------- | -------------------------------------------------- |
| Blog ideas          | `blog/content-posts/ideas/` or `blog/brainstorms/` |
| Conference research | `conferences/research/`                            |
| Presentation ideas  | `presentations/todo-ideas/`                        |
| General research    | `research/` or project root                        |
| Tool comparisons    | `research/comparisons/`                            |

### 3. Document Structure

Include in the document:

```markdown
# [Descriptive Title]

**Generated:** [Date]
**Context:** [Brief description of what was requested]

---

[Main content with proper formatting]

---

## Notes

[Any additional context, caveats, or follow-up suggestions]
```

### 4. Inform the User

After creating the document:

-   Tell the user that a document was created
-   Provide the file path/link
-   Offer a brief summary (2-3 sentences) of what's in the document
-   Ask if they want any modifications or additional information

## Example Behaviors

### Example 1: User asks "Give me 10 blog post ideas about testing"

**Do:**

1. Create `blog/brainstorms/2026-01-16-testing-blog-ideas.md`
2. Include all 10 ideas with descriptions, SEO notes, and priority indicators
3. Respond: "I've created a document with 10 testing blog post ideas at [blog/brainstorms/2026-01-16-testing-blog-ideas.md](blog/brainstorms/2026-01-16-testing-blog-ideas.md). The ideas range from beginner topics like mocking basics to advanced concepts like mutation testing. Want me to expand on any of these or add SEO research?"

### Example 2: User asks "Compare NSubstitute vs Moq"

**Do:**

1. Create `research/comparisons/nsubstitute-vs-moq.md`
2. Include feature comparison table, pros/cons, use cases, code examples
3. Respond with summary and file location

### Example 3: User asks "What are some good testing conferences?"

**Do:**

1. Create `research/testing-conferences.md`
2. Include conference names, dates, locations, CFP deadlines, focus areas
3. Respond with summary and file location

## When NOT to Create a Document

-   Simple, short answers (fewer than 5 items, under ~300 words)
-   Single direct answers to questions
-   Code snippets or quick fixes
-   Conversational responses
-   When the user explicitly asks for inline response only

## Benefits

-   User gets **more comprehensive information** since document format allows for richer detail
-   Content is **persistent and searchable** in the workspace
-   User can **review and edit** the content later
-   Enables **richer formatting** like tables and detailed subsections
-   Reduces **context window pressure** in long conversations
