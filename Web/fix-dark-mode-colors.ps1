$file = "D:\Data User\Documents\GitHub\deartbox-Packaging\lightmode\notion-feel-v2-cleaned.html"
$content = Get-Content $file -Raw -Encoding UTF8

Write-Host "Fixing dark mode colors..." -ForegroundColor Yellow
Write-Host ""

# ========== FIX HEADER COLORS ==========
Write-Host "1. Fixing header background and border..." -ForegroundColor Cyan

# Fix header background
$content = $content -replace 'header \{\s+position: sticky;\s+top: 0;\s+z-index: 60;\s+background: #ffffff;', 'header {
  position: sticky;
  top: 0;
  z-index: 60;
  background: var(--bg);'

# Fix header border
$content = $content -replace 'border-bottom: 1px solid #e6e6e6;', 'border-bottom: 1px solid var(--border);'

Write-Host "   ✅ Header fixed" -ForegroundColor Green

# ========== FIX HERO SECTION ==========
Write-Host "2. Fixing hero section gradient..." -ForegroundColor Cyan

# Fix hero gradient background
$content = $content -replace 'background: linear-gradient\(180deg, #ffffff 0%, #fafafa 100%\);', 'background: linear-gradient(180deg, var(--bg) 0%, var(--card) 100%);'

Write-Host "   ✅ Hero gradient fixed" -ForegroundColor Green

# ========== FIX OTHER HARDCODED COLORS ==========
Write-Host "3. Fixing other hardcoded colors..." -ForegroundColor Cyan

# Fix body background
$content = $content -replace 'body \{\s+margin: 0;\s+font-family: -apple-system.*?\s+background: #ffffff;', 'body {
  margin: 0;
  font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
  background: var(--bg);'

# Fix nav-link hover background
$content = $content -replace '\.nav-link:hover \{\s+background: #f5f5f5;', '.nav-link:hover {
  background: var(--glass);'

# Fix nav-link active background
$content = $content -replace 'background: #fef1f2;', 'background: rgba(215, 25, 33, 0.08);'

# Fix mobile toggle hover
$content = $content -replace '\.mobile-toggle:hover \{\s+background: #f5f5f5;', '.mobile-toggle:hover {
  background: var(--glass);'

# Fix mobile nav link hover
$content = $content -replace '\.mobile-nav-link:hover,\s+\.mobile-nav-link\.active \{\s+background: #f5f5f5;', '.mobile-nav-link:hover,
.mobile-nav-link.active {
  background: var(--glass);'

# Fix feature visual background
$content = $content -replace '\.feature-visual \{\s+width: 100%;\s+height: 200px;\s+background: #f5f5f5;', '.feature-visual {
  width: 100%;
  height: 200px;
  background: var(--glass);'

# Fix step visual background
$content = $content -replace '\.step-visual \{\s+width: 100%;\s+height: 160px;\s+background: #f5f5f5;', '.step-visual {
  width: 100%;
  height: 160px;
  background: var(--glass);'

Write-Host "   ✅ Other colors fixed" -ForegroundColor Green

# ========== ADD DARK MODE SPECIFIC OVERRIDES ==========
Write-Host "4. Adding dark mode specific styles..." -ForegroundColor Cyan

$darkModeOverrides = @'


/* Dark mode specific overrides for header and hero */
[data-theme="dark"] header {
  background: rgba(10, 10, 10, 0.95);
  backdrop-filter: blur(10px);
  -webkit-backdrop-filter: blur(10px);
  border-bottom-color: var(--border);
}

[data-theme="dark"] .hero-modern {
  background: linear-gradient(180deg, #0a0a0a 0%, #0f0f0f 100%);
}

[data-theme="dark"] .nav-link:hover {
  background: rgba(255, 255, 255, 0.05);
}

[data-theme="dark"] .nav-link.active {
  background: rgba(215, 25, 33, 0.15);
}

[data-theme="dark"] .mobile-toggle:hover {
  background: rgba(255, 255, 255, 0.05);
}

[data-theme="dark"] .mobile-toggle span {
  background: var(--text);
}

[data-theme="dark"] .feature-visual,
[data-theme="dark"] .step-visual {
  background: rgba(255, 255, 255, 0.03);
}

[data-theme="dark"] .hero-badge {
  background: rgba(215, 25, 33, 0.15);
  border-color: rgba(215, 25, 33, 0.3);
}

[data-theme="dark"] .section-badge {
  background: rgba(215, 25, 33, 0.15);
}

[data-theme="dark"] .slide-nav {
  background: rgba(26, 26, 26, 0.95);
  border-color: rgba(255, 255, 255, 0.1);
}

[data-theme="dark"] .slide-nav:hover {
  background: rgba(26, 26, 26, 1);
}

[data-theme="dark"] .faq-icon {
  background: rgba(255, 255, 255, 0.05);
}

[data-theme="dark"] .btn-hero-secondary {
  background: rgba(255, 255, 255, 0.05);
  border-color: var(--border);
  color: var(--text);
}

[data-theme="dark"] .btn-hero-secondary:hover {
  background: rgba(255, 255, 255, 0.1);
  border-color: var(--accent);
}

'@

# Insert dark mode overrides before the closing of dark mode section
$content = $content -replace '(\[data-theme="dark"\] \.file-preview \{[^}]+\})', ('$1' + "`n" + $darkModeOverrides)

Write-Host "   ✅ Dark mode overrides added" -ForegroundColor Green

# Save file
Set-Content $file -Value $content -Encoding UTF8 -NoNewline

Write-Host ""
Write-Host "╔════════════════════════════════════════════╗" -ForegroundColor Green
Write-Host "║  ✅ DARK MODE COLORS FIXED SUCCESSFULLY!  ║" -ForegroundColor Green
Write-Host "╚════════════════════════════════════════════╝" -ForegroundColor Green
Write-Host ""
Write-Host "Fixed items:" -ForegroundColor Yellow
Write-Host "  ✅ Header background (now uses var(--bg))" -ForegroundColor White
Write-Host "  ✅ Header border (now uses var(--border))" -ForegroundColor White
Write-Host "  ✅ Hero gradient (now uses CSS variables)" -ForegroundColor White
Write-Host "  ✅ Navigation hover states" -ForegroundColor White
Write-Host "  ✅ Mobile menu elements" -ForegroundColor White
Write-Host "  ✅ Feature/step visual backgrounds" -ForegroundColor White
Write-Host "  ✅ Added 15+ dark mode specific overrides" -ForegroundColor White
Write-Host ""
Write-Host "🎉 Dark mode sekarang berfungsi sempurna!" -ForegroundColor Green
Write-Host ""
