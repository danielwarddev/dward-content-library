# PriceCharting Instructions

## Search URL

**Direct Search URL:** `https://www.pricecharting.com/search-products?type=prices&q={encoded search}`

### URL Encoding

- Spaces → `+`
- Ampersand (`&`) → `%26`
- etc.

**Examples:**

| Card Name        | Encoded URL                                                                      |
| ---------------- | -------------------------------------------------------------------------------- |
| Dark Espeon      | `https://www.pricecharting.com/search-products?type=prices&q=dark+espeon`        |
| Gengar & Mimikyu | `https://www.pricecharting.com/search-products?type=prices&q=gengar+%26+mimikyu` |

## Search Process

1. Navigate directly to the search URL with your query
2. Find the correct card in search results
3. Click to go to the card's detail page
4. Capture the price information

## HTML Capture

Use this Playwright code to capture price data:

```javascript
// From search results - get the price cell
async (page) => {
    const priceCell = await page.locator("td.price").first();
    return await priceCell.evaluate((el) => el.outerHTML);
};

// From product detail page - get the price box
async (page) => {
    const priceBox = await page.locator("#price-box, .price-summary").first();
    return await priceBox.evaluate((el) => el.outerHTML);
};
```

## HTML Structure

PriceCharting has various layouts. Common patterns:

**Search results table:**

```html
<td class="price">$55.00</td>
```

**Product detail page:**

```html
<span class="price">$55.00</span>
<!-- Or with grade labels -->
<tr>
    <td>Ungraded</td>
    <td class="price">$55.00</td>
</tr>
<tr>
    <td>PSA 10</td>
    <td class="price">$250.00</td>
</tr>
```

## Pricing Notes

⚠️ **Important:** PriceCharting shows **market prices**, NOT buylist offers.

- These are based on recent eBay sales and other marketplace data
- Actual buylist offers will typically be 50-70% of market price
- Graded prices (PSA 9, PSA 10) are shown separately when available

## PowerShell Parsing

```powershell
.\parse-price-html.ps1 -Site "PriceCharting" -Html $html
```

**Output fields:**

- `UngradedPrice` - Market price for ungraded/loose cards
- `GradedPrices` - Hashtable of graded prices (e.g., "PSA 10": 250.00)

**Example JSON output:**

```json
{
    "Site": "PriceCharting",
    "ItemName": "Charizard ex",
    "UngradedPrice": 55.0,
    "GradedPrices": {
        "PSA 10": 250.0,
        "PSA 9": 120.0
    }
}
```

## Use Cases

PriceCharting is best for:

- Determining fair market value
- Comparing buylist offers to market price
- Checking graded card values
- Historical price trends (on full website)

It's NOT a buylist - you can't sell directly to them.
