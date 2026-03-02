## Gambaran Kondisi Saat Ini
- Proyek ini situs statis (tanpa bundler). Output `dist/` dibuat dengan menyalin file tertentu lewat [build-dist.ps1](file:///d:/Data%20User/Documents/Jihad/Web/build-dist.ps1).
- Banyak optimasi sudah ada: preload CSS/JS/hero image, `defer` untuk JS, lazy-load via `IntersectionObserver`, caching + kompresi di [.htaccess](file:///d:/Data%20User/Documents/Jihad/Web/.htaccess), SEO meta + OG/Twitter + canonical + schema di [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html).

## Target Hasil
- Performa lebih cepat (LCP/CLS/INP lebih baik), SEO on-page lebih kuat, mobile usability lebih rapi.
- Analytics lengkap: GA4 sudah ada, ditambah integrasi Search Console (verifikasi) tanpa mempengaruhi dev/local.
- Semua perubahan ikut ter-export ke folder [dist/](file:///d:/Data%20User/Documents/Jihad/Web/dist) via pembaruan build script bila diperlukan.

## 1) Audit Cepat (Baseline)
- Cek HTML head: resource hints, render-blocking (font), canonical consistency, structured data.
- Cek gambar above-the-fold: atribut `width/height`, `fetchpriority`, format (WebP), lazy-load untuk offscreen.
- Cek server header/caching: `Expires`, `Cache-Control`, kompresi (gzip/brotli bila tersedia), `Vary`.

## 2) Optimasi Kecepatan Halaman
- **Fonts**
  - Opsi A (paling aman): tetap Google Fonts, tetapi ubah loading agar lebih non-blocking (preload stylesheet + swap) tanpa merusak tampilan.
  - Opsi B (paling kencang/terkontrol): self-host font (WOFF2) di `assets/fonts/`, update CSS `@font-face`, dan tambahkan caching kuat.
- **CSS/JS**
  - Pastikan `preload` tidak redundant dan urutannya ideal (preload → stylesheet/script dengan `defer`).
  - Tambahkan `fetchpriority`/`decoding` pada elemen gambar hero bila belum konsisten di seluruh halaman.
- **Caching & Kompresi (.htaccess)**
  - Tambahkan `Cache-Control` untuk CSS/JS/images (misalnya `public, max-age=...`).
  - Tambahkan `Vary: Accept-Encoding`.
  - Tambahkan dukungan brotli bila modul tersedia (fallback tetap gzip).

## 3) Peningkatan SEO On-Page
- **Canonical & konsistensi URL**: samakan canonical homepage jadi `https://deartbox.com/` dan pastikan halaman legal punya canonical masing-masing.
- **Meta penting**: pastikan title/description unik untuk halaman legal/404, dan OG/Twitter meta minimal pada halaman penting.
- **Structured data**: rapikan/validasi schema (Organization + FAQ sudah ada) dan tambahkan `WebSite` bila relevan.
- **Sitemap**: update `lastmod` saat deploy/build (atau set strategi update manual yang konsisten).

## 4) Responsive & Mobile Usability
- Review breakpoint utama dan komponen rawan (nav, menu mobile, tombol CTA, form RFQ).
- Perbaiki isu umum mobile:
  - Tap target minimal, spacing, `100dvh` untuk menu, safe-area iOS.
  - Aksesibilitas menu: `aria-expanded`, fokus/scroll locking (bila perlu) supaya tidak “loncat”.

## 5) Integrasi Tracker & Analytics (GA4 + Search Console)
- **GA4**: pertahankan pola saat ini (aktif hanya di host production). Tambahkan event tambahan jika diperlukan (mis. outbound click selain WhatsApp) tanpa menambah beban besar.
- **Search Console**:
  - Tambahkan placeholder `<meta name="google-site-verification" content="...">` di semua halaman publish (index + legal + 404).
  - Siapkan opsi alternatif: file verifikasi HTML (akan ditambahkan ke daftar copy di build script bila dipakai).

## 6) Export ke dist
- Update [build-dist.ps1](file:///d:/Data%20User/Documents/Jihad/Web/build-dist.ps1) agar menyalin file baru (mis. `site.webmanifest`, icon, atau file verifikasi GSC) jika ditambahkan.
- Jalankan build untuk memastikan `dist/` berisi versi terbaru dari semua perubahan.

## File yang Akan Tersentuh
- [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html)
- [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css) (jika self-host fonts/adjust responsive)
- [optimized_script.js](file:///d:/Data%20User/Documents/Jihad/Web/optimized_script.js) (jika perlu event tracking tambahan / UX menu)
- [.htaccess](file:///d:/Data%20User/Documents/Jihad/Web/.htaccess)
- Halaman pendukung: [privacy-policy.html](file:///d:/Data%20User/Documents/Jihad/Web/privacy-policy.html), [terms-of-service.html](file:///d:/Data%20User/Documents/Jihad/Web/terms-of-service.html), [404.html](file:///d:/Data%20User/Documents/Jihad/Web/404.html)
- [build-dist.ps1](file:///d:/Data%20User/Documents/Jihad/Web/build-dist.ps1) (agar output `dist/` ikut lengkap)

## Verifikasi Setelah Implementasi
- Validasi struktur HTML + schema (cek error/duplikasi).
- Cek load order (CSS/JS/fonts) dan pastikan tidak ada regresi tampilan.
- Pastikan `dist/` berisi file terbaru dan halaman tetap bisa berjalan normal.
- Smoke-test event GA4 (whatsapp_click) dan kesiapan verifikasi Search Console.