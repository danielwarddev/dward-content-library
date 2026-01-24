# CoolStuffInc Selllist Instructions

## Search URL

**Direct Search URL:** `https://www.coolstuffinc.com/main_selllist.php?name={encoded search}&min=&max=&a=1&s=pokemon`

### URL Encoding

- Spaces → `+`
- Ampersand (`&`) → `%26`
- etc.

**Examples:**

| Card Name        | Encoded URL                                                                                      |
| ---------------- | ------------------------------------------------------------------------------------------------ |
| Dark Espeon      | `https://www.coolstuffinc.com/main_selllist.php?name=dark+espeon&min=&max=&a=1&s=pokemon`        |
| Gengar & Mimikyu | `https://www.coolstuffinc.com/main_selllist.php?name=gengar+%26+mimikyu&min=&max=&a=1&s=pokemon` |

⚠️ **Search by name ONLY** - do not include set or card number in the search.

## Search Process

1. Navigate directly to the search URL with your query
2. Find the correct variant in results by matching:
    - Card name and number in heading
    - Set name in card data list
    - Rarity (Ultra Rare, Special Illustration Rare, etc.)

## HTML Capture

Use this Playwright code to capture the card HTML:

```javascript
async (page) => {
    // Get a specific card row by card number
    const row = await page
        .locator('.buylist-row-wrapper:has-text("223/197")')
        .first();
    return await row.evaluate((el) => el.outerHTML);
};

// Or get all matching rows:
async (page) => {
    const rows = await page.locator(".buylist-row-wrapper").all();
    // Return specific row based on index or further filtering
    return await rows[0].evaluate((el) => el.outerHTML);
};
```

## HTML Structure

Key elements in the HTML:

```html
<div class="buylist-row-wrapper">
    <div class="buylist-header">
        <h2>Charizard ex (Alt Full Art) - 223/197</h2>
        <ul class="buylist-card-data">
            <li>SV Obsidian Flames</li>
            <li>#223/197</li>
            <li>Non-Foil</li>
            <li>Special Illustration Rare</li>
        </ul>
    </div>
    <div class="buylist-footer">
        <div class="buylist-footer-price-wrapper">
            <div>Near Mint</div>
            <ul class="buylist-price-wrapper">
                <li class="buylist-price-default">
                    $42.00<span class="buylist-currency">USD</span>
                </li>
                <li class="buylist-price-credit">
                    $52.50<span class="buylist-currency">Credit</span>
                </li>
            </ul>
        </div>
    </div>
</div>
```

## Pricing Notes

CoolStuffInc displays **both** cash and credit values directly:

| Class                   | Meaning                           |
| ----------------------- | --------------------------------- |
| `buylist-price-default` | Cash payout                       |
| `buylist-price-credit`  | Store credit (includes 25% bonus) |

## PowerShell Parsing

```powershell
.\parse-price-html.ps1 -Site "CoolStuffInc" -Html $html
```

**Output fields:**

- `CashValue` - Cash payout amount
- `CreditValue` - Store credit amount (with 25% bonus)
- `ProductTitle` - Card name from h2
- `SetName` - Set name from card data
- `CardNumber` - Card number (e.g., "#223/197")
- `Rarity` - Rarity level
- `Condition` - Condition (typically "Near Mint")

**Example JSON output:**

```json
{
    "Site": "CoolStuffInc",
    "ItemName": "Charizard ex (Alt Full Art) - 223/197",
    "CashValue": 42.0,
    "CreditValue": 52.5,
    "SetName": "SV Obsidian Flames",
    "CardNumber": "#223/197",
    "Rarity": "Special Illustration Rare",
    "Condition": "Near Mint"
}
```
