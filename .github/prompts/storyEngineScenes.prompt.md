---
name: storyEngineScenes
agent: agent
description: Generate 3 full story scenes per story engine card, each in a different genre with varying tension and expectation subversion. Uses parallel subagents per card and produces a document with a clickable table of contents.
argument-hint: Paste or attach your story engine cards (one card per line or section). If none are provided, the agent will read from story-engine.md.
tools: [agent, edit, read, todo]
---

# Story Engine Scenes Generator

Generate three full story scenes (200–400 words each) for every story engine card provided. Each set of three scenes must span different genres, vary in tension resolution (cleanly resolved vs. ambiguous vs. unresolved), and include at least one story that subverts genre expectations.

## Input

Check the user's message for story engine card text. If none was provided, stop immediately and ask the user to provide the cards.

Parse each card as a distinct unit. Blank lines divide cards.

---

## Workflow

### Step 1 — Parse and Plan

1. Parse all cards from the input or `story-engine.md`.
2. Number them sequentially (Card 1, Card 2, …).
3. Create a **todo list** using the todo tool: one item per card, labeled `Card N — [short description]`.

### Step 2 — Generate Scenes (One Subagent Per Card)

For each card, use the `#runSubagent` tool to spawn a **separate subagent**. Do this **sequentially** — wait for each subagent to finish before starting the next (the output of each subagent is needed to assemble the document).

Each subagent receives a self-contained prompt that includes:

- The full card text
- The card number and a short slug for the heading anchor
- The scene requirements (see below)

**Subagent prompt template to use:**

> You are writing three story scenes based on a story engine card. Do not save any files. Return only the formatted markdown text.
>
> **Card N — [Card short title]**
> Card text: [full card text]
>
> Write exactly three scenes, each 200–400 words. Format as:
>
> ### Idea 1 — *[Title]* ([Genre])
> [scene text]
>
> ### Idea 2 — *[Title]* ([Genre])
> [scene text]
>
> ### Idea 3 — *[Title]* ([Genre])
> [scene text]
>
> Requirements:
> - Each scene must be a **different genre** (pick from: Dark Fantasy, Literary, Magical Realism, Thriller, Horror, Sci-Fi, Cozy Fantasy, Noir, Mythic Fantasy, Historical Mystery, Dark Comedy, Post-Apocalyptic, Gothic, Cosmic Horror, Folklore, Psychological Thriller, Social Satire, Epic Fantasy, Atmospheric).
> - Vary the **tension resolution** across the three scenes: one should resolve cleanly, one ambiguously, one should leave tension unresolved or escalating.
> - At least one scene must **subvert genre expectations** (e.g., a horror card played for deadpan comedy, a cozy card that ends on dread, a thriller card resolved absurdly).
> - Be creative. Make the scenes feel complete and distinct — not variations of each other.

Mark the card's todo item as complete after the subagent returns.

### Step 3 — Assemble the Document

After all subagents have completed, assemble the full document and save it to:

```
story-engine/stories/YYYY-MM-DD-story-engine-scenes.md
```

Use today's date for the filename.

**Document structure:**

```markdown
# Story Engine Scenes — YYYY-MM-DD

Generated from story engine cards. Three full scenes per card — different genres, varying tension resolution, and expectation subversion.

---

## Table of Contents

- [Card 1 — Short Title](#card-1--short-title)
- [Card 2 — Short Title](#card-2--short-title)
- …

---

## Card 1 — [Short Title]

> **Card:** [full card text reproduced verbatim]

[Subagent output — three scenes]

---

## Card 2 — [Short Title]

> **Card:** [full card text reproduced verbatim]

[Subagent output — three scenes]

---

…

*End of document. [N] cards × 3 scenes = [N×3] stories.*
```

**Anchor rules for the TOC:**
- GitHub-flavored Markdown anchors are generated from headings: lowercase, spaces become `-`, special characters removed.
- `## Card 1 — The Unlucky Artisan` → anchor `#card-1--the-unlucky-artisan`
- Build every TOC link to match the actual heading text exactly.

---

## Quality Checklist

Before saving, verify:
- [ ] Every card has exactly 3 scenes
- [ ] No two scenes for the same card share a genre
- [ ] At least one scene per card is 200–400 words (not shorter, not a summary)
- [ ] Every TOC link has a matching `##` heading in the document
- [ ] The file is saved to `story-engine/stories/`
