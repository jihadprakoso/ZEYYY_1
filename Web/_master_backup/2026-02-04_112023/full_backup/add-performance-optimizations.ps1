$file = "D:\Data User\Documents\GitHub\deartbox-Packaging\lightmode\notion-feel-v2-cleaned.html"
$content = Get-Content $file -Raw -Encoding UTF8

# ========== OPTIMIZE FONT LOADING ==========
# Update Google Fonts link to use font-display: swap
$content = $content -replace '<link href="https://fonts.googleapis.com/css2\?family=Gramatika&display=swap" rel="stylesheet">', '<link href="https://fonts.googleapis.com/css2?family=Gramatika&display=swap" rel="stylesheet" media="print" onload="this.media=''all''">'

# ========== ADD LAZY LOADING CSS WITH BLUR PLACEHOLDER ==========
$lazyLoadCSS = @'

/* ================ LAZY LOADING WITH BLUR PLACEHOLDER ================ */

img[loading="lazy"] {
  opacity: 0;
  transition: opacity 0.3s ease;
}

img[loading="lazy"].loaded {
  opacity: 1;
}

img[loading="lazy"]:not(.loaded) {
  background: linear-gradient(90deg, #f0f0f0 25%, #e0e0e0 50%, #f0f0f0 75%);
  background-size: 200% 100%;
  animation: shimmer 1.5s infinite;
}

@keyframes shimmer {
  0% {
    background-position: -200% 0;
  }
  100% {
    background-position: 200% 0;
  }
}

/* Blur-up effect for images */
.blur-load {
  background-size: cover;
  background-position: center;
}

.blur-load img {
  opacity: 0;
  transition: opacity 0.5s ease-in-out;
}

.blur-load img.loaded {
  opacity: 1;
}

.blur-load::before {
  content: '';
  position: absolute;
  inset: 0;
  background-size: cover;
  background-position: center;
  filter: blur(10px);
  transform: scale(1.1);
  transition: opacity 0.5s ease-in-out;
}

.blur-load.loaded::before {
  opacity: 0;
}

'@

# Insert lazy loading CSS
$content = $content -replace '(\/\* ================ FORM VALIDATION STYLES ================ \*\/)', ($lazyLoadCSS + "`n`n" + '$1')

# ========== ADD PERFORMANCE JAVASCRIPT ==========
$performanceJS = @'

      // ================ PERFORMANCE OPTIMIZATIONS ================
      
      // Enhanced lazy loading with intersection observer
      const lazyImages = document.querySelectorAll('img[loading="lazy"]');
      
      if ('IntersectionObserver' in window) {
        const imageObserver = new IntersectionObserver(function(entries, observer) {
          entries.forEach(function(entry) {
            if (entry.isIntersecting) {
              const img = entry.target;
              
              // Add loaded class when image loads
              img.addEventListener('load', function() {
                img.classList.add('loaded');
              });
              
              // If image is already cached/loaded
              if (img.complete) {
                img.classList.add('loaded');
              }
              
              observer.unobserve(img);
            }
          });
        }, {
          rootMargin: '50px 0px',
          threshold: 0.01
        });
        
        lazyImages.forEach(function(img) {
          imageObserver.observe(img);
        });
      } else {
        // Fallback for browsers without IntersectionObserver
        lazyImages.forEach(function(img) {
          img.classList.add('loaded');
        });
      }

      // Preload critical images on hover (predictive loading)
      const criticalLinks = document.querySelectorAll('a[href^="#"]');
      criticalLinks.forEach(function(link) {
        link.addEventListener('mouseenter', function() {
          const targetId = this.getAttribute('href').substring(1);
          const targetSection = document.getElementById(targetId);
          
          if (targetSection) {
            const images = targetSection.querySelectorAll('img[loading="lazy"]');
            images.forEach(function(img) {
              if (!img.classList.contains('loaded')) {
                // Trigger loading
                const src = img.getAttribute('src');
                if (src) {
                  const preloadImg = new Image();
                  preloadImg.src = src;
                }
              }
            });
          }
        }, { once: true });
      });

      // Resource hints for external domains
      function addResourceHint(url, rel) {
        const link = document.createElement('link');
        link.rel = rel;
        link.href = url;
        document.head.appendChild(link);
      }

      // Prefetch next likely pages
      if ('requestIdleCallback' in window) {
        requestIdleCallback(function() {
          // Prefetch WhatsApp if user shows interest
          const waLinks = document.querySelectorAll('a[href*="wa.me"]');
          waLinks.forEach(function(link) {
            link.addEventListener('mouseenter', function() {
              addResourceHint('https://wa.me', 'dns-prefetch');
            }, { once: true });
          });
        });
      }

      // Defer non-critical CSS
      const deferredStyles = document.querySelectorAll('link[media="print"]');
      deferredStyles.forEach(function(link) {
        link.addEventListener('load', function() {
          this.media = 'all';
        });
      });

      // Monitor performance
      if ('PerformanceObserver' in window) {
        try {
          const perfObserver = new PerformanceObserver(function(list) {
            list.getEntries().forEach(function(entry) {
              // Log slow resources (> 1s)
              if (entry.duration > 1000) {
                console.warn('Slow resource:', entry.name, entry.duration + 'ms');
              }
            });
          });
          
          perfObserver.observe({ entryTypes: ['resource', 'navigation'] });
        } catch (e) {
          // Silently fail if not supported
        }
      }

      // Service Worker registration (for future PWA support)
      if ('serviceWorker' in navigator && location.protocol === 'https:') {
        window.addEventListener('load', function() {
          // Uncomment when service worker is ready
          // navigator.serviceWorker.register('/sw.js').catch(function(err) {
          //   console.log('SW registration failed:', err);
          // });
        });
      }

'@

# Insert performance JS
$content = $content -replace '(\/\/ ================ FORM VALIDATION & ENHANCEMENTS ================)', ($performanceJS + "`n`n" + '$1')

# Save file
Set-Content $file -Value $content -Encoding UTF8 -NoNewline

Write-Host "Performance optimizations added successfully!"
