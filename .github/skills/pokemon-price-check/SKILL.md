---
name: pokemon-price-check
description: Price check Pokemon cards and other collectibles across PriceCharting, GameNerdz buylist, and CoolStuffInc selllist. Uses Playwright MCP for navigation and PowerShell for fast HTML parsing. Use this skill when comparing card values, evaluating offers, or finding the best place to sell cards.
user-invocable: true
disable-model-invocation: false
---

# Pokemon / Collectible Price Check

A hybrid Playwright + PowerShell workflow for price checking collectibles across three buylist and
pricing sites.

## Prerequisites

**If the user did not provide a list of items, ask which items to check and stop.** Do not proceed
without a list.

**Do NOT ask which websites to search** — always use all three sites below.

## Approach

1. **Playwright MCP** handles navigation, searching, and finding the correct card
2. **PowerShell** handles fast, deterministic parsing once the right HTML element is captured

## Sites

| Site          | Reference                                                | Type                      |
| ------------- | -------------------------------------------------------- | ------------------------- |
| PriceCharting | [references/pricecharting.md](references/pricecharting.md) | Market price reference    |
| GameNerdz     | [references/gamenerdz.md](references/gamenerdz.md)         | Store credit/cash buylist |
| CoolStuffInc  | [references/coolstuffinc.md](references/coolstuffinc.md)   | Store credit/cash buylist |

Each site reference has its search URL, search process, HTML selectors, capture snippet, pricing
notes, and parser output fields. Read the site's file right before working that site.

## References

| File | Read it when |
| ---- | ------------ |
| [references/workflow.md](references/workflow.md) | Starting a run — todo tracking, parallel subagent strategy, the two-phase loop, saving results |
| [references/results-format.md](references/results-format.md) | Compiling the final comparison table and cash/credit conversions |
| [references/pricecharting.md](references/pricecharting.md) · [references/gamenerdz.md](references/gamenerdz.md) · [references/coolstuffinc.md](references/coolstuffinc.md) | Searching and scraping that specific site |

## Script

[scripts/parse-price-html.ps1](scripts/parse-price-html.ps1) — parses captured HTML and outputs JSON.

```powershell
.\.github\skills\pokemon-price-check\scripts\parse-price-html.ps1 -Site "GameNerdz" -Html $html -ItemName "Charizard ex 223/197"

# Or from a file
.\.github\skills\pokemon-price-check\scripts\parse-price-html.ps1 -Site "CoolStuffInc" -HtmlFile "card.html"

# -Site accepts: PriceCharting, GameNerdz, CoolStuffInc
```
