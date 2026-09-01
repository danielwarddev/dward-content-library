---
name: pokemon-price-check
description: Price check Pokemon cards across PriceCharting, GameNerdz buylist, and CoolStuffInc selllist. Uses Playwright MCP for navigation and PowerShell for fast HTML parsing. Use this skill when comparing card values, evaluating offers, or finding the best place to sell cards.
user-invocable: true
disable-model-invocation: false
---

# Pokemon Price Check

A hybrid Playwright + PowerShell workflow for price checking Pokemon cards across multiple buylist/pricing websites.

## Overview

This skill uses a two-phase approach:

1. **Playwright MCP** handles navigation, searching, and finding the correct card
2. **PowerShell** handles fast, deterministic HTML parsing once the right element is found

## Supported Sites

For site-specific instructions (URLs, search process, HTML selectors, pricing notes), reference these files:

| Site          | File                                 | Type                      |
| ------------- | ------------------------------------ | ------------------------- |
| PriceCharting | [pricecharting.md](pricecharting.md) | Market price reference    |
| GameNerdz     | [gamenerdz.md](gamenerdz.md)         | Store credit/cash buylist |
| CoolStuffInc  | [coolstuffinc.md](coolstuffinc.md)   | Store credit/cash buylist |

## Workflow

### Phase 1: Playwright Navigation

1. Navigate to the site's search page (see site-specific file for URL)
2. Search for the card (see site-specific file for search tips)
3. Locate the correct card in search results
4. **Capture the relevant HTML element** using `browser_run_code` (see site-specific file for selectors)

### Phase 2: PowerShell Parsing

Run the PowerShell script located in this skill folder:

```powershell
# From the skill folder
.\.github\skills\pokemon-price-check\parse-price-html.ps1 -Site "GameNerdz" -Html $html

# Supported sites: PriceCharting, GameNerdz, CoolStuffInc
```

## PowerShell Script Usage

```powershell
# Basic usage
.\parse-price-html.ps1 -Site "SiteName" -Html "<html content>"

# With item name for output
.\parse-price-html.ps1 -Site "GameNerdz" -Html $html -ItemName "Charizard ex 223/197"

# From file
.\parse-price-html.ps1 -Site "CoolStuffInc" -HtmlFile "card.html"
```

The script outputs JSON. See each site's documentation for output field details.

## Pricing Summary

| Site          | Displayed Price                   | Cash Calculation     |
| ------------- | --------------------------------- | -------------------- |
| GameNerdz     | Store Credit (25% bonus included) | Cash = Credit ÷ 1.25 |
| CoolStuffInc  | Both Cash and Credit shown        | Credit = Cash × 1.25 |
| PriceCharting | Market price (not buylist)        | N/A                  |

## Results Table Format

When compiling results, use this table format:

| Item Name | Offer Value | PriceCharting (Ungraded) | CoolStuffInc (Cash) | CoolStuffInc (Credit) | GameNerdz (Cash) | GameNerdz (Credit) | Best Alternative |
| --------- | ----------- | ------------------------ | ------------------- | --------------------- | ---------------- | ------------------ | ---------------- |
| Card Name | $XX.XX      | $XX.XX (+X%)             | $XX.XX (+X%)        | $XX.XX (+X%)          | $XX.XX (+X%)     | $XX.XX (+X%)       | $XX.XX (+X%)     |

**Percentage notes:** Shows difference from Offer Value. Positive = site value higher; Negative = site value lower.
