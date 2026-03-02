# Audit Full + Kesiapan Deploy cPanel

Tanggal: 2026-02-04  
Scope: website statis (HTML/CSS/JS) dengan artefak deploy di folder [dist](file:///d:/Data%20User/Documents/Jihad/Web/dist)

## Ringkasan
- Status: **siap deploy ke cPanel (Apache/LiteSpeed)** dengan cara upload **isi folder** `dist/` ke `public_html/`.
- Catatan: konfigurasi HTTPS redirect di `.htaccess` mengasumsikan SSL/AutoSSL sudah aktif.
- Tidak ada dependensi server-side (PHP/DB). Semua fitur berjalan di client-side.

## Struktur Deploy
Artefak deploy ada di:
- [dist/index.html](file:///d:/Data%20User/Documents/Jihad/Web/dist/index.html)
- [dist/optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/dist/optimized_styles.css)
- [dist/optimized_script.js](file:///d:/Data%20User/Documents/Jihad/Web/dist/optimized_script.js)
- [dist/assets/](file:///d:/Data%20User/Documents/Jihad/Web/dist/assets)
- [dist/.htaccess](file:///d:/Data%20User/Documents/Jihad/Web/dist/.htaccess)
- [dist/robots.txt](file:///d:/Data%20User/Documents/Jihad/Web/dist/robots.txt)
- [dist/sitemap.xml](file:///d:/Data%20User/Documents/Jihad/Web/dist/sitemap.xml)
- [dist/404.html](file:///d:/Data%20User/Documents/Jihad/Web/dist/404.html)
- [dist/privacy-policy.html](file:///d:/Data%20User/Documents/Jihad/Web/dist/privacy-policy.html)
- [dist/terms-of-service.html](file:///d:/Data%20User/Documents/Jihad/Web/dist/terms-of-service.html)

## Audit SEO
- Canonical sudah ada: [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L41-L43)
- OpenGraph + Twitter cards ada, termasuk og:image dan og:url.
- Structured data Organization (JSON-LD) ada.
- robots.txt dan sitemap.xml tersedia di dist.

**Catatan SEO penting**
- Domain hardcode ke `https://deartbox.com` (canonical/og/schema). Ini benar untuk produksi di domain tersebut, tapi untuk staging/subdomain sebaiknya diganti sementara.
- Link “Blog & Artikel” masih placeholder `href="#"`: [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L140-L145). Ini bisa menurunkan UX/SEO (dead link).

## Audit UX & A11y
- Skip-to-content ada: [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L95-L97)
- Navigasi dropdown pakai `<details>` dan sudah ada role menu pada item dropdown.
- Tap target mobile: tombol-tombol utama terlihat cukup besar, namun tetap perlu cek manual di device (360–430px).

**Catatan A11y**
- Beberapa link `target="_blank"` tanpa `rel="noopener noreferrer"` (best practice keamanan & performa). Contoh: [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L1206-L1210)

## Audit Performance
- Preload CSS/JS dan hero image sudah ada: [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L49-L54)
- Gambar dominan sudah WebP di `assets/images/...`.
- `.htaccess` sudah mengaktifkan gzip/deflate dan expires caching: [dist/.htaccess](file:///d:/Data%20User/Documents/Jihad/Web/dist/.htaccess#L24-L39)

**Catatan caching**
- CSS/JS memakai nama file tetap (tanpa hash). Cache untuk CSS/JS jangan dibuat terlalu agresif (mis. 1 tahun immutable) agar update tidak “nyangkut”.

## Audit Security
Konfigurasi `.htaccess` saat ini:
- Disable directory listing: `Options -Indexes`
- Security headers dasar: nosniff, frame deny, referrer-policy, permissions-policy
- Block akses file/dir sensitif (backup, .trae, ps1/md/txt) via RedirectMatch
- Force HTTPS via rewrite rule

**Catatan keamanan**
- HTTPS redirect akan membuat site tidak bisa diakses jika SSL belum aktif. Di cPanel, pastikan AutoSSL/HTTPS sudah ready sebelum mengaktifkan paksa HTTPS (atau gunakan mode rule yang lebih aman).

## Rekomendasi Prioritas
P1 (disarankan sebelum go-live):
- Perbaiki link placeholder `href="#"` untuk “Blog & Artikel” (atau nonaktifkan sementara).
- Tambahkan `rel="noopener noreferrer"` untuk semua `target="_blank"`.
- Pastikan aturan HTTPS redirect tidak menyebabkan downtime saat SSL belum ready.

P2 (nice-to-have):
- Tambah proses “release packaging” (zip + checksum) untuk mengunci versi yang di-deploy.

