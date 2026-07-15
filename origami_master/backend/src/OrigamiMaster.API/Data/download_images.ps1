<#
.SYNOPSIS
    Downloads all origami.me images referenced in origami_data.json and
    updates the JSON to use local relative paths served by the ASP.NET API.

.DESCRIPTION
    - Reads origami_data.json
    - Finds all ThumbnailUrl, CoverImageUrl, and ImageUrl fields pointing to origami.me
    - Downloads each unique image to wwwroot/images/origami/
    - Replaces the external URLs in the JSON with local /images/origami/<filename> paths
    - Writes the updated JSON back to origami_data.json
#>

$ErrorActionPreference = "Stop"
$scriptDir   = Split-Path -Parent $MyInvocation.MyCommand.Path
$jsonPath    = Join-Path $scriptDir "origami_data.json"
$outputDir   = Join-Path $scriptDir "..\wwwroot\images\origami"

# Ensure output directory exists
if (-not (Test-Path $outputDir)) {
    New-Item -ItemType Directory -Force -Path $outputDir | Out-Null
    Write-Host "[Info] Created directory: $outputDir"
}

# Read JSON as raw text (we'll do regex replacement to keep formatting clean)
$rawJson = Get-Content -Path $jsonPath -Encoding UTF8 -Raw

# Parse JSON to extract all unique origami.me URLs
$data = $rawJson | ConvertFrom-Json

# Collect all unique URLs
$urlSet = [System.Collections.Generic.HashSet[string]]::new()

foreach ($model in $data.OrigamiModels) {
    if ($model.ThumbnailUrl  -and $model.ThumbnailUrl  -like "*origami.me*") { $urlSet.Add($model.ThumbnailUrl)  | Out-Null }
    if ($model.CoverImageUrl -and $model.CoverImageUrl -like "*origami.me*") { $urlSet.Add($model.CoverImageUrl) | Out-Null }
}

foreach ($step in $data.OrigamiSteps) {
    if ($step.ImageUrl -and $step.ImageUrl -like "*origami.me*") { $urlSet.Add($step.ImageUrl) | Out-Null }
}

$totalUrls = $urlSet.Count
Write-Host "[Info] Found $totalUrls unique origami.me image URLs to download."

# Download each image and build a URL->local-path map
$urlMap = @{}
$downloaded = 0
$failed = 0

# Use a single HttpClient for all requests (more efficient)
Add-Type -AssemblyName System.Net.Http

$handler = [System.Net.Http.HttpClientHandler]::new()
$handler.AutomaticDecompression = [System.Net.DecompressionMethods]::GZip -bor [System.Net.DecompressionMethods]::Deflate
$client = [System.Net.Http.HttpClient]::new($handler)
$client.DefaultRequestHeaders.Add("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36")
$client.Timeout = [TimeSpan]::FromSeconds(30)

$i = 0
foreach ($url in $urlSet) {
    $i++
    $uri = [System.Uri]$url
    $filename = [System.IO.Path]::GetFileName($uri.LocalPath)
    $destPath = Join-Path $outputDir $filename

    # Local relative URL for the API to serve (ASP.NET static files)
    $localUrl = "/images/origami/$filename"
    $urlMap[$url] = $localUrl

    Write-Progress -Activity "Downloading images" -Status "$i/$totalUrls : $filename" -PercentComplete (($i / $totalUrls) * 100)

    if (Test-Path $destPath) {
        Write-Host "[Skip] ($i/$totalUrls) Already exists: $filename"
        $downloaded++
        continue
    }

    try {
        $bytes = $client.GetByteArrayAsync($url).Result
        [System.IO.File]::WriteAllBytes($destPath, $bytes)
        Write-Host "[OK]   ($i/$totalUrls) Downloaded: $filename  ($($bytes.Length) bytes)"
        $downloaded++
    }
    catch {
        Write-Host "[FAIL] ($i/$totalUrls) Failed to download: $url`n       Error: $_" -ForegroundColor Red
        # Keep the original URL in map so the JSON still references something
        $urlMap[$url] = $url
        $failed++
    }

    # Small delay to be polite to the server
    Start-Sleep -Milliseconds 200
}

$client.Dispose()
Write-Progress -Activity "Downloading images" -Completed

Write-Host ""
Write-Host "[Summary] Downloaded: $downloaded  |  Failed: $failed  |  Total unique URLs: $totalUrls"
Write-Host ""

# Replace all origami.me URLs in the raw JSON text with local paths
Write-Host "[Info] Updating origami_data.json with local paths..."

$updatedJson = $rawJson
foreach ($kvp in $urlMap.GetEnumerator()) {
    # Only replace URLs that were successfully downloaded
    if ($kvp.Value -ne $kvp.Key) {
        $escapedUrl = [regex]::Escape($kvp.Key)
        $updatedJson = $updatedJson -replace $escapedUrl, $kvp.Value
    }
}

# Write back with UTF-8 (no BOM)
[System.IO.File]::WriteAllText($jsonPath, $updatedJson, [System.Text.UTF8Encoding]::new($false))

Write-Host "[Done] origami_data.json has been updated with local image paths."
Write-Host "       Images are stored at: $outputDir"
Write-Host ""
Write-Host "IMPORTANT: If the database has already been seeded with the old URLs,"
Write-Host "           you must drop and re-seed the database for the changes to take effect."
Write-Host "           The application will automatically re-seed on next startup if models are cleared."
