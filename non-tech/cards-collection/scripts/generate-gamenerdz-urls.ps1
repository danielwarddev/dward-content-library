param(
    [string]$InputFile = (Join-Path $PSScriptRoot "cards.txt"),
    [switch]$Reverse
)

$baseUrl = "https://buylist.gamenerdz.com/retailer/buylist?product_line=Pokemon&sort=Relevance&q="

$lines = Get-Content $InputFile | Where-Object { $_.Trim() -ne "" }

if ($Reverse) {
    [array]::Reverse($lines)
}

foreach ($line in $lines) {
    $encoded = [System.Uri]::EscapeDataString($line.Trim()) -replace '%20', '+'
    Write-Output "$baseUrl$encoded"
}
