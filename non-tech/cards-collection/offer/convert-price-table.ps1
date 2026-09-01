<#
.SYNOPSIS
    Converts Pokemon card price markdown tables into an interactive HTML comparison page.

.DESCRIPTION
    Reads the main price comparison table from a markdown file and optionally includes
    additional card price files (simpler format: Card | Set | PC | GN | CSI).
    Generates a filterable, sortable HTML page with deal analysis.

.PARAMETER InputFile
    Path to the main markdown file with the comparison table.
    Defaults to price-check-results.md in the same directory.

.PARAMETER AdditionalCardFiles
    Optional paths to additional card price markdown files (simpler format).
    These cards will have no offer value and will be appended after the main table cards.

.PARAMETER OutputFile
    Path for the generated HTML file.
    Defaults to price-check-results.html in the same directory.

.PARAMETER GnCreditMultiplier
    Multiplier to calculate GameNerdz credit from cash. Default: 1.25

.PARAMETER CsiCreditMultiplier
    Multiplier to calculate CoolStuffInc credit from cash. Default: 1.20

.EXAMPLE
    .\convert-price-table.ps1

.EXAMPLE
    .\convert-price-table.ps1 -AdditionalCardFiles ..\card-prices.md

.EXAMPLE
    .\convert-price-table.ps1 -InputFile .\my-cards.md -OutputFile .\my-cards.html
#>

[CmdletBinding()]
param(
    [string]$InputFile = (Join-Path $PSScriptRoot "price-check-results.md"),
    [string[]]$AdditionalCardFiles = @(),
    [string]$OutputFile = (Join-Path $PSScriptRoot "price-check-results.html"),
    [double]$GnCreditMultiplier = 1.25,
    [double]$CsiCreditMultiplier = 1.20
)

# ============================================================
# Helper Functions
# ============================================================

function Parse-DollarAmount {
    param([string]$text)
    if ([string]::IsNullOrWhiteSpace($text) -or $text.Trim() -match '(?i)^N/?A') {
        return $null
    }
    if ($text -match '\$([\d,]+(?:\.\d+)?)') {
        return [double]($matches[1] -replace ',', '')
    }
    return $null
}

function Format-JsNumber {
    param($val)
    if ($null -eq $val) { return "null" }
    return $val.ToString([System.Globalization.CultureInfo]::InvariantCulture)
}

function Get-BestAlternative {
    param($pc, $csiCash, $csiCredit, $gnCash, $gnCredit)

    $alts = @()
    if ($null -ne $pc)        { $alts += [PSCustomObject]@{ Value = $pc;        Source = "PC" } }
    if ($null -ne $csiCash)   { $alts += [PSCustomObject]@{ Value = $csiCash;   Source = "CSI Cash" } }
    if ($null -ne $csiCredit) { $alts += [PSCustomObject]@{ Value = $csiCredit; Source = "CSI Credit" } }
    if ($null -ne $gnCash)    { $alts += [PSCustomObject]@{ Value = $gnCash;    Source = "GN Cash" } }
    if ($null -ne $gnCredit)  { $alts += [PSCustomObject]@{ Value = $gnCredit;  Source = "GN Credit" } }

    if ($alts.Count -gt 0) {
        $best = $alts | Sort-Object -Property Value -Descending | Select-Object -First 1
        return $best
    }
    return [PSCustomObject]@{ Value = $null; Source = "N/A" }
}

function Parse-MarkdownTables {
    param([string[]]$lines)

    $tables = @()
    $inTable = $false
    $headerSeen = $false
    $separatorSeen = $false
    $lastHeading = ""
    $currentTable = $null

    foreach ($line in $lines) {
        # Track section headings
        if ($line -match '^#{1,3}\s+(.+)') {
            $lastHeading = $matches[1].Trim()
        }

        if ($line -match '^\s*\|.*\|') {
            if (-not $inTable) {
                $inTable = $true
                $headerSeen = $true
                $separatorSeen = $false
                $currentTable = @{
                    Header      = $lastHeading
                    Rows        = @()
                    HeaderCells = ($line -split '\|' | ForEach-Object { $_.Trim() } | Where-Object { $_ -ne '' })
                }
                continue
            }
            if ($headerSeen -and -not $separatorSeen) {
                if ($line -match '^\s*\|\s*[-:\s]+[-|\s:]+\|') {
                    $separatorSeen = $true
                    continue
                }
            }
            if ($separatorSeen) {
                $currentTable.Rows += $line
            }
        }
        elseif ($inTable) {
            if ($separatorSeen -and $currentTable.Rows.Count -gt 0) {
                $tables += $currentTable
            }
            $inTable = $false
            $headerSeen = $false
            $separatorSeen = $false
            $currentTable = $null
        }
    }

    # Catch final table
    if ($inTable -and $separatorSeen -and $currentTable -and $currentTable.Rows.Count -gt 0) {
        $tables += $currentTable
    }

    return $tables
}

# ============================================================
# Parse Main Comparison Table
# ============================================================

Write-Host "Reading main file: $InputFile"
$mainLines = Get-Content $InputFile
$mainTables = Parse-MarkdownTables $mainLines

# The summary table is the first table with 7+ columns
$summaryTable = $mainTables | Where-Object { $_.HeaderCells.Count -ge 7 } | Select-Object -First 1

$cards = @()
$num = 1

if ($summaryTable) {
    Write-Host "  Found summary table: $($summaryTable.Rows.Count) rows"

    foreach ($row in $summaryTable.Rows) {
        $cells = $row -split '\|' | ForEach-Object { $_.Trim() } | Where-Object { $_ -ne '' }
        if ($cells.Count -lt 7) { continue }

        $rawName = $cells[0]
        # Strip leading item number like "01. " and bold markers
        $name = $rawName -replace '^\*{0,2}\d+\.\s*', ''
        $name = $name -replace '\*{1,2}', ''
        $name = $name.Trim()

        $offer    = Parse-DollarAmount $cells[1]
        $pc       = Parse-DollarAmount $cells[2]
        $csiCash  = Parse-DollarAmount $cells[3]
        $csiCredit = Parse-DollarAmount $cells[4]
        $gnCash   = Parse-DollarAmount $cells[5]
        $gnCredit = Parse-DollarAmount $cells[6]

        $best = Get-BestAlternative $pc $csiCash $csiCredit $gnCash $gnCredit

        $cards += [PSCustomObject]@{
            Num        = $num
            Name       = $name
            Offer      = $offer
            PC         = $pc
            CsiCash    = $csiCash
            CsiCredit  = $csiCredit
            GnCash     = $gnCash
            GnCredit   = $gnCredit
            BestAlt    = $best.Value
            BestSource = $best.Source
        }
        $num++
    }
}
else {
    Write-Warning "No summary table found with 7+ columns in $InputFile"
}

# ============================================================
# Parse Additional Card Files
# ============================================================

foreach ($cardFile in $AdditionalCardFiles) {
    $resolvedPath = if ([System.IO.Path]::IsPathRooted($cardFile)) {
        $cardFile
    } else {
        Join-Path $PSScriptRoot $cardFile
    }

    if (-not (Test-Path $resolvedPath)) {
        Write-Warning "Additional card file not found: $resolvedPath"
        continue
    }

    Write-Host "Reading additional cards: $resolvedPath"
    $addLines = Get-Content $resolvedPath
    $addTables = Parse-MarkdownTables $addLines

    foreach ($table in $addTables) {
        # Skip tables that don't look like card data (need at least Card + Set + one price)
        if ($table.HeaderCells.Count -lt 3) { continue }

        # Detect card type from section heading
        $cardType = ""
        if ($table.Header -match '(?i)reverse\s*holo') {
            $cardType = "Rev Holo"
        }
        elseif ($table.Header -match '(?i)holo') {
            $cardType = "Holo"
        }

        Write-Host "  Section '$($table.Header)': $($table.Rows.Count) rows $(if ($cardType) { "[$cardType]" })"

        foreach ($row in $table.Rows) {
            $cells = $row -split '\|' | ForEach-Object { $_.Trim() } | Where-Object { $_ -ne '' }
            if ($cells.Count -lt 3) { continue }

            $cardName  = $cells[0].Trim()
            $setName   = $cells[1].Trim()
            $pcVal     = Parse-DollarAmount $cells[2]
            $gnCashVal = if ($cells.Count -ge 4) { Parse-DollarAmount $cells[3] } else { $null }
            $csiCashVal = if ($cells.Count -ge 5) { Parse-DollarAmount $cells[4] } else { $null }

            # Compute credit values from cash
            $gnCreditVal  = if ($null -ne $gnCashVal)  { [Math]::Round($gnCashVal * $GnCreditMultiplier, 2) }  else { $null }
            $csiCreditVal = if ($null -ne $csiCashVal) { [Math]::Round($csiCashVal * $CsiCreditMultiplier, 2) } else { $null }

            # Build display name: "Card Name (Set) [Type]"
            $typeTag = if ($cardType) { " [$cardType]" } else { "" }
            $displayName = "$cardName ($setName)$typeTag"

            $best = Get-BestAlternative $pcVal $csiCashVal $csiCreditVal $gnCashVal $gnCreditVal

            $cards += [PSCustomObject]@{
                Num        = $num
                Name       = $displayName
                Offer      = $null
                PC         = $pcVal
                CsiCash    = $csiCashVal
                CsiCredit  = $csiCreditVal
                GnCash     = $gnCashVal
                GnCredit   = $gnCreditVal
                BestAlt    = $best.Value
                BestSource = $best.Source
            }
            $num++
        }
    }
}

Write-Host "`nTotal cards: $($cards.Count)"

# ============================================================
# Generate JavaScript Card Data
# ============================================================

$cardEntries = $cards | ForEach-Object {
    $c = $_
    $escapedName = $c.Name -replace '\\', '\\\\' -replace '"', '\"' -replace "'", "\'"
    "                { num: $(Format-JsNumber $c.Num), name: `"$escapedName`", offer: $(Format-JsNumber $c.Offer), pc: $(Format-JsNumber $c.PC), csiCash: $(Format-JsNumber $c.CsiCash), csiCredit: $(Format-JsNumber $c.CsiCredit), gnCash: $(Format-JsNumber $c.GnCash), gnCredit: $(Format-JsNumber $c.GnCredit), bestAlt: $(Format-JsNumber $c.BestAlt), bestSource: `"$($c.BestSource)`" }"
}

$cardDataBlock = $cardEntries -join ",`n"

# ============================================================
# HTML Template
# ============================================================

$htmlTemplate = @'
<!doctype html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Pokemon Card Offer Price Comparison</title>
        <style>
            * { box-sizing: border-box; }
            body {
                font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Oxygen, Ubuntu, sans-serif;
                margin: 0; padding: 20px; background: #1a1a2e; color: #eee;
            }
            h1 { color: #ffcb05; text-align: center; margin-bottom: 10px; }
            .summary { text-align: center; margin-bottom: 20px; color: #aaa; }
            .filters { display: flex; gap: 15px; margin-bottom: 20px; flex-wrap: wrap; justify-content: center; }
            .filters label { display: flex; align-items: center; gap: 5px; cursor: pointer; }
            .filters input[type="checkbox"] { width: 18px; height: 18px; }
            .search-box { display: flex; justify-content: center; margin-bottom: 15px; }
            .search-box input {
                padding: 8px 15px; width: 400px; max-width: 90%; border-radius: 6px;
                border: 1px solid #444; background: #16213e; color: #eee; font-size: 14px;
            }
            .search-box input::placeholder { color: #777; }
            .table-container { overflow-x: auto; }
            table { width: 100%; border-collapse: collapse; font-size: 14px; }
            th, td { padding: 10px 8px; text-align: left; border-bottom: 1px solid #333; }
            th {
                background: #16213e; color: #ffcb05; cursor: pointer; user-select: none;
                position: sticky; top: 0; white-space: nowrap;
            }
            th:hover { background: #1f3460; }
            th::after { content: " \21C5"; opacity: 0.3; }
            th.sort-asc::after { content: " \25B2"; opacity: 1; }
            th.sort-desc::after { content: " \25BC"; opacity: 1; }
            tr:hover { background: #16213e; }
            tr.great-deal { background: rgba(40, 167, 69, 0.2); }
            tr.good-deal { background: rgba(40, 167, 69, 0.1); }
            tr.bad-deal { background: rgba(220, 53, 69, 0.2); }
            tr.no-offer { background: rgba(108, 117, 125, 0.1); }
            tr.hidden { display: none; }
            .money { font-family: "Courier New", monospace; text-align: right; }
            .positive { color: #28a745; }
            .negative { color: #dc3545; }
            .neutral { color: #6c757d; }
            .verdict { font-weight: bold; }
            .legend { display: flex; gap: 20px; justify-content: center; margin-bottom: 15px; flex-wrap: wrap; }
            .legend-item { display: flex; align-items: center; gap: 8px; }
            .legend-box { width: 20px; height: 20px; border-radius: 3px; }
            .legend-great { background: rgba(40, 167, 69, 0.4); }
            .legend-good { background: rgba(40, 167, 69, 0.2); }
            .legend-bad { background: rgba(220, 53, 69, 0.3); }
            .legend-nooffer { background: rgba(108, 117, 125, 0.2); }
            .totals {
                margin-top: 20px; padding: 15px; background: #16213e; border-radius: 8px;
                display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 15px;
            }
            .total-item { text-align: center; }
            .total-value { font-size: 24px; font-weight: bold; color: #ffcb05; }
            .total-label { color: #aaa; font-size: 12px; }
            .checkbox-col { width: 40px; text-align: center; }
            .checkbox-col input { width: 18px; height: 18px; cursor: pointer; }
            th.checkbox-col::after { content: ""; }
            tr.unchecked { opacity: 0.4; }
        </style>
    </head>
    <body>
        <h1>&#127140; Pokemon Card Offer Price Comparison</h1>
        <p class="summary">Click column headers to sort &bull; Use search to filter by name</p>

        <div class="legend">
            <div class="legend-item"><div class="legend-box legend-great"></div> Great Deal (10%+ above market)</div>
            <div class="legend-item"><div class="legend-box legend-good"></div> Good Deal (at/above market)</div>
            <div class="legend-item"><div class="legend-box legend-bad"></div> Below Market (consider rejecting)</div>
            <div class="legend-item"><div class="legend-box legend-nooffer"></div> No Offer (price tracking only)</div>
        </div>

        <div class="search-box">
            <input type="text" id="searchInput" placeholder="Search by card name..." />
        </div>

        <div class="filters">
            <label><input type="checkbox" id="showAll" checked /> Show All</label>
            <label><input type="checkbox" id="showGreat" /> Great Deals Only</label>
            <label><input type="checkbox" id="showBad" /> Below Market Only</label>
            <label><input type="checkbox" id="showNoOffer" /> No Offer Only</label>
        </div>

        <div class="totals">
            <div class="total-item">
                <div class="total-value" id="totalOffer">$0</div>
                <div class="total-label">Total Offer Value</div>
            </div>
            <div class="total-item">
                <div class="total-value" id="totalBest">$0</div>
                <div class="total-label">Total Best Alternative</div>
            </div>
            <div class="total-item">
                <div class="total-value" id="totalDiff">$0</div>
                <div class="total-label">Difference</div>
            </div>
            <div class="total-item">
                <div class="total-value" id="visibleCount">0</div>
                <div class="total-label">Items Selected / Shown</div>
            </div>
        </div>

        <div class="table-container">
            <table id="priceTable">
                <thead>
                    <tr>
                        <th class="checkbox-col"><input type="checkbox" id="selectAll" checked /></th>
                        <th data-sort="number">#</th>
                        <th data-sort="string">Item Name</th>
                        <th data-sort="number">Offer</th>
                        <th data-sort="number">PriceCharting</th>
                        <th data-sort="number">CSI Cash</th>
                        <th data-sort="number">CSI Credit</th>
                        <th data-sort="number">GN Cash</th>
                        <th data-sort="number">GN Credit</th>
                        <th data-sort="number">Best Alt</th>
                        <th data-sort="number">Diff $</th>
                        <th data-sort="number">Diff %</th>
                        <th data-sort="string">Verdict</th>
                    </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>

        <script>
            const cardData = [
__CARD_DATA__
            ];

            // Calculate derived values
            cardData.forEach((card) => {
                if (card.offer !== null && card.bestAlt !== null) {
                    card.diffDollar = card.offer - card.bestAlt;
                    card.diffPercent = card.bestAlt !== 0 ? ((card.offer - card.bestAlt) / card.bestAlt) * 100 : 0;

                    if (card.diffPercent >= 10) {
                        card.verdict = "GREAT";
                        card.dealClass = "great-deal";
                    } else if (card.diffPercent >= -5) {
                        card.verdict = "GOOD";
                        card.dealClass = "good-deal";
                    } else {
                        card.verdict = "BELOW";
                        card.dealClass = "bad-deal";
                    }
                } else {
                    card.diffDollar = null;
                    card.diffPercent = null;
                    card.verdict = "NO OFFER";
                    card.dealClass = "no-offer";
                }
            });

            const tbody = document.querySelector("#priceTable tbody");
            const thead = document.querySelector("#priceTable thead");
            let currentSort = { column: null, direction: "asc" };
            const checkedItems = new Set(cardData.map((c) => c.num));

            function formatMoney(val) {
                if (val === null || val === undefined) return "N/A";
                return "$" + val.toFixed(2);
            }

            function formatDiff(val, isPercent = false) {
                if (val === null || val === undefined) return "N/A";
                const prefix = val >= 0 ? "+" : "";
                const suffix = isPercent ? "%" : "";
                return prefix + val.toFixed(isPercent ? 1 : 2) + suffix;
            }

            function renderTable(data) {
                tbody.innerHTML = "";
                data.forEach((card) => {
                    const tr = document.createElement("tr");
                    tr.className = card.dealClass;
                    tr.dataset.verdict = card.verdict;
                    tr.dataset.num = card.num;
                    tr.dataset.name = card.name.toLowerCase();

                    const diffClass = card.diffDollar !== null
                        ? (card.diffDollar >= 0 ? "positive" : "negative")
                        : "neutral";

                    const isChecked = checkedItems.has(card.num);
                    if (!isChecked) tr.classList.add("unchecked");

                    tr.innerHTML = `
                    <td class="checkbox-col"><input type="checkbox" class="row-checkbox" data-num="${card.num}" ${isChecked ? "checked" : ""} /></td>
                    <td>${card.num}</td>
                    <td>${card.name}</td>
                    <td class="money">${formatMoney(card.offer)}</td>
                    <td class="money">${formatMoney(card.pc)}</td>
                    <td class="money">${formatMoney(card.csiCash)}</td>
                    <td class="money">${formatMoney(card.csiCredit)}</td>
                    <td class="money">${formatMoney(card.gnCash)}</td>
                    <td class="money">${formatMoney(card.gnCredit)}</td>
                    <td class="money">${formatMoney(card.bestAlt)}<br><small>(${card.bestSource})</small></td>
                    <td class="money ${diffClass}">${formatDiff(card.diffDollar)}</td>
                    <td class="money ${diffClass}">${formatDiff(card.diffPercent, true)}</td>
                    <td class="verdict">${card.verdict}</td>
                    `;
                    tbody.appendChild(tr);
                });
                attachCheckboxListeners();
                applyFilters();
            }

            function updateTotals() {
                const visibleRows = [...tbody.querySelectorAll("tr:not(.hidden)")];
                const visibleNums = visibleRows.map((tr) => parseInt(tr.dataset.num));
                const visibleCards = cardData.filter((c) => visibleNums.includes(c.num));
                const checkedCards = visibleCards.filter((c) => checkedItems.has(c.num));

                const cardsWithOffer = checkedCards.filter((c) => c.offer !== null);
                const totalOffer = cardsWithOffer.reduce((sum, c) => sum + c.offer, 0);
                const totalBest = cardsWithOffer.reduce((sum, c) => sum + (c.bestAlt || 0), 0);
                const diff = totalOffer - totalBest;
                const diffPercent = totalBest > 0 ? (diff / totalBest) * 100 : 0;

                document.getElementById("totalOffer").textContent = formatMoney(totalOffer);
                document.getElementById("totalBest").textContent = formatMoney(totalBest);
                document.getElementById("totalDiff").textContent = formatDiff(diff) + " (" + formatDiff(diffPercent, true) + ")";
                document.getElementById("totalDiff").className = "total-value " + (diff >= 0 ? "positive" : "negative");
                document.getElementById("visibleCount").textContent = checkedCards.length + " / " + visibleCards.length;
            }

            function sortData(column, direction) {
                const sortKey = { 0: "num", 1: "num", 2: "name", 3: "offer", 4: "pc", 5: "csiCash", 6: "csiCredit", 7: "gnCash", 8: "gnCredit", 9: "bestAlt", 10: "diffDollar", 11: "diffPercent", 12: "verdict" }[column];

                const sorted = [...cardData].sort((a, b) => {
                    let valA = a[sortKey];
                    let valB = b[sortKey];
                    if (valA === null) valA = -Infinity;
                    if (valB === null) valB = -Infinity;
                    if (typeof valA === "string") {
                        return direction === "asc" ? valA.localeCompare(valB) : valB.localeCompare(valA);
                    }
                    return direction === "asc" ? valA - valB : valB - valA;
                });

                renderTable(sorted);
            }

            // Sort click handlers
            thead.querySelectorAll("th").forEach((th, index) => {
                if (index === 0) return;
                th.addEventListener("click", () => {
                    const newDirection = currentSort.column === index && currentSort.direction === "asc" ? "desc" : "asc";
                    currentSort = { column: index, direction: newDirection };
                    thead.querySelectorAll("th").forEach((h) => h.classList.remove("sort-asc", "sort-desc"));
                    th.classList.add(newDirection === "asc" ? "sort-asc" : "sort-desc");
                    sortData(index, newDirection);
                });
            });

            // Checkbox handlers
            function attachCheckboxListeners() {
                tbody.querySelectorAll(".row-checkbox").forEach((cb) => {
                    cb.addEventListener("change", function () {
                        const num = parseInt(this.dataset.num);
                        const row = this.closest("tr");
                        if (this.checked) { checkedItems.add(num); row.classList.remove("unchecked"); }
                        else { checkedItems.delete(num); row.classList.add("unchecked"); }
                        updateSelectAllCheckbox();
                        updateTotals();
                    });
                });
            }

            function updateSelectAllCheckbox() {
                const allCheckboxes = tbody.querySelectorAll(".row-checkbox");
                const checkedCount = [...allCheckboxes].filter((cb) => cb.checked).length;
                const selectAll = document.getElementById("selectAll");
                selectAll.checked = checkedCount === allCheckboxes.length;
                selectAll.indeterminate = checkedCount > 0 && checkedCount < allCheckboxes.length;
            }

            document.getElementById("selectAll").addEventListener("change", function () {
                const isChecked = this.checked;
                tbody.querySelectorAll(".row-checkbox").forEach((cb) => {
                    cb.checked = isChecked;
                    const num = parseInt(cb.dataset.num);
                    const row = cb.closest("tr");
                    if (isChecked) { checkedItems.add(num); row.classList.remove("unchecked"); }
                    else { checkedItems.delete(num); row.classList.add("unchecked"); }
                });
                updateTotals();
            });

            // Filter handlers
            const filterIds = ["showAll", "showGreat", "showBad", "showNoOffer"];
            filterIds.forEach((id) => {
                document.getElementById(id).addEventListener("change", function () {
                    if (this.checked && id !== "showAll") {
                        // Uncheck others except showAll
                        filterIds.forEach((fid) => { if (fid !== id) document.getElementById(fid).checked = false; });
                    } else if (this.checked && id === "showAll") {
                        filterIds.forEach((fid) => { if (fid !== "showAll") document.getElementById(fid).checked = false; });
                    }
                    applyFilters();
                });
            });

            // Search handler
            document.getElementById("searchInput").addEventListener("input", function () {
                applyFilters();
            });

            function applyFilters() {
                const showAll = document.getElementById("showAll").checked;
                const showGreat = document.getElementById("showGreat").checked;
                const showBad = document.getElementById("showBad").checked;
                const showNoOffer = document.getElementById("showNoOffer").checked;
                const searchTerm = document.getElementById("searchInput").value.toLowerCase().trim();

                tbody.querySelectorAll("tr").forEach((tr) => {
                    const verdict = tr.dataset.verdict;
                    const name = tr.dataset.name || "";
                    let visible = true;

                    // Apply verdict filter
                    if (!showAll) {
                        if (showGreat) visible = verdict === "GREAT";
                        else if (showBad) visible = verdict === "BELOW";
                        else if (showNoOffer) visible = verdict === "NO OFFER";
                        else { visible = true; document.getElementById("showAll").checked = true; }
                    }

                    // Apply search filter
                    if (visible && searchTerm) {
                        visible = name.includes(searchTerm);
                    }

                    tr.classList.toggle("hidden", !visible);
                });
                updateTotals();
            }

            // Initial render
            renderTable(cardData);
        </script>
    </body>
</html>
'@

# ============================================================
# Output
# ============================================================

$html = $htmlTemplate -replace '__CARD_DATA__', $cardDataBlock
$html | Out-File $OutputFile -Encoding UTF8

Write-Host "`nGenerated: $OutputFile"
Write-Host "Cards with offers: $(($cards | Where-Object { $null -ne $_.Offer }).Count)"
Write-Host "Cards without offers: $(($cards | Where-Object { $null -eq $_.Offer }).Count)"
