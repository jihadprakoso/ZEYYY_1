$ErrorActionPreference = "Stop"

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$dist = Join-Path $root "dist"
$releaseRoot = Join-Path $root "release"
$version = (Get-Date -Format "yyyyMMdd-HHmmss")

& (Join-Path $root "build-dist.ps1")

if (!(Test-Path $dist)) {
  throw "dist folder not found: $dist"
}

if (!(Test-Path $releaseRoot)) {
  New-Item -ItemType Directory -Path $releaseRoot | Out-Null
}

$releaseDir = Join-Path $releaseRoot $version
New-Item -ItemType Directory -Path $releaseDir | Out-Null

$zipName = "deartbox-dist-$version.zip"
$zipPath = Join-Path $releaseDir $zipName
Compress-Archive -Path (Join-Path $dist "*") -DestinationPath $zipPath -Force

$checksumPath = Join-Path $releaseDir "SHA256SUMS.txt"
$files = Get-ChildItem -Path $dist -Recurse -File | Sort-Object FullName
$lines = foreach ($file in $files) {
  $hash = (Get-FileHash -Path $file.FullName -Algorithm SHA256).Hash.ToLowerInvariant()
  $rel = $file.FullName.Substring($dist.Length).TrimStart('\','/')
  "$hash  $rel"
}
$lines | Set-Content -Path $checksumPath -Encoding utf8

$manifestPath = Join-Path $releaseDir "manifest.json"
$manifest = [ordered]@{
  version = $version
  createdAt = (Get-Date).ToString("o")
  zip = $zipName
  fileCount = $files.Count
  files = @(
    foreach ($file in $files) {
      [ordered]@{
        path = $file.FullName.Substring($dist.Length).TrimStart('\','/')
        bytes = $file.Length
      }
    }
  )
}
($manifest | ConvertTo-Json -Depth 6) | Set-Content -Path $manifestPath -Encoding utf8

Write-Host "Release created:"
Write-Host "  $zipPath"
Write-Host "  $checksumPath"
Write-Host "  $manifestPath"

