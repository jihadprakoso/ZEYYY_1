$file = "D:\Data User\Documents\GitHub\deartbox-Packaging\lightmode\notion-feel-v2-cleaned.html"
$content = Get-Content $file -Raw -Encoding UTF8

# Fix header background
$content = $content -replace 'header \{([^}]*?)background: #ffffff;', 'header {$1background: var(--bg);'

# Fix header border
$content = $content -replace 'border-bottom: 1px solid #e6e6e6;', 'border-bottom: 1px solid var(--border);'

# Fix hero gradient
$content = $content -replace 'background: linear-gradient\(180deg, #ffffff 0%, #fafafa 100%\);', 'background: linear-gradient(180deg, var(--bg) 0%, var(--card) 100%);'

# Fix nav-link hover
$content = $content -replace '\.nav-link:hover \{([^}]*?)background: #f5f5f5;', '.nav-link:hover {$1background: var(--glass);'

# Fix mobile toggle hover
$content = $content -replace '\.mobile-toggle:hover \{([^}]*?)background: #f5f5f5;', '.mobile-toggle:hover {$1background: var(--glass);'

# Fix mobile nav link hover
$content = $content -replace '(\.mobile-nav-link:hover,\s*\.mobile-nav-link\.active \{[^}]*?)background: #f5f5f5;', '$1background: var(--glass);'

# Fix feature visual
$content = $content -replace '(\.feature-visual \{[^}]*?)background: #f5f5f5;', '$1background: var(--glass);'

# Fix step visual
$content = $content -replace '(\.step-visual \{[^}]*?)background: #f5f5f5;', '$1background: var(--glass);'

# Add dark mode overrides
$darkOverrides = @'


/* ================ DARK MODE OVERRIDES FOR HEADER & HERO ================ */

[data-theme="dark"] header {
  background: rgba(10, 10, 10, 0.95);
  backdrop-filter: blur(10px);
  -webkit-backdrop-filter: blur(10px);
  border-bottom-color: rgba(255, 255, 255, 0.1);
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

[data-theme="dark"] .mobile-toggle span {
  background: var(--text);
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

[data-theme="dark"] .slide-dot {
  background: rgba(255, 255, 255, 0.3);
  border-color: rgba(255, 255, 255, 0.5);
}

[data-theme="dark"] .slide-dot.active {
  background: white;
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

# Insert dark mode overrides
$content = $content -replace '(\[data-theme="dark"\] \.file-preview \{)', ($darkOverrides + '$1')

# Save file
Set-Content $file -Value $content -Encoding UTF8 -NoNewline

Write-Host "Dark mode colors fixed successfully!"
Write-Host "Header and hero section now properly support dark mode."
