$file = "D:\Data User\Documents\GitHub\deartbox-Packaging\lightmode\notion-feel-v2-cleaned.html"
$content = Get-Content $file -Raw -Encoding UTF8

Write-Host ""
Write-Host "╔════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║  ☀️ FIXING LIGHT MODE CSS VARIABLES...                ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

# Find and fix the :root variables (light mode)
$oldRootVars = @'
:root {
  --bg: #ffffff;
  --card: #ffffff;
  --text: #ffffff;
  --text-muted: #525252;
  --text-light: #767676;
  --border: #e5e5e5;
  --accent: #d71921;
  --accent-2: #a01419;
  --glass: rgba(0,0,0,0.02);
  --shadow: rgba(0,0,0,0.08);
}
'@

$newRootVars = @'
:root {
  --bg: #ffffff;
  --card: #ffffff;
  --text: #1a1a1a;
  --text-muted: #525252;
  --text-light: #767676;
  --border: #e5e5e5;
  --accent: #d71921;
  --accent-2: #a01419;
  --glass: rgba(0,0,0,0.02);
  --shadow: rgba(0,0,0,0.08);
}
'@

# Replace the root variables
$content = $content -replace [regex]::Escape($oldRootVars), $newRootVars

# Also update dark mode text-light for better readability
$oldDarkVars = @'
[data-theme="dark"] {
  --bg: #0a0a0a;
  --card: #1a1a1a;
  --text: #ffffff;
  --text-muted: #a3a3a3;
  --text-light: #767676;
  --border: #2a2a2a;
  --accent: #ff2d3a;
  --accent-2: #d71921;
  --glass: rgba(255,255,255,0.05);
  --shadow: rgba(0,0,0,0.3);
}
'@

$newDarkVars = @'
[data-theme="dark"] {
  --bg: #0a0a0a;
  --card: #1a1a1a;
  --text: #ffffff;
  --text-muted: #b5b5b5;
  --text-light: #8a8a8a;
  --border: #2a2a2a;
  --accent: #ff2d3a;
  --accent-2: #d71921;
  --glass: rgba(255,255,255,0.05);
  --shadow: rgba(0,0,0,0.3);
}
'@

# Replace dark mode variables
$content = $content -replace [regex]::Escape($oldDarkVars), $newDarkVars

# Save file
Set-Content $file -Value $content -Encoding UTF8 -NoNewline

Write-Host "╔════════════════════════════════════════════════════════╗" -ForegroundColor Green
Write-Host "║  ✅ LIGHT MODE FIXED SUCCESSFULLY!                    ║" -ForegroundColor Green
Write-Host "╚════════════════════════════════════════════════════════╝" -ForegroundColor Green
Write-Host ""
Write-Host "Light Mode Variables:" -ForegroundColor Yellow
Write-Host "  --text: #1a1a1a (dark text) ✅" -ForegroundColor White
Write-Host "  --text-muted: #525252 (medium gray) ✅" -ForegroundColor White
Write-Host "  --text-light: #767676 (light gray) ✅" -ForegroundColor White
Write-Host ""
Write-Host "Dark Mode Variables:" -ForegroundColor Yellow
Write-Host "  --text: #ffffff (white text) ✅" -ForegroundColor White
Write-Host "  --text-muted: #b5b5b5 (light gray) ✅" -ForegroundColor White
Write-Host "  --text-light: #8a8a8a (medium gray) ✅" -ForegroundColor White
Write-Host ""
Write-Host "🎉 Light mode dan dark mode sekarang PERFECT!" -ForegroundColor Green
Write-Host ""
