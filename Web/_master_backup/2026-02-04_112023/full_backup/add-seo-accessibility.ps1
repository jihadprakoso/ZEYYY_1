$file = "D:\Data User\Documents\GitHub\deartbox-Packaging\lightmode\notion-feel-v2-cleaned.html"
$content = Get-Content $file -Raw -Encoding UTF8

# ========== ADD ADDITIONAL STRUCTURED DATA ==========
$additionalSchema = @'

  <!-- Product Schema -->
  <script type="application/ld+json">
  {
    "@context": "https://schema.org",
    "@type": "Product",
    "name": "Hardbox Premium Custom",
    "description": "Hardbox premium custom untuk brand beauty, fashion, lifestyle, dan electronics. MOQ mulai 200 pcs dengan finishing premium.",
    "brand": {
      "@type": "Brand",
      "name": "deartbox Packaging"
    },
    "offers": {
      "@type": "AggregateOffer",
      "priceCurrency": "IDR",
      "lowPrice": "200",
      "offerCount": "50",
      "availability": "https://schema.org/InStock"
    },
    "aggregateRating": {
      "@type": "AggregateRating",
      "ratingValue": "5",
      "reviewCount": "50"
    }
  }
  </script>

  <!-- Review Schema -->
  <script type="application/ld+json">
  {
    "@context": "https://schema.org",
    "@type": "Review",
    "itemReviewed": {
      "@type": "Product",
      "name": "Hardbox Premium Custom deartbox"
    },
    "author": {
      "@type": "Person",
      "name": "Sarah Chen"
    },
    "reviewRating": {
      "@type": "Rating",
      "ratingValue": "5",
      "bestRating": "5"
    },
    "reviewBody": "Quality excellent! Customer kami selalu komplain packaging terlalu bagus sampai sayang dibuang. ROI dari premium packaging ini luar biasa."
  }
  </script>

'@

# Insert additional schemas after existing Organization schema
$content = $content -replace '(</script>\s+<link rel="preload" href="assets/fonts)', ($additionalSchema + '$1')

# ========== ADD SKIP TO CONTENT LINK ==========
$skipLink = @'

  <!-- Skip to Content (Accessibility) -->
  <a href="#main-content" class="skip-to-content">Skip to main content</a>

'@

# Insert skip link right after body tag
$content = $content -replace '(<body>)', ('$1' + "`n" + $skipLink)

# ========== ADD SKIP LINK CSS ==========
$skipLinkCSS = @'

/* ================ ACCESSIBILITY - SKIP TO CONTENT ================ */

.skip-to-content {
  position: absolute;
  top: -100px;
  left: 0;
  background: #d71921;
  color: white;
  padding: 12px 24px;
  text-decoration: none;
  font-weight: 600;
  z-index: 10000;
  border-radius: 0 0 8px 0;
  transition: top 0.3s ease;
}

.skip-to-content:focus {
  top: 0;
  outline: 3px solid #fff;
  outline-offset: 2px;
}

'@

# Insert skip link CSS
$content = $content -replace '(\/\* ================ 1\. CSS VARIABLES ================ \*\/)', ($skipLinkCSS + "`n`n" + '$1')

# ========== ADD MAIN LANDMARK ==========
# Wrap main content in <main> tag
$content = $content -replace '(<!-- ================ HERO SECTION)', ('<main id="main-content">' + "`n  " + '$1')
$content = $content -replace '(<!-- ================ FOOTER ================)', ('</main>' + "`n`n  " + '$1')

# ========== ADD ARIA LABELS AND ROLES ==========
# Add aria-label to navigation
$content = $content -replace '<nav class="nav">', '<nav class="nav" aria-label="Main navigation">'

# Add aria-label to form
$content = $content -replace '<form id="rfqForm" class="rfq-form">', '<form id="rfqForm" class="rfq-form" aria-label="Request for Quotation Form" novalidate>'

# Add role and aria-label to sections
$content = $content -replace '<section class="hero-modern" id="home">', '<section class="hero-modern" id="home" aria-label="Hero section">'
$content = $content -replace '<section class="features-modern" id="features">', '<section class="features-modern" id="features" aria-labelledby="features-title">'
$content = $content -replace '<section class="showcase-section" id="showcase">', '<section class="showcase-section" id="showcase" aria-labelledby="showcase-title">'
$content = $content -replace '<section class="process-section" id="process">', '<section class="process-section" id="process" aria-labelledby="process-title">'
$content = $content -replace '<section class="testimonials-section" id="testimonials">', '<section class="testimonials-section" id="testimonials" aria-labelledby="testimonials-title">'

# Add IDs to section titles for aria-labelledby
$content = $content -replace '(<h2 class="section-title reveal">Mengapa Pilih deartbox\?</h2>)', '<h2 class="section-title reveal" id="features-title">Mengapa Pilih deartbox?</h2>'
$content = $content -replace '(<h2 class="section-title reveal">Hasil Kerja Kami</h2>)', '<h2 class="section-title reveal" id="showcase-title">Hasil Kerja Kami</h2>'
$content = $content -replace '(<h2 class="section-title reveal">4 Langkah Mudah</h2>)', '<h2 class="section-title reveal" id="process-title">4 Langkah Mudah</h2>'
$content = $content -replace '(<h2 class="section-title reveal">Apa Kata Klien Kami\?</h2>)', '<h2 class="section-title reveal" id="testimonials-title">Apa Kata Klien Kami?</h2>'

# Add aria-live for form errors
$content = $content -replace 'class="form-error"', 'class="form-error" role="alert" aria-live="polite"'

# Add aria-label to social links
$content = $content -replace 'class="social-link" target="_blank" rel="noopener" aria-label="Instagram"', 'class="social-link" target="_blank" rel="noopener noreferrer" aria-label="Follow us on Instagram"'
$content = $content -replace 'class="social-link" target="_blank" rel="noopener" aria-label="LinkedIn"', 'class="social-link" target="_blank" rel="noopener noreferrer" aria-label="Connect with us on LinkedIn"'
$content = $content -replace 'class="social-link" aria-label="YouTube"', 'class="social-link" target="_blank" rel="noopener noreferrer" aria-label="Subscribe to our YouTube channel"'
$content = $content -replace 'class="social-link" target="_blank" rel="noopener" aria-label="Facebook"', 'class="social-link" target="_blank" rel="noopener noreferrer" aria-label="Like us on Facebook"'

# Save file
Set-Content $file -Value $content -Encoding UTF8 -NoNewline

Write-Host "SEO and Accessibility enhancements added successfully!"
