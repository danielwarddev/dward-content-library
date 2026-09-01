# Workflow

## Setup

Create a todo list with one item per card/collectible so progress is trackable.

## Per-Card Loop

For each card, run **three searches in parallel** — one subagent per site (PriceCharting, GameNerdz,
CoolStuffInc), each in its own browser tab. Wait for all three to return before moving to the next
card.

Each subagent runs both phases for its site:

### Phase 1 — Playwright Navigation

1. Navigate to the site's search page (URL is in the site reference file)
2. Search for the card, following that site's search tips:
   - **PriceCharting** — search with full item details (name, set, number)
   - **GameNerdz** — search with item name and number, wait for results to load
   - **CoolStuffInc** — search with ONLY the item name (no set/number), then locate the correct variant in results
3. Locate the correct card in the search results
4. **Capture the relevant HTML element** with `browser_run_code` using that site's selector

### Phase 2 — PowerShell Parsing

```powershell
.\.github\skills\pokemon-price-check\scripts\parse-price-html.ps1 -Site "GameNerdz" -Html $html -ItemName "Charizard ex 223/197"
```

The script outputs JSON. Field details are in each site's reference file.

## Per-Card Recording

For each result, note:

- Cash payout and store credit value (compute the missing one — see [results-format.md](results-format.md))
- Whether the displayed price is cash or credit
- Any bonus percentage applied to store credit
- Condition, variant, and set name

Mark the card's todo item complete once all three sites are done.

## Wrap-Up

1. Compile all results into the table in [results-format.md](results-format.md)
2. **Save the compiled results to a markdown file in the workspace** — don't leave them only in chat
