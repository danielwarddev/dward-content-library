# PowerShell script to convert Pokemon products HTML table to Markdown
# Extracts: Item Name, Set Name, Quantity, Total Value

$inputFile = Join-Path $PSScriptRoot "pokemon-products.html"
$outputFile = Join-Path $PSScriptRoot "pokemon-products.md"

# Read the HTML content
$html = Get-Content -Path $inputFile -Raw

# Function to decode HTML entities
function Decode-HtmlEntities {
    param([string]$text)
    
    # Use .NET's HtmlDecode for comprehensive entity decoding
    Add-Type -AssemblyName System.Web
    return [System.Web.HttpUtility]::HtmlDecode($text)
}

# Initialize array to hold product data
$products = @()

# Regex to match each offer row and extract the needed data
# Pattern explanation:
# - Match <tr class="offer" data-offer-id=...> blocks
# - Capture item name from <p class="title"><a>...</a>
# - Capture set name (text after <br> in the title paragraph)
# - Capture quantity from <input ... id="js-quantity" value="...">
# - Capture price from <td class="price">...<span class="js-price">...</span>

$offerPattern = '(?s)<tr class="offer" data-offer-id="[^"]+">.*?<td class="meta">.*?<p class="title">\s*<a[^>]*>([^<]+)</a>\s*<br>\s*([^<]+?)\s*</p>.*?<input[^>]*id="js-quantity"[^>]*value="(\d+)".*?<td class="price">.*?<span class="js-price">([^<]+)</span>'

$matches = [regex]::Matches($html, $offerPattern)

foreach ($match in $matches) {
    $itemName = Decode-HtmlEntities $match.Groups[1].Value.Trim()
    $setName = Decode-HtmlEntities $match.Groups[2].Value.Trim()
    $quantity = $match.Groups[3].Value.Trim()
    $totalValue = $match.Groups[4].Value.Trim()
    
    $products += [PSCustomObject]@{
        ItemName = $itemName
        SetName = $setName
        Quantity = $quantity
        TotalValue = $totalValue
    }
}

# Build markdown content
$mdContent = @"
# Pokemon Products Collection

| Item Name | Set Name | Quantity | Total Value |
|-----------|----------|----------|-------------|
"@

foreach ($product in $products) {
    # Escape pipe characters in item names if any
    $escapedItemName = $product.ItemName -replace '\|', '\|'
    $escapedSetName = $product.SetName -replace '\|', '\|'
    
    $mdContent += "`n| $escapedItemName | $escapedSetName | $($product.Quantity) | $($product.TotalValue) |"
}

# Add summary
$mdContent += "`n`n---`n"
$mdContent += "`n**Total Items:** $($products.Count)`n"

# Write to output file
$mdContent | Out-File -FilePath $outputFile -Encoding utf8

Write-Host "Conversion complete!" -ForegroundColor Green
Write-Host "Total products extracted: $($products.Count)"
Write-Host "Output saved to: $outputFile"
