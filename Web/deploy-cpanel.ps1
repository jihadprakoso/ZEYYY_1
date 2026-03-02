$ErrorActionPreference = "Stop"

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$dist = Join-Path $root "dist"
$zipPath = Join-Path $root "cpanel-deploy.zip"

Write-Host "Building dist..." -ForegroundColor Cyan
powershell -ExecutionPolicy Bypass -File (Join-Path $root "build-dist.ps1")

if (!(Test-Path $dist)) {
  throw "dist/ tidak ditemukan setelah build."
}

if (Test-Path $zipPath) {
  Remove-Item -Force $zipPath
}

Write-Host "Creating ZIP: $zipPath" -ForegroundColor Cyan
Compress-Archive -Path (Join-Path $dist "*") -DestinationPath $zipPath -CompressionLevel Optimal

Write-Host "Done." -ForegroundColor Green
Write-Host "Upload isi ZIP ke public_html (atau extract lalu upload)." -ForegroundColor Green

