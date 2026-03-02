$file = "D:\Data User\Documents\GitHub\deartbox-Packaging\lightmode\notion-feel-v2-cleaned.html"
$content = Get-Content $file -Raw -Encoding UTF8

# Find the closing script tag and add touch interaction code before it
$touchJS = @'

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
        // Any additional scroll-based operations can go here
      }, 100);

      window.addEventListener('scroll', debouncedScrollHandler, { passive: true });

'@

# Insert before the closing script tag
$content = $content -replace '(\s+)\}\)\(\);(\s+)</script>', ('$1' + $touchJS + '$1})();$2</script>')

# Save file
Set-Content $file -Value $content -Encoding UTF8 -NoNewline

Write-Host "Touch interactions and responsive JavaScript added successfully!"
