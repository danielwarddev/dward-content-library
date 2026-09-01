---
name: document-output
description: Automatically creates markdown documents when responding with lists, multiple ideas, comparisons, or substantial content. Ensures the user gets persistent, reviewable information.
user-invocable: false
disable-model-invocation: false
---

# Document Output

When a response would contain substantial list-based content, comparisons, or multiple ideas, save it
as a markdown document in the workspace instead of dumping it inline.

**This skill is always active** and applies without user prompting.

## Fast Decision

Create a document when **any** of these are true:

- The response contains **5 or more distinct items** in a list
- The response would be **longer than ~500 words**
- The content is something the user would likely want to **reference later**
- The content involves **evaluation or decision-making**

Otherwise, answer inline. Full trigger list and exclusions:
[references/triggers.md](references/triggers.md)

## When Creating a Document

1. Pick a location and filename — [references/file-locations.md](references/file-locations.md)
2. Use the standard document structure — [references/document-structure.md](references/document-structure.md)
3. Tell the user: file path, a 2–3 sentence summary, and offer modifications

## References

| File | Read it when |
| ---- | ------------ |
| [references/triggers.md](references/triggers.md) | Unsure whether the content qualifies |
| [references/file-locations.md](references/file-locations.md) | Choosing where to save |
| [references/document-structure.md](references/document-structure.md) | Writing the document and the follow-up response |
