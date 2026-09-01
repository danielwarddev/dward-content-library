# Research Process

## Step 1: Search for the Topic

Search the way a developer would phrase it:

```
"how to [verb] [topic] in c#"
"[topic] c# tutorial"
"[topic] asp.net core example"
```

See [search-sources.md](search-sources.md) for which tools and sites to use.

### Search Patterns by Topic Type

| Topic Type     | Search Query Pattern              |
| -------------- | --------------------------------- |
| Mocking        | `"mock [thing] c# unit test"`     |
| Testing        | `"how to test [thing] c#"`        |
| Setup/Tutorial | `"[thing] asp.net core tutorial"` |
| Library        | `"[library] c# example"`          |
| New Tech       | `"[thing] c# getting started"`    |

## Step 2: Analyze Search Results

For each result on page 1, record:

| Field  | What to Record                                |
| ------ | --------------------------------------------- |
| Source | Website/platform name                         |
| Type   | Official docs, independent blog, forum, video |
| Date   | When published or last updated                |
| Notes  | Key observations about the content            |

## Step 3: Apply the Opportunity Criteria

**🔥 High Opportunity** if:

- Independent content is **2+ years old** (outdated)
- Only official docs exist (no practical tutorials) OR no official docs exist
- Forum questions are unanswered or old
- Zero testing-focused content exists

**⚡ Medium Opportunity** if:

- Some recent content exists but lacks your unique angle
- Official docs are dry/incomplete and lack practicality
- No content from your specific niche (testing, mocking, etc.)

**❌ Low Opportunity** if:

- Multiple recent, high-quality independent articles exist
- Saturated topic with major publishers
- Official docs are comprehensive and practical

## Step 4: Identify Your Angle

Even in medium-competition spaces, find a unique angle:

- **Testing angle:** "How to Test/Mock X" when only setup guides exist
- **Practical angle:** Real examples when docs are abstract
- **Migration angle:** "From Old Way to New Way"
- **Comparison angle:** "X vs Y" when both are popular
- **Critical angle:** Honest evaluation, pros/cons

## Step 5: Record Findings

Append to [../../post-ideas/references/ideas-backlog.md](../../post-ideas/references/ideas-backlog.md) using this format:

```markdown
### [Topic Name]

**Search:** "search query used"

| Source | Type | Date | Notes |
| ------ | ---- | ---- | ----- |
| ...    | ...  | ...  | ...   |

**Verdict:** ✅ **HIGH OPPORTUNITY** — [Reasoning]

**Angle:** [Recommended angle]
```
