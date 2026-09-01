# GameNerdz Buylist Instructions

## Search URL

**Direct Search URL:** `https://buylist.gamenerdz.com/retailer/buylist?product_line=Pokemon&sort=Relevance&q={encoded search}`

**IMPORTANT:** DO NOT use https://www.gamenerdz.com/buylist - that is NOT the buylist.

### URL Encoding

- Spaces → `+`
- Ampersand (`&`) → `%26`
- etc.

**Examples:**

| Card Name        | Encoded URL                                                                                               |
| ---------------- | --------------------------------------------------------------------------------------------------------- |
| Dark Espeon      | `https://buylist.gamenerdz.com/retailer/buylist?product_line=Pokemon&sort=Relevance&q=dark+espeon`        |
| Gengar & Mimikyu | `https://buylist.gamenerdz.com/retailer/buylist?product_line=Pokemon&sort=Relevance&q=gengar+%26+mimikyu` |

## Search Process

1. Navigate directly to the search URL with your query
2. Wait for results to load
3. Identify the correct card by matching:
    - Card name
    - Set name (shown below card name)
    - Card number
    - Finish (Holofoil, Reverse Holofoil, Normal)

## HTML Capture

Use this Playwright code to capture the card HTML:

```javascript
async (page) => {
    // Get the first matching buylist product card
    const card = await page.locator(".buylist-product").first();
    return await card.evaluate((el) => el.outerHTML);
};

// Or for a specific card by name:
async (page) => {
    const card = await page
        .locator('.buylist-product:has-text("223/197")')
        .first();
    return await card.evaluate((el) => el.outerHTML);
};
```

## HTML Structure

Key elements in the HTML:

```html
<div class="product buylist-product">
    <span class="badge badge-dark">Holofoil</span>
    <div class="product-title">
        <div>Charizard ex 223 - SV03 Obsidian Flames Holofoil</div>
    </div>
    <div class="product-set">
        <span>SV03: Obsidian Flames</span>
    </div>
    <strong>Buy Price: $54.05</strong>
</div>
```

## Pricing Notes

⚠️ **Important:** GameNerdz displays **Store Credit** values with the 25% bonus already included.

| Displayed | Meaning                    |
| --------- | -------------------------- |
| $54.05    | Store Credit value         |
| $43.24    | Actual Cash value (÷ 1.25) |

The PowerShell script automatically calculates both values.

## PowerShell Parsing

```powershell
.\.github\skills\pokemon-price-check\scripts\parse-price-html.ps1 -Site "GameNerdz" -Html $html
```

**Output fields:**

- `StoreCredit` - The displayed price (with 25% bonus)
- `CashValue` - Calculated cash value (StoreCredit ÷ 1.25)
- `ProductTitle` - Full card name with set
- `SetName` - Just the set name
- `Finish` - Holofoil, Reverse Holofoil, Normal, etc.

**Example JSON output:**

```json
{
    "Site": "GameNerdz",
    "ItemName": "Charizard ex 223 - SV03 Obsidian Flames Holofoil",
    "StoreCredit": 54.05,
    "CashValue": 43.24,
    "SetName": "SV03: Obsidian Flames",
    "Finish": "Holofoil"
}
```
