# Search Sources

## Tools to Use

- **Playwright MCP** — `browser_navigate` to load a search page, `browser_snapshot` to read results
- **Page fetching** — for reading specific articles in detail
- Close the browser when done with `browser_close`

## Sites to Avoid

- **Reddit** — Blocks non-human access. Do not navigate to reddit.com URLs during research; skip them in search results or find an alternative source.
- **Google / Bing / DuckDuckGo / Brave / Startpage / Mojeek search pages** — These engines present CAPTCHAs / bot challenges to Playwright. Do not waste time cycling through them. Use direct site search instead.

## Fallback: Direct Site Search

When general search engines block automation, search authoritative sources directly. These typically allow Playwright access:

| Source | URL pattern |
| ------ | ----------- |
| Microsoft Learn | `https://learn.microsoft.com/en-us/search/?terms=<query>` |
| GitHub | `https://github.com/search?q=<query>&type=<code\|issues\|discussions>` |
| Microsoft DevBlogs | `https://devblogs.microsoft.com/?s=<query>` |
| dev.to | `https://dev.to/search?q=<query>` |
| Code Maze | `https://code-maze.com/?s=<query>` |
| Hacker News (Algolia) | `https://hn.algolia.com/?q=<query>` |
| YouTube | `https://www.youtube.com/results?search_query=<query>` |

Aggregate findings from 3–5 of these sources and apply the opportunity criteria in
[research-process.md](research-process.md) the same way.
