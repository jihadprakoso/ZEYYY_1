$file = "D:\Data User\Documents\GitHub\deartbox-Packaging\lightmode\notion-feel-v2-cleaned.html"
$content = Get-Content $file -Raw -Encoding UTF8

# ========== ADD DARK MODE CSS VARIABLES ==========
$darkModeCSS = @'

/* ================ DARK MODE ================ */

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

/* Apply dark mode colors */
body {
  background: var(--bg);
  color: var(--text);
  transition: background-color 0.3s ease, color 0.3s ease;
}

header {
  background: var(--bg);
  border-bottom-color: var(--border);
}

.card,
.feature-card,
.process-step,
.testimonial-card,
.rfq-form,
.rfq-info-card,
.rfq-contact-quick,
.marketplace-card {
  background: var(--card);
  border-color: var(--border);
}

h1, h2, h3, h4, h5, h6 {
  color: var(--text);
}

p {
  color: var(--text-muted);
}

.nav-link,
.mobile-nav-link,
.logo-text h1 {
  color: var(--text);
}

.logo-text p,
.hero-microcopy,
.trust-qualifier,
.form-note {
  color: var(--text-light);
}

.hero-modern,
.features-modern,
.showcase-section,
.process-section,
.testimonials-section,
.rfq-section,
.marketplace-section {
  background: var(--bg);
}

[data-theme="dark"] .features-modern,
[data-theme="dark"] .process-section {
  background: #0f0f0f;
}

.form-field input,
.form-field select,
.form-field textarea {
  background: var(--card);
  color: var(--text);
  border-color: var(--border);
}

.form-field input::placeholder,
.form-field textarea::placeholder {
  color: var(--text-light);
}

/* Dark mode toggle button */
.theme-toggle {
  position: relative;
  width: 60px;
  height: 30px;
  background: var(--border);
  border-radius: 100px;
  cursor: pointer;
  transition: background 0.3s ease;
  border: none;
  padding: 0;
}

.theme-toggle::before {
  content: '';
  position: absolute;
  top: 3px;
  left: 3px;
  width: 24px;
  height: 24px;
  background: white;
  border-radius: 50%;
  transition: transform 0.3s cubic-bezier(0.16, 0.84, 0.44, 1);
  box-shadow: 0 2px 4px rgba(0,0,0,0.2);
}

[data-theme="dark"] .theme-toggle {
  background: var(--accent);
}

[data-theme="dark"] .theme-toggle::before {
  transform: translateX(30px);
}

.theme-toggle-icon {
  position: absolute;
  top: 50%;
  transform: translateY(-50%);
  width: 16px;
  height: 16px;
  transition: opacity 0.3s ease;
}

.theme-toggle-icon.sun {
  left: 7px;
  opacity: 1;
}

.theme-toggle-icon.moon {
  right: 7px;
  opacity: 0;
}

[data-theme="dark"] .theme-toggle-icon.sun {
  opacity: 0;
}

[data-theme="dark"] .theme-toggle-icon.moon {
  opacity: 1;
}

/* Dark mode specific adjustments */
[data-theme="dark"] .mobile-menu {
  background: rgba(26, 26, 26, 0.95);
}

[data-theme="dark"] .mobile-overlay {
  background: rgba(0,0,0,0.6);
}

[data-theme="dark"] .trust-marquee img,
[data-theme="dark"] .trust-logo img {
  filter: brightness(0) invert(1);
  opacity: 0.7;
}

[data-theme="dark"] .trust-marquee img:hover,
[data-theme="dark"] .trust-logo img:hover {
  opacity: 1;
}

[data-theme="dark"] footer {
  background: #0f0f0f;
  border-top: 1px solid var(--border);
}

[data-theme="dark"] .file-upload-label {
  background: var(--card);
  border-color: var(--border);
}

[data-theme="dark"] .file-preview {
  background: #0f0f0f;
}

'@

# Insert dark mode CSS after root variables
$content = $content -replace '(:root \{[^}]+\})', ('$1' + "`n`n" + $darkModeCSS)

# ========== ADD THEME TOGGLE BUTTON TO HEADER ==========
$themeToggleHTML = @'

        <!-- Dark Mode Toggle -->
        <button class="theme-toggle" id="themeToggle" aria-label="Toggle dark mode">
          <svg class="theme-toggle-icon sun" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <circle cx="12" cy="12" r="5"></circle>
            <line x1="12" y1="1" x2="12" y2="3"></line>
            <line x1="12" y1="21" x2="12" y2="23"></line>
            <line x1="4.22" y1="4.22" x2="5.64" y2="5.64"></line>
            <line x1="18.36" y1="18.36" x2="19.78" y2="19.78"></line>
            <line x1="1" y1="12" x2="3" y2="12"></line>
            <line x1="21" y1="12" x2="23" y2="12"></line>
            <line x1="4.22" y1="19.78" x2="5.64" y2="18.36"></line>
            <line x1="18.36" y1="5.64" x2="19.78" y2="4.22"></line>
          </svg>
          <svg class="theme-toggle-icon moon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <path d="M21 12.79A9 9 0 1 1 11.21 3 7 7 0 0 0 21 12.79z"></path>
          </svg>
        </button>

'@

# Insert theme toggle before mobile toggle
$content = $content -replace '(<!-- Mobile Toggle -->)', ($themeToggleHTML + '        $1')

# ========== ADD DARK MODE JAVASCRIPT ==========
$darkModeJS = @'

      // ================ DARK MODE ================
      
      const themeToggle = document.getElementById('themeToggle');
      const htmlElement = document.documentElement;
      
      // Check for saved theme preference or default to system preference
      const savedTheme = localStorage.getItem('theme');
      const systemPrefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
      
      // Set initial theme
      if (savedTheme) {
        htmlElement.setAttribute('data-theme', savedTheme);
      } else if (systemPrefersDark) {
        htmlElement.setAttribute('data-theme', 'dark');
      }
      
      // Toggle theme
      if (themeToggle) {
        themeToggle.addEventListener('click', function() {
          const currentTheme = htmlElement.getAttribute('data-theme');
          const newTheme = currentTheme === 'dark' ? 'light' : 'dark';
          
          htmlElement.setAttribute('data-theme', newTheme);
          localStorage.setItem('theme', newTheme);
          
          // Update meta theme-color
          const metaThemeColor = document.querySelector('meta[name="theme-color"]');
          if (metaThemeColor) {
            metaThemeColor.setAttribute('content', newTheme === 'dark' ? '#0a0a0a' : '#ffffff');
          }
        });
      }
      
      // Listen for system theme changes
      window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', function(e) {
        if (!localStorage.getItem('theme')) {
          htmlElement.setAttribute('data-theme', e.matches ? 'dark' : 'light');
        }
      });

'@

# Insert dark mode JS
$content = $content -replace '(\/\/ ================ DESIGN IMPROVEMENTS ================)', ($darkModeJS + "`n`n" + '$1')

# Save file
Set-Content $file -Value $content -Encoding UTF8 -NoNewline

Write-Host "Dark mode added successfully!"
