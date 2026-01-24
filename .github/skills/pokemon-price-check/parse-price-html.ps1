# PowerShell script to parse price HTML from collectible pricing sites
# Usage: .\parse-price-html.ps1 -Site "PriceCharting" -Html "<html content>"
# Or pipe HTML: Get-Content pricing.html | .\parse-price-html.ps1 -Site "GameNerdz"

param(
    [Parameter(Mandatory = $true)]
    [ValidateSet("PriceCharting", "GameNerdz", "CoolStuffInc")]
    [string]$Site,
    
    [Parameter(ValueFromPipeline = $true)]
    [string]$Html,
    
    [Parameter()]
    [string]$HtmlFile,
    
    [Parameter()]
    [string]$ItemName = ""
)

# Load HTML from file if specified
if ($HtmlFile -and (Test-Path $HtmlFile)) {
    $Html = Get-Content -Path $HtmlFile -Raw
}

if (-not $Html) {
    Write-Error "No HTML content provided. Use -Html parameter, -HtmlFile parameter, or pipe content."
    exit 1
}

# Function to decode HTML entities
function Decode-HtmlEntities {
    param([string]$text)
    Add-Type -AssemblyName System.Web
    $decoded = [System.Web.HttpUtility]::HtmlDecode($text)
    # Clean up whitespace
    return ($decoded -replace '\s+', ' ').Trim()
}

# Function to extract price from text (handles $XX.XX format)
function Extract-Price {
    param([string]$text)
    if ($text -match '\$?([\d,]+\.?\d*)') {
        return [decimal]($matches[1] -replace ',', '')
    }
    return $null
}

# Parse PriceCharting HTML
function Parse-PriceCharting {
    param([string]$Html)
    
    $result = @{
        Site = "PriceCharting"
        ItemName = $ItemName
        UngradedPrice = $null
        GradedPrices = @{}
        RawData = @{}
    }
    
    # Try to find the ungraded/loose price
    # Common patterns: "Ungraded" or "Loose" followed by a price
    if ($Html -match '(?i)(?:ungraded|loose)[^$]*\$?([\d,]+\.?\d*)') {
        $result.UngradedPrice = Extract-Price $matches[0]
    }
    
    # Alternative: Look for price in the main price display area
    if (-not $result.UngradedPrice) {
        # PriceCharting often has <span class="price">$XX.XX</span> or similar
        if ($Html -match '<span[^>]*class="[^"]*price[^"]*"[^>]*>\s*\$?([\d,]+\.?\d*)\s*</span>') {
            $result.UngradedPrice = Extract-Price $matches[1]
        }
    }
    
    # Look for the price in td.price elements
    if (-not $result.UngradedPrice) {
        if ($Html -match '<td[^>]*class="[^"]*price[^"]*"[^>]*>\s*\$?([\d,]+\.?\d*)') {
            $result.UngradedPrice = Extract-Price $matches[1]
        }
    }
    
    # Try to find graded prices (PSA 9, PSA 10, etc.)
    $gradedPattern = '(?i)(PSA|BGS|CGC)\s*(\d+)[^$]*\$?([\d,]+\.?\d*)'
    $gradedMatches = [regex]::Matches($Html, $gradedPattern)
    foreach ($match in $gradedMatches) {
        $gradeLabel = "$($match.Groups[1].Value) $($match.Groups[2].Value)"
        $gradePrice = Extract-Price $match.Groups[3].Value
        if ($gradePrice) {
            $result.GradedPrices[$gradeLabel] = $gradePrice
        }
    }
    
    return $result
}

# Parse GameNerdz buylist HTML
function Parse-GameNerdz {
    param([string]$Html)
    
    $result = @{
        Site = "GameNerdz"
        ItemName = $ItemName
        StoreCredit = $null
        CashValue = $null
        ProductTitle = $null
        SetName = $null
        Finish = $null
        RawData = @{}
    }
    
    # GameNerdz buylist shows store credit value (with 25% bonus included)
    # Cash = StoreCredit / 1.25
    
    # Extract product title from product-title div or img alt
    if ($Html -match '<div[^>]*class="[^"]*product-title[^"]*"[^>]*>.*?<div[^>]*>([^<]+)</div>') {
        $result.ProductTitle = Decode-HtmlEntities $matches[1]
    }
    elseif ($Html -match '<img[^>]*alt="([^"]+)"') {
        $result.ProductTitle = Decode-HtmlEntities $matches[1]
    }
    
    # Extract set name from product-set div
    if ($Html -match '<div[^>]*class="[^"]*product-set[^"]*"[^>]*>.*?<span[^>]*>([^<]+)</span>') {
        $result.SetName = Decode-HtmlEntities $matches[1]
    }
    
    # Extract finish (Holofoil, Reverse Holofoil, Normal, etc.)
    if ($Html -match '<span[^>]*class="[^"]*badge[^"]*"[^>]*>([^<]+)</span>') {
        $result.Finish = Decode-HtmlEntities $matches[1]
    }
    
    # Look for "Buy Price: $XX.XX" in strong tag
    if ($Html -match '<strong[^>]*>Buy Price:\s*\$?([\d,]+\.?\d*)</strong>') {
        $creditValue = [decimal]($matches[1] -replace ',', '')
        $result.StoreCredit = $creditValue
        $result.CashValue = [math]::Round($creditValue / 1.25, 2)
    }
    
    # Fallback: Look for any price pattern
    if (-not $result.StoreCredit) {
        if ($Html -match '\$\s*([\d,]+\.?\d*)') {
            $creditValue = Extract-Price $matches[0]
            if ($creditValue) {
                $result.StoreCredit = $creditValue
                $result.CashValue = [math]::Round($creditValue / 1.25, 2)
            }
        }
    }
    
    # Use ProductTitle as ItemName if not provided
    if (-not $result.ItemName -and $result.ProductTitle) {
        $result.ItemName = $result.ProductTitle
    }
    
    return $result
}

# Parse CoolStuffInc selllist HTML
function Parse-CoolStuffInc {
    param([string]$Html)
    
    $result = @{
        Site = "CoolStuffInc"
        ItemName = $ItemName
        CashValue = $null
        CreditValue = $null
        ProductTitle = $null
        SetName = $null
        CardNumber = $null
        Rarity = $null
        Condition = $null
        RawData = @{}
    }
    
    # CoolStuffInc shows both cash and credit values
    # Credit includes 25% bonus
    
    # Extract product title from h2
    if ($Html -match '<h2[^>]*>([^<]+)</h2>') {
        $result.ProductTitle = Decode-HtmlEntities $matches[1]
    }
    
    # Extract set name from buylist-card-data list (first li)
    if ($Html -match '<ul[^>]*class="[^"]*buylist-card-data[^"]*"[^>]*>\s*<li[^>]*>([^<]+)</li>') {
        $result.SetName = Decode-HtmlEntities $matches[1]
    }
    
    # Extract card number (second li, starts with #)
    if ($Html -match '<ul[^>]*class="[^"]*buylist-card-data[^"]*"[^>]*>.*?<li[^>]*>[^<]+</li>\s*<li[^>]*>(#[^<]+)</li>') {
        $result.CardNumber = Decode-HtmlEntities $matches[1]
    }
    
    # Extract rarity (fourth li typically)
    $rarityPattern = '(?:Ultra Rare|Rare|Common|Uncommon|Promo|Special Illustration Rare|Holo Rare|Shiny Rare|Shiny Ultra Rare|Illustration Rare)'
    if ($Html -match "<li[^>]*>($rarityPattern)</li>") {
        $result.Rarity = Decode-HtmlEntities $matches[1]
    }
    
    # Extract condition
    if ($Html -match '<div[^>]*class="[^"]*buylist-footer-price-wrapper[^"]*"[^>]*>\s*<div[^>]*>([^<]+)</div>') {
        $result.Condition = Decode-HtmlEntities $matches[1]
    }
    
    # Extract cash value - look for buylist-price-default class
    if ($Html -match '<li[^>]*class="[^"]*buylist-price-default[^"]*"[^>]*>\s*\$?([\d,]+\.?\d*)') {
        $result.CashValue = [decimal]($matches[1] -replace ',', '')
    }
    
    # Extract credit value - look for buylist-price-credit class
    if ($Html -match '<li[^>]*class="[^"]*buylist-price-credit[^"]*"[^>]*>\s*[\$/]?([\d,]+\.?\d*)') {
        $result.CreditValue = [decimal]($matches[1] -replace ',', '')
    }
    
    # Fallback: Look for two prices in the format $XX.XX
    if (-not $result.CashValue -or -not $result.CreditValue) {
        $priceMatches = [regex]::Matches($Html, '\$([\d,]+\.?\d*)')
        if ($priceMatches.Count -ge 2) {
            $prices = $priceMatches | ForEach-Object { [decimal]($_.Groups[1].Value -replace ',', '') } | Where-Object { $_ -gt 0 }
            if ($prices.Count -ge 2) {
                # Usually the lower value is cash, higher is credit
                $sortedPrices = $prices | Sort-Object
                if (-not $result.CashValue) { $result.CashValue = $sortedPrices[0] }
                if (-not $result.CreditValue) { $result.CreditValue = $sortedPrices[-1] }
            }
            elseif ($prices.Count -eq 1 -and -not $result.CashValue) {
                # Only one price found, assume it's cash
                $result.CashValue = $prices[0]
                $result.CreditValue = [math]::Round($prices[0] * 1.25, 2)
            }
        }
    }
    
    # Use ProductTitle as ItemName if not provided
    if (-not $result.ItemName -and $result.ProductTitle) {
        $result.ItemName = $result.ProductTitle
    }
    
    return $result
}

# Main parsing logic
$parsedResult = switch ($Site) {
    "PriceCharting" { Parse-PriceCharting -Html $Html }
    "GameNerdz" { Parse-GameNerdz -Html $Html }
    "CoolStuffInc" { Parse-CoolStuffInc -Html $Html }
}

# Output as JSON for easy consumption
$parsedResult | ConvertTo-Json -Depth 3
