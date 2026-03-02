      'use strict';

// ================ SECURITY FUNCTIONS ================

// XSS Protection: HTML Entity Encoding
function escapeHtml(text) {
  const map = {
    '&': '&amp;',
    '<': '&lt;',
    '>': '&gt;',
    '"': '&quot;',
    "'": '&#039;',
    '/': '&#x2F;'
  };
  return String(text).replace(/[&<>"'/]/g, m => map[m]);
}

// CSRF Token Generation
function generateCSRFToken() {
  const array = new Uint8Array(32);
  crypto.getRandomValues(array);
  return Array.from(array, byte => byte.toString(16).padStart(2, '0')).join('');
}

// Initialize CSRF token on page load
const csrfToken = generateCSRFToken();
sessionStorage.setItem('csrf_token', csrfToken);

// Rate Limiter
const RateLimiter = {
  attempts: 0,
  lastAttempt: 0,
  maxAttempts: 3,
  cooldown: 30000, // 30 seconds

  canSubmit() {
    const now = Date.now();
    if (now - this.lastAttempt > this.cooldown) {
      this.attempts = 0;
    }
    if (this.attempts >= this.maxAttempts) {
      return false;
    }
    this.attempts++;
    this.lastAttempt = now;
    return true;
  }
};


      // Global error handler for graceful degradation
      window.addEventListener('error', function(e) {
        console.warn('Non-critical error caught:', e.message);
        return true; // Prevent default error handling
      });

      // Mobile Menu Toggle
      const mobileToggle = document.querySelector('.mobile-toggle');
      const mobileOverlay = document.querySelector('.mobile-overlay');
      const mobileLinks = document.querySelectorAll('.mobile-nav-link');

      if (mobileToggle) {
        mobileToggle.addEventListener('click', function() {
          document.body.classList.toggle('menu-open');
        });
      }

      if (mobileOverlay) {
        mobileOverlay.addEventListener('click', function() {
          document.body.classList.remove('menu-open');
        });
      }

      mobileLinks.forEach(function(link) {
        link.addEventListener('click', function() {
          document.body.classList.remove('menu-open');
        });
      });

      // Smooth Scroll with fallback
      document.querySelectorAll('a[href^="#"]').forEach(function(anchor) {
        anchor.addEventListener('click', function(e) {
          const href = this.getAttribute('href');
          if (href === '#') return;
          
          e.preventDefault();
          const target = document.querySelector(href);
          if (target) {
            const offsetTop = target.offsetTop - 80;
            
            // Try modern smooth scroll, fallback to instant scroll
            try {
              window.scrollTo({
                top: offsetTop,
                behavior: 'smooth'
              });
            } catch (error) {
              // Fallback for older browsers
              window.scrollTo(0, offsetTop);
            }
          }
        });
      });

      // Hero Slideshow
      const slideshowContainer = document.querySelector('.hero-slideshow-container');
      if (slideshowContainer) {
        const slides = document.querySelectorAll('.hero-slide');
        const dots = document.querySelectorAll('.slide-dot');
        const prevBtn = document.querySelector('.slide-nav.prev');
        const nextBtn = document.querySelector('.slide-nav.next');
        
        let currentSlide = 0;
        let slideInterval;
        const slideDuration = 5000;
        
        function showSlide(index) {
          slides.forEach(slide => slide.classList.remove('active'));
          dots.forEach(dot => dot.classList.remove('active'));
          
          if (index >= slides.length) currentSlide = 0;
          if (index < 0) currentSlide = slides.length - 1;
          
          slides[currentSlide].classList.add('active');
          dots[currentSlide].classList.add('active');
        }
        
        function nextSlide() {
          currentSlide++;
          if (currentSlide >= slides.length) currentSlide = 0;
          showSlide(currentSlide);
        }
        
        function prevSlide() {
          currentSlide--;
          if (currentSlide < 0) currentSlide = slides.length - 1;
          showSlide(currentSlide);
        }
        
        function startInterval() {
          clearInterval(slideInterval);
          slideInterval = setInterval(nextSlide, slideDuration);
        }
        
        function resetInterval() {
          clearInterval(slideInterval);
          startInterval();
        }
        
        if (prevBtn) {
          prevBtn.addEventListener('click', function() {
            prevSlide();
            resetInterval();
          });
        }
        
        if (nextBtn) {
          nextBtn.addEventListener('click', function() {
            nextSlide();
            resetInterval();
          });
        }
        
        dots.forEach(function(dot, index) {
          dot.addEventListener('click', function() {
            currentSlide = index;
            showSlide(currentSlide);
            resetInterval();
          });
        });
        
        slideshowContainer.addEventListener('mouseenter', function() {
          clearInterval(slideInterval);
        });
        
        slideshowContainer.addEventListener('mouseleave', function() {
          startInterval();
        });
        
        showSlide(currentSlide);
        startInterval();
        
        document.addEventListener('visibilitychange', function() {
          if (document.hidden) {
            clearInterval(slideInterval);
          } else {
            startInterval();
          }
        });
      }

      // Back to Top Button
      const backToTop = document.getElementById('backToTop');
      if (backToTop) {
        window.addEventListener('scroll', function() {
          if (window.scrollY > 500) {
            backToTop.classList.add('show');
          } else {
            backToTop.classList.remove('show');
          }
        }, { passive: true });

        backToTop.addEventListener('click', function() {
          window.scrollTo({
            top: 0,
            behavior: 'smooth'
          });
        });
      }

      // RFQ Form Handler with validation and loading state
      const rfqForm = document.getElementById('rfqForm');
      if (rfqForm) {
        const submitBtn = rfqForm.querySelector('.btn-submit-rfq');
        const originalBtnText = submitBtn.innerHTML;
        
        rfqForm.addEventListener('submit', function(e) {
          e.preventDefault();

    // Rate limiting check
    if (!RateLimiter.canSubmit()) {
      alert('Terlalu banyak percobaan. Mohon tunggu 30 detik.');
      return;
    }
          
          // Show loading state
          submitBtn.disabled = true;
          submitBtn.innerHTML = '<svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="animation: spin 1s linear infinite;"><circle cx="12" cy="12" r="10"/></svg> <span>Mengirim...</span>';
          
          const formData = new FormData(rfqForm);
          const name = escapeHtml(formData.get('name'));
          const whatsapp = escapeHtml(formData.get('whatsapp'));
          const email = escapeHtml(formData.get('email'));
          const brand = escapeHtml(formData.get('brand') || '-') || '-';
          const industry = formData.get('industry');
          const boxType = formData.get('boxType');
          const quantity = formData.get('quantity') || '-';
          const message = escapeHtml(formData.get('message'));

          const waMessage = `Halo deartbox,
Saya ingin request quotation:

Nama: ${name}
WhatsApp: ${whatsapp}
Email: ${email}
Brand: ${brand}
Industri: ${industry}
Tipe Box: ${boxType}
Kuantitas: ${quantity}
Deskripsi: ${message}`;

          const waUrl = 'https://wa.me/628195181427?text=' + encodeURIComponent(waMessage);
          window.open(waUrl, '_blank');

          // Reset button after short delay
          setTimeout(function() {
      'use strict';

// ================ SECURITY FUNCTIONS ================

// XSS Protection: HTML Entity Encoding
function escapeHtml(text) {
  const map = {
    '&': '&amp;',
    '<': '&lt;',
    '>': '&gt;',
    '"': '&quot;',
    "'": '&#039;',
    '/': '&#x2F;'
  };
  return String(text).replace(/[&<>"'/]/g, m => map[m]);
}

// CSRF Token Generation
function generateCSRFToken() {
  const array = new Uint8Array(32);
  crypto.getRandomValues(array);
  return Array.from(array, byte => byte.toString(16).padStart(2, '0')).join('');
}

// Initialize CSRF token on page load
const csrfToken = generateCSRFToken();
sessionStorage.setItem('csrf_token', csrfToken);

// Rate Limiter
const RateLimiter = {
  attempts: 0,
  lastAttempt: 0,
  maxAttempts: 3,
  cooldown: 30000, // 30 seconds

  canSubmit() {
    const now = Date.now();
    if (now - this.lastAttempt > this.cooldown) {
      this.attempts = 0;
    }
    if (this.attempts >= this.maxAttempts) {
      return false;
    }
    this.attempts++;
    this.lastAttempt = now;
    return true;
  }
};


            submitBtn.disabled = false;
            submitBtn.innerHTML = originalBtnText;
            rfqForm.reset();
          }, 2000);
        });
      }

      // Active Navigation on Scroll
      const sections = document.querySelectorAll('section[id]');
      const navLinks = document.querySelectorAll('.nav-link, .mobile-nav-link');

      window.addEventListener('scroll', function() {
        let current = '';
        sections.forEach(function(section) {
          const sectionTop = section.offsetTop;
          const sectionHeight = section.clientHeight;
          if (window.scrollY >= (sectionTop - 200)) {
            current = section.getAttribute('id');
          }
        });

        navLinks.forEach(function(link) {
          link.classList.remove('active');
          if (link.getAttribute('href') === '#' + current) {
            link.classList.add('active');
          }
        });
      }, { passive: true });
      
      // Reveal Animation with IntersectionObserver
      const reveals = document.querySelectorAll('.reveal');

      const observer = new IntersectionObserver(entries => {
        entries.forEach(entry => {
          if (entry.isIntersecting) {
            entry.target.classList.add('active');
            observer.unobserve(entry.target);
          }
        });
      }, {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
      });

      reveals.forEach(reveal => {
        observer.observe(reveal);
      });

      document.addEventListener("DOMContentLoaded", () => {
        const targets = document.querySelectorAll(
          ".section-title, .section-subtitle"
        );

        const observer = new IntersectionObserver(
          (entries, obs) => {
            entries.forEach(entry => {
              if (entry.isIntersecting) {
                entry.target.classList.add("is-visible");
                obs.unobserve(entry.target); // animasi sekali
              }
            });
          },
          {
            threshold: 0.2
          }
        );

        targets.forEach(el => observer.observe(el));
      });
    
      // ================ TOUCH INTERACTIONS & SWIPE GESTURES ================
      
      // Swipe support for hero slideshow
      if (slideshowContainer) {
        let touchStartX = 0;
        let touchEndX = 0;
        
        slideshowContainer.addEventListener('touchstart', function(e) {
          touchStartX = e.changedTouches[0].screenX;
        }, { passive: true });
        
        slideshowContainer.addEventListener('touchend', function(e) {
          touchEndX = e.changedTouches[0].screenX;
          handleSwipe();
        }, { passive: true });
        
        function handleSwipe() {
          const swipeThreshold = 50;
          const diff = touchStartX - touchEndX;
          
          if (Math.abs(diff) > swipeThreshold) {
            if (diff > 0) {
              // Swipe left - next slide
              nextSlide();
              resetInterval();
            } else {
              // Swipe right - previous slide
              prevSlide();
              resetInterval();
            }
          }
        }
      }

      // Swipe to close mobile menu
      const mobileMenu = document.querySelector('.mobile-menu');
      if (mobileMenu) {
        let menuTouchStartX = 0;
        let menuTouchEndX = 0;
        
        mobileMenu.addEventListener('touchstart', function(e) {
          menuTouchStartX = e.changedTouches[0].screenX;
        }, { passive: true });
        
        mobileMenu.addEventListener('touchend', function(e) {
          menuTouchEndX = e.changedTouches[0].screenX;
          
          // Swipe right to close
          if (menuTouchEndX - menuTouchStartX > 100) {
            document.body.classList.remove('menu-open');
          }
        }, { passive: true });
      }

      // ================ SMART STICKY CTA ================
      
      const stickyCTA = document.querySelector('.sticky-cta');
      if (stickyCTA) {
        let lastScrollTop = 0;
        let scrollTimeout;
        
        window.addEventListener('scroll', function() {
          clearTimeout(scrollTimeout);
          
          scrollTimeout = setTimeout(function() {
      'use strict';

// ================ SECURITY FUNCTIONS ================

// XSS Protection: HTML Entity Encoding
function escapeHtml(text) {
  const map = {
    '&': '&amp;',
    '<': '&lt;',
    '>': '&gt;',
    '"': '&quot;',
    "'": '&#039;',
    '/': '&#x2F;'
  };
  return String(text).replace(/[&<>"'/]/g, m => map[m]);
}

// CSRF Token Generation
function generateCSRFToken() {
  const array = new Uint8Array(32);
  crypto.getRandomValues(array);
  return Array.from(array, byte => byte.toString(16).padStart(2, '0')).join('');
}

// Initialize CSRF token on page load
const csrfToken = generateCSRFToken();
sessionStorage.setItem('csrf_token', csrfToken);

// Rate Limiter
const RateLimiter = {
  attempts: 0,
  lastAttempt: 0,
  maxAttempts: 3,
  cooldown: 30000, // 30 seconds

  canSubmit() {
    const now = Date.now();
    if (now - this.lastAttempt > this.cooldown) {
      this.attempts = 0;
    }
    if (this.attempts >= this.maxAttempts) {
      return false;
    }
    this.attempts++;
    this.lastAttempt = now;
    return true;
  }
};


            const scrollTop = window.scrollY || document.documentElement.scrollTop;
            const windowHeight = window.innerHeight;
            const documentHeight = document.documentElement.scrollHeight;
            const footer = document.querySelector('footer');
            const footerTop = footer ? footer.offsetTop : documentHeight;
            
            // Hide CTA when scrolling down, show when scrolling up
            if (scrollTop > lastScrollTop && scrollTop > 200) {
              // Scrolling down
              stickyCTA.classList.add('hide');
            } else {
              // Scrolling up
              stickyCTA.classList.remove('hide');
            }
            
            // Hide CTA when footer is visible
            if (scrollTop + windowHeight >= footerTop - 50) {
              stickyCTA.style.display = 'none';
            } else {
              stickyCTA.style.display = 'flex';
            }
            
            lastScrollTop = scrollTop <= 0 ? 0 : scrollTop;
          }, 100);
        }, { passive: true });
      }

      // ================ PREVENT iOS ZOOM ON INPUT FOCUS ================
      
      // Add viewport meta tag adjustment for iOS
      const viewport = document.querySelector('meta[name="viewport"]');
      if (viewport && /iPhone|iPad|iPod/.test(navigator.userAgent)) {
        const inputs = document.querySelectorAll('input, select, textarea');
        
        inputs.forEach(function(input) {
          input.addEventListener('focus', function() {
            viewport.setAttribute('content', 'width=device-width, initial-scale=1, maximum-scale=1');
          });
          
          input.addEventListener('blur', function() {
            viewport.setAttribute('content', 'width=device-width, initial-scale=1');
          });
        });
      }

      // ================ IMPROVED MOBILE MENU ACCESSIBILITY ================
      
      // Trap focus in mobile menu when open
      if (mobileMenu && mobileToggle) {
        const focusableElements = mobileMenu.querySelectorAll(
          'a[href], button:not([disabled])'
        );
        const firstFocusable = focusableElements[0];
        const lastFocusable = focusableElements[focusableElements.length - 1];
        
        document.addEventListener('keydown', function(e) {
          if (!document.body.classList.contains('menu-open')) return;
          
          // Close menu on Escape
          if (e.key === 'Escape') {
            document.body.classList.remove('menu-open');
            mobileToggle.focus();
            return;
          }
          
          // Trap focus
          if (e.key === 'Tab') {
            if (e.shiftKey) {
              if (document.activeElement === firstFocusable) {
                e.preventDefault();
                lastFocusable.focus();
              }
            } else {
              if (document.activeElement === lastFocusable) {
                e.preventDefault();
                firstFocusable.focus();
              }
            }
          }
        });
      }

      
      
      
      
      
      // ================ FAQ ACCORDION ================
      
      const faqItems = document.querySelectorAll('.faq-item');
      
      faqItems.forEach(function(item) {
        const question = item.querySelector('.faq-question');
        
        question.addEventListener('click', function() {
          const isActive = item.classList.contains('active');
          
          // Close all other items
          faqItems.forEach(function(otherItem) {
            if (otherItem !== item) {
              otherItem.classList.remove('active');
              otherItem.querySelector('.faq-question').setAttribute('aria-expanded', 'false');
            }
          });
          
          // Toggle current item
          if (isActive) {
            item.classList.remove('active');
            question.setAttribute('aria-expanded', 'false');
          } else {
            item.classList.add('active');
            question.setAttribute('aria-expanded', 'true');
          }
        });
      });


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
      'use strict';

// ================ SECURITY FUNCTIONS ================

// XSS Protection: HTML Entity Encoding
function escapeHtml(text) {
  const map = {
    '&': '&amp;',
    '<': '&lt;',
    '>': '&gt;',
    '"': '&quot;',
    "'": '&#039;',
    '/': '&#x2F;'
  };
  return String(text).replace(/[&<>"'/]/g, m => map[m]);
}

// CSRF Token Generation
function generateCSRFToken() {
  const array = new Uint8Array(32);
  crypto.getRandomValues(array);
  return Array.from(array, byte => byte.toString(16).padStart(2, '0')).join('');
}

// Initialize CSRF token on page load
const csrfToken = generateCSRFToken();
sessionStorage.setItem('csrf_token', csrfToken);

// Rate Limiter
const RateLimiter = {
  attempts: 0,
  lastAttempt: 0,
  maxAttempts: 3,
  cooldown: 30000, // 30 seconds

  canSubmit() {
    const now = Date.now();
    if (now - this.lastAttempt > this.cooldown) {
      this.attempts = 0;
    }
    if (this.attempts >= this.maxAttempts) {
      return false;
    }
    this.attempts++;
    this.lastAttempt = now;
    return true;
  }
};


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
      'use strict';

// ================ SECURITY FUNCTIONS ================

// XSS Protection: HTML Entity Encoding
function escapeHtml(text) {
  const map = {
    '&': '&amp;',
    '<': '&lt;',
    '>': '&gt;',
    '"': '&quot;',
    "'": '&#039;',
    '/': '&#x2F;'
  };
  return String(text).replace(/[&<>"'/]/g, m => map[m]);
}

// CSRF Token Generation
function generateCSRFToken() {
  const array = new Uint8Array(32);
  crypto.getRandomValues(array);
  return Array.from(array, byte => byte.toString(16).padStart(2, '0')).join('');
}

// Initialize CSRF token on page load
const csrfToken = generateCSRFToken();
sessionStorage.setItem('csrf_token', csrfToken);

// Rate Limiter
const RateLimiter = {
  attempts: 0,
  lastAttempt: 0,
  maxAttempts: 3,
  cooldown: 30000, // 30 seconds

  canSubmit() {
    const now = Date.now();
    if (now - this.lastAttempt > this.cooldown) {
      this.attempts = 0;
    }
    if (this.attempts >= this.maxAttempts) {
      return false;
    }
    this.attempts++;
    this.lastAttempt = now;
    return true;
  }
};


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
                // Performance monitoring - disabled for production
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
          //   // console.log('SW registration failed:', err); // Disabled for production
          // });
        });
      }


// ================ FORM VALIDATION & ENHANCEMENTS ================
      
      // Real-time validation functions
      const validators = {
        name: function(value) {
          if (!value || value.trim().length < 2) {
            return { valid: false, message: 'Nama minimal 2 karakter' };
          }
          return { valid: true, message: 'Nama valid' };
        },
        
        whatsapp: function(value) {
          // Indonesian phone format: 08xx-xxxx-xxxx
          const cleaned = value.replace(/\D/g, '');
          if (!cleaned.startsWith('08')) {
            return { valid: false, message: 'Nomor harus diawali 08' };
          }
          if (cleaned.length < 10 || cleaned.length > 13) {
            return { valid: false, message: 'Nomor tidak valid (10-13 digit)' };
          }
          return { valid: true, message: 'Nomor valid' };
        },
        
        email: function(value) {
          const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
          if (!emailRegex.test(value)) {
            return { valid: false, message: 'Format email tidak valid' };
          }
          
          // Common typo suggestions
          const commonTypos = {
            'gmial.com': 'gmail.com',
            'gmai.com': 'gmail.com',
            'yahooo.com': 'yahoo.com',
            'hotmial.com': 'hotmail.com'
          };
          
          const domain = value.split('@')[1];
          if (commonTypos[domain]) {
            return { 
              valid: false, 
              message: `Maksud Anda ${value.replace(domain, commonTypos[domain])}?` 
            };
          }
          
          return { valid: true, message: 'Email valid' };
        }
      };

      // Phone number auto-formatting
      const whatsappInput = document.getElementById('whatsapp');
      if (whatsappInput) {
        whatsappInput.addEventListener('input', function(e) {
          let value = e.target.value.replace(/\D/g, '');
          
          // Format: 0819-1234-5678
          if (value.length > 4 && value.length <= 8) {
            value = value.slice(0, 4) + '-' + value.slice(4);
          } else if (value.length > 8) {
            value = value.slice(0, 4) + '-' + value.slice(4, 8) + '-' + value.slice(8, 12);
          }
          
          e.target.value = value;
          validateField(e.target, 'whatsapp');
        });
      }

      // Real-time validation for all fields
      function validateField(field, validatorName) {
        const fieldWrapper = field.closest('.form-field');
        if (!fieldWrapper) return;
        
        const value = field.value.trim();
        const validator = validators[validatorName];
        
        if (!validator) return;
        
        const result = validator(value);
        
        // Remove existing error/success messages
        let errorMsg = fieldWrapper.querySelector('.form-error');
        let successMsg = fieldWrapper.querySelector('.form-success');
        
        if (!errorMsg) {
          errorMsg = document.createElement('div');
          errorMsg.className = 'form-error';
          field.parentNode.appendChild(errorMsg);
        }
        
        if (!successMsg) {
          successMsg = document.createElement('div');
          successMsg.className = 'form-success';
          field.parentNode.appendChild(successMsg);
        }
        
        if (result.valid) {
          fieldWrapper.classList.remove('error');
          fieldWrapper.classList.add('valid');
          errorMsg.textContent = '';
          successMsg.textContent = result.message;
        } else {
          fieldWrapper.classList.remove('valid');
          fieldWrapper.classList.add('error');
          errorMsg.textContent = result.message;
          successMsg.textContent = '';
        }
      }

      // Attach validators to form fields
      const nameInput = document.getElementById('rfq-name');
      const emailInput = document.getElementById('rfq-email');
      
      if (nameInput) {
        nameInput.addEventListener('blur', function() {
          validateField(this, 'name');
        });
      }
      
      if (emailInput) {
        emailInput.addEventListener('blur', function() {
          validateField(this, 'email');
        });
      }

      // ================ FILE UPLOAD HANDLING ================
      
      const fileInput = document.getElementById('rfq-files');
      const fileLabel = document.querySelector('.file-upload-label');
      const filePreview = document.getElementById('filePreview');
      let uploadedFiles = [];

      if (fileInput && fileLabel) {
        // Click to upload
        fileInput.addEventListener('change', handleFiles);
        
        // Drag and drop
        fileLabel.addEventListener('dragover', function(e) {
          e.preventDefault();
          this.classList.add('dragover');
        });
        
        fileLabel.addEventListener('dragleave', function(e) {
          e.preventDefault();
          this.classList.remove('dragover');
        });
        
        fileLabel.addEventListener('drop', function(e) {
          e.preventDefault();
          this.classList.remove('dragover');
          
          const files = e.dataTransfer.files;
          handleFiles({ target: { files: files } });
        });
      }

      function handleFiles(e) {
        const files = Array.from(e.target.files);
        const maxSize = 5 * 1024 * 1024; // 5MB
        const allowedTypes = ['image/jpeg', 'image/png', 'image/webp', 'application/pdf'];
        
        files.forEach(file => {
          // Validate file size
          if (file.size > maxSize) {
            alert(`File ${file.name} terlalu besar. Maksimal 5MB.`);
            return;
          }
          
          // Validate file type
          if (!allowedTypes.includes(file.type)) {
            alert(`File ${file.name} format tidak didukung. Gunakan JPG, PNG, atau PDF.`);
            return;
          }
          
          uploadedFiles.push(file);
          displayFilePreview(file);
        });
      }

      function displayFilePreview(file) {
        const previewItem = document.createElement('div');
        previewItem.className = 'file-preview-item';
        previewItem.style.cssText = 'display: flex; align-items: center; gap: 12px; padding: 12px; background: #f5f5f5; border-radius: 8px; margin-bottom: 8px;';
        
        // File icon or image preview
        if (file.type.startsWith('image/')) {
          const img = document.createElement('img');
          img.style.cssText = 'width: 60px; height: 60px; object-fit: cover; border-radius: 4px;';
          const reader = new FileReader();
          reader.onload = function(e) {
            img.src = e.target.result;
          };
          reader.readAsDataURL(file);
          previewItem.appendChild(img);
        } else {
          const icon = document.createElement('div');
          icon.style.cssText = 'width: 60px; height: 60px; background: #d71921; border-radius: 4px; display: flex; align-items: center; justify-content: center; color: white; font-weight: bold;';
          icon.textContent = 'PDF';
          previewItem.appendChild(icon);
        }
        
        // File info
        const fileInfo = document.createElement('div');
        fileInfo.style.flex = '1';
        fileInfo.innerHTML = `
          <div class="file-name">${file.name}</div>
          <div class="file-size">${(file.size / 1024).toFixed(1)} KB</div>
        `;
        previewItem.appendChild(fileInfo);
        
        // Remove button
        const removeBtn = document.createElement('button');
        removeBtn.type = 'button';
        removeBtn.className = 'file-remove';
        removeBtn.innerHTML = 'Ã—';
        removeBtn.onclick = function() {
          uploadedFiles = uploadedFiles.filter(f => f !== file);
          previewItem.remove();
          if (uploadedFiles.length === 0) {
            filePreview.classList.remove('show');
          }
        };
        previewItem.appendChild(removeBtn);
        
        filePreview.appendChild(previewItem);
        filePreview.classList.add('show');
      }

      // ================ FORM AUTO-SAVE (localStorage) ================
      
      const formFields = ['rfq-name', 'whatsapp', 'rfq-email', 'rfq-brand', 'rfq-industry', 'rfq-box', 'rfq-qty', 'rfq-message'];
      
      // Load saved data on page load
      window.addEventListener('load', function() {
        formFields.forEach(fieldId => {
          const field = document.getElementById(fieldId);
          const savedValue = localStorage.getItem('rfq_' + fieldId);
          if (field && savedValue) {
            field.value = savedValue;
          }
        });
      });

      // Auto-save every 30 seconds
      setInterval(function() {
      'use strict';

// ================ SECURITY FUNCTIONS ================

// XSS Protection: HTML Entity Encoding
function escapeHtml(text) {
  const map = {
    '&': '&amp;',
    '<': '&lt;',
    '>': '&gt;',
    '"': '&quot;',
    "'": '&#039;',
    '/': '&#x2F;'
  };
  return String(text).replace(/[&<>"'/]/g, m => map[m]);
}

// CSRF Token Generation
function generateCSRFToken() {
  const array = new Uint8Array(32);
  crypto.getRandomValues(array);
  return Array.from(array, byte => byte.toString(16).padStart(2, '0')).join('');
}

// Initialize CSRF token on page load
const csrfToken = generateCSRFToken();
sessionStorage.setItem('csrf_token', csrfToken);

// Rate Limiter
const RateLimiter = {
  attempts: 0,
  lastAttempt: 0,
  maxAttempts: 3,
  cooldown: 30000, // 30 seconds

  canSubmit() {
    const now = Date.now();
    if (now - this.lastAttempt > this.cooldown) {
      this.attempts = 0;
    }
    if (this.attempts >= this.maxAttempts) {
      return false;
    }
    this.attempts++;
    this.lastAttempt = now;
    return true;
  }
};


        formFields.forEach(fieldId => {
          const field = document.getElementById(fieldId);
          if (field && field.value) {
            localStorage.setItem('rfq_' + fieldId, field.value);
          }
        });
      }, 30000);

      // Clear saved data on successful submission
      function clearFormData() {
        formFields.forEach(fieldId => {
          localStorage.removeItem('rfq_' + fieldId);
        });
      }

      // ================ ENHANCED FORM SUBMISSION ================
      
      if (rfqForm) {
        rfqForm.addEventListener('submit', function(e) {
          e.preventDefault();

    // Rate limiting check
    if (!RateLimiter.canSubmit()) {
      alert('Terlalu banyak percobaan. Mohon tunggu 30 detik.');
      return;
    }
          
          // Validate all required fields
          let isValid = true;
          const requiredFields = [
            { id: 'rfq-name', validator: 'name' },
            { id: 'whatsapp', validator: 'whatsapp' },
            { id: 'rfq-email', validator: 'email' }
          ];
          
          requiredFields.forEach(field => {
            const input = document.getElementById(field.id);
            if (input) {
              validateField(input, field.validator);
              const wrapper = input.closest('.form-field');
              if (wrapper && wrapper.classList.contains('error')) {
                isValid = false;
              }
            }
          });
          
          if (!isValid) {
            // Show validation error in UI
          const errorMsg = document.createElement('div');
          errorMsg.style.cssText = 'position: fixed; top: 20px; right: 20px; background: #ef4444; color: white; padding: 16px 24px; border-radius: 8px; z-index: 10000; animation: slideIn 0.3s ease;';
          errorMsg.textContent = 'Mohon perbaiki field yang error terlebih dahulu.';
          document.body.appendChild(errorMsg);
          setTimeout(() => errorMsg.remove(), 3000);
            return;
          }
          
          // Show loading state
          submitBtn.disabled = true;
          submitBtn.innerHTML = '<svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="animation: spin 1s linear infinite;"><circle cx="12" cy="12" r="10"/></svg> <span>Mengirim...</span>';
          
          const formData = new FormData(rfqForm);
          const name = escapeHtml(formData.get('name'));
          const whatsapp = escapeHtml(formData.get('whatsapp'));
          const email = escapeHtml(formData.get('email'));
          const brand = escapeHtml(formData.get('brand') || '-') || '-';
          const industry = formData.get('industry');
          const boxType = formData.get('boxType');
          const quantity = formData.get('quantity') || '-';
          const message = escapeHtml(formData.get('message'));

          let waMessage = `Halo deartbox,\nSaya ingin request quotation:\n\nNama: ${name}\nWhatsApp: ${whatsapp}\nEmail: ${email}\nBrand: ${brand}\nIndustri: ${industry}\nTipe Box: ${boxType}\nKuantitas: ${quantity}\nDeskripsi: ${message}`;
          
          if (uploadedFiles.length > 0) {
            waMessage += `\n\nFile referensi: ${uploadedFiles.length} file terlampir`;
          }

          const waUrl = 'https://wa.me/628195181427?text=' + encodeURIComponent(waMessage);
          
          // Simulate sending delay
          setTimeout(function() {
      'use strict';

// ================ SECURITY FUNCTIONS ================

// XSS Protection: HTML Entity Encoding
function escapeHtml(text) {
  const map = {
    '&': '&amp;',
    '<': '&lt;',
    '>': '&gt;',
    '"': '&quot;',
    "'": '&#039;',
    '/': '&#x2F;'
  };
  return String(text).replace(/[&<>"'/]/g, m => map[m]);
}

// CSRF Token Generation
function generateCSRFToken() {
  const array = new Uint8Array(32);
  crypto.getRandomValues(array);
  return Array.from(array, byte => byte.toString(16).padStart(2, '0')).join('');
}

// Initialize CSRF token on page load
const csrfToken = generateCSRFToken();
sessionStorage.setItem('csrf_token', csrfToken);

// Rate Limiter
const RateLimiter = {
  attempts: 0,
  lastAttempt: 0,
  maxAttempts: 3,
  cooldown: 30000, // 30 seconds

  canSubmit() {
    const now = Date.now();
    if (now - this.lastAttempt > this.cooldown) {
      this.attempts = 0;
    }
    if (this.attempts >= this.maxAttempts) {
      return false;
    }
    this.attempts++;
    this.lastAttempt = now;
    return true;
  }
};


            // Open WhatsApp
            window.open(waUrl, '_blank');
            
            // Show success modal
            document.getElementById('successModal').classList.add('show');
            
            // Reset form
            rfqForm.reset();
            uploadedFiles = [];
            filePreview.innerHTML = '';
            filePreview.classList.remove('show');
            
            // Clear localStorage
            clearFormData();
            
            // Reset button
            submitBtn.disabled = false;
            submitBtn.innerHTML = originalBtnText;
            
            // Remove validation classes
            document.querySelectorAll('.form-field').forEach(field => {
              field.classList.remove('valid', 'error');
            });
          }, 1500);
        });
      }

      // Close modal on outside click
      const successModal = document.getElementById('successModal');
      if (successModal) {
        successModal.addEventListener('click', function(e) {
          if (e.target === this) {
            this.classList.remove('show');
          }
        });
      }


// ================ PERFORMANCE: DEBOUNCE SCROLL EVENTS ================
      
      function debounce(func, wait) {
        let timeout;
        return function executedFunction(...args) {
          const later = function() {
            clearTimeout(timeout);
            func(...args);
          };
          clearTimeout(timeout);
          timeout = setTimeout(later, wait);
        };
      }

      // Apply debounce to scroll-heavy operations
      const debouncedScrollHandler = debounce(function() {
      'use strict';

// ================ SECURITY FUNCTIONS ================

// XSS Protection: HTML Entity Encoding
function escapeHtml(text) {
  const map = {
    '&': '&amp;',
    '<': '&lt;',
    '>': '&gt;',
    '"': '&quot;',
    "'": '&#039;',
    '/': '&#x2F;'
  };
  return String(text).replace(/[&<>"'/]/g, m => map[m]);
}

// CSRF Token Generation
function generateCSRFToken() {
  const array = new Uint8Array(32);
  crypto.getRandomValues(array);
  return Array.from(array, byte => byte.toString(16).padStart(2, '0')).join('');
}

// Initialize CSRF token on page load
const csrfToken = generateCSRFToken();
sessionStorage.setItem('csrf_token', csrfToken);

// Rate Limiter
const RateLimiter = {
  attempts: 0,
  lastAttempt: 0,
  maxAttempts: 3,
  cooldown: 30000, // 30 seconds

  canSubmit() {
    const now = Date.now();
    if (now - this.lastAttempt > this.cooldown) {
      this.attempts = 0;
    }
    if (this.attempts >= this.maxAttempts) {
      return false;
    }
    this.attempts++;
    this.lastAttempt = now;
    return true;
  }
};


        // Any additional scroll-based operations can go here
      }, 100);

      window.addEventListener('scroll', debouncedScrollHandler, { passive: true });


