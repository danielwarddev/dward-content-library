param(
    [string]$ExportPath = (Join-Path $PSScriptRoot "daninacan.WordPress.2026-09-22.xml"),
    [string]$OutputPath = (Join-Path $PSScriptRoot "media")
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path -LiteralPath $ExportPath)) {
    throw "WordPress export not found: $ExportPath"
}

[xml]$export = Get-Content -Raw -LiteralPath $ExportPath
$namespaces = New-Object System.Xml.XmlNamespaceManager($export.NameTable)
$namespaces.AddNamespace("content", "http://purl.org/rss/1.0/modules/content/")
$namespaces.AddNamespace("wp", "http://wordpress.org/export/1.2/")

$items = @($export.SelectNodes("//item", $namespaces))
$contentItemsById = @{}

foreach ($item in $items) {
    $postType = $item.SelectSingleNode("wp:post_type", $namespaces).InnerText
    if ($postType -notin @("post", "page")) {
        continue
    }

    $postId = $item.SelectSingleNode("wp:post_id", $namespaces).InnerText
    $slug = $item.SelectSingleNode("wp:post_name", $namespaces).InnerText
    if ([string]::IsNullOrWhiteSpace($slug)) {
        $slug = "$postType-$postId"
    }

    $contentItemsById[$postId] = [pscustomobject]@{
        Id = $postId
        Slug = $slug
        Status = $item.SelectSingleNode("wp:status", $namespaces).InnerText
        Type = $postType
        Content = $item.SelectSingleNode("content:encoded", $namespaces).InnerText
    }
}

function Get-UploadUrlInfo {
    param([string]$Url)

    $decodedUrl = [System.Net.WebUtility]::HtmlDecode($Url).TrimEnd(")", "]", "}", ",", ".")
    $uri = [Uri]$decodedUrl
    $marker = "/wp-content/uploads/"
    $markerIndex = $uri.AbsolutePath.IndexOf($marker, [StringComparison]::OrdinalIgnoreCase)
    if ($markerIndex -lt 0) {
        return $null
    }

    $relativePath = [Uri]::UnescapeDataString($uri.AbsolutePath.Substring($markerIndex + $marker.Length))
    if ([string]::IsNullOrWhiteSpace($relativePath)) {
        return $null
    }

    [pscustomobject]@{
        Url = $uri.GetLeftPart([UriPartial]::Path)
        RelativePath = $relativePath.Replace("/", [IO.Path]::DirectorySeparatorChar)
    }
}

$downloadRequests = @{}

function Add-DownloadRequest {
    param(
        [pscustomobject]$Owner,
        [string]$Url,
        [string]$Source
    )

    $urlInfo = Get-UploadUrlInfo -Url $Url
    if ($null -eq $urlInfo) {
        return
    }

    if ($null -eq $Owner) {
        $ownerPath = "unassigned"
        $ownerSlug = ""
        $ownerStatus = ""
        $ownerType = ""
    }
    else {
        $statePath = if ($Owner.Status -eq "publish") { "published" } else { "drafts" }
        $ownerPath = Join-Path "by-post" (Join-Path $statePath $Owner.Slug)
        $ownerSlug = $Owner.Slug
        $ownerStatus = $Owner.Status
        $ownerType = $Owner.Type
    }

    $relativeOutputPath = Join-Path $ownerPath $urlInfo.RelativePath
    $key = "$relativeOutputPath|$($urlInfo.Url)"
    $downloadRequests[$key] = [pscustomobject]@{
        PostSlug = $ownerSlug
        PostStatus = $ownerStatus
        PostType = $ownerType
        Source = $Source
        SourceUrl = $urlInfo.Url
        RelativePath = $relativeOutputPath
    }
}

$uploadUrlPattern = 'https?://[^\s"''<>]+/wp-content/uploads/[^\s"''<>]+'

foreach ($owner in $contentItemsById.Values) {
    foreach ($match in [regex]::Matches($owner.Content, $uploadUrlPattern, [Text.RegularExpressions.RegexOptions]::IgnoreCase)) {
        Add-DownloadRequest -Owner $owner -Url $match.Value -Source "embedded-content"
    }
}

foreach ($item in $items) {
    if ($item.SelectSingleNode("wp:post_type", $namespaces).InnerText -ne "attachment") {
        continue
    }

    $attachmentUrlNode = $item.SelectSingleNode("wp:attachment_url", $namespaces)
    if ($null -eq $attachmentUrlNode -or [string]::IsNullOrWhiteSpace($attachmentUrlNode.InnerText)) {
        continue
    }

    $parentId = $item.SelectSingleNode("wp:post_parent", $namespaces).InnerText
    $owner = if ($contentItemsById.ContainsKey($parentId)) { $contentItemsById[$parentId] } else { $null }
    $source = if ($null -eq $owner) { "attachment-unassigned" } else { "attachment-parent" }
    Add-DownloadRequest -Owner $owner -Url $attachmentUrlNode.InnerText -Source $source

    $attachmentUri = [Uri]$attachmentUrlNode.InnerText
    $attachmentDirectory = $attachmentUri.GetLeftPart([UriPartial]::Authority) +
        $attachmentUri.AbsolutePath.Substring(0, $attachmentUri.AbsolutePath.LastIndexOf("/") + 1)
    $metadataNode = $item.SelectNodes("wp:postmeta", $namespaces) | Where-Object {
        $_.SelectSingleNode("wp:meta_key", $namespaces).InnerText -eq "_wp_attachment_metadata"
    } | Select-Object -First 1

    if ($null -eq $metadataNode) {
        continue
    }

    $metadataValue = $metadataNode.SelectSingleNode("wp:meta_value", $namespaces).InnerText
    foreach ($fileMatch in [regex]::Matches($metadataValue, 's:4:"file";s:\d+:"(?<file>[^"]+)"')) {
        $fileName = $fileMatch.Groups["file"].Value
        if ($fileName.Contains("/")) {
            continue
        }

        Add-DownloadRequest -Owner $owner -Url ($attachmentDirectory + $fileName) -Source "attachment-generated-size"
    }
}

$siteImageNode = $export.SelectSingleNode("//channel/image/url")
if ($null -ne $siteImageNode -and -not [string]::IsNullOrWhiteSpace($siteImageNode.InnerText)) {
    $siteImage = Get-UploadUrlInfo -Url $siteImageNode.InnerText
    if ($null -ne $siteImage) {
        $relativeOutputPath = Join-Path "site" $siteImage.RelativePath
        $downloadRequests["$relativeOutputPath|$($siteImage.Url)"] = [pscustomobject]@{
            PostSlug = ""
            PostStatus = ""
            PostType = "site"
            Source = "site-image"
            SourceUrl = $siteImage.Url
            RelativePath = $relativeOutputPath
        }
    }
}

$requests = @($downloadRequests.Values | Sort-Object RelativePath, SourceUrl)
$failures = [Collections.Generic.List[object]]::new()
$downloaded = 0
$existing = 0

foreach ($request in $requests) {
    $destination = Join-Path $OutputPath $request.RelativePath
    $destinationDirectory = Split-Path -Parent $destination
    New-Item -ItemType Directory -Force -Path $destinationDirectory | Out-Null

    if (Test-Path -LiteralPath $destination) {
        $existing++
        continue
    }

    try {
        Invoke-WebRequest -UseBasicParsing -Uri $request.SourceUrl -OutFile $destination
        $downloaded++
    }
    catch {
        Remove-Item -ErrorAction SilentlyContinue -LiteralPath $destination
        $failures.Add([pscustomobject]@{
            SourceUrl = $request.SourceUrl
            RelativePath = $request.RelativePath
            Error = $_.Exception.Message
        })
    }
}

New-Item -ItemType Directory -Force -Path $OutputPath | Out-Null
$requests | Export-Csv -NoTypeInformation -Encoding UTF8 -Path (Join-Path $OutputPath "manifest.csv")
$failures | Export-Csv -NoTypeInformation -Encoding UTF8 -Path (Join-Path $OutputPath "failures.csv")

Write-Output "Media references: $($requests.Count)"
Write-Output "Downloaded: $downloaded"
Write-Output "Already present: $existing"
Write-Output "Failed: $($failures.Count)"

if ($failures.Count -gt 0) {
    exit 1
}