# PowerShell script to move cards from Unshipped to Shipped section
# Usage: .\move-to-shipped.ps1 -SearchTerms "Pikachu #7", "Rayquaza EX #97"

param(
    [Parameter(Mandatory=$true)]
    [string[]]$SearchTerms
)

$filePath = Join-Path $PSScriptRoot "pokemon-products.md"

# Read the file content
$content = Get-Content -Path $filePath -Raw

# Split into unshipped and shipped sections
$sections = $content -split '## Shipped Cards'

if ($sections.Count -ne 2) {
    Write-Error "Could not find '## Shipped Cards' section in the file"
    exit 1
}

$unshippedSection = $sections[0]
$shippedSection = "## Shipped Cards" + $sections[1]

# Extract the shipped table (everything between the header row and the total line)
$shippedLines = $shippedSection -split "`n"

# Find where to insert new shipped items (after the table header separator)
$insertIndex = -1
for ($i = 0; $i -lt $shippedLines.Count; $i++) {
    if ($shippedLines[$i] -match '^\|\s*[-]+\s*\|') {
        $insertIndex = $i + 1
        break
    }
}

$movedCards = @()
$notFoundTerms = @()

foreach ($term in $SearchTerms) {
    # Find matching line in unshipped section (case-insensitive, partial match anywhere in the row)
    $pattern = "^\|.*$([regex]::Escape($term)).*\|"
    
    $unshippedLines = $unshippedSection -split "`n"
    $found = $false
    
    for ($i = 0; $i -lt $unshippedLines.Count; $i++) {
        if ($unshippedLines[$i] -match $pattern) {
            $matchedLine = $unshippedLines[$i]
            
            # Remove from unshipped
            $unshippedSection = ($unshippedLines[0..($i-1)] + $unshippedLines[($i+1)..($unshippedLines.Count-1)]) -join "`n"
            
            # Add to shipped (normalize spacing for the shipped table format)
            $movedCards += $matchedLine.Trim()
            
            Write-Host "Moved: $term" -ForegroundColor Green
            $found = $true
            break
        }
    }
    
    if (-not $found) {
        $notFoundTerms += $term
        Write-Host "Not found: $term" -ForegroundColor Yellow
    }
}

# Insert moved cards into shipped section
if ($movedCards.Count -gt 0) {
    $shippedLines = $shippedSection -split "`n"
    $newShippedLines = @()
    
    for ($i = 0; $i -lt $shippedLines.Count; $i++) {
        $newShippedLines += $shippedLines[$i]
        if ($i -eq $insertIndex - 1) {
            foreach ($card in $movedCards) {
                $newShippedLines += $card
            }
        }
    }
    
    $shippedSection = $newShippedLines -join "`n"
}

# Update the counts
# Count unshipped items (lines starting with | that aren't headers)
$unshippedCount = ($unshippedSection -split "`n" | Where-Object { $_ -match '^\|[^-]' -and $_ -notmatch '^\|\s*Item Name' }).Count
$shippedCount = ($shippedSection -split "`n" | Where-Object { $_ -match '^\|[^-]' -and $_ -notmatch '^\|\s*Item Name' }).Count

# Calculate shipped total value
$shippedTotal = 0.0
$shippedSection -split "`n" | Where-Object { $_ -match '^\|[^-]' -and $_ -notmatch '^\|\s*Item Name' } | ForEach-Object {
    if ($_ -match '\$[\d,]+\.?\d*\s*\|?\s*$') {
        $priceStr = $Matches[0] -replace '[\$,\|\s]', ''
        $shippedTotal += [decimal]$priceStr
    }
}

# Update the totals in the content
$unshippedSection = $unshippedSection -replace '\*\*Unshipped Total Items:\*\*\s*\d+', "**Unshipped Total Items:** $unshippedCount"
$shippedSection = $shippedSection -replace '\*\*Shipped Total Items:\*\*\s*\d+', "**Shipped Total Items:** $shippedCount"
$shippedSection = $shippedSection -replace '\*\*Shipped Total Value:\*\*\s*\$[\d,]*\.?\d*', "**Shipped Total Value:** `$$('{0:N2}' -f $shippedTotal)"

# Combine and write back
$newContent = $unshippedSection + $shippedSection
$newContent | Out-File -FilePath $filePath -Encoding utf8 -NoNewline

Write-Host "`n--- Summary ---" -ForegroundColor Cyan
Write-Host "Cards moved: $($movedCards.Count)"
Write-Host "Unshipped count: $unshippedCount"
Write-Host "Shipped count: $shippedCount"
Write-Host "Shipped total value: `$$('{0:N2}' -f $shippedTotal)" -ForegroundColor Green

if ($notFoundTerms.Count -gt 0) {
    Write-Host "`nNot found:" -ForegroundColor Yellow
    $notFoundTerms | ForEach-Object { Write-Host "  - $_" }
}
