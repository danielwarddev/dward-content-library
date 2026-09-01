---
name: meetup-social-posts
description: Generate social media posts for .NET User Group meetups across Twitter/X, Bluesky, and LinkedIn.
user-invocable: true
disable-model-invocation: true
---

# Meetup Social Posts

Generate social media posts for upcoming San Antonio/Austin .NET User Group meetups across Twitter/X,
Bluesky, and LinkedIn.

## Step 1 — Get the Meetup Link

If the user did not provide a Meetup link, **ask for it and stop immediately.** Do not proceed until
the link is provided.

## Step 2 — Scrape Meetup Details

Use **Playwright MCP** (`browser_navigate`, `browser_snapshot`) to open the link and extract:

- **Title** — the talk/event title
- **Speaker** — speaker's name
- **Date/Time** — event date and time
- **Location** — Zoom for virtual, or venue name/address for in-person
- **Speaker's Twitter/X handle** — look for a Twitter/X link on the page
- **Speaker's LinkedIn** — look for a LinkedIn link on the page

## Step 3 — Ask for Missing Handles

- **Always ask for the speaker's Bluesky handle** (this won't be on Meetup)
- **Only ask for Twitter/X handle** if it wasn't found on the page
- **Only ask for LinkedIn name** if it wasn't found on the page
- **Ask about any products/tools/companies to tag** (e.g., GitHub Copilot, MongoDB, Azure, Semantic Kernel). For each, get the Twitter handle, Bluesky handle, and full name for LinkedIn.

## Step 4 — Research Hashtags

Search (via Playwright MCP) for popular hashtags related to the talk's technology, e.g.
`twitter MAUI .NET`. Always include `#dotnet`, then pick 1–2 additional relevant tags based on the
results (e.g., `#csharp`, `#ai`, `#azure`, `#maui`).

## Step 5 — Write the Posts

Read [references/style-guide.md](references/style-guide.md) before writing — the voice rules matter
more than anything else here.

## Step 6 — Output

Use the exact output format in [references/post-templates.md](references/post-templates.md).

## References

| File | Read it when |
| ---- | ------------ |
| [references/style-guide.md](references/style-guide.md) | Writing the hook and body — voice, emoji conventions, AI-language to avoid |
| [references/post-templates.md](references/post-templates.md) | Assembling posts — virtual/in-person structures, per-platform limits, cross-platform tagging, output format |
