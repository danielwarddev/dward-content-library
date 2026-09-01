# Document Format

Save to `story-engine/stories/YYYY-MM-DD-story-engine-scenes.md` using today's date.

## Structure

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

## TOC Anchor Rules

- GitHub-flavored Markdown anchors are generated from headings: lowercase, spaces become `-`, special characters removed.
- `## Card 1 — The Unlucky Artisan` → anchor `#card-1--the-unlucky-artisan`
- Build every TOC link to match the actual heading text exactly.

## Quality Checklist

Before saving, verify:

- [ ] Every card has exactly 3 scenes
- [ ] No two scenes for the same card share a genre
- [ ] Every scene is 200–400 words (not shorter, not a summary)
- [ ] Tension resolution varies across the three scenes
- [ ] At least one scene per card subverts genre expectations
- [ ] Every TOC link has a matching `##` heading in the document
- [ ] The file is saved to `story-engine/stories/`
