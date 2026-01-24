---
name: meetupSocialPosts
agent: agent
description: "Generate social media posts for .NET User Group meetups across Twitter/X, Bluesky, and LinkedIn"
---

# Social Media Post Generator for .NET User Group Meetups

Generate social media posts for upcoming San Antonio/Austin .NET User Group meetups across Twitter/X, Bluesky, and LinkedIn.

## Instructions

### Step 1: Get the Meetup Link

If the user did not provide a Meetup link, ask for it and **stop immediately**. Do not proceed until the link is provided.

### Step 2: Scrape Meetup Details

Once you have the Meetup link, use **Playwright MCP** (`mcp_microsoft_pla_browser_navigate` and `mcp_microsoft_pla_browser_snapshot`) to open the link and extract:

- **Title**: The talk/event title
- **Speaker**: Speaker's name
- **Date/Time**: The event date and time
- **Location**: Zoom for virtual, or venue name/address for in-person
- **Speaker's Twitter/X handle**: Look for a Twitter/X link on the page
- **Speaker's LinkedIn**: Look for a LinkedIn link on the page

### Step 3: Ask for Missing Handles

After scraping the Meetup page:

- **Always ask for the speaker's Bluesky handle** (this won't be on Meetup)
- **Only ask for Twitter/X handle** if it wasn't found on the Meetup page
- **Only ask for LinkedIn name** if it wasn't found on the Meetup page
- **Ask about any products/tools/companies to tag**: e.g., GitHub Copilot, MongoDB, Azure, Semantic Kernel
    - For each, ask for the Twitter handle, Bluesky handle, and full name for LinkedIn

## Platform Requirements

1. **Twitter/X**: Maximum 280 characters
2. **Bluesky**: Maximum 300 characters
3. **LinkedIn**: No character limit

## Style Guidelines

Reference existing posts in the `user-group/` folder for examples of phrasing, structure, and marketing style.

### General Style

- Start with a catchy hook or question related to the topic
- Use relevant hashtags like #dotnet, #csharp, #ai, etc.
- Include emojis for visual structure:
    - 🎤 or 🎙 for the talk title
    - 👨‍🏫 or 👨‍💼 for the speaker
    - ⌚ or 📆 for the date/time
    - 🌐 for the location
- End with "Signup:" or "Sign up here:" followed by the Meetup link
- For in-person events, add 🗣️ at the start and mention food/drinks if applicable

### Post Structure - Virtual Meetup

```
[Hook/teaser about the topic] #dotnet

🎤What: [Talk Title]
👨‍🏫Who: [Speaker Name]
⌚When: [Date] @ [Time] CST
🌐Where: Zoom

Signup: [meetup link]
```

### Post Structure - In-Person Meetup

```
🗣️In-person Austin DNUG meetup this Thursday! [Brief description]

🎤What: [Talk Title]
👨‍🏫Who: [Speaker Name]
⌚When: [Date] @ [Time] CST
🌐Where: [Venue Name]

Signup: [meetup link]
```

## Cross-Platform Notes

- Twitter and Bluesky posts are typically **identical** except for account tagging:
    - Twitter uses @handles (e.g., @GitHubCopilot)
    - Bluesky uses @handle.bsky.social format (e.g., @github.bsky.social)
- LinkedIn post can be the same, or slightly expanded with more context since there's no character limit
- LinkedIn uses full names instead of handles (e.g., "GitHub Copilot" instead of @GitHubCopilot)

## Output Format

Provide the posts in this format, including character counts for Twitter and Bluesky:

### Twitter/X

**Character count: X/280**

```
[post content]
```

### Bluesky

**Character count: X/300**

```
[post content]
```

### LinkedIn

```
[post content]
```
