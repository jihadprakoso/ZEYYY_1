## Audit Full (yang akan saya cek dan laporkan)
- **Struktur deploy statis**: pastikan `dist/` sudah berisi semua kebutuhan (HTML/CSS/JS/assets/robots/sitemap/404/.htaccess).
- **SEO**: title/description, canonical, OG/Twitter, schema.org JSON-LD, robots.txt, sitemap.xml, internal link (termasuk link placeholder seperti “Blog & Artikel”).
- **UX/A11y**: skip-to-content, fokus keyboard, aria-label, kontras, ukuran tap target mobile, tab order.
- **Performance**: preload/preconnect, ukuran gambar (WebP), caching policy, render-blocking, potensi CLS.
- **Security**: hardening `.htaccess` (headers, directory listing, deny file sensitif), validasi form/DOM injection risk, dan pola external link.

## Lock Code (release siap deploy)
- Buat **paket release yang “terkunci”**: hanya berisi isi `dist/` (tanpa `_master_backup/`, `.trae/`, file `.ps1`, `.md`, dll.).
- Tambahkan **manifest verifikasi** (checksum SHA256) untuk memastikan file yang di-upload ke cPanel sama persis.
- Buat **ZIP release** (mis. `release/deartbox-dist-YYYYMMDD-HHMM.zip`) agar upload ke cPanel tinggal upload + extract.
- Review & finalisasi `.htaccess` untuk produksi:
  - Tetap **aman untuk update** (cache CSS/JS tidak “nyangkut” karena file tidak memakai hash).
  - Pastikan **redirect HTTPS** tidak bikin masalah kalau SSL belum aktif (akan saya buat mode aman: bisa diaktifkan setelah AutoSSL OK).

## Tutor Deploy ke cPanel (step-by-step)
- Panduan deploy via **File Manager** dan alternatif **FTP**.
- Cara setup **Domain/Add-on Domain/Subdomain** dan menentukan **Document Root**.
- Cara upload ZIP, extract, pastikan `.htaccess` ikut terpasang.
- Checklist setelah deploy:
  - HTTPS/AutoSSL aktif
  - robots.txt & sitemap.xml dapat diakses
  - 404 page jalan
  - tes cepat: menu, form WA, dark mode, mobile menu, back-to-top

## Output yang akan saya deliver setelah plan disetujui
- 1 file laporan audit (Markdown) + daftar temuan dan prioritas.
- 1 paket release ZIP + checksum.
- 1 dokumen tutorial deploy cPanel yang sesuai struktur `dist/`.
