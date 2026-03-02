## What I found (current state)

* SEO basics look strong: title/description/canonical + OpenGraph/Twitter + JSON-LD Organization are present in [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L12-L88).

* Accessibility baseline is good: skip-to-content link and a real main landmark exist in [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L169-L356).

## High-impact issues

* Broken/placeholder navigation: “Blog & Artikel” links to `#` (desktop + mobile), which causes a jump-to-top and is a bad UX/SEO signal. Locations: [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L206-L308).

* Marquee logos are noisy for screen readers and can cause layout shift:

  * Many client logos use generic alt text (“Client Logo …”) instead of either real brand names or `alt=""` when decorative. Example area: [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L434-L527).

  * Logos don’t specify `width`/`height`, increasing CLS risk.

* CSS has a global transition rule on `*` that can create unnecessary work and odd “color fade” effects across the entire page: [optimized\_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L130-L140).

* JavaScript globally logs runtime errors via `console.warn`, which is usually undesirable on production sites: [optimized\_script.js](file:///d:/Data%20User/Documents/Jihad/Web/optimized_script.js#L60-L64).

* RFQ WhatsApp input pattern only accepts Indonesian `08…` format and may reject `+62…` / `62…` entries: [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L852-L867).

## Plan (what I’ll change)

1. Fix navigation placeholders

   * Replace `href="#"` “Blog & Artikel” with a real URL if it exists, or convert it into a non-link “Coming soon” element that doesn’t hijack scrolling.
2. Improve marquee accessibility + reduce CLS

   * Treat decorative client logos as decorative (`alt=""`, `aria-hidden="true"`) OR update to real brand names if you want them indexed/read.

   * Add consistent `width`/`height` for logo images to stabilize layout.
3. Tune CSS for performance without visual changes

   * Replace the global `* { transition-property: ... }` with transitions only on interactive components (buttons, links, cards) to avoid repaint churn.

   * Review `will-change` usage and limit it to elements that actually animate.
4. Harden JS behavior

   * Replace the global error logger with a silent handler (or only enable logging in a “debug” mode).

   * Make phone validation accept `08…`, `628…`, and `+628…` safely.

   * Optional: remove inline `onclick` handlers in the success modal and attach listeners in JS (CSP-friendly).
5. Verify

   * Run a local preview and do a quick QA pass (menu open/close, anchor scroll offset, slideshow controls, RFQ submit → WhatsApp + modal).

   * Run a Lighthouse-style check for Performance/Accessibility/SEO and ensure there are no console errors.

If you confirm, I’ll apply these changes directly to:

* [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html)

* [optimized\_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css)

* [optimized\_script.js](file:///d:/Data%20User/Documents/Jihad/Web/optimized_script.js)

