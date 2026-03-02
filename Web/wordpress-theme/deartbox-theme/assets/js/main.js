/**
 * Deartbox Blog Theme - Main JavaScript
 *
 * @package Deartbox
 */

(function() {
    'use strict';

    // ================ THEME TOGGLE ================
    const themeToggle = document.getElementById('themeToggle');
    const iconSun = themeToggle?.querySelector('.icon-sun');
    const iconMoon = themeToggle?.querySelector('.icon-moon');

    function setTheme(theme) {
        document.documentElement.setAttribute('data-theme', theme);
        localStorage.setItem('deartbox-blog-theme', theme);
        
        if (iconSun && iconMoon) {
            if (theme === 'dark') {
                iconSun.style.display = 'none';
                iconMoon.style.display = 'block';
            } else {
                iconSun.style.display = 'block';
                iconMoon.style.display = 'none';
            }
        }

        // Update logo for dark mode
        const logos = document.querySelectorAll('[data-logo-light][data-logo-dark]');
        logos.forEach(function(logo) {
            if (theme === 'dark') {
                logo.src = logo.getAttribute('data-logo-dark');
            } else {
                logo.src = logo.getAttribute('data-logo-light');
            }
        });
    }

    // Initialize theme - Default to light mode for new visitors
    const savedTheme = localStorage.getItem('deartbox-blog-theme');
    const initialTheme = savedTheme || 'light';
    setTheme(initialTheme);

    // Theme toggle click
    if (themeToggle) {
        themeToggle.addEventListener('click', function() {
            const currentTheme = document.documentElement.getAttribute('data-theme');
            const newTheme = currentTheme === 'dark' ? 'light' : 'dark';
            setTheme(newTheme);
        });
    }

    // ================ MOBILE MENU ================
    const mobileToggle = document.getElementById('mobileToggle');
    const mainNav = document.querySelector('.main-nav');

    if (mobileToggle && mainNav) {
        mobileToggle.addEventListener('click', function() {
            const isExpanded = mobileToggle.getAttribute('aria-expanded') === 'true';
            mobileToggle.setAttribute('aria-expanded', !isExpanded);
            mainNav.classList.toggle('active');
            
            // Toggle hamburger animation
            mobileToggle.classList.toggle('active');
        });

        // Close menu when clicking outside
        document.addEventListener('click', function(e) {
            if (!mainNav.contains(e.target) && !mobileToggle.contains(e.target)) {
                mainNav.classList.remove('active');
                mobileToggle.setAttribute('aria-expanded', 'false');
                mobileToggle.classList.remove('active');
            }
        });
    }

    // ================ HEADER SCROLL ================
    const header = document.querySelector('.site-header');
    let lastScrollY = 0;

    function handleScroll() {
        const scrollY = window.scrollY;
        
        if (scrollY > 50) {
            header?.classList.add('scrolled');
        } else {
            header?.classList.remove('scrolled');
        }

        lastScrollY = scrollY;
    }

    window.addEventListener('scroll', handleScroll, { passive: true });
    handleScroll();

    // ================ SMOOTH SCROLL ================
    document.querySelectorAll('a[href^="#"]').forEach(function(anchor) {
        anchor.addEventListener('click', function(e) {
            const href = this.getAttribute('href');
            if (href === '#') return;

            const target = document.querySelector(href);
            if (target) {
                e.preventDefault();
                const headerHeight = header?.offsetHeight || 75;
                const targetPosition = target.getBoundingClientRect().top + window.scrollY - headerHeight;
                
                window.scrollTo({
                    top: targetPosition,
                    behavior: 'smooth'
                });
            }
        });
    });

    // ================ LAZY LOAD IMAGES ================
    if ('IntersectionObserver' in window) {
        const imageObserver = new IntersectionObserver(function(entries, observer) {
            entries.forEach(function(entry) {
                if (entry.isIntersecting) {
                    const img = entry.target;
                    if (img.dataset.src) {
                        img.src = img.dataset.src;
                        img.removeAttribute('data-src');
                    }
                    observer.unobserve(img);
                }
            });
        }, {
            rootMargin: '50px 0px'
        });

        document.querySelectorAll('img[data-src]').forEach(function(img) {
            imageObserver.observe(img);
        });
    }

    // ================ READING PROGRESS ================
    const progressBar = document.querySelector('.reading-progress');
    
    if (progressBar && document.body.classList.contains('single-post')) {
        window.addEventListener('scroll', function() {
            const scrollTop = window.scrollY;
            const docHeight = document.documentElement.scrollHeight - window.innerHeight;
            const progress = (scrollTop / docHeight) * 100;
            progressBar.style.width = progress + '%';
        }, { passive: true });
    }

    // ================ COPY CODE BLOCKS ================
    document.querySelectorAll('pre code').forEach(function(codeBlock) {
        const wrapper = document.createElement('div');
        wrapper.className = 'code-block-wrapper';
        codeBlock.parentNode.insertBefore(wrapper, codeBlock);
        wrapper.appendChild(codeBlock.parentNode.removeChild(codeBlock).parentNode);

        const copyBtn = document.createElement('button');
        copyBtn.className = 'copy-code-btn';
        copyBtn.textContent = 'Copy';
        wrapper.appendChild(copyBtn);

        copyBtn.addEventListener('click', function() {
            navigator.clipboard.writeText(codeBlock.textContent).then(function() {
                copyBtn.textContent = 'Copied!';
                setTimeout(function() {
                    copyBtn.textContent = 'Copy';
                }, 2000);
            });
        });
    });

    // ================ EXTERNAL LINKS ================
    document.querySelectorAll('a[href^="http"]').forEach(function(link) {
        if (!link.href.includes(window.location.hostname)) {
            link.setAttribute('target', '_blank');
            link.setAttribute('rel', 'noopener noreferrer');
        }
    });

})();
