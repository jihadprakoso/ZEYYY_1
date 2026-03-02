$file = "D:\Data User\Documents\GitHub\deartbox-Packaging\lightmode\notion-feel-v2-cleaned.html"
$content = Get-Content $file -Raw -Encoding UTF8

# ========== ADD RESPONSIVE CSS IMPROVEMENTS ==========
$responsiveCSS = @'

/* ================ RESPONSIVE ENHANCEMENTS ================ */

/* ===== TABLET OPTIMIZATION (768px - 1024px) ===== */
@media (min-width: 768px) and (max-width: 1024px) {
  /* 2-column layouts for better tablet experience */
  .features-grid,
  .testimonials-grid {
    grid-template-columns: repeat(2, 1fr);
    gap: 24px;
  }

  .process-steps {
    grid-template-columns: repeat(2, 1fr);
  }

  .showcase-grid {
    grid-template-columns: repeat(2, 1fr);
  }

  /* Hybrid navigation for tablet */
  .nav-links {
    gap: 4px;
  }

  .nav-link {
    padding: 8px 12px;
    font-size: 13px;
  }

  .cta-nav {
    padding: 8px 16px;
    font-size: 13px;
  }
}

/* ===== MOBILE ENHANCEMENTS ===== */
@media (max-width: 767px) {
  /* Larger touch targets for mobile */
  .slide-nav {
    width: 48px;
    height: 48px;
  }

  .slide-nav.prev {
    left: 12px;
  }

  .slide-nav.next {
    right: 12px;
  }

  .slide-dot {
    width: 12px;
    height: 12px;
  }

  /* Better form touch targets */
  .form-field input,
  .form-field select,
  .form-field textarea {
    min-height: 48px;
    font-size: 16px; /* Prevents zoom on iOS */
  }

  .btn-submit-rfq {
    min-height: 52px;
    font-size: 16px;
  }

  /* Improved mobile menu */
  .mobile-menu {
    top: 73px;
    height: calc(100vh - 73px);
  }

  .mobile-nav-link {
    min-height: 48px;
    display: flex;
    align-items: center;
  }

  /* Better spacing for mobile */
  section {
    padding-top: 60px;
    padding-bottom: 60px;
  }

  .hero-modern {
    padding: 48px 0 40px;
  }

  /* Sticky CTA improvements */
  .sticky-cta {
    position: fixed;
    bottom: 0;
    left: 0;
    right: 0;
    border-radius: 0;
    padding: 16px 24px;
    justify-content: center;
    box-shadow: 0 -4px 12px rgba(0,0,0,0.1);
    transition: transform 0.3s ease;
    z-index: 100;
  }

  .sticky-cta.hide {
    transform: translateY(100%);
  }

  /* Add padding to body to prevent content being hidden by sticky CTA */
  body {
    padding-bottom: 72px;
  }

  /* Hide back to top on mobile */
  .back-to-top {
    display: none !important;
  }
}

/* ===== TOUCH DEVICE OPTIMIZATIONS ===== */
@media (hover: none) and (pointer: coarse) {
  /* Remove hover effects on touch devices */
  .feature-card:hover,
  .process-step:hover,
  .testimonial-card:hover,
  .showcase-item:hover {
    transform: none;
  }

  /* Larger tap targets */
  button,
  a,
  input,
  select,
  textarea {
    min-height: 44px;
  }

  /* Better touch feedback */
  button:active,
  .btn-hero-primary:active,
  .btn-cta-wa:active,
  .sticky-cta:active {
    transform: scale(0.98);
    opacity: 0.9;
  }
}

/* ===== LANDSCAPE MOBILE ===== */
@media (max-width: 896px) and (orientation: landscape) {
  .hero-modern {
    padding: 32px 0 24px;
  }

  .hero-title {
    font-size: 24px;
  }

  .hero-subtitle {
    font-size: 14px;
  }

  section {
    padding-top: 40px;
    padding-bottom: 40px;
  }
}

/* ===== SMALL MOBILE (< 375px) ===== */
@media (max-width: 374px) {
  .hero-title {
    font-size: 24px;
  }

  .section-title {
    font-size: 24px;
  }

  .btn-hero-primary,
  .btn-hero-secondary {
    padding: 12px 20px;
    font-size: 14px;
  }

  .logo-text h1 {
    font-size: 15px;
  }

  .logo-text p {
    font-size: 10px;
  }
}

/* ===== ACCESSIBILITY - REDUCED MOTION ===== */
@media (prefers-reduced-motion: reduce) {
  *,
  *::before,
  *::after {
    animation-duration: 0.01ms !important;
    animation-iteration-count: 1 !important;
    transition-duration: 0.01ms !important;
    scroll-behavior: auto !important;
  }

  .marquee-track {
    animation: none !important;
  }
}

'@

# Insert responsive CSS before </style>
$content = $content -replace '</style>', ($responsiveCSS + "`n  </style>")

# Save file
Set-Content $file -Value $content -Encoding UTF8 -NoNewline

Write-Host "Responsive CSS improvements added successfully!"
