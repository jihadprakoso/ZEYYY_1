$ErrorActionPreference = "Stop"

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$dist = Join-Path $root "dist"

if (Test-Path $dist) {
  try {
    Remove-Item -Recurse -Force $dist
  } catch {}
}

if (-not (Test-Path $dist)) {
  New-Item -ItemType Directory -Path $dist | Out-Null
}

$filesToCopy = @(
  ".htaccess",
  "index.html",
  "404.html",
  "privacy-policy.html",
  "terms-of-service.html",
  "robots.txt",
  "sitemap.xml",
  "optimized_styles.css",
  "optimized_script.js"
)

foreach ($file in $filesToCopy) {
  $src = Join-Path $root $file
  if (Test-Path $src) {
    Copy-Item -Force $src (Join-Path $dist $file)
  }
}

$assetsSrc = Join-Path $root "assets"
if (Test-Path $assetsSrc) {
  Copy-Item -Recurse -Force $assetsSrc (Join-Path $dist "assets")
}

$portofolioSrc = Join-Path $root "portofolio"
if (Test-Path $portofolioSrc) {
  Copy-Item -Recurse -Force $portofolioSrc (Join-Path $dist "portofolio")
}

$apiSrc = Join-Path $root "api"
if (Test-Path $apiSrc) {
  Copy-Item -Recurse -Force $apiSrc (Join-Path $dist "api")
}

$uploadsSrc = Join-Path $root "uploads"
if (Test-Path $uploadsSrc) {
  Copy-Item -Recurse -Force $uploadsSrc (Join-Path $dist "uploads")
}
