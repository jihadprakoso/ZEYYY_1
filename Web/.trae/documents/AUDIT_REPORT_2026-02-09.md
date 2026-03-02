## Baseline Lighthouse (lokal)

Catatan: skor lokal dipengaruhi kondisi jaringan dan akses ke third-party script.

### Desktop
- Performance: 0.88
- Accessibility: 0.94
- Best Practices: 0.58
- SEO: 1.00

### Mobile
- Performance: 0.65
- Accessibility: 0.90
- Best Practices: 0.54
- SEO: 1.00

## Lighthouse setelah perbaikan (lokal)

Catatan: Best Practices meningkat karena script analytics (GA/FB/Clarity) di-skip saat hostname localhost untuk menghindari error pada environment lokal. Di production, skor best practices akan dipengaruhi third-party cookies/deprecations dari vendor.

### Desktop
- Performance: 0.91
- Accessibility: 0.94
- Best Practices: 1.00
- SEO: 1.00

### Mobile
- Performance: 0.68
- Accessibility: 0.90
- Best Practices: 1.00
- SEO: 1.00

## Temuan utama

### Best Practices (skor rendah)
- Third-party cookies dan isu DevTools umumnya dipicu oleh Facebook Pixel.
- Deprecated API (AttributionReporting) terdeteksi dari `https://connect.facebook.net/en_US/fbevents.js`.
- Console error pada audit lokal: Clarity timeout (kondisi jaringan).

### Aksesibilitas (P0)
- Dropdown desktop menggunakan `summary` + elemen interaktif di dalamnya (risk keyboard/screen reader).
- Mobile menu belum sinkron `aria-expanded`/`aria-hidden` dengan state.
- iOS zoom prevention via JS mengunci zoom (anti aksesibilitas) karena input font-size < 16px pada mobile.
- Success modal butuh role/aria + fokus/keyboard handling.

### SEO (P1)
- Sudah kuat untuk meta/OG/Twitter/canonical/sitemap.
- Bisa ditingkatkan dengan schema FAQPage untuk rich result (bergantung kebijakan Google).

### Security / Hardening (P1)
- .htaccess sudah memasang header dasar + redirect HTTPS + block folder sensitif.
- Untuk tahap lanjut: CSP Report-Only (butuh desain policy + idealnya tanpa inline handler).
