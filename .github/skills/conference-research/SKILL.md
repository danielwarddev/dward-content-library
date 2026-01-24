---
name: conference-research
description: Research conferences to understand what talks get accepted. Use this skill to analyze past conference programs, talk topics, and abstract styles before submitting.
---

# Conference Research Skill

This skill helps research conferences to understand what kinds of talks get accepted, informing how to position your submission.

## When to Use This Skill

-   Before writing or refining an abstract for a specific conference
-   Deciding whether a talk idea fits a particular conference
-   Understanding a conference's audience and typical content
-   Comparing conferences to decide where to submit

## Research Process

### Step 1: Gather Conference Information

Ask the user if they did not provide already:

> "Which conference are you targeting? (If you have a link to the conference or its past programs, that helps!)"

### Step 2: Find Past Programs

Use Playwright MCP to research. Conference info can be tricky to find, especially for smaller conferences or those using third-party platforms (Sessionize, Sched, etc.).

**Search strategies:**

1. **Web search first** — Search for `"[conference name] [year] agenda"` or `"[conference name] [year] sessions"` or `"[conference name] [year] schedule"`
2. **Navigate from results** — Once on the site, look for navigation links/buttons labeled "Agenda," "Schedule," "Speakers," "Sessions," or "Program"
3. **Try previous years** — Search for `"[conference name] 2025"`, `"[conference name] 2024"` etc. to find archived programs

**What to gather:**

1. **Conference website** — Find the "Schedule," "Program," or "Past Events" section
2. **Past year schedules** — Look for 2-3 previous years if available
3. **Session/talk listings** — Get titles, abstracts, speaker info, and session tracks

**Common URL patterns to try (if you have the site):**

-   `[conference-site]/schedule`
-   `[conference-site]/program`
-   `[conference-site]/agenda`
-   `[conference-site]/sessions`
-   `[conference-site]/speakers`
-   `[conference-site]/archive` or `[conference-site]/past-events`
-   `[conference-site]/2025` (or previous years)

### Step 3: Analyze Patterns

When reviewing past talks, look for:

#### Topic Patterns

-   What themes appear frequently?
-   What topics seem underrepresented?
-   Are there specific tracks or categories?
-   What level (beginner/intermediate/advanced) dominates?

#### Abstract Style

-   How long are typical abstracts?
-   What tone do they use (formal, conversational, technical)?
-   Do they include specific takeaways/learning objectives?
-   How do they structure the content?

#### Speaker Patterns

-   Mix of first-time vs. returning speakers?
-   Industry vs. community vs. vendor speakers?
-   Solo vs. co-presented talks?

### Step 4: Generate Recommendations

Based on the research, provide:

1. **Fit assessment** — How well does the user's topic fit this conference?
2. **Positioning suggestions** — How to angle the talk for this audience
3. **Level recommendation** — What level tag to use
4. **Track/category suggestion** — Which track to submit to (if applicable)
5. **Abstract style notes** — Any conference-specific style observations
6. **Differentiation opportunities** — Gaps in past programs the talk could fill

### Step 5: Save Research to File

**Always save research findings to a markdown file** in the `conferences/` folder at the root of the workspace.

**File naming convention:** `[conference-name]-[year].md` (e.g., `wearedevelopers-world-congress-2026-na.md`)

**Include in the file:**

-   Conference details (dates, location, CFP deadline, links)
-   Conference profile (focus, size, what they're looking for)
-   All session categories with descriptions
-   Recommendations for existing talks (with category suggestions)
-   New talk ideas that might fit
-   Questions for the user to consider

This creates a reference document for future submissions and helps track which conferences have been researched.

## Output Format

After researching, summarize findings like this:

```
## Conference Research: [Conference Name]

### Conference Profile
- **Focus:** [Main themes/audience]
- **Size/vibe:** [Large enterprise / intimate community / etc.]
- **Talk formats:** [Session lengths, workshops, lightning talks, etc.]

### What Gets Accepted
- **Common topics:** [List]
- **Typical level:** [Beginner/Intermediate/Advanced mix]
- **Abstract style:** [Observations about length, tone, structure]

### For Your Talk: "[Talk Title]"
- **Fit score:** [Strong / Moderate / Stretch]
- **Recommended positioning:** [Suggestions]
- **Suggested track:** [If applicable]
- **Suggested level:** [Beginner/Intermediate/Advanced]
- **Key differentiator:** [What makes this stand out from past talks]
```

## Tips for Effective Research

-   **Look at rejected vs. accepted** — Some conferences publish waitlisted talks too
-   **Check speaker requirements** — Some conferences have specific format requirements for abstracts
-   **Note CFP language** — The Call for Papers often hints at what they're looking for
-   **Review conference themes** — Many conferences have annual themes that influence selection

## Known Conferences

_(Add frequently-submitted conferences here with direct links to their archives)_

| Conference          | Program Archive      | Notes                                      |
| ------------------- | -------------------- | ------------------------------------------ |
| _Example: NDC Oslo_ | _ndcoslo.com/agenda_ | _Strong .NET/software craftsmanship focus_ |

## Related Skills

-   **presentation-abstracts** — Use after this research to write/refine your abstract with conference-specific insights
