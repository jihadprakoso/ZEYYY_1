$file = "D:\Data User\Documents\GitHub\deartbox-Packaging\lightmode\notion-feel-v2-cleaned.html"
$content = Get-Content $file -Raw -Encoding UTF8

# ========== ADD DESIGN IMPROVEMENTS CSS ==========
$designCSS = @'

/* ================ DESIGN IMPROVEMENTS ================ */

/* Micro-interactions - Ripple Effect */
.btn-ripple {
  position: relative;
  overflow: hidden;
}

.btn-ripple::after {
  content: '';
  position: absolute;
  top: 50%;
  left: 50%;
  width: 0;
  height: 0;
  border-radius: 50%;
  background: rgba(255,255,255,0.5);
  transform: translate(-50%, -50%);
  transition: width 0.6s, height 0.6s;
}

.btn-ripple:active::after {
  width: 300px;
  height: 300px;
}

/* Apply ripple to buttons */
.btn-hero-primary,
.btn-cta-wa,
.btn-submit-rfq,
.sticky-cta {
  position: relative;
  overflow: hidden;
}

/* Glassmorphism Effects */
.glass {
  background: rgba(255, 255, 255, 0.7);
  backdrop-filter: blur(10px);
  -webkit-backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.3);
}

/* Mobile menu glassmorphism */
.mobile-menu {
  background: rgba(255, 255, 255, 0.95);
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
}

.mobile-overlay {
  backdrop-filter: blur(4px);
  -webkit-backdrop-filter: blur(4px);
}

/* Sticky header glassmorphism on scroll */
header.scrolled {
  background: rgba(255, 255, 255, 0.9);
  backdrop-filter: blur(10px);
  -webkit-backdrop-filter: blur(10px);
  box-shadow: 0 2px 20px rgba(0,0,0,0.08);
}

/* Card hover glow effect */
.feature-card,
.testimonial-card,
.process-step {
  position: relative;
  transition: all 0.3s cubic-bezier(0.16, 0.84, 0.44, 1);
}

.feature-card::before,
.testimonial-card::before,
.process-step::before {
  content: '';
  position: absolute;
  inset: -2px;
  border-radius: 14px;
  background: linear-gradient(45deg, #d71921, #a01419, #d71921);
  opacity: 0;
  z-index: -1;
  transition: opacity 0.3s ease;
  filter: blur(8px);
}

.feature-card:hover::before,
.testimonial-card:hover::before,
.process-step:hover::before {
  opacity: 0.3;
}

.feature-card:hover,
.testimonial-card:hover,
.process-step:hover {
  transform: translateY(-4px);
  box-shadow: 0 12px 32px rgba(215, 25, 33, 0.15);
}

/* Button magnetic effect (subtle) */
@media (hover: hover) and (pointer: fine) {
  .btn-hero-primary,
  .btn-cta-wa {
    transition: transform 0.2s cubic-bezier(0.16, 0.84, 0.44, 1);
  }
  
  .btn-hero-primary:hover,
  .btn-cta-wa:hover {
    transform: translateY(-2px) scale(1.02);
  }
}

/* Loading skeleton for images */
.skeleton {
  background: linear-gradient(90deg, #f0f0f0 25%, #e0e0e0 50%, #f0f0f0 75%);
  background-size: 200% 100%;
  animation: shimmer 1.5s infinite;
  border-radius: 8px;
}

/* Smooth color transitions */
* {
  transition-property: background-color, border-color, color, fill, stroke;
  transition-duration: 0.2s;
  transition-timing-function: ease;
}

/* Exclude elements that shouldn't have transitions */
*:where(img, video, iframe, canvas, svg) {
  transition: none;
}

/* Focus visible improvements */
*:focus-visible {
  outline: 3px solid #d71921;
  outline-offset: 3px;
  border-radius: 4px;
  transition: outline-offset 0.2s ease;
}

/* Smooth scroll progress indicator */
.scroll-progress {
  position: fixed;
  top: 0;
  left: 0;
  width: 0%;
  height: 3px;
  background: linear-gradient(90deg, #d71921, #a01419);
  z-index: 9999;
  transition: width 0.1s ease-out;
}

/* Improved link underline animation */
a:not(.btn-hero-primary):not(.btn-cta-wa):not(.sticky-cta) {
  position: relative;
}

.footer-links a::after {
  content: '';
  position: absolute;
  bottom: -2px;
  left: 0;
  width: 0;
  height: 1px;
  background: currentColor;
  transition: width 0.3s ease;
}

.footer-links a:hover::after {
  width: 100%;
}

/* Improved form input focus */
.form-field input:focus,
.form-field select:focus,
.form-field textarea:focus {
  transform: translateY(-1px);
  box-shadow: 0 4px 12px rgba(215, 25, 33, 0.1);
}

/* Testimonial card quote mark */
.testimonial-text::before {
  content: '"';
  font-size: 48px;
  line-height: 0;
  color: #d71921;
  opacity: 0.2;
  position: absolute;
  top: 20px;
  left: 20px;
}

.testimonial-card {
  position: relative;
}

/* Showcase item overlay improvement */
.showcase-item {
  position: relative;
  overflow: hidden;
}

.showcase-item::after {
  content: '';
  position: absolute;
  inset: 0;
  background: linear-gradient(to top, rgba(215, 25, 33, 0.8), transparent);
  opacity: 0;
  transition: opacity 0.3s ease;
}

.showcase-item:hover::after {
  opacity: 1;
}

.showcase-overlay {
  position: relative;
  z-index: 1;
}

/* Process step number pulse */
.step-number {
  animation: pulse 2s cubic-bezier(0.4, 0, 0.6, 1) infinite;
}

@keyframes pulse {
  0%, 100% {
    opacity: 1;
  }
  50% {
    opacity: 0.8;
    transform: scale(1.05);
  }
}

/* Hero badge shine effect */
.hero-badge {
  position: relative;
  overflow: hidden;
}

.hero-badge::before {
  content: '';
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: linear-gradient(90deg, transparent, rgba(255,255,255,0.4), transparent);
  animation: shine 3s infinite;
}

@keyframes shine {
  0% {
    left: -100%;
  }
  50%, 100% {
    left: 100%;
  }
}

/* Improved shadow on scroll */
.shadow-scroll {
  box-shadow: 0 2px 4px rgba(0,0,0,0.05);
  transition: box-shadow 0.3s ease;
}

.shadow-scroll.scrolled {
  box-shadow: 0 4px 20px rgba(0,0,0,0.1);
}

'@

# Insert design CSS
$content = $content -replace '(\/\* ================ ACCESSIBILITY - SKIP TO CONTENT ================ \*\/)', ($designCSS + "`n`n" + '$1')

# ========== ADD DESIGN IMPROVEMENTS JAVASCRIPT ==========
$designJS = @'

      // ================ DESIGN IMPROVEMENTS ================
      
      // Scroll progress indicator
      const scrollProgress = document.createElement('div');
      scrollProgress.className = 'scroll-progress';
      document.body.appendChild(scrollProgress);
      
      window.addEventListener('scroll', function() {
        const windowHeight = window.innerHeight;
        const documentHeight = document.documentElement.scrollHeight - windowHeight;
        const scrolled = window.scrollY;
        const progress = (scrolled / documentHeight) * 100;
        
        scrollProgress.style.width = progress + '%';
      }, { passive: true });

      // Glassmorphism header on scroll
      const header = document.querySelector('header');
      if (header) {
        window.addEventListener('scroll', function() {
          if (window.scrollY > 50) {
            header.classList.add('scrolled');
          } else {
            header.classList.remove('scrolled');
          }
        }, { passive: true });
      }

      // Ripple effect on buttons
      const rippleButtons = document.querySelectorAll('.btn-hero-primary, .btn-cta-wa, .btn-submit-rfq, .sticky-cta');
      rippleButtons.forEach(function(button) {
        button.classList.add('btn-ripple');
      });

      // Magnetic button effect (desktop only)
      if (window.matchMedia('(hover: hover) and (pointer: fine)').matches) {
        const magneticButtons = document.querySelectorAll('.btn-hero-primary, .btn-cta-wa');
        
        magneticButtons.forEach(function(button) {
          button.addEventListener('mousemove', function(e) {
            const rect = button.getBoundingClientRect();
            const x = e.clientX - rect.left - rect.width / 2;
            const y = e.clientY - rect.top - rect.height / 2;
            
            const moveX = x * 0.1;
            const moveY = y * 0.1;
            
            button.style.transform = `translate(${moveX}px, ${moveY}px) translateY(-2px)`;
          });
          
          button.addEventListener('mouseleave', function() {
            button.style.transform = '';
          });
        });
      }

      // Parallax effect for hero section (subtle)
      const heroSection = document.querySelector('.hero-modern');
      if (heroSection && window.matchMedia('(prefers-reduced-motion: no-preference)').matches) {
        window.addEventListener('scroll', function() {
          const scrolled = window.scrollY;
          const parallaxSpeed = 0.5;
          
          if (scrolled < window.innerHeight) {
            heroSection.style.transform = `translateY(${scrolled * parallaxSpeed}px)`;
          }
        }, { passive: true });
      }

      // Animate numbers (count up effect)
      function animateNumber(element, target, duration = 2000) {
        const start = 0;
        const increment = target / (duration / 16);
        let current = start;
        
        const timer = setInterval(function() {
          current += increment;
          if (current >= target) {
            element.textContent = target + '+';
            clearInterval(timer);
          } else {
            element.textContent = Math.floor(current) + '+';
          }
        }, 16);
      }

      // Trigger number animation when visible
      const trustTitle = document.querySelector('.trust-title');
      if (trustTitle && trustTitle.textContent.includes('50+')) {
        const observer = new IntersectionObserver(function(entries) {
          entries.forEach(function(entry) {
            if (entry.isIntersecting) {
              // Animate the number
              const numberSpan = document.createElement('span');
              numberSpan.textContent = '0+';
              trustTitle.innerHTML = trustTitle.innerHTML.replace('50+', '<span class="animated-number">0+</span>');
              
              const animatedNumber = document.querySelector('.animated-number');
              if (animatedNumber) {
                animateNumber(animatedNumber, 50);
              }
              
              observer.unobserve(entry.target);
            }
          });
        }, { threshold: 0.5 });
        
        observer.observe(trustTitle);
      }

'@

# Insert design JS
$content = $content -replace '(\/\/ ================ PERFORMANCE OPTIMIZATIONS ================)', ($designJS + "`n`n" + '$1')

# Save file
Set-Content $file -Value $content -Encoding UTF8 -NoNewline

Write-Host "Design improvements added successfully!"
