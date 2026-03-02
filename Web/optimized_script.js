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
  try {
    if (window.crypto && typeof window.crypto.getRandomValues === 'function') {
      const array = new Uint8Array(32);
      window.crypto.getRandomValues(array);
      return Array.from(array, byte => byte.toString(16).padStart(2, '0')).join('');
    }
  } catch (e) {}

  let token = '';
  for (let i = 0; i < 64; i++) token += Math.floor(Math.random() * 16).toString(16);
  return token;
}

// Initialize CSRF token on page load
const csrfToken = generateCSRFToken();
try {
  sessionStorage.setItem('csrf_token', csrfToken);
} catch (e) {}

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

// Debug mode disabled for production
const debugMode = false;

function reportHorizontalOverflow(opts) {
  const options = opts || {};
  const threshold = typeof options.threshold === 'number' ? options.threshold : 1;
  const mark = options.mark !== false;

  const viewportWidth = window.innerWidth || document.documentElement.clientWidth || 0;
  const root = document.documentElement;
  const scrollWidth = Math.max(root.scrollWidth, document.body ? document.body.scrollWidth : 0);

  const offenders = [];
  if (!document.body) return { viewportWidth, scrollWidth, offenders };

  const candidates = document.body.querySelectorAll('*');
  for (let i = 0; i < candidates.length; i++) {
    const el = candidates[i];
    if (!el || !el.getBoundingClientRect) continue;
    const rect = el.getBoundingClientRect();
    if (!rect || !isFinite(rect.width)) continue;

    const exceedsRight = rect.right - viewportWidth > threshold;
    const exceedsLeft = rect.left < -threshold;
    if (!exceedsRight && !exceedsLeft) continue;

    offenders.push({
      tag: el.tagName,
      className: el.className || '',
      id: el.id || '',
      left: Math.round(rect.left),
      right: Math.round(rect.right),
      width: Math.round(rect.width)
    });

    if (mark) {
      try {
        el.style.outline = '2px solid #ff00ff';
        el.style.outlineOffset = '-2px';
      } catch (e) {}
    }
  }

  if (debugMode) {
    try {
      console.log('[overflow]', { viewportWidth, scrollWidth, offenderCount: offenders.length, offenders });
    } catch (e) {}
  }

  return { viewportWidth, scrollWidth, offenders };
}

if (debugMode) {
  window.__reportOverflow = reportHorizontalOverflow;
  setTimeout(function () { reportHorizontalOverflow({ mark: false }); }, 400);
}

window.addEventListener('error', function (e) {
  if (!debugMode) return;
  try {
    console.warn('Non-critical error caught:', e && e.message ? e.message : e);
  } catch (err) {}
});

window.addEventListener('unhandledrejection', function (e) {
  if (!debugMode) return;
  try {
    console.warn('Unhandled promise rejection:', e && e.reason ? e.reason : e);
  } catch (err) {}
});

// ================ UI INTERATIONS ================

// Mobile Menu Toggle
const mobileToggle = document.querySelector('.mobile-toggle');
const mobileOverlay = document.querySelector('.mobile-overlay');
const mobileLinks = document.querySelectorAll('.mobile-nav-link');
const mobileCtas = document.querySelectorAll('.mobile-cta');
const headerElement = document.querySelector('header');
const mobileMenu = document.querySelector('.mobile-menu');

function setMobileMenuState(isOpen, opts) {
  const shouldFocus = !(opts && opts.focus === false);
  if (mobileToggle) mobileToggle.setAttribute('aria-expanded', isOpen ? 'true' : 'false');
  if (mobileMenu) mobileMenu.setAttribute('aria-hidden', isOpen ? 'false' : 'true');
  if (mobileOverlay) mobileOverlay.setAttribute('aria-hidden', isOpen ? 'false' : 'true');

  if (!isOpen) {
    document.body.classList.remove('menu-open');
    return;
  }

  document.body.classList.add('menu-open');

  if (shouldFocus && mobileMenu) {
    const firstFocusable = mobileMenu.querySelector('a[href], button:not([disabled])');
    if (firstFocusable) firstFocusable.focus();
  }
}

setMobileMenuState(document.body.classList.contains('menu-open'), { focus: false });

function updateHeaderHeightVar() {
  if (!headerElement) return;
  const height = headerElement.offsetHeight;
  if (!height) return;
  document.documentElement.style.setProperty('--header-h', height + 'px');
}

let headerHeightRaf = 0;
function scheduleHeaderHeightUpdate() {
  if (headerHeightRaf) return;
  headerHeightRaf = window.requestAnimationFrame(function () {
    headerHeightRaf = 0;
    updateHeaderHeightVar();
  });
}

scheduleHeaderHeightUpdate();
window.addEventListener('resize', scheduleHeaderHeightUpdate, { passive: true });
window.addEventListener('orientationchange', scheduleHeaderHeightUpdate, { passive: true });
setTimeout(scheduleHeaderHeightUpdate, 0);
setTimeout(scheduleHeaderHeightUpdate, 250);

if (mobileToggle) {
  mobileToggle.addEventListener('click', function() {
    const isOpen = !document.body.classList.contains('menu-open');
    setMobileMenuState(isOpen);
  });
}

if (mobileOverlay) {
  mobileOverlay.addEventListener('click', function() {
    setMobileMenuState(false);
  });
}

mobileLinks.forEach(function(link) {
  link.addEventListener('click', function() {
    setMobileMenuState(false, { focus: false });
  });
});

mobileCtas.forEach(function(link) {
  link.addEventListener('click', function() {
    setMobileMenuState(false, { focus: false });
  });
});

function scrollToY(top, useSmooth) {
  const y = Math.max(0, Number(top) || 0);
  if (!useSmooth) {
    window.scrollTo(0, y);
    return;
  }

  try {
    window.scrollTo({ top: y, behavior: 'smooth' });
  } catch (error) {
    window.scrollTo(0, y);
  }
}

function scrollToTargetWithOffset(target, offset) {
  const headerOffset = Number(offset) || 0;
  const y = target.getBoundingClientRect().top + window.pageYOffset - headerOffset;
  scrollToY(y, true);
}

// Smooth Scroll with fallback
document.querySelectorAll('a[href^="#"]').forEach(function(anchor) {
  anchor.addEventListener('click', function(e) {
    const href = this.getAttribute('href');
    if (href === '#') return;
    
    const target = document.querySelector(href);
    if (!target) return;

    document.body.classList.remove('menu-open');
    document.querySelectorAll('.nav-dropdown[open]').forEach(function(dropdown) {
      dropdown.removeAttribute('open');
    });

    requestAnimationFrame(function() {
      setActiveNav(href);
    });
  });
});

document.querySelectorAll('[data-video-embed]').forEach(function(container) {
  const playBtn = container.querySelector('.video-play-btn');
  if (!playBtn) return;

  playBtn.addEventListener('click', function() {
    const embedUrl = (container.getAttribute('data-video-embed') || '').trim();
    if (!embedUrl) {
      const waMessage = 'Halo deartbox, saya minta link company video/profil produksi.';
      const waUrl = 'https://wa.me/628195181427?text=' + encodeURIComponent(waMessage);
      window.open(waUrl, '_blank');
      return;
    }

    const iframe = document.createElement('iframe');
    iframe.src = embedUrl;
    iframe.title = 'Company video deartbox Packaging';
    iframe.loading = 'lazy';
    iframe.allow = 'accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share';
    iframe.allowFullscreen = true;
    iframe.referrerPolicy = 'strict-origin-when-cross-origin';

    container.innerHTML = '';
    container.appendChild(iframe);
  });
});

const navDropdowns = document.querySelectorAll('.nav-dropdown');
if (navDropdowns.length) {
  const hoverMedia = window.matchMedia('(hover: hover) and (pointer: fine)');

  document.addEventListener('click', function(e) {
    navDropdowns.forEach(function(dropdown) {
      if (!dropdown.contains(e.target)) dropdown.removeAttribute('open');
    });
  });

  navDropdowns.forEach(function(dropdown) {
    dropdown.querySelectorAll('.nav-dropdown-summary a[href^="#"]').forEach(function(anchor) {
      anchor.addEventListener('click', function(e) {
        e.stopPropagation();
        dropdown.removeAttribute('open');
      });
    });

    if (hoverMedia.matches) {
      dropdown.addEventListener('pointerenter', function() {
        dropdown.setAttribute('open', '');
      });

      dropdown.addEventListener('pointerleave', function() {
        if (dropdown.matches(':focus-within')) return;
        dropdown.removeAttribute('open');
      });
    }

    dropdown.querySelectorAll('a').forEach(function(link) {
      link.addEventListener('click', function() {
        dropdown.removeAttribute('open');
      });
    });

    dropdown.addEventListener('keydown', function(e) {
      if (e.key !== 'Escape') return;
      dropdown.removeAttribute('open');
      const summary = dropdown.querySelector('summary');
      if (summary) summary.focus();
    });
  });
}

function applyShowcaseFilter(category) {
  const buttons = document.querySelectorAll('[data-showcase-filter-btn]');
  const items = document.querySelectorAll('.showcase-item[data-category]');
  const empty = document.querySelector('.showcase-empty');

  buttons.forEach(function(btn) {
    const isActive = btn.getAttribute('data-showcase-filter-btn') === category;
    btn.classList.toggle('is-active', isActive);
    btn.setAttribute('aria-pressed', isActive ? 'true' : 'false');
  });

  let visibleCount = 0;
  items.forEach(function(item) {
    const itemCategory = item.getAttribute('data-category');
    const isVisible = itemCategory === category;
    item.classList.toggle('is-hidden', !isVisible);
    if (isVisible) visibleCount++;
  });

  if (empty) empty.hidden = visibleCount > 0;
}

const showcaseFilterButtons = document.querySelectorAll('[data-showcase-filter-btn]');
if (showcaseFilterButtons.length) {
  showcaseFilterButtons.forEach(function(btn) {
    btn.addEventListener('click', function() {
      const category = btn.getAttribute('data-showcase-filter-btn');
      if (!category) return;
      applyShowcaseFilter(category);
    });
  });

  applyShowcaseFilter('signature');
}

document.querySelectorAll('a[data-showcase-filter]').forEach(function(link) {
  link.addEventListener('click', function() {
    const category = link.getAttribute('data-showcase-filter');
    if (!category) return;
    applyShowcaseFilter(category);
  });
});

// Hero Slideshow
const slideshowContainer = document.querySelector('.hero-slideshow-container');
if (slideshowContainer) {
  const slides = document.querySelectorAll('.hero-slide');
  const dots = document.querySelectorAll('.slide-dot');
  const prevBtn = document.querySelector('.slide-nav.prev');
  const nextBtn = document.querySelector('.slide-nav.next');
  const ghostPrevImg = slideshowContainer.querySelector('.hero-ghost-prev img');
  const ghostPrev2Img = slideshowContainer.querySelector('.hero-ghost-prev2 img');
  const ghostNextImg = slideshowContainer.querySelector('.hero-ghost-next img');
  const ghostNext2Img = slideshowContainer.querySelector('.hero-ghost-next2 img');
  
  let currentSlide = 0;
  let slideInterval;
  const slideDuration = 5000;
  const slideTransitionMs = 760;
  let isAnimatingSlide = false;
  let slideCleanupTimer = null;
  
  function getEffectiveImgSrc(img) {
    if (!img) return null;
    const ds = img.dataset && img.dataset.src ? img.dataset.src : null;
    if (ds) return ds;
    const current = typeof img.currentSrc === 'string' && img.currentSrc ? img.currentSrc : null;
    if (current) return current;
    const src = img.getAttribute('src');
    if (src) return src;
    return null;
  }

  function syncGhostImage(ghostImg, sourceImg) {
    if (!ghostImg || !sourceImg) return;

    const sourceCurrent = typeof sourceImg.currentSrc === 'string' && sourceImg.currentSrc ? sourceImg.currentSrc : '';
    const sourceSrc = (sourceImg.dataset && sourceImg.dataset.src) ? sourceImg.dataset.src : (sourceImg.getAttribute('src') || '');
    const sourceSrcset = (sourceImg.dataset && sourceImg.dataset.srcset) ? sourceImg.dataset.srcset : (sourceImg.getAttribute('srcset') || '');
    const sourceSizes = (sourceImg.dataset && sourceImg.dataset.sizes) ? sourceImg.dataset.sizes : (sourceImg.getAttribute('sizes') || '');

    if (sourceCurrent && sourceCurrent.indexOf('data:image') !== 0) {
      ghostImg.removeAttribute('sizes');
      ghostImg.removeAttribute('srcset');
      ghostImg.srcset = '';
      ghostImg.sizes = '';
      ghostImg.src = sourceCurrent;
      return;
    }

    if (sourceSizes) ghostImg.sizes = sourceSizes;
    if (sourceSrcset) ghostImg.srcset = sourceSrcset;
    if (sourceSrc) ghostImg.src = sourceSrc;
  }

  function updateGhostPreviews() {
    if ((!ghostPrevImg && !ghostNextImg && !ghostPrev2Img && !ghostNext2Img) || !slides.length) return;
    const prevIndex = (currentSlide - 1 + slides.length) % slides.length;
    const prev2Index = (currentSlide - 2 + slides.length) % slides.length;
    const nextIndex = (currentSlide + 1) % slides.length;
    const next2Index = (currentSlide + 2) % slides.length;
    const prevSlideImg = slides[prevIndex].querySelector('img');
    const prev2SlideImg = slides[prev2Index].querySelector('img');
    const nextSlideImg = slides[nextIndex].querySelector('img');
    const next2SlideImg = slides[next2Index].querySelector('img');
    if (prevSlideImg) loadDeferredImage(prevSlideImg);
    if (prev2SlideImg) loadDeferredImage(prev2SlideImg);
    if (nextSlideImg) loadDeferredImage(nextSlideImg);
    if (next2SlideImg) loadDeferredImage(next2SlideImg);
    syncGhostImage(ghostPrevImg, prevSlideImg);
    syncGhostImage(ghostPrev2Img, prev2SlideImg);
    syncGhostImage(ghostNextImg, nextSlideImg);
    syncGhostImage(ghostNext2Img, next2SlideImg);
  }

  function normalizeIndex(index) {
    if (!slides.length) return 0;
    if (index >= slides.length) return 0;
    if (index < 0) return slides.length - 1;
    return index;
  }

  function showSlide(index, dir) {
    if (!slides.length) return;
    const nextIndex = normalizeIndex(index);
    if (nextIndex === currentSlide) {
      dots.forEach(dot => dot.classList.remove('active'));
      if (dots[currentSlide]) dots[currentSlide].classList.add('active');
      updateGhostPreviews();
      return;
    }

    const direction = dir === 'prev' ? 'prev' : 'next';
    slideshowContainer.dataset.slideDir = direction;

    if (slideCleanupTimer) {
      clearTimeout(slideCleanupTimer);
      slideCleanupTimer = null;
    }

    if (isAnimatingSlide) {
      slides.forEach(function(slide, idx) {
        slide.classList.remove('is-entering', 'is-exiting');
        if (idx !== currentSlide) slide.classList.remove('active');
      });
    }
    
    slideshowContainer.classList.remove('ghost-animating-next', 'ghost-animating-prev');

    // Ensure ghost images are correct before animating
    updateGhostPreviews();
    
    // Add ghost animating class
    slideshowContainer.classList.add(direction === 'next' ? 'ghost-animating-next' : 'ghost-animating-prev');

    const outgoing = slides[currentSlide];
    const incoming = slides[nextIndex];
    const incomingImg = incoming ? incoming.querySelector('img') : null;
    if (incomingImg) loadDeferredImage(incomingImg);

    if (outgoing) outgoing.classList.add('is-exiting');
    if (incoming) incoming.classList.add('active', 'is-entering');

    // Force browser to register the starting state (is-entering)
    // using Double RAF to ensure painting happens before removing class
    requestAnimationFrame(function() {
      requestAnimationFrame(function() {
        if (incoming) incoming.classList.remove('is-entering');
      });
    });

    dots.forEach(dot => dot.classList.remove('active'));
    if (dots[nextIndex]) dots[nextIndex].classList.add('active');

    currentSlide = nextIndex;
    // Removed immediate updateGhostPreviews() here

    isAnimatingSlide = true;
    slideCleanupTimer = setTimeout(function() {
      slides.forEach(function(slide, idx) {
        slide.classList.remove('is-entering', 'is-exiting');
        if (idx !== currentSlide) slide.classList.remove('active');
      });
      
      // Update ghosts after animation finishes
      updateGhostPreviews();
      
      // Remove ghost animating classes
      slideshowContainer.classList.remove('ghost-animating-next', 'ghost-animating-prev');
      
      isAnimatingSlide = false;
      slideCleanupTimer = null;
    }, slideTransitionMs);
  }
  
  function nextSlide() {
    showSlide(currentSlide + 1, 'next');
  }
  
  function prevSlide() {
    showSlide(currentSlide - 1, 'prev');
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
      const dir = index < currentSlide ? 'prev' : 'next';
      showSlide(index, dir);
      resetInterval();
    });
  });
  
  slideshowContainer.addEventListener('mouseenter', function() {
    clearInterval(slideInterval);
  });
  
  slideshowContainer.addEventListener('mouseleave', function() {
    startInterval();
  });
  
  showSlide(currentSlide, 'next');
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
  backToTop.addEventListener('click', function() {
    try {
      const scrollingElement = document.scrollingElement || document.documentElement;
      if (scrollingElement && typeof scrollingElement.scrollTo === 'function') {
        try {
          scrollingElement.scrollTo({ top: 0, behavior: 'smooth' });
        } catch (e) {
          scrollingElement.scrollTop = 0;
        }
      }

      document.documentElement.scrollTop = 0;
      document.body.scrollTop = 0;
      scrollToY(0, true);
    } catch (e) {
      window.scrollTo(0, 0);
    }
  });
}

// Active Navigation on Scroll
const sections = document.querySelectorAll('section[id]');
const navLinks = document.querySelectorAll('.nav-link, .mobile-nav-link');
const ctaNavSecondary = document.querySelectorAll('.cta-nav-secondary');

function setActiveNav(hash) {
  if (!hash || hash[0] !== '#') return;
  const target = document.querySelector(hash);
  if (!target) return;

  navLinks.forEach(function(link) {
    link.classList.remove('active');
  });

  ctaNavSecondary.forEach(function(link) {
    link.classList.remove('active');
  });

  document.querySelectorAll('a.nav-link[href]').forEach(function(link) {
    if (link.getAttribute('href') === hash) link.classList.add('active');
  });

  document.querySelectorAll('a.mobile-nav-link[href]').forEach(function(link) {
    if (link.getAttribute('href') === hash) link.classList.add('active');
  });

  document.querySelectorAll('a.cta-nav-secondary[href]').forEach(function(link) {
    if (link.getAttribute('href') === hash) link.classList.add('active');
  });

  document.querySelectorAll('.nav-dropdown').forEach(function(dropdown) {
    const summary = dropdown.querySelector('.nav-dropdown-summary');
    if (!summary) return;
    let hasMatch = false;
    dropdown.querySelectorAll('a[href^="#"]').forEach(function(link) {
      if (link.getAttribute('href') === hash) hasMatch = true;
    });
    if (hasMatch) summary.classList.add('active');
  });
}

if (sections.length && navLinks.length && 'IntersectionObserver' in window) {
  const sectionObserver = new IntersectionObserver(function(entries) {
    let best = null;
    entries.forEach(function(entry) {
      if (!entry.isIntersecting) return;
      if (!best || entry.intersectionRatio > best.intersectionRatio) best = entry;
    });
    if (best && best.target && best.target.id) setActiveNav('#' + best.target.id);
  }, {
    rootMargin: '-40% 0px -55% 0px',
    threshold: [0.15, 0.25, 0.35, 0.5, 0.65]
  });

  sections.forEach(function(section) {
    sectionObserver.observe(section);
  });
}

setActiveNav(window.location.hash || '#home');

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
    ".section-title, .section-subtitle, .pain-point-item, .pain-points-conclusion, .pain-points-cta, .pain-points-subtitle"
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
      setMobileMenuState(false);
    }
  }, { passive: true });
}

// ================ SMART STICKY CTA ================

const stickyCTA = document.querySelector('.sticky-cta');

// ================ IMPROVED MOBILE MENU ACCESSIBILITY ================

// Trap focus in mobile menu when open
if (mobileMenu && mobileToggle) {
  function getFocusableElements() {
    return mobileMenu.querySelectorAll('a[href], button:not([disabled])');
  }
  
  document.addEventListener('keydown', function(e) {
    if (!document.body.classList.contains('menu-open')) return;
    
    // Close menu on Escape
    if (e.key === 'Escape') {
      setMobileMenuState(false, { focus: false });
      mobileToggle.focus();
      return;
    }
    
    // Trap focus
    if (e.key === 'Tab') {
      const focusableElements = getFocusableElements();
      const firstFocusable = focusableElements[0];
      const lastFocusable = focusableElements[focusableElements.length - 1];
      if (!firstFocusable || !lastFocusable) return;
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

// Check for saved theme preference; default for new visitors is light
const savedTheme = localStorage.getItem('theme');

function getThemeColorValue(theme) {
  return theme === 'dark' ? '#0b0d12' : '#d71921';
}

function setThemeColorMeta(theme) {
  const metaThemeColor = document.querySelector('meta[name="theme-color"]:not([media])') || document.querySelector('meta[name="theme-color"]');
  if (!metaThemeColor) return;
  metaThemeColor.setAttribute('content', getThemeColorValue(theme));
}

function updateBrandLogos(theme) {
  const resolvedTheme = theme === 'dark' ? 'dark' : 'light';
  document.querySelectorAll('img.brand-logo[data-logo-light][data-logo-dark]').forEach(function(img) {
    const lightSrc = img.getAttribute('data-logo-light');
    const darkSrc = img.getAttribute('data-logo-dark');
    const nextSrc = resolvedTheme === 'dark' ? darkSrc : lightSrc;
    if (!nextSrc) return;
    img.setAttribute('src', nextSrc);
    if (img.hasAttribute('data-src')) img.setAttribute('data-src', nextSrc);
  });
}

// Set initial theme (new visitors always get light)
if (savedTheme === 'dark' || savedTheme === 'light') {
  htmlElement.setAttribute('data-theme', savedTheme);
} else {
  htmlElement.removeAttribute('data-theme');
}

const initialTheme = htmlElement.getAttribute('data-theme') === 'dark' ? 'dark' : 'light';
setThemeColorMeta(initialTheme);
updateBrandLogos(initialTheme);

// Toggle theme
if (themeToggle) {
  themeToggle.addEventListener('click', function() {
    const currentTheme = htmlElement.getAttribute('data-theme');
    const newTheme = currentTheme === 'dark' ? 'light' : 'dark';
    
    htmlElement.setAttribute('data-theme', newTheme);
    localStorage.setItem('theme', newTheme);
    
    setThemeColorMeta(newTheme);
    updateBrandLogos(newTheme);
  });
}

// ================ DESIGN IMPROVEMENTS ================

// Glassmorphism header on scroll
const header = document.querySelector('header');

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
const allowHeroParallax = Boolean(heroSection);

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

// ================ PERFORMANCE OPTIMIZATIONS ================

let deferredImageLoadingStarted = false;

function loadDeferredImage(img) {
  if (!img || img.dataset.deferState === 'loading' || img.dataset.deferState === 'loaded') return;
  const src = (img.dataset && img.dataset.src) ? img.dataset.src : '';
  const srcset = (img.dataset && img.dataset.srcset) ? img.dataset.srcset : '';
  const sizes = (img.dataset && img.dataset.sizes) ? img.dataset.sizes : '';
  if (!src && !srcset) return;

  img.dataset.deferState = 'loading';

  function onLoad() {
    img.classList.add('loaded');
    img.dataset.deferState = 'loaded';
    img.removeEventListener('load', onLoad);
    img.removeEventListener('error', onError);
  }

  function onError() {
    img.dataset.deferState = 'error';
    img.removeEventListener('load', onLoad);
    img.removeEventListener('error', onError);
  }

  img.addEventListener('load', onLoad);
  img.addEventListener('error', onError);

  if (sizes) img.sizes = sizes;
  if (srcset) img.srcset = srcset;
  if (src) img.src = src;
}

function startDeferredImageLoading() {
  if (deferredImageLoadingStarted) return;
  deferredImageLoadingStarted = true;

  const deferredImages = document.querySelectorAll('img[data-src], img[data-srcset]');
  if (!deferredImages.length) return;

  if (!('IntersectionObserver' in window)) {
    deferredImages.forEach(function (img) {
      loadDeferredImage(img);
    });
    return;
  }

  const imageObserver = new IntersectionObserver(function (entries, observer) {
    entries.forEach(function (entry) {
      if (!entry.isIntersecting) return;
      const img = entry.target;
      loadDeferredImage(img);
      observer.unobserve(img);
    });
  }, { rootMargin: '200px 0px', threshold: 0.01 });

  deferredImages.forEach(function (img) {
    imageObserver.observe(img);
  });
}

function startDeferredImageLoadingOnFirstScroll() {
  function onFirstInteraction() {
    window.removeEventListener('scroll', onFirstInteraction);
    window.removeEventListener('wheel', onFirstInteraction);
    window.removeEventListener('touchmove', onFirstInteraction);
    window.removeEventListener('keydown', onFirstInteraction);
    startDeferredImageLoading();
  }

  window.addEventListener('scroll', onFirstInteraction, { passive: true });
  window.addEventListener('wheel', onFirstInteraction, { passive: true });
  window.addEventListener('touchmove', onFirstInteraction, { passive: true });
  window.addEventListener('keydown', onFirstInteraction);
}

startDeferredImageLoadingOnFirstScroll();

if ('IntersectionObserver' in window) {
  startDeferredImageLoading();
} else if (window.location && window.location.hash) {
  requestAnimationFrame(function () {
    startDeferredImageLoading();
  });
} else if (window.scrollY > 0) {
  requestAnimationFrame(function () {
    startDeferredImageLoading();
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
  required: function(value) {
    if (!value || !value.trim()) {
      return { valid: false, message: 'Wajib diisi' };
    }
    return { valid: true, message: '' };
  },

  message: function(value) {
    if (!value || value.trim().length < 10) {
      return { valid: false, message: 'Mohon isi minimal 10 karakter' };
    }
    return { valid: true, message: 'Deskripsi cukup' };
  },

  name: function(value) {
    if (!value || value.trim().length < 2) {
      return { valid: false, message: 'Nama minimal 2 karakter' };
    }
    return { valid: true, message: 'Nama valid' };
  },
  
  whatsapp: function(value) {
    const cleaned = value.replace(/\D/g, '');
    const normalized = cleaned.startsWith('62') ? ('0' + cleaned.slice(2)) : cleaned;

    if (!normalized.startsWith('08')) {
      return { valid: false, message: 'Gunakan format 08xx… atau +62…' };
    }

    if (normalized.length < 10 || normalized.length > 13) {
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
    if (value.startsWith('62')) value = '0' + value.slice(2);
    
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
const messageInput = document.getElementById('rfq-message');

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

if (messageInput) {
  messageInput.addEventListener('blur', function() {
    validateField(this, 'message');
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
  const fileName = document.createElement('div');
  fileName.className = 'file-name';
  fileName.textContent = file.name;
  const fileSize = document.createElement('div');
  fileSize.className = 'file-size';
  fileSize.textContent = `${(file.size / 1024).toFixed(1)} KB`;
  fileInfo.appendChild(fileName);
  fileInfo.appendChild(fileSize);
  previewItem.appendChild(fileInfo);
  
  // Remove button
  const removeBtn = document.createElement('button');
  removeBtn.type = 'button';
  removeBtn.className = 'file-remove';
  removeBtn.textContent = '×';
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

const formFields = ['rfq-name', 'whatsapp', 'rfq-email', 'rfq-message'];

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

const rfqForm = document.getElementById('rfqForm');
if (rfqForm) {
  const submitBtn = rfqForm.querySelector('.btn-submit-rfq');
  const originalBtnText = submitBtn.innerHTML;
  let lastFocusEl = null;
  const successModal = document.getElementById('successModal');
  const successModalContent = successModal ? successModal.querySelector('.success-modal-content') : null;
  const successModalClose = document.getElementById('successModalClose');
  const successModalOpenWhatsapp = document.getElementById('successModalOpenWhatsapp');

  function closeSuccessModal() {
    if (!successModal) return;
    successModal.classList.remove('show');
    successModal.setAttribute('aria-hidden', 'true');
    if (lastFocusEl && typeof lastFocusEl.focus === 'function') lastFocusEl.focus();
  }

  function openSuccessModal(focusReturnEl) {
    if (!successModal) return;
    lastFocusEl = focusReturnEl || document.activeElement;
    successModal.classList.add('show');
    successModal.setAttribute('aria-hidden', 'false');
    if (successModalContent) successModalContent.focus();
  }

  if (successModalClose) successModalClose.addEventListener('click', closeSuccessModal);
  if (successModalOpenWhatsapp) {
    successModalOpenWhatsapp.addEventListener('click', function () {
      window.location.href = 'https://wa.me/628195181427';
    });
  }

  if (successModal) {
    successModal.addEventListener('click', function (e) {
      if (e.target === successModal) closeSuccessModal();
    });

    document.addEventListener('keydown', function (e) {
      if (!successModal.classList.contains('show')) return;
      if (e.key === 'Escape') {
        closeSuccessModal();
        return;
      }

      if (e.key === 'Tab') {
        const focusables = successModal.querySelectorAll('button:not([disabled]), a[href]');
        const first = focusables[0];
        const last = focusables[focusables.length - 1];
        if (!first || !last) return;
        if (e.shiftKey) {
          if (document.activeElement === first) {
            e.preventDefault();
            last.focus();
          }
        } else {
          if (document.activeElement === last) {
            e.preventDefault();
            first.focus();
          }
        }
      }
    });
  }
  
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
      { id: 'rfq-email', validator: 'email' },
      { id: 'rfq-message', validator: 'message' }
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
      errorMsg.style.cssText = 'position: fixed; top: 20px; right: 20px; background: var(--danger); color: white; padding: 16px 24px; border-radius: 8px; z-index: 10000; animation: slideIn 0.3s ease;';
      errorMsg.textContent = 'Mohon perbaiki field yang error terlebih dahulu.';
      document.body.appendChild(errorMsg);
      setTimeout(() => errorMsg.remove(), 3000);
      return;
    }
    
    // Show loading state
    submitBtn.disabled = true;
    submitBtn.innerHTML = '<svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="animation: spin 1s linear infinite;"><circle cx="12" cy="12" r="10"/></svg> <span>Mengirim...</span>';

    (async function () {
      const rawFormData = new FormData(rfqForm);
      const nameRaw = String(rawFormData.get('name') || '');
      const whatsappRaw = String(rawFormData.get('whatsapp') || '');
      const emailRaw = String(rawFormData.get('email') || '');
      const messageRaw = String(rawFormData.get('message') || '');

      try {
        let requestBody;
        const requestHeaders = { 'Accept': 'application/json' };

        if (uploadedFiles.length === 0) {
          const params = new URLSearchParams();
          params.set('name', nameRaw);
          params.set('whatsapp', whatsappRaw);
          params.set('email', emailRaw);
          params.set('message', messageRaw);
          requestBody = params;
          requestHeaders['Content-Type'] = 'application/x-www-form-urlencoded; charset=UTF-8';
        } else {
          const apiFormData = new FormData();
          apiFormData.append('name', nameRaw);
          apiFormData.append('whatsapp', whatsappRaw);
          apiFormData.append('email', emailRaw);
          apiFormData.append('message', messageRaw);
          uploadedFiles.forEach(function (file) {
            apiFormData.append('files[]', file, file.name);
          });
          requestBody = apiFormData;
        }

        const resp = await fetch('api/rfq.php', {
          method: 'POST',
          body: requestBody,
          headers: requestHeaders
        });
        const data = await resp.json().catch(function () { return null; });

        if (!resp.ok || !data || data.ok !== true) {
          const err = data && data.error ? data.error : ('HTTP_' + resp.status);
          throw new Error(err);
        }

        const name = escapeHtml(nameRaw);
        const whatsapp = escapeHtml(whatsappRaw);
        const email = escapeHtml(emailRaw);
        const message = escapeHtml(messageRaw);

        let waMessage = `Halo deartbox,\nSaya ingin request quotation:\n\nNama: ${name}\nWhatsApp: ${whatsapp}\nEmail: ${email}\nDeskripsi Project: ${message}`;
        
        if (uploadedFiles.length > 0) {
          const fileNames = uploadedFiles
            .slice(0, 5)
            .map(f => f.name)
            .join(', ');
          const extraCount = uploadedFiles.length > 5 ? ` (+${uploadedFiles.length - 5} lainnya)` : '';
          waMessage += `\n\nReferensi design: ${uploadedFiles.length} file (${fileNames}${extraCount})`;
        }

        const waUrl = 'https://wa.me/628195181427?text=' + encodeURIComponent(waMessage);
        window.open(waUrl, '_blank');
        openSuccessModal(submitBtn);
        
        rfqForm.reset();
        uploadedFiles = [];
        filePreview.innerHTML = '';
        filePreview.classList.remove('show');
        clearFormData();
        
        document.querySelectorAll('.form-field').forEach(field => {
          field.classList.remove('valid', 'error');
        });
      } catch (err) {
        const errorMsg = document.createElement('div');
        errorMsg.style.cssText = 'position: fixed; top: 20px; right: 20px; background: var(--danger); color: white; padding: 16px 24px; border-radius: 8px; z-index: 10000; animation: slideIn 0.3s ease;';
        const errText = err && err.message ? String(err.message) : '';
        if (errText === 'HTTP_403') {
          errorMsg.textContent = 'RFQ ditolak server (403). Coba kirim tanpa upload file, atau minta hosting whitelist /api/rfq.php.';
        } else {
          errorMsg.textContent = 'Gagal mengirim RFQ. Silakan coba lagi.';
        }
        document.body.appendChild(errorMsg);
        setTimeout(() => errorMsg.remove(), 3500);
      } finally {
        submitBtn.disabled = false;
        submitBtn.innerHTML = originalBtnText;
      }
    })();
  });
}

// ================ SCROLL STATE (CONSOLIDATED) ================

const footer = document.querySelector('footer');
const scrollState = {
  latestY: window.scrollY || document.documentElement.scrollTop || 0,
  ticking: false,
  lastStickyScrollTop: 0,
  stickyTimeout: null
};

function updateBackToTop(scrollY) {
  if (!backToTop) return;
  if (scrollY > 250) {
    backToTop.classList.add('show');
  } else {
    backToTop.classList.remove('show');
  }
}

function updateActiveNav(scrollY) {
  if (!sections.length || !navLinks.length) return;
  let current = '';
  sections.forEach(function(section) {
    const sectionTop = section.offsetTop;
    const sectionHeight = section.clientHeight;
    if (sectionHeight && scrollY >= (sectionTop - 200)) {
      current = section.getAttribute('id');
    }
  });

  navLinks.forEach(function(link) {
    link.classList.remove('active');
    if (link.getAttribute('href') === '#' + current) {
      link.classList.add('active');
    }
  });
}

function updateHeaderScrolled(scrollY) {
  if (!header) return;
  if (scrollY > 50) {
    header.classList.add('scrolled');
  } else {
    header.classList.remove('scrolled');
  }
}

function updateHeroParallax(scrollY) {
  if (!allowHeroParallax) return;
  const parallaxSpeed = 0.5;
  if (scrollY < window.innerHeight) {
    heroSection.style.transform = `translateY(${scrollY * parallaxSpeed}px)`;
  }
}

function updateStickyCTA() {
  if (!stickyCTA) return;
  const scrollTop = scrollState.latestY;
  const windowHeight = window.innerHeight;
  const documentHeight = document.documentElement.scrollHeight;
  const footerTop = footer ? footer.offsetTop : documentHeight;

  if (scrollTop > scrollState.lastStickyScrollTop && scrollTop > 200) {
    stickyCTA.classList.add('hide');
  } else {
    stickyCTA.classList.remove('hide');
  }

  if (scrollTop + windowHeight >= footerTop - 50) {
    stickyCTA.style.display = 'none';
  } else {
    stickyCTA.style.display = 'flex';
  }

  scrollState.lastStickyScrollTop = scrollTop <= 0 ? 0 : scrollTop;
}

function runScrollFrame() {
  scrollState.ticking = false;
  const y = scrollState.latestY;
  updateBackToTop(y);
  updateActiveNav(y);
  updateHeaderScrolled(y);
  updateHeroParallax(y);
}

function onScroll() {
  scrollState.latestY = window.scrollY || document.documentElement.scrollTop || 0;

  if (!scrollState.ticking) {
    scrollState.ticking = true;
    requestAnimationFrame(runScrollFrame);
  }

  if (stickyCTA) {
    clearTimeout(scrollState.stickyTimeout);
    scrollState.stickyTimeout = setTimeout(updateStickyCTA, 100);
  }
}

window.addEventListener('scroll', onScroll, { passive: true });
onScroll();

// ================ FEATURE MODAL ================

const featureModal = document.getElementById('featureModal');
const featureModalContent = featureModal ? featureModal.querySelector('.feature-modal-content') : null;
const featureModalClose = document.getElementById('featureModalClose');
const featureModalTitle = document.getElementById('featureModalTitle');
const featureModalDesc = document.getElementById('featureModalDesc');
const featureModalList = document.getElementById('featureModalList');
const featureModalIcon = document.getElementById('featureModalIcon');
const featureModalWA = document.getElementById('featureModalWA');
const featureCardButtons = document.querySelectorAll('.feature-card-cta[data-feature]');

// Feature data content
const featureData = {
  moq: {
    title: 'MOQ Fleksibel - Mulai 200 Pcs',
    desc: 'Tidak perlu order ribuan unit untuk memulai. Kami menyediakan MOQ yang ramah untuk brand yang sedang berkembang.',
    icon: '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z"></path><polyline points="3.27 6.96 12 12.01 20.73 6.96"></polyline><line x1="12" y1="22.08" x2="12" y2="12"></line></svg>',
    list: [
      'MOQ mulai dari 200 pcs per desain',
      'Cocok untuk test market atau launching produk baru',
      'Bisa repeat order dengan jumlah fleksibel',
      'Harga kompetitif meski kuantitas kecil'
    ],
    waText: 'Halo deartbox, saya mau tanya tentang MOQ Fleksibel mulai 200 pcs'
  },
  qc: {
    title: 'Quality Control Ketat',
    desc: 'Setiap tahap produksi kami kontrol dengan standar yang ketat untuk memastikan hasil yang konsisten dan berkualitas.',
    icon: '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path><polyline points="22 4 12 14.01 9 11.01"></polyline></svg>',
    list: [
      'Inspeksi material sebelum produksi',
      'Kontrol warna dan finishing di setiap batch',
      'Pengecekan dimensi dan struktur box',
      'Final QC sebelum packing dan pengiriman'
    ],
    waText: 'Halo deartbox, saya mau tanya tentang Quality Control yang diterapkan'
  },
  custom: {
    title: 'Full Custom Design',
    desc: 'Desain 100% sesuai kebutuhan brand Anda. Dari ukuran, bentuk, material, hingga finishing - semuanya bisa disesuaikan.',
    icon: '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 19l7-7 3 3-7 7-3-3z"></path><path d="M18 13l-1.5-7.5L2 2l3.5 14.5L13 18l5-5z"></path><path d="M2 2l7.586 7.586"></path><circle cx="11" cy="11" r="2"></circle></svg>',
    list: [
      'Bebas pilih ukuran sesuai produk Anda',
      'Pilihan material: art paper, fancy paper, linen, dll',
      'Finishing: hotprint, emboss, UV spot, lamination',
      'Custom insert foam atau cardboard'
    ],
    waText: 'Halo deartbox, saya mau tanya tentang Full Custom Design untuk packaging'
  },
  timeline: {
    title: 'Timeline Jelas & Terukur',
    desc: 'Kami memberikan estimasi waktu yang realistis dan update progress secara berkala agar Anda bisa merencanakan dengan baik.',
    icon: '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"></circle><polyline points="12 6 12 12 16 14"></polyline></svg>',
    list: [
      'Estimasi timeline diberikan di awal project',
      'Update progress di setiap tahap produksi',
      'Koordinasi jadwal pengiriman yang fleksibel',
      'Opsi pengiriman partial jika diperlukan'
    ],
    waText: 'Halo deartbox, saya mau tanya tentang timeline produksi packaging'
  },
  material: {
    title: 'Material Berkualitas',
    desc: 'Kami menggunakan board tebal dan rigid yang tidak mudah penyok, sehingga hasil finishing lebih presisi dan tahan lama.',
    icon: '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M2 20h20"></path><path d="M5 20V8.2c0-1.12 0-1.68.218-2.108a2 2 0 0 1 .874-.874C6.52 5 7.08 5 8.2 5h7.6c1.12 0 1.68 0 2.108.218a2 2 0 0 1 .874.874C19 6.52 19 7.08 19 8.2V20"></path><path d="M12 5V2"></path><path d="M9 12h6"></path><path d="M9 16h6"></path></svg>',
    list: [
      'Board tebal 2mm - 3mm untuk struktur kokoh',
      'Material rigid anti penyok',
      'Pilihan kertas premium untuk wrapping',
      'Hasil finishing lebih presisi dan rapi'
    ],
    waText: 'Halo deartbox, saya mau tanya tentang material yang digunakan'
  },
  mesin: {
    title: 'Mesin Produksi Semi-Auto',
    desc: 'Kombinasi mesin semi-otomatis dan keahlian craftsman untuk menghasilkan packaging dengan konsistensi dan akurasi tinggi.',
    icon: '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="2" y="6" width="20" height="12" rx="2"></rect><path d="M12 12h.01"></path><path d="M17 12h.01"></path><path d="M7 12h.01"></path></svg>',
    list: [
      'Mesin cutting presisi untuk akurasi ukuran',
      'Mesin laminating untuk hasil finishing rata',
      'Proses assembly oleh craftsman berpengalaman',
      'Konsistensi kualitas di setiap batch produksi'
    ],
    waText: 'Halo deartbox, saya mau tanya tentang proses produksi dengan mesin semi-auto'
  }
};

let featureModalLastFocus = null;

function openFeatureModal(featureKey) {
  if (!featureModal || !featureData[featureKey]) return;
  
  const data = featureData[featureKey];
  featureModalLastFocus = document.activeElement;
  
  // Update modal content
  if (featureModalTitle) featureModalTitle.textContent = data.title;
  if (featureModalDesc) featureModalDesc.textContent = data.desc;
  if (featureModalIcon) featureModalIcon.innerHTML = data.icon;
  
  // Update list
  if (featureModalList) {
    featureModalList.innerHTML = data.list.map(function(item) {
      return '<li>' + item + '</li>';
    }).join('');
  }
  
  // Update WhatsApp link
  if (featureModalWA) {
    featureModalWA.href = 'https://wa.me/628195181427?text=' + encodeURIComponent(data.waText);
  }
  
  // Show modal
  featureModal.classList.add('show');
  featureModal.setAttribute('aria-hidden', 'false');
  document.body.style.overflow = 'hidden';
  
  // Focus modal content
  if (featureModalContent) {
    featureModalContent.focus();
  }
}

function closeFeatureModal() {
  if (!featureModal) return;
  
  featureModal.classList.remove('show');
  featureModal.setAttribute('aria-hidden', 'true');
  document.body.style.overflow = '';
  
  // Return focus
  if (featureModalLastFocus && typeof featureModalLastFocus.focus === 'function') {
    featureModalLastFocus.focus();
  }
}

// Event listeners for feature buttons
featureCardButtons.forEach(function(btn) {
  btn.addEventListener('click', function() {
    const featureKey = btn.getAttribute('data-feature');
    if (featureKey) {
      openFeatureModal(featureKey);
    }
  });
});

// Close button
if (featureModalClose) {
  featureModalClose.addEventListener('click', closeFeatureModal);
}

// Click outside to close
if (featureModal) {
  featureModal.addEventListener('click', function(e) {
    if (e.target === featureModal) {
      closeFeatureModal();
    }
  });
}

// Keyboard navigation
document.addEventListener('keydown', function(e) {
  if (!featureModal || !featureModal.classList.contains('show')) return;
  
  // Close on Escape
  if (e.key === 'Escape') {
    closeFeatureModal();
    return;
  }
  
  // Trap focus
  if (e.key === 'Tab') {
    const focusables = featureModal.querySelectorAll('button:not([disabled]), a[href]');
    const first = focusables[0];
    const last = focusables[focusables.length - 1];
    if (!first || !last) return;
    
    if (e.shiftKey) {
      if (document.activeElement === first) {
        e.preventDefault();
        last.focus();
      }
    } else {
      if (document.activeElement === last) {
        e.preventDefault();
        first.focus();
      }
    }
  }
});
