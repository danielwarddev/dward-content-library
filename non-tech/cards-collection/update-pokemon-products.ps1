# Script to reorganize Pokemon products and calculate totals

$inputFile = Join-Path $PSScriptRoot "pokemon-products.md"
$content = Get-Content $inputFile -Raw

# Extract all product rows (lines between table header and totals)
$tablePattern = '(?sm)\| Item Name.*?\n\|-+\|-+\|-+\|-+\|\n(.*?)\n\n\*\*'
if ($content -match $tablePattern) {
    $allRows = $matches[1]
    
    # Split into individual rows and process
    $rows = $allRows -split '\n' | Where-Object { $_ -match '^\|' -and $_ -notmatch '^\|-' }
    
    $rumbleCards = @()
    $shippedCards = @()
    $shippedTotal = 0
    
    foreach ($row in $rows) {
        if ($row -match 'Pokemon Rumble') {
            $rumbleCards += $row
        } else {
            $shippedCards += $row
            # Extract price
            if ($row -match '\$([0-9,]+\.\d{2})') {
                $price = $matches[1] -replace ',', ''
                $shippedTotal += [decimal]$price
            }
        }
    }
    
    # Add additional cards to shipped
    $additionalCards = @(
        '| Rayquaza EX #97 | Pokemon Dragon | 1 | $215.75 |',
        '| Rayquaza EX #104 | Pokemon Roaring Skies | 1 | $71.50 |',
        '| Groudon EX #150 | Pokemon Primal Clash | 1 | $59.16 |',
        '| Poliwrath #H24 | Pokemon Skyridge | 1 | $246.68 |',
        '| Kingdra #148 | Pokemon Aquapolis | 1 | $241.07 |',
        '| Elite Trainer Box [Pokemon Center] | Pokemon Silver Tempest | 1 | $250.00 |',
        '| M Latios EX #102 | Pokemon Roaring Skies | 1 | $46.47 |'
    )
    
    foreach ($card in $additionalCards) {
        $shippedCards += $card
        if ($card -match '\$([0-9,]+\.\d{2})') {
            $price = $matches[1] -replace ',', ''
            $shippedTotal += [decimal]$price
        }
    }
    
    Write-Host "Rumble Cards: $($rumbleCards.Count)"
    Write-Host "Shipped Cards: $($shippedCards.Count)"
    Write-Host "Shipped Total Value: `$$($shippedTotal.ToString('N2'))"
}
