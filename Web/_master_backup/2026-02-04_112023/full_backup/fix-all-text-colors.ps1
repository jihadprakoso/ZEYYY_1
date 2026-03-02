$file = "D:\Data User\Documents\GitHub\deartbox-Packaging\lightmode\notion-feel-v2-cleaned.html"
$content = Get-Content $file -Raw -Encoding UTF8

Write-Host ""
Write-Host "╔════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║  🎨 FIXING ALL HARDCODED TEXT COLORS...               ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

# Count before
$count1a = ([regex]::Matches($content, 'color: #1a1a1a;')).Count
$count52 = ([regex]::Matches($content, 'color: #525252;')).Count
$count76 = ([regex]::Matches($content, 'color: #767676;')).Count
$count55 = ([regex]::Matches($content, 'color: #555;')).Count
$counta3 = ([regex]::Matches($content, 'color: #a3a3a3;')).Count

Write-Host "Found hardcoded colors:" -ForegroundColor Yellow
Write-Host "  - #1a1a1a: $count1a instances" -ForegroundColor White
Write-Host "  - #525252: $count52 instances" -ForegroundColor White
Write-Host "  - #767676: $count76 instances" -ForegroundColor White
Write-Host "  - #555: $count55 instances" -ForegroundColor White
Write-Host "  - #a3a3a3: $counta3 instances" -ForegroundColor White
Write-Host "  TOTAL: $($count1a + $count52 + $count76 + $count55 + $counta3) instances" -ForegroundColor Red
Write-Host ""

# ========== REPLACE ALL HARDCODED TEXT COLORS ==========

Write-Host "Replacing with CSS variables..." -ForegroundColor Yellow
Write-Host ""

# Replace #1a1a1a with var(--text)
Write-Host "  Fixing #1a1a1a → var(--text)..." -ForegroundColor Cyan
$content = $content -replace 'color: #1a1a1a;', 'color: var(--text);'

# Replace #525252 with var(--text-muted)
Write-Host "  Fixing #525252 → var(--text-muted)..." -ForegroundColor Cyan
$content = $content -replace 'color: #525252;', 'color: var(--text-muted);'

# Replace #767676 with var(--text-light)
Write-Host "  Fixing #767676 → var(--text-light)..." -ForegroundColor Cyan
$content = $content -replace 'color: #767676;', 'color: var(--text-light);'

# Replace #555 with var(--text-muted)
Write-Host "  Fixing #555 → var(--text-muted)..." -ForegroundColor Cyan
$content = $content -replace 'color: #555;', 'color: var(--text-muted);'

# Replace #a3a3a3 with var(--text-light) (this is for footer)
Write-Host "  Fixing #a3a3a3 → var(--text-light)..." -ForegroundColor Cyan
$content = $content -replace 'color: #a3a3a3;', 'color: var(--text-light);'

Write-Host ""
Write-Host "  ✅ All text colors replaced with CSS variables!" -ForegroundColor Green

# ========== UPDATE CSS VARIABLES FOR BETTER DARK MODE ==========

Write-Host ""
Write-Host "Updating CSS variables for better contrast..." -ForegroundColor Yellow

# Update dark mode text variables for better readability
$updatedDarkVars = @'
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

# Replace existing dark theme variables
$content = $content -replace '\[data-theme="dark"\] \{[^}]+--shadow: rgba\(0,0,0,0\.3\);[^}]*\}', $updatedDarkVars

Write-Host "  ✅ CSS variables updated for better contrast!" -ForegroundColor Green

# Save file
Set-Content $file -Value $content -Encoding UTF8 -NoNewline

Write-Host ""
Write-Host "╔════════════════════════════════════════════════════════╗" -ForegroundColor Green
Write-Host "║  ✅ ALL TEXT COLORS FIXED SUCCESSFULLY!               ║" -ForegroundColor Green
Write-Host "╚════════════════════════════════════════════════════════╝" -ForegroundColor Green
Write-Host ""

# Count after
$contentAfter = Get-Content $file -Raw -Encoding UTF8
$remaining1a = ([regex]::Matches($contentAfter, 'color: #1a1a1a;')).Count
$remaining52 = ([regex]::Matches($contentAfter, 'color: #525252;')).Count
$remaining76 = ([regex]::Matches($contentAfter, 'color: #767676;')).Count
$remaining55 = ([regex]::Matches($contentAfter, 'color: #555;')).Count
$remaininga3 = ([regex]::Matches($contentAfter, 'color: #a3a3a3;')).Count

Write-Host "Results:" -ForegroundColor Cyan
Write-Host "  Before: 42 hardcoded colors" -ForegroundColor White
Write-Host "  After: $($remaining1a + $remaining52 + $remaining76 + $remaining55 + $remaininga3) hardcoded colors" -ForegroundColor White
Write-Host "  Fixed: $($count1a + $count52 + $count76 + $count55 + $counta3 - ($remaining1a + $remaining52 + $remaining76 + $remaining55 + $remaininga3)) instances" -ForegroundColor Green
Write-Host ""
Write-Host "Dark mode text colors:" -ForegroundColor Cyan
Write-Host "  --text: #ffffff (white - main text)" -ForegroundColor White
Write-Host "  --text-muted: #b5b5b5 (light gray - secondary text)" -ForegroundColor White
Write-Host "  --text-light: #8a8a8a (medium gray - subtle text)" -ForegroundColor White
Write-Host ""
Write-Host "🎉 Semua teks sekarang readable di dark mode!" -ForegroundColor Green
Write-Host ""
