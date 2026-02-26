<#
.SYNOPSIS
Generate GameNerdz buylist URLs from a file of card names (supports Markdown table or plain list).

.DESCRIPTION
- Reads an input file (default: ../card-prices.md)
- Extracts the "Card" (name + number) column from a Markdown table, or reads each non-empty line if file is a plain list
- URL-encodes the name using form-style encoding (spaces -> +, other reserved chars percent-encoded)
- Writes one GameNerdz URL per line to the output file

.EXAMPLE
.
PS> .\generate-gamenerdz-urls.ps1 -InputFile ..\card-prices.md -OutputFile ..\scripts\gamenerdz-urls.txt -Overwrite

#>
param(
    [string]$InputFile = (Join-Path $PSScriptRoot '..\card-prices.md'),
    [string]$OutputFile = ".\gamenerdz-urls.txt",
    [string]$Name,
    [string[]]$Names,
    [switch]$Overwrite,
    [switch]$OnlyFromArgs,
    [switch]$AsStartProcessLoop
)

function FormUrlEncode {
    param([string]$s)
    if ($null -eq $s) { return $null }
    # Use EscapeDataString for safe percent-encoding, then convert %20 -> + for form-style encoding
    $escaped = [System.Uri]::EscapeDataString($s)
    return ($escaped -replace '%20', '+')
}

function Extract-NamesFromMarkdownTable {
    param([string[]]$Lines)
    $names = @()

    # Find header line that contains the 'Card' column
    for ($i = 0; $i -lt $Lines.Length; $i++) {
        if ($Lines[$i] -match '\|\s*Card\s*\|') {
            # expect the next line to be the table separator (---)
            $start = $i + 2
            for ($j = $start; $j -lt $Lines.Length; $j++) {
                $line = $Lines[$j].Trim()
                if (-not $line -or $line -notmatch '^\|') { break }
                # split by |, trim, ignore first/last if empty
                $cols = ($line -split '\|') | ForEach-Object { $_.Trim() }
                if ($cols.Length -ge 2) {
                    $card = $cols[1]
                    if ($card) { $names += $card }
                }
            }
            break
        }
    }
    return $names
}

# ---- Main ----
# Collect names from pipeline, -Name (single) or -Names (multiple)
$collectedNames = @()

# Add single -Name parameter if provided
if ($PSBoundParameters.ContainsKey('Name') -and $Name) {
    $collectedNames += $Name.Trim()
}

# Add -Names array if provided
if ($PSBoundParameters.ContainsKey('Names') -and $Names) {
    $collectedNames += $Names | ForEach-Object { $_.Trim() } | Where-Object { $_ }
}

# Collect pipeline input (supports piping many names into the script)
foreach ($item in $input) {
    if ($item -and $item.ToString().Trim()) { $collectedNames += $item.ToString().Trim() }
}

# If no names were provided via parameters or pipeline, read from the input file (unless -OnlyFromArgs is set)
if ($collectedNames.Count -eq 0) {
    if ($OnlyFromArgs) {
        Write-Error "No names provided via parameters or pipeline and -OnlyFromArgs was specified."
        exit 1
    }
    if (-not (Test-Path -Path $InputFile)) {
        Write-Error "Input file not found: $InputFile"
        exit 1
    }

    $raw = Get-Content -Path $InputFile -Encoding UTF8

    # Try to parse as markdown table first
    $collectedNames = Extract-NamesFromMarkdownTable -Lines $raw

    # If no names found, try a simple heuristic: lines that look like "Name Number"
    if ($collectedNames.Count -eq 0) {
        foreach ($line in $raw) {
            $t = $line.Trim()
            if (-not $t) { continue }
            # Skip markdown table separators or lines that already look like full URLs
            if ($t -match '^\|?\s*-{3,}\s*\|' -or $t -match '^https?://') { continue }
            $collectedNames += $t
        }
    }

    if ($collectedNames.Count -eq 0) {
        Write-Error "No names found in $InputFile"
        exit 1
    }
}

# Build URLs
$base = 'https://buylist.gamenerdz.com/retailer/buylist?product_line=Pokemon&sort=Relevance&q='
$urls = $collectedNames | ForEach-Object {
    $encoded = FormUrlEncode -s $_
    "$base$encoded"
}

# Write output (default: write to file; if OutputFile is empty string, write to stdout)
if ($AsStartProcessLoop) {
    # Build a single foreach loop string containing all URLs
    $quoted = $urls | ForEach-Object { '"' + $_ + '"' }
    $joined = $quoted -join ','
    # Include a 1-second delay after opening each URL
    $loopString = 'foreach ($u in ' + $joined + ') { Start-Process $u; Start-Sleep -Seconds 1 }'

    if ($OutputFile) {
        if ((Test-Path $OutputFile) -and (-not $Overwrite)) {
            Write-Error "Output file already exists: $OutputFile. Use -Overwrite to replace."
            exit 1
        }
        $loopString | Set-Content -Path $OutputFile -Encoding UTF8
        Write-Output "Wrote foreach loop string to: $OutputFile"
    } else {
        Write-Output $loopString
    }
} else {
    if ($OutputFile) {
        if ((Test-Path $OutputFile) -and (-not $Overwrite)) {
            Write-Error "Output file already exists: $OutputFile. Use -Overwrite to replace."
            exit 1
        }
        $urls | Set-Content -Path $OutputFile -Encoding UTF8
        Write-Output "Wrote $($urls.Count) URLs to: $OutputFile"
    } else {
        $urls | ForEach-Object { Write-Output $_ }
    }
}