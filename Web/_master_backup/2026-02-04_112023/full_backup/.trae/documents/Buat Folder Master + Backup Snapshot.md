## Yang akan dibuat
- Folder baru snapshot, misalnya: `d:\Data User\Documents\Jihad\Web\_master_backup\2026-02-04_XXXX` (timestamp otomatis).
- Di dalamnya ada 2 subfolder:
  1) `master_site` = versi “master” yang siap deploy (hanya file yang dipakai website).
  2) `full_backup` = backup lengkap seluruh folder project (snapshot).

## Isi yang akan disalin
- **master_site**
  - `index.html`, `optimized_styles.css`, `optimized_script.js`
  - `assets/`
  - `404.html`, `robots.txt`, `sitemap.xml`
  - `privacy-policy.html`, `terms-of-service.html`
- **full_backup**
  - Copy seluruh isi `Web/` *kecuali* folder snapshot itu sendiri (`_master_backup`) supaya tidak rekursif.
  - Juga mengecualikan folder tooling yang tidak perlu untuk backup website: `.git/` dan `node_modules/` bila ada.

## Catatan info
- Tambah file `MASTER-BACKUP-INFO.md` di folder snapshot berisi tanggal, lokasi, dan daftar yang dibackup.

## Cara eksekusi
- Menggunakan perintah PowerShell untuk membuat folder dan menyalin file/folder secara rekursif dengan pengecualian di atas.

Kalau Anda approve, saya langsung buat folder snapshot + copy semua sesuai struktur ini.