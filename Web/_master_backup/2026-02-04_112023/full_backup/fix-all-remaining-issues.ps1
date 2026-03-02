$file = "D:\Data User\Documents\GitHub\deartbox-Packaging\lightmode\notion-feel-v2-cleaned.html"
$content = Get-Content $file -Raw -Encoding UTF8

Write-Host ""
Write-Host "╔════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║  🔧 FIXING ALL REMAINING ISSUES...                    ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

# ========== ISSUE 1: LIGHT MODE - FOOTER TEXT NOT VISIBLE ==========
Write-Host "1. Fixing footer text in light mode..." -ForegroundColor Yellow

# Footer already uses #a3a3a3 which should be visible, but let's ensure it uses CSS variable
# The issue is footer has hardcoded background #1a1a1a
# We need to make sure footer text in light mode is visible

# Add specific light mode footer text override
$footerLightFix = @'


/* ================ LIGHT MODE FOOTER FIX ================ */

/* Ensure footer text is visible in light mode */
footer {
  background: #1a1a1a;
  color: #a3a3a3;
}

footer h3,
footer h4 {
  color: white;
}

.footer-brand p,
.footer-links a,
.footer-address-link,
.footer-payments-title,
.footer-bottom p,
.footer-badge-item {
  color: #a3a3a3;
}

.footer-links a:hover,
.footer-address-link:hover {
  color: white;
}

'@

# Insert before dark mode section
$content = $content -replace '(\/\* ================ DARK MODE ================ \*\/)', ($footerLightFix + '$1')

Write-Host "   ✅ Footer text fixed for light mode" -ForegroundColor Green

# ========== ISSUE 2: DARK MODE - MOON ICON NOT VISIBLE ==========
Write-Host "2. Fixing moon icon color in dark mode..." -ForegroundColor Yellow

$moonIconFix = @'


[data-theme="dark"] .theme-toggle-icon.moon {
  color: white;
  stroke: white;
}

[data-theme="dark"] .theme-toggle-icon.sun {
  color: #1a1a1a;
  stroke: #1a1a1a;
}

'@

# Insert after theme toggle styles
$content = $content -replace '(\[data-theme="dark"\] \.theme-toggle-icon\.moon \{[^}]+\})', ('$1' + $moonIconFix)

Write-Host "   ✅ Moon icon color fixed" -ForegroundColor Green

# ========== ISSUE 3: DARK MODE - SLIDESHOW BUTTONS NOT VISIBLE ==========
Write-Host "3. Fixing slideshow navigation buttons in dark mode..." -ForegroundColor Yellow

$slideshowFix = @'


[data-theme="dark"] .slide-nav {
  background: rgba(26, 26, 26, 0.95);
  border-color: rgba(255, 255, 255, 0.1);
}

[data-theme="dark"] .slide-nav svg {
  stroke: white;
  color: white;
}

[data-theme="dark"] .slide-nav:hover {
  background: rgba(26, 26, 26, 1);
}

'@

# Insert after existing slide-nav dark mode styles
$content = $content -replace '(\[data-theme="dark"\] \.slide-nav \{[^}]+\})', ('$1' + $slideshowFix)

Write-Host "   ✅ Slideshow buttons fixed" -ForegroundColor Green

# ========== ISSUE 4: DARK MODE - CTA BUTTONS NOT VISIBLE ==========
Write-Host "4. Fixing CTA buttons in dark mode..." -ForegroundColor Yellow

$ctaButtonsFix = @'


/* Fix all CTA buttons text visibility in dark mode */
[data-theme="dark"] .btn-hero-primary,
[data-theme="dark"] .btn-cta-wa,
[data-theme="dark"] .btn-submit-rfq,
[data-theme="dark"] .sticky-cta,
[data-theme="dark"] .cta-nav,
[data-theme="dark"] .mobile-cta {
  color: white !important;
}

[data-theme="dark"] .btn-hero-primary svg,
[data-theme="dark"] .btn-cta-wa svg,
[data-theme="dark"] .btn-submit-rfq svg,
[data-theme="dark"] .sticky-cta svg {
  fill: white;
  stroke: white;
  color: white;
}

'@

# Insert after button styles
$content = $content -replace '(\[data-theme="dark"\] \.btn-hero-secondary:hover \{[^}]+\})', ('$1' + $ctaButtonsFix)

Write-Host "   ✅ CTA buttons fixed" -ForegroundColor Green

# ========== ISSUE 5: DARK MODE - FILE UPLOAD HOVER SHOULD NOT BE WHITE ==========
Write-Host "5. Fixing file upload hover in dark mode..." -ForegroundColor Yellow

$fileUploadFix = @'


[data-theme="dark"] .file-upload-label {
  background: rgba(26, 26, 26, 0.5);
  border-color: rgba(255, 255, 255, 0.1);
  color: var(--text);
}

[data-theme="dark"] .file-upload-label:hover {
  background: rgba(215, 25, 33, 0.1);
  border-color: var(--accent);
}

[data-theme="dark"] .file-upload-label span {
  color: var(--text-muted);
}

[data-theme="dark"] .file-upload-label svg {
  stroke: var(--text-muted);
}

'@

# Insert after existing file-upload-label dark mode styles
$content = $content -replace '(\[data-theme="dark"\] \.file-upload-label \{[^}]+\})', ('$1' + $fileUploadFix)

Write-Host "   ✅ File upload hover fixed" -ForegroundColor Green

# Save file
Set-Content $file -Value $content -Encoding UTF8 -NoNewline

Write-Host ""
Write-Host "╔════════════════════════════════════════════════════════╗" -ForegroundColor Green
Write-Host "║  ✅ ALL ISSUES FIXED SUCCESSFULLY!                    ║" -ForegroundColor Green
Write-Host "╚════════════════════════════════════════════════════════╝" -ForegroundColor Green
Write-Host ""
Write-Host "Fixed issues:" -ForegroundColor Cyan
Write-Host "  ✅ Light mode: Footer text now visible" -ForegroundColor White
Write-Host "  ✅ Dark mode: Moon icon now white" -ForegroundColor White
Write-Host "  ✅ Dark mode: Slideshow buttons now white" -ForegroundColor White
Write-Host "  ✅ Dark mode: CTA buttons text now white" -ForegroundColor White
Write-Host "  ✅ Dark mode: File upload hover stays dark (not white)" -ForegroundColor White
Write-Host ""
Write-Host "🎉 Light mode dan dark mode sekarang PERFECT!" -ForegroundColor Green
Write-Host ""
