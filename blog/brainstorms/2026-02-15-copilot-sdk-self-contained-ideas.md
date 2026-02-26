# Copilot SDK Blog Post Ideas: Self-Contained (Hooks + Custom Tools + MCP)

**Generated:** 2026-02-15  
**Context:** Blog post demo ideas for the GitHub Copilot SDK in C#/.NET. Each idea uses all three SDK features (hook, custom tool, MCP server) and is **fully self-contained** — a reader clones one repo, runs the app, and everything works. No external accounts, repos, CI pipelines, or infrastructure required.

---

## Self-Contained Constraint

Every idea must:

- Ship with all sample data/files in the repo itself
- Use an MCP server that works locally without external credentials (Playwright, filesystem, etc.)
- Require no setup beyond `dotnet run` (and maybe `npm install` for a sample app)
- Produce visible output a reader can screenshot for their own experimentation

---

## Ideas

### 1. Local Recipe Site Nutrition Auditor

**The problem:** You have a small recipe website (or any content site) and you want to check if the nutrition claims on each page are internally consistent — does the ingredient list actually support "high protein" or "low carb" labels?

**What it does:** The agent navigates a local static site (included in the repo), reads each recipe page, extracts ingredients and nutrition claims, and cross-checks them using a custom tool that knows basic nutrition facts. Produces a report of inconsistencies.

**What ships in the repo:** A small static HTML site (3-5 recipe pages) served via `dotnet serve` or a simple file server.

| Feature         | How It's Used                                                                                                                                                                                                       |
| --------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **MCP Server**  | **Playwright MCP** — navigates the local recipe site, reads page content and structured data                                                                                                                        |
| **Custom Tool** | `LookupNutrition` — given an ingredient and quantity, returns approximate macros from a hardcoded dictionary. `ValidateClaim` — given a nutrition claim ("high protein") and actual macro totals, returns pass/fail |
| **Hook**        | `afterToolCall` — tallies pass/fail counts per page and tracks which claims fail most often across the whole site. Builds the summary statistics for the final report                                               |

**Why it's good for a blog post:** Fun and relatable (everyone eats). Zero external dependencies. The hook pattern (aggregating results across many tool calls) is practical and easy to explain. Readers can swap in their own site.

**Scope:** ~80-100 lines of SDK code. Sample site is ~5 HTML files.

---

### 2. Portfolio Site SEO & Link Checker

**The problem:** You have a personal portfolio or blog running locally and you want to check for broken links, missing meta tags, missing alt text on images, and basic SEO issues before deploying.

**What it does:** The agent crawls your locally-running site, checks each page for SEO basics and broken links, and produces a prioritized fix list.

**What ships in the repo:** A small multi-page HTML portfolio site with intentional issues planted (broken links, missing alt text, missing meta descriptions).

| Feature         | How It's Used                                                                                                                                                                                                                                 |
| --------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **MCP Server**  | **Playwright MCP** — navigates each page, captures accessibility snapshots, follows links to detect 404s, reads meta tags                                                                                                                     |
| **Custom Tool** | `CheckSEORule` — evaluates a page against a specific SEO rule (title length, meta description present, heading hierarchy, etc.) from a configurable rule set. `ReportBrokenLink` — records a broken link with its source page and anchor text |
| **Hook**        | `beforeToolCall` — restricts the agent to only navigate URLs on `localhost` (prevents it from crawling out to the real internet). A clean, relatable safety guardrail                                                                         |

**Why it's good for a blog post:** Developers with portfolio sites immediately relate. The localhost-only hook is a perfect "here's why hooks matter" teaching moment. Readers clone, run, see results, and can point it at their own site.

**Scope:** ~90-120 lines of SDK code. Sample site is ~4-6 HTML files.

---

### 3. Local Markdown Knowledge Base Q&A With Source Citations

**The problem:** You have a folder of markdown files (docs, notes, runbooks, wiki pages) and you want to ask questions and get answers with exact file + line citations. Like a local RAG system but simpler.

**What it does:** The agent reads markdown files from a local folder, answers your question, and cites exactly which file and section the answer came from. Not a full RAG pipeline — the SDK's agentic loop handles the "search, read, synthesize" workflow naturally.

**What ships in the repo:** A `knowledge-base/` folder with 10-15 markdown files covering a fictional product's documentation (setup guide, API reference, troubleshooting, FAQ).

| Feature         | How It's Used                                                                                                                                                                                                                                                                                                      |
| --------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **MCP Server**  | **Filesystem MCP** — lists files in the knowledge base directory, reads file contents on demand. The agent decides which files to read based on the question                                                                                                                                                       |
| **Custom Tool** | `SearchFiles` — does a simple text search across all markdown files and returns matching filenames + line numbers. Gives the agent a fast way to narrow down which files to read in full. `FormatCitation` — takes a file path, line range, and extracted quote, and formats it as a clean markdown citation block |
| **Hook**        | `afterToolCall` — tracks which files the agent accessed and which it cited in the answer. At the end, appends a "Sources consulted but not cited" section so the user can see the agent's reasoning process                                                                                                        |

**Why it's good for a blog post:** Extremely practical — every developer has a docs folder. The "show your work" hook (sources consulted vs cited) is a unique transparency pattern readers haven't seen. Filesystem MCP is dead simple to set up.

**Scope:** ~70-100 lines of SDK code. Knowledge base is ~15 markdown files.

---

### 4. CSS Theme Contrast Checker

**The problem:** You're building a dark mode for your site and you need to verify that all text/background color combinations meet WCAG AA contrast ratios. Manually checking dozens of combinations is tedious.

**What it does:** The agent navigates your locally-running site in both light and dark modes, extracts all foreground/background color pairs from rendered elements, calculates contrast ratios, and flags violations.

**What ships in the repo:** A small HTML/CSS site with light and dark themes, some combinations intentionally failing contrast checks.

| Feature         | How It's Used                                                                                                                                                                                                                        |
| --------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **MCP Server**  | **Playwright MCP** — navigates the local site, toggles dark mode via a class or media query override, runs JavaScript to extract computed colors from elements                                                                       |
| **Custom Tool** | `CalculateContrast` — implements the WCAG 2.1 relative luminance formula to compute contrast ratio between two hex/rgb colors. `ClassifyViolation` — given a contrast ratio and text size, determines if it fails AA, AAA, or passes |
| **Hook**        | `beforeToolCall` — injects the current theme mode ("light" or "dark") as context into every tool call so the report clearly attributes violations to the correct theme. Also deduplicates color pairs the agent has already checked  |

**Why it's good for a blog post:** Accessibility is important and underdemoed. The deduplication hook is practical (without it the agent would recheck the same color pairs). Great visual output — you can show failing color swatches in the blog post.

**Scope:** ~90-110 lines of SDK code. Sample site is ~3 HTML files with CSS variables.

---

### 5. Local API Contract Tester

**The problem:** You have an OpenAPI/Swagger spec file and a locally running API. Do they actually match? Does the API return the shapes the spec promises?

**What it does:** The agent reads your OpenAPI spec file, generates test requests for each endpoint, hits your local API, and compares the actual responses against the spec. Produces a pass/fail report per endpoint.

**What ships in the repo:** A minimal ASP.NET API project (3-4 endpoints) and its OpenAPI spec YAML file, with a couple of intentional mismatches planted.

| Feature         | How It's Used                                                                                                                                                                                                                            |
| --------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **MCP Server**  | **Playwright MCP** (or a simple HTTP MCP) — makes HTTP requests to the local API endpoints and captures responses. Alternatively, a **filesystem MCP** reads the OpenAPI spec file                                                       |
| **Custom Tool** | `ParseOpenAPISpec` — reads the spec file and extracts endpoint definitions (path, method, expected response schema). `ValidateResponse` — compares an actual API response body against the expected schema and returns mismatched fields |
| **Hook**        | `afterToolCall` — tracks pass/fail per endpoint and enforces a "fail fast" mode: if more than 3 endpoints fail, the agent stops testing and reports what it found (avoids wasting tokens on a clearly broken API)                        |

**Why it's good for a blog post:** Contract testing is a real pain point. The fail-fast hook is a practical token-saving pattern. Readers run `dotnet run` for the API, then run the agent — two commands, instant results.

**Scope:** ~100-130 lines of SDK code. Sample API is ~50 lines.

---

### 6. Résumé/CV Tailoring Assistant

**The problem:** You have a master résumé and a job posting. You want to see which of your skills/experiences are relevant and which are missing, then get a tailored version.

**What it does:** The agent reads your master résumé (markdown file) and a job posting (pasted into a local text file), identifies skill matches and gaps, and generates a tailored résumé version optimized for that posting.

**What ships in the repo:** A sample master résumé markdown file and 2-3 sample job posting text files.

| Feature         | How It's Used                                                                                                                                                                                                                                                     |
| --------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **MCP Server**  | **Filesystem MCP** — reads the résumé file and job posting files, writes the tailored output résumé                                                                                                                                                               |
| **Custom Tool** | `ExtractRequirements` — parses a job posting and extracts required skills, preferred skills, and years of experience into a structured list. `ScoreMatch` — compares a résumé section against extracted requirements and returns a relevance score with reasoning |
| **Hook**        | `beforeToolCall` — ensures the agent never modifies the original master résumé file (read-only guardrail on the source file). This is a safety pattern that's easy to teach: "let the agent write new files but never touch originals"                            |

**Why it's good for a blog post:** Universally relatable — every developer job hunts. The read-only guardrail hook is a broadly useful pattern. Filesystem MCP keeps it dead simple. Readers can immediately use it with their own résumé.

**Scope:** ~70-90 lines of SDK code. 3-4 sample files.

---

### 7. Log File Anomaly Investigator

**The problem:** You have a large log file from a failed deployment or production incident. You need to find the root cause buried in thousands of lines.

**What it does:** The agent reads a log file, identifies anomalies (errors, unusual patterns, timing spikes), traces causal chains between related log entries, and produces a timeline of what went wrong.

**What ships in the repo:** 2-3 sample log files (~500-1000 lines each) from realistic scenarios — a failing deployment, a memory leak, a cascading timeout.

| Feature         | How It's Used                                                                                                                                                                                                                                                                       |
| --------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **MCP Server**  | **Filesystem MCP** — reads log files, potentially reads config files for context about expected service behavior                                                                                                                                                                    |
| **Custom Tool** | `ParseLogEntry` — parses a log line into structured fields (timestamp, level, service, message, correlation ID). Handles multiple common log formats. `FindCorrelatedEntries` — given a correlation ID or timewindow, searches the log file for related entries                     |
| **Hook**        | `onTurn` — implements a "depth budget": tracks how many turns the agent has used and applies increasing pressure to reach a conclusion. Turn 1-3: explore freely. Turn 4-6: narrow focus. Turn 7+: summarize what you've found. Prevents the agent from endlessly reading log lines |

**Why it's good for a blog post:** Every developer has had the "stare at logs for an hour" experience. The depth-budget hook is a novel, useful pattern for controlling agent behavior. The sample log files make it instantly runnable.

**Scope:** ~90-120 lines of SDK code. Sample logs are text files.

---

### 8. Static Site Generator Preview Checker

**The problem:** You write a blog post in markdown, generate the static site, and realize there are formatting issues — broken image paths, unclosed HTML tags in your markdown, code blocks without language tags, broken internal links between posts.

**What it does:** The agent builds and serves your static site locally, then navigates each page checking for rendering issues, broken assets, and content quality signals.

**What ships in the repo:** A small static site generator setup (e.g., a few markdown posts + a minimal build script) with intentional issues baked in.

| Feature         | How It's Used                                                                                                                                                                                                                                                            |
| --------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **MCP Server**  | **Playwright MCP** — navigates the locally served static site, checks for broken images (naturalWidth === 0), verifies internal links resolve, captures console errors                                                                                                   |
| **Custom Tool** | `CheckMarkdownQuality` — reads the source markdown and flags issues that survive rendering (unclosed tags, images without alt text, code blocks without language). `MapInternalLinks` — builds a graph of all internal links and identifies orphaned pages or dead links |
| **Hook**        | `afterToolCall` — classifies findings into "content issues" (you need to fix the markdown) vs "build issues" (the generator is broken) and routes them to separate sections of the report. Tracks which source markdown file caused each rendered-page issue             |

**Why it's good for a blog post:** Meta — a blog post about checking blog posts. The classification hook (content vs build issues) is a smart routing pattern. Readers who use static site generators can use it immediately.

**Scope:** ~100-120 lines of SDK code. Sample site is a few markdown files + simple build script.

---

## Ranking for Blog Post Fit

| Rank | Idea                          | Scope  | Self-Contained? | "Wow" Factor | Hook Pattern                      | Reader Can Reuse? |
| ---- | ----------------------------- | ------ | --------------- | ------------ | --------------------------------- | ----------------- |
| 1    | Portfolio SEO & Link Checker  | Small  | Total           | High         | Safety gate (localhost-only)      | Immediately       |
| 2    | Markdown Knowledge Base Q&A   | Small  | Total           | High         | Transparency (sources consulted)  | Immediately       |
| 3    | Log File Anomaly Investigator | Medium | Total           | Very High    | Depth budget (turn pressure)      | Immediately       |
| 4    | Résumé Tailoring Assistant    | Small  | Total           | Medium-High  | Read-only guardrail               | Immediately       |
| 5    | Local API Contract Tester     | Medium | Total           | High         | Fail-fast token saver             | With own API      |
| 6    | CSS Theme Contrast Checker    | Medium | Total           | High         | Deduplication + context injection | With own site     |
| 7    | Static Site Preview Checker   | Medium | Total           | Medium-High  | Classification routing            | With own site     |
| 8    | Recipe Site Nutrition Auditor | Small  | Total           | Medium       | Aggregation                       | Fun demo only     |

**Portfolio SEO & Link Checker is #1**: tiny scope, universally relatable, the localhost-only safety hook is the clearest "here's why hooks exist" moment, and readers can immediately point it at their own site. **Markdown Knowledge Base Q&A is #2**: the "show your work" hook is a unique, memorable pattern and filesystem MCP requires zero setup.

---

## Notes

- **MCP servers used:** Only Playwright MCP and Filesystem MCP — both run locally, no accounts or API keys needed.
- **Every sample project ships in the repo** — readers `git clone` and `dotnet run`, nothing else.
- **Hook patterns across ideas:** safety gates, aggregation, transparency/audit, depth budgeting, deduplication, fail-fast, classification routing, read-only guardrails. Each idea teaches a different hook pattern.
- All ideas produce **markdown output** for easy blog post screenshots.
- These are all new ideas, distinct from the brainstorms at `2026-02-09`, `2026-02-11`, and `2026-02-12`.
