---
name: story-engine-scenes
description: Generate 3 full story scenes per story engine card, each in a different genre with varying tension and expectation subversion. Uses one subagent per card and produces a document with a clickable table of contents.
user-invocable: true
disable-model-invocation: true
---

# Story Engine Scenes

Generate three full story scenes (200–400 words each) for every story engine card provided. Each set
of three must span different genres, vary in tension resolution (cleanly resolved vs. ambiguous vs.
unresolved), and include at least one story that subverts genre expectations.

## Input

Check the user's message for story engine card text. If none was provided, **stop immediately and ask
the user to provide the cards.** Blank lines divide cards.

## Workflow

### Step 1 — Parse and Plan

1. Parse all cards from the input
2. Number them sequentially (Card 1, Card 2, …)
3. Create a **todo list** with one item per card, labeled `Card N — [short description]`

### Step 2 — Generate Scenes (One Subagent Per Card)

Spawn a **separate subagent per card**, **sequentially** — wait for each to finish before starting the
next, since each output is needed to assemble the document.

Use the self-contained prompt in
[references/subagent-prompt.md](references/subagent-prompt.md) verbatim, filling in the card details.

Mark the card's todo item complete after the subagent returns.

### Step 3 — Assemble the Document

After all subagents complete, assemble and save the document to
`story-engine/stories/YYYY-MM-DD-story-engine-scenes.md` (today's date), following
[references/document-format.md](references/document-format.md).

### Step 4 — Verify

Run the checklist in [references/document-format.md](references/document-format.md) before saving.

## References

| File | Read it when |
| ---- | ------------ |
| [references/subagent-prompt.md](references/subagent-prompt.md) | Step 2 — the exact prompt template and scene requirements |
| [references/document-format.md](references/document-format.md) | Steps 3–4 — document structure, TOC anchor rules, quality checklist |
