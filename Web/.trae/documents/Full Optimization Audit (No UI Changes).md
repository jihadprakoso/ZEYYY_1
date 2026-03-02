## Scope & Constraints
- Audit + rencana optimasi **tanpa mengubah UI/UX/animasi/desain/warna/copywriting**.
- Perubahan yang diizinkan: pengurangan beban file (CSS/JS/asset), pengurangan kerja runtime (event handler), perbaikan SEO teknis, konfigurasi caching/header, struktur deploy, dan kebersihan repo—dengan output visual tetap sama.

## Snapshot Kondisi Saat Ini (yang sudah bagus)
- SEO sudah kuat: meta OG/Twitter + canonical + structured data Organization: [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L1-L93)
- Performance hints sudah ada: preload logo/hero/CSS/JS + prefetch halaman legal.
- Image loading cukup rapi: banyak `loading="lazy"`, `decoding="async"`, hero LCP pakai `fetchpriority="high"`.
- robots.txt + sitemap.xml tersedia dan valid: [robots.txt](file:///d:/Data%20User/Documents/Jihad/Web/robots.txt), [sitemap.xml](file:///d:/Data%20User/Documents/Jihad/Web/sitemap.xml)

## Temuan Audit (Prioritas Optimasi)
### 1) Risiko Deploy Footprint (High Impact, 0% UI change)
- Folder `_master_backup/` dan banyak file historis (.md/.ps1/backup html) ada di root repo. Kalau hosting kamu “upload semua file”, ini:
  - bikin ukuran deploy membengkak,
  - memperbesar permukaan attack (file audit/skrip bisa kebaca publik),
  - memperberat crawl & indexing walau robots disallow.

### 2) JavaScript Runtime Overhead (High Impact, 0% UI change)
- `optimized_script.js` memasang **banyak** `scroll` listener terpisah (minimal 6 lokasi) dan beberapa melakukan query DOM di handler (contoh footer lookup di sticky CTA): [optimized_script.js](file:///d:/Data%20User/Documents/Jihad/Web/optimized_script.js#L435-L470)
- Ini berpotensi mengganggu INP/scroll smooth di device menengah.
- Optimasi yang aman tanpa mengubah behavior:
  - gabungkan seluruh kebutuhan scroll (back-to-top, active nav, header scrolled, parallax, sticky CTA) ke **satu** loop scroll yang di-throttle via `requestAnimationFrame` + cache elemen DOM.

### 3) JS Inisialisasi “selalu jalan” (Medium-High Impact)
- Banyak fitur jalan walau section-nya tidak ada/ tidak dipakai di page lain: validasi form, predictive preload hover, observer performance, dsb.
- Bisa diubah menjadi **conditional init** (cek elemen ada dulu) + sebagian dipindah ke `requestIdleCallback` agar tidak mengganggu render awal.

### 4) CSS Size & Redundansi (Medium Impact)
- `optimized_styles.css` sangat panjang dan memuat banyak rule legacy/duplikatif (contoh rule untuk `.process-step` yang sekarang sudah tidak dipakai setelah diganti stepper).
- Optimasi aman:
  - hapus selector yang tidak dipakai (dead CSS),
  - rapikan media query yang berulang,
  - (opsional) pisah critical CSS kecil + defer sisanya (tanpa mengubah tampilan).

### 5) HTML/Resource Hints Cleanup (Low-Medium Impact)
- Ada `dns-prefetch` ke Google Tag Manager tapi tidak ada script GTM di halaman: [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L44-L49)
- Ini bisa dibersihkan.

### 6) Asset Strategy (Medium Impact)
- Banyak asset gambar di repo yang tidak dipakai oleh halaman utama.
- Optimasi aman:
  - buat “publishing whitelist” supaya hanya asset yang dipakai yang ikut deploy,
  - (opsional) generate `srcset` untuk gambar besar (visual sama, ukuran transfer lebih kecil di mobile).

## Rencana Implementasi (Jika kamu setuju)
### A) Buat Deploy-Safe Output (tanpa ubah UI)
- Tambah konfigurasi untuk memastikan file backup/skrip/audit **tidak ikut terdeploy**.
  - Opsi Netlify: buat `netlify.toml` + publish folder.
  - Opsi Apache: `.htaccess` + folder `public/`.
  - Opsi generic: struktur `public/` hanya berisi file yang dibutuhkan (index.html, optimized_styles.css, optimized_script.js, assets yang terpakai).

### B) Optimasi JS Tanpa Ubah Perilaku
- Refactor `optimized_script.js`:
  - satukan semua scroll handler jadi 1 rAF loop,
  - cache DOM yang sering diakses (footer/header/backToTop/navLinks),
  - ubah `setInterval` animasi angka ke `requestAnimationFrame` (hasil sama),
  - gunakan event delegation untuk hover handler anchor (mengurangi jumlah listener).

### C) Optimasi CSS Tanpa Ubah Tampilan
- Audit pemakaian selector dan hapus dead CSS (mis. `.process-step`, `.process-steps` dan rule lama yang tidak terpakai).
- Rapikan duplikasi hover/media-query jika identik.
- (Opsional) bikin versi minified untuk produksi (tetap sama tampilannya).

### D) Resource Hint & SEO Teknis
- Bersihkan hint yang tidak dipakai (mis. GTM dns-prefetch).
- (Opsional) tambah OG image dimension tags untuk preview yang lebih stabil.

## Verifikasi (wajib, supaya UI 100% sama)
- Visual check: desktop/tablet/mobile + dark mode.
- Behavior check: hero slideshow, sticky CTA, back-to-top, dropdown menu, form RFQ, FAQ.
- Performance check: Lighthouse (Performance/INP), dan cek network payload CSS/JS.

Kalau OK, saya lanjutkan eksekusi sesuai rencana di atas (tanpa mengubah tampilan sama sekali).