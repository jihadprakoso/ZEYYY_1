## Status
- **Siap deploy ke cPanel (static hosting)** jika Anda upload **isi folder** [dist](file:///d:/Data%20User/Documents/Jihad/Web/dist) ke `public_html/`.
- Ada beberapa **catatan penting** (security/performa/UX) yang sebaiknya dibereskan sebelum produksi penuh, tapi tidak menghalangi halaman tampil.

## Paket Deploy yang Sudah OK
- `dist/` sudah berisi semua file yang dibutuhkan untuk website statis:
  - [dist/index.html](file:///d:/Data%20User/Documents/Jihad/Web/dist/index.html)
  - [dist/optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/dist/optimized_styles.css)
  - [dist/optimized_script.js](file:///d:/Data%20User/Documents/Jihad/Web/dist/optimized_script.js)
  - [dist/assets/](file:///d:/Data%20User/Documents/Jihad/Web/dist/assets)
  - [dist/privacy-policy.html](file:///d:/Data%20User/Documents/Jihad/Web/dist/privacy-policy.html)
  - [dist/terms-of-service.html](file:///d:/Data%20User/Documents/Jihad/Web/dist/terms-of-service.html)
  - [dist/robots.txt](file:///d:/Data%20User/Documents/Jihad/Web/dist/robots.txt)
  - [dist/sitemap.xml](file:///d:/Data%20User/Documents/Jihad/Web/dist/sitemap.xml)
  - [dist/404.html](file:///d:/Data%20User/Documents/Jihad/Web/dist/404.html)

## Checklist Deploy di cPanel (Manual)
- Upload **isi `dist/`** langsung ke `public_html/` (bukan folder `dist`-nya).
- Pastikan AutoSSL aktif, lalu set redirect HTTP→HTTPS (via cPanel atau `.htaccess`).
- Pastikan `robots.txt` & `sitemap.xml` bisa diakses dari browser.

## Isu Penting (Sebaiknya Dibenerin sebelum produksi)
- **`.htaccess` belum ikut di `dist/`**:
  - Saat deploy dari `dist/`, file proteksi seperti di root [.htaccess](file:///d:/Data%20User/Documents/Jihad/Web/.htaccess) tidak ikut. Jika butuh 404 custom/caching/security headers, perlu `.htaccess` di `public_html/`.
- **DOM XSS risk di preview upload file**:
  - `file.name` dimasukkan via `innerHTML` di [optimized_script.js:L926-L973](file:///d:/Data%20User/Documents/Jihad/Web/dist/optimized_script.js#L926-L973). Ini bisa jadi injeksi HTML/DOM (meski input dari nama file lokal, tetap praktik unsafe).
- **Encoding rusak untuk tombol hapus**:
  - Remove button berisi `Ã—` di [optimized_script.js:L957-L963](file:///d:/Data%20User/Documents/Jihad/Web/dist/optimized_script.js#L957-L963).
- **Global error handler menelan error**:
  - `window.addEventListener('error', ...) return true;` di [optimized_script.js:L50-L55](file:///d:/Data%20User/Documents/Jihad/Web/dist/optimized_script.js#L50-L55) bisa menyembunyikan error penting di produksi.

## Catatan Deploy yang Sering Menjebak
- **Cache headers**: file CSS/JS tidak pakai nama hash (mis. `optimized_styles.css`), jadi jangan set cache 1 tahun “immutable” untuk CSS/JS kecuali Anda siap pakai versioning/querystring. Kalau tidak, user bisa “nyangkut” di versi lama.
- **404 page**: `dist/404.html` menggunakan link `/` (root). Ini OK kalau website ditempatkan di root domain; kalau dipasang di subfolder, linknya perlu disesuaikan.
- **SEO domain hardcode**: canonical/OG/schema/robots sitemap mengarah ke `https://deartbox.com` (OK untuk production domain itu; kurang cocok untuk staging/subdomain).

## Output yang Bisa Saya Kerjakan Setelah Audit (Jika Anda minta)
- Buat `.htaccess` produksi untuk cPanel: 404 custom, gzip, cache aman (tanpa bikin update nyangkut), dan security headers.
- Fix DOM XSS + encoding `×` tanpa ubah UI.
- Rapikan dead link “Blog & Artikel” kalau sudah ada URL.

(Ini audit-only; saya tidak menjalankan deploy atau perubahan sistem.)