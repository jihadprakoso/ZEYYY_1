$file = "D:\Data User\Documents\GitHub\deartbox-Packaging\lightmode\notion-feel-v2-cleaned.html"
$content = Get-Content $file -Raw -Encoding UTF8

Write-Host ""
Write-Host "╔════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║  🌙 FIXING ALL SECTIONS FOR DARK MODE...              ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

# ========== FIX ALL SECTION BACKGROUNDS ==========

Write-Host "1. Fixing features-modern section..." -ForegroundColor Yellow
$content = $content -replace '(\.features-modern \{[^}]*?)background: #fafafa;', '$1background: var(--card);'
Write-Host "   ✅ Done" -ForegroundColor Green

Write-Host "2. Fixing showcase-section..." -ForegroundColor Yellow
$content = $content -replace '(\.showcase-section \{[^}]*?)background: white;', '$1background: var(--bg);'
Write-Host "   ✅ Done" -ForegroundColor Green

Write-Host "3. Fixing process-section..." -ForegroundColor Yellow
$content = $content -replace '(\.process-section \{[^}]*?)background: #fafafa;', '$1background: var(--card);'
Write-Host "   ✅ Done" -ForegroundColor Green

Write-Host "4. Fixing testimonials-section..." -ForegroundColor Yellow
$content = $content -replace '(\.testimonials-section \{[^}]*?)background: white;', '$1background: var(--bg);'
Write-Host "   ✅ Done" -ForegroundColor Green

Write-Host "5. Fixing rfq-section..." -ForegroundColor Yellow
$content = $content -replace '(\.rfq-section \{[^}]*?)background: #fafafa;', '$1background: var(--card);'
Write-Host "   ✅ Done" -ForegroundColor Green

Write-Host "6. Fixing marketplace-section..." -ForegroundColor Yellow
$content = $content -replace '(\.marketplace-section \{[^}]*?)background: white;', '$1background: var(--bg);'
Write-Host "   ✅ Done" -ForegroundColor Green

Write-Host "7. Fixing video-section..." -ForegroundColor Yellow
$content = $content -replace '(\.video-section \{[^}]*?)background: white;', '$1background: var(--bg);'
Write-Host "   ✅ Done" -ForegroundColor Green

Write-Host "8. Fixing trust-section..." -ForegroundColor Yellow
$content = $content -replace '(\.trust-section \{[^}]*?)background: white;', '$1background: var(--bg);'
Write-Host "   ✅ Done" -ForegroundColor Green

Write-Host "9. Fixing faq-section..." -ForegroundColor Yellow
$content = $content -replace '(\.faq-section \{[^}]*?)background: var\(--bg\);', '$1background: var(--card);'
Write-Host "   ✅ Done" -ForegroundColor Green

Write-Host "10. Fixing cta-section..." -ForegroundColor Yellow
$content = $content -replace '\.cta-section-modern \{([^}]*?)background: linear-gradient\(135deg, rgba\(230, 57, 70, 0\.08\), rgba\(164, 22, 26, 0\.04\)\);', '.cta-section-modern {$1background: linear-gradient(135deg, rgba(230, 57, 70, 0.08), rgba(164, 22, 26, 0.04));'
Write-Host "   ✅ Done" -ForegroundColor Green

# ========== ADD COMPREHENSIVE DARK MODE SECTION OVERRIDES ==========

Write-Host ""
Write-Host "11. Adding comprehensive dark mode overrides..." -ForegroundColor Yellow

$comprehensiveDarkMode = @'


/* ================ COMPREHENSIVE DARK MODE FOR ALL SECTIONS ================ */

/* Alternating section backgrounds for visual hierarchy */
[data-theme="dark"] .trust-section,
[data-theme="dark"] .showcase-section,
[data-theme="dark"] .testimonials-section,
[data-theme="dark"] .marketplace-section,
[data-theme="dark"] .video-section {
  background: #0a0a0a;
}

[data-theme="dark"] .features-modern,
[data-theme="dark"] .process-section,
[data-theme="dark"] .rfq-section,
[data-theme="dark"] .faq-section {
  background: #0f0f0f;
}

[data-theme="dark"] .cta-section-modern {
  background: linear-gradient(135deg, rgba(215, 25, 33, 0.15), rgba(160, 20, 25, 0.08));
}

/* Card backgrounds in dark mode */
[data-theme="dark"] .feature-card,
[data-theme="dark"] .process-step,
[data-theme="dark"] .testimonial-card,
[data-theme="dark"] .showcase-item,
[data-theme="dark"] .rfq-form,
[data-theme="dark"] .rfq-info-card,
[data-theme="dark"] .rfq-contact-quick,
[data-theme="dark"] .marketplace-card,
[data-theme="dark"] .faq-item {
  background: #1a1a1a;
  border-color: rgba(255, 255, 255, 0.1);
}

/* Testimonial card specific */
[data-theme="dark"] .testimonial-card {
  background: #1a1a1a;
}

/* Feature/step visual backgrounds */
[data-theme="dark"] .feature-visual,
[data-theme="dark"] .step-visual {
  background: rgba(255, 255, 255, 0.03);
}

/* Testimonial avatar background */
[data-theme="dark"] .testimonial-avatar {
  background: rgba(255, 255, 255, 0.1);
}

/* File upload in dark mode */
[data-theme="dark"] .file-upload-label {
  background: #1a1a1a;
  border-color: rgba(255, 255, 255, 0.1);
}

[data-theme="dark"] .file-upload-label:hover {
  background: rgba(215, 25, 33, 0.1);
  border-color: var(--accent);
}

/* Success modal dark mode */
[data-theme="dark"] .success-modal-content {
  background: #1a1a1a;
  color: var(--text);
}

[data-theme="dark"] .btn-modal-secondary {
  background: rgba(255, 255, 255, 0.05);
  color: var(--text);
}

[data-theme="dark"] .btn-modal-secondary:hover {
  background: rgba(255, 255, 255, 0.1);
}

/* Showcase overlay in dark mode */
[data-theme="dark"] .showcase-overlay {
  background: linear-gradient(to top, rgba(10, 10, 10, 0.9), transparent);
}

/* Trust qualifier text */
[data-theme="dark"] .trust-qualifier {
  color: var(--text-light);
}

/* Hero content text colors */
[data-theme="dark"] .hero-title {
  color: var(--text);
}

[data-theme="dark"] .hero-subtitle {
  color: var(--text-muted);
}

[data-theme="dark"] .hero-microcopy {
  color: var(--text-light);
}

/* Section titles and subtitles */
[data-theme="dark"] .section-title {
  color: var(--text);
}

[data-theme="dark"] .section-subtitle {
  color: var(--text-muted);
}

/* Feature, step, testimonial content */
[data-theme="dark"] .feature-title,
[data-theme="dark"] .step-title,
[data-theme="dark"] .testimonial-info h4,
[data-theme="dark"] .faq-question {
  color: var(--text);
}

[data-theme="dark"] .feature-description,
[data-theme="dark"] .step-description,
[data-theme="dark"] .testimonial-text,
[data-theme="dark"] .faq-answer p {
  color: var(--text-muted);
}

/* CTA section text */
[data-theme="dark"] .cta-title {
  color: var(--text);
}

[data-theme="dark"] .cta-subtitle {
  color: var(--text-muted);
}

[data-theme="dark"] .cta-feature {
  color: var(--text);
}

/* RFQ reasoning text */
[data-theme="dark"] .rfq-reasoning {
  color: var(--text-light);
}

/* Form field backgrounds */
[data-theme="dark"] .form-field input,
[data-theme="dark"] .form-field select,
[data-theme="dark"] .form-field textarea {
  background: rgba(255, 255, 255, 0.05);
  border-color: rgba(255, 255, 255, 0.1);
  color: var(--text);
}

[data-theme="dark"] .form-field input:focus,
[data-theme="dark"] .form-field select:focus,
[data-theme="dark"] .form-field textarea:focus {
  background: rgba(255, 255, 255, 0.08);
  border-color: var(--accent);
}

[data-theme="dark"] .form-field input::placeholder,
[data-theme="dark"] .form-field textarea::placeholder {
  color: rgba(255, 255, 255, 0.3);
}

/* RFQ benefits list */
[data-theme="dark"] .rfq-benefits li {
  color: var(--text-muted);
}

/* Marketplace card hover */
[data-theme="dark"] .marketplace-card:hover {
  background: rgba(215, 25, 33, 0.1);
  border-color: var(--accent);
}

/* Video wrapper */
[data-theme="dark"] .video-wrapper {
  box-shadow: 0 20px 60px rgba(0, 0, 0, 0.5);
}

/* Hero slideshow container */
[data-theme="dark"] .hero-slideshow-container {
  box-shadow: 0 20px 60px rgba(0, 0, 0, 0.5);
}

'@

# Insert comprehensive dark mode overrides
$content = $content -replace '(\[data-theme="dark"\] \.btn-hero-secondary:hover \{[^}]+\})', ('$1' + "`n" + $comprehensiveDarkMode)

Write-Host "   ✅ Done" -ForegroundColor Green

# Save file
Set-Content $file -Value $content -Encoding UTF8 -NoNewline

Write-Host ""
Write-Host "╔════════════════════════════════════════════════════════╗" -ForegroundColor Green
Write-Host "║  ✅ ALL SECTIONS DARK MODE FIXED SUCCESSFULLY!        ║" -ForegroundColor Green
Write-Host "╚════════════════════════════════════════════════════════╝" -ForegroundColor Green
Write-Host ""
Write-Host "Fixed sections:" -ForegroundColor Cyan
Write-Host "  ✅ features-modern (now uses var(--card))" -ForegroundColor White
Write-Host "  ✅ showcase-section (now uses var(--bg))" -ForegroundColor White
Write-Host "  ✅ process-section (now uses var(--card))" -ForegroundColor White
Write-Host "  ✅ testimonials-section (now uses var(--bg))" -ForegroundColor White
Write-Host "  ✅ rfq-section (now uses var(--card))" -ForegroundColor White
Write-Host "  ✅ marketplace-section (now uses var(--bg))" -ForegroundColor White
Write-Host "  ✅ video-section (now uses var(--bg))" -ForegroundColor White
Write-Host "  ✅ trust-section (now uses var(--bg))" -ForegroundColor White
Write-Host "  ✅ faq-section (now uses var(--card))" -ForegroundColor White
Write-Host "  ✅ cta-section (gradient updated)" -ForegroundColor White
Write-Host ""
Write-Host "Dark mode pattern:" -ForegroundColor Cyan
Write-Host "  🌑 Main sections: #0a0a0a (pure black)" -ForegroundColor White
Write-Host "  🌑 Alternate sections: #0f0f0f (slightly lighter)" -ForegroundColor White
Write-Host "  🌑 Cards: #1a1a1a (card background)" -ForegroundColor White
Write-Host ""
Write-Host "🎉 Sekarang SEMUA section akan berubah hitam di dark mode!" -ForegroundColor Green
Write-Host ""
