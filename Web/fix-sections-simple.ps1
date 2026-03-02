$file = "D:\Data User\Documents\GitHub\deartbox-Packaging\lightmode\notion-feel-v2-cleaned.html"
$content = Get-Content $file -Raw -Encoding UTF8

Write-Host "Fixing all section backgrounds for dark mode..." -ForegroundColor Yellow
Write-Host ""

# Simple replacements without complex regex
$content = $content -replace 'background: #fafafa;', 'background: var(--card);'
$content = $content -replace 'background: white;', 'background: var(--bg);'
$content = $content -replace 'background: #ffffff;', 'background: var(--bg);'

# Add comprehensive dark mode section styles
$darkSections = @'


/* ================ ALL SECTIONS DARK MODE ================ */

[data-theme="dark"] .trust-section,
[data-theme="dark"] .showcase-section,
[data-theme="dark"] .testimonials-section,
[data-theme="dark"] .marketplace-section,
[data-theme="dark"] .video-section {
  background: #0a0a0a !important;
}

[data-theme="dark"] .features-modern,
[data-theme="dark"] .process-section,
[data-theme="dark"] .rfq-section,
[data-theme="dark"] .faq-section {
  background: #0f0f0f !important;
}

[data-theme="dark"] .cta-section-modern {
  background: linear-gradient(135deg, rgba(215, 25, 33, 0.15), rgba(160, 20, 25, 0.08)) !important;
}

[data-theme="dark"] .feature-card,
[data-theme="dark"] .process-step,
[data-theme="dark"] .testimonial-card,
[data-theme="dark"] .rfq-form,
[data-theme="dark"] .rfq-info-card,
[data-theme="dark"] .rfq-contact-quick,
[data-theme="dark"] .marketplace-card,
[data-theme="dark"] .faq-item {
  background: #1a1a1a !important;
  border-color: rgba(255, 255, 255, 0.1) !important;
}

[data-theme="dark"] .feature-visual,
[data-theme="dark"] .step-visual {
  background: rgba(255, 255, 255, 0.03) !important;
}

[data-theme="dark"] .testimonial-avatar {
  background: rgba(255, 255, 255, 0.1) !important;
}

[data-theme="dark"] .hero-title,
[data-theme="dark"] .section-title,
[data-theme="dark"] .feature-title,
[data-theme="dark"] .step-title,
[data-theme="dark"] .cta-title {
  color: var(--text) !important;
}

[data-theme="dark"] .hero-subtitle,
[data-theme="dark"] .section-subtitle,
[data-theme="dark"] .feature-description,
[data-theme="dark"] .step-description,
[data-theme="dark"] .testimonial-text,
[data-theme="dark"] .cta-subtitle {
  color: var(--text-muted) !important;
}

[data-theme="dark"] .hero-microcopy,
[data-theme="dark"] .trust-qualifier,
[data-theme="dark"] .rfq-reasoning {
  color: var(--text-light) !important;
}

'@

# Find a good place to insert (before the last dark mode section)
$content = $content -replace '(\/\* ================ COMPREHENSIVE DARK MODE FOR ALL SECTIONS ================ \*\/)', ($darkSections + '$1')

# If pattern not found, insert before closing style tag
if ($content -notmatch 'ALL SECTIONS DARK MODE') {
    $content = $content -replace '(\/\* ================ RESPONSIVE ENHANCEMENTS ================ \*\/)', ($darkSections + '$1')
}

# Save file
Set-Content $file -Value $content -Encoding UTF8 -NoNewline

Write-Host "✅ All section backgrounds fixed!" -ForegroundColor Green
Write-Host "✅ Dark mode now applies to ALL sections!" -ForegroundColor Green
Write-Host ""
Write-Host "Sections updated:" -ForegroundColor Cyan
Write-Host "  - trust-section" -ForegroundColor White
Write-Host "  - features-modern" -ForegroundColor White
Write-Host "  - showcase-section" -ForegroundColor White
Write-Host "  - process-section" -ForegroundColor White
Write-Host "  - testimonials-section" -ForegroundColor White
Write-Host "  - rfq-section" -ForegroundColor White
Write-Host "  - marketplace-section" -ForegroundColor White
Write-Host "  - video-section" -ForegroundColor White
Write-Host "  - faq-section" -ForegroundColor White
Write-Host "  - cta-section" -ForegroundColor White
Write-Host ""
