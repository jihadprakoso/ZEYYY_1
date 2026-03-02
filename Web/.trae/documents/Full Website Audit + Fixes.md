## Ringkasan Audit (temuan awal dari codebase)

### SEO (cukup kuat)
- Sudah ada: title+description, canonical, OG/Twitter, robots, sitemap, JSON-LD Organization. [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L1-L92) [robots.txt](file:///d:/Data%20User/Documents/Jihad/Web/robots.txt) [sitemap.xml](file:///d:/Data%20User/Documents/Jihad/Web/sitemap.xml)
- Catatan perbaikan: tambah schema FAQPage (karena FAQ ada), tambah meta OG image dimension/alt, rapikan konsistensi copy meta Twitter vs OG.

### Aksesibilitas (ada baseline bagus, tapi ada blocker)
- Sudah ada: skip link, aria-label pada nav, alt pada gambar penting. [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L180-L215)
- Isu utama:
  - `<summary>` berisi `<a>` (nested interactive element) berpotensi bikin masalah keyboard/screen reader & perilaku klik. [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L219-L236)
  - Tombol menu mobile belum punya `aria-expanded`/`aria-controls` dan belum ada pengelolaan fokus saat drawer terbuka. [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L240-L349)
  - Modal sukses RFQ perlu aria role/label/focus management (di JS ada `.show`, tapi perlu audit markup modalnya). [optimized_script.js](file:///d:/Data%20User/Documents/Jihad/Web/optimized_script.js#L1210-L1316)

### Performance
- Sudah ada preload CSS/JS, preload hero image, lazy loading untuk gambar lain, gzip/expire headers di .htaccess. [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L48-L61) [.htaccess](file:///d:/Data%20User/Documents/Jihad/Web/.htaccess)
- Potensi perbaikan: evaluasi beban third-party (GA/FB/Clarity), optimasi font loading, cek ukuran `optimized_styles.css`/`optimized_script.js`, dan set strategi caching HTML vs asset.

### Security / Hardening
- Sudah ada: HTTPS redirect, HSTS (hanya saat HTTPS), nosniff, frame deny, referrer policy, permissions policy, blok akses folder backup/markdown/ps1 via .htaccess. [.htaccess](file:///d:/Data%20User/Documents/Jihad/Web/.htaccess)
- Potensi perbaikan: tambah CSP (mulai dari Report-Only), pertimbangkan COOP/COEP (kalau cocok), rapikan HSTS agar konsisten.
- Risiko operasional: backup & dokumen masih berada di web root; walau diblok via .htaccess, best practice tetap pisahkan dari folder deploy.

## Rencana Audit “Full” (yang akan dikerjakan setelah kamu keluar dari plan mode)

### 1) Audit otomatis (baseline angka)
- Jalankan Lighthouse (Mobile + Desktop) untuk: Performance, Accessibility, Best Practices, SEO.
- Cek Core Web Vitals proxy (LCP/CLS/INP) dari hasil Lighthouse + rekomendasi.
- Validasi HTML (W3C) dan structured data (Schema).

### 2) Audit manual terstruktur
- **UX & Conversion**: konsistensi CTA, alur RFQ → WhatsApp, friction point.
- **A11y**: keyboard nav (tab order), focus states, dropdown/menu, modal, form errors.
- **SEO on-page**: heading hierarchy, internal anchor nav, metadata konsistensi, sitemap coverage.
- **Performance**: gambar (sizes/priority), CSS/JS critical path, font loading, third-party script strategy.
- **Security**: header policy (CSP), exposure file/folder, link rel noopener, HTTPS.

### 3) Implementasi perbaikan prioritas (P0/P1)
- P0 A11y: perbaiki dropdown `<summary>` (hapus anchor di dalamnya) + proper ARIA.
- P0 A11y: mobile menu `aria-expanded`/`aria-controls`, ESC to close, focus trap, restore focus.
- P0 Modal/form: tambahkan role/aria + error announcement.
- P1 SEO: tambah FAQPage JSON-LD + perbaiki OG/Twitter detail.
- P1 Perf: optimasi third-party + font loading + audit ukuran CSS/JS.
- P1 Security: CSP Report-Only + hardening tambahan yang aman.

### 4) Regression check
- Tes responsif (320/360/390/768 + landscape), cek dark mode, cek iOS Safari quirks.
- Re-run Lighthouse untuk memastikan ada peningkatan dan tidak ada regress.

## Output yang kamu dapat
- Laporan audit ringkas (P0/P1/P2) + rekomendasi teknis.
- Patch perbaikan pada file utama (index.html, optimized_script.js, optimized_styles.css, .htaccess, sitemap/robots bila perlu).
- Hasil Lighthouse before/after (angka + catatan).

## File yang akan disentuh (jika diperlukan)
- [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html)
- [optimized_script.js](file:///d:/Data%20User/Documents/Jihad/Web/optimized_script.js)
- [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css)
- [.htaccess](file:///d:/Data%20User/Documents/Jihad/Web/.htaccess)
- [robots.txt](file:///d:/Data%20User/Documents/Jihad/Web/robots.txt) / [sitemap.xml](file:///d:/Data%20User/Documents/Jihad/Web/sitemap.xml)