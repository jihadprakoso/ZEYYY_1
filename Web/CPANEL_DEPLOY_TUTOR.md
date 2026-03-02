# Tutorial Deploy ke cPanel (Static Site)

Dokumen ini mengasumsikan website Anda adalah **statis** (HTML/CSS/JS + assets) dan artefak deploy ada di folder [dist](file:///d:/Data%20User/Documents/Jihad/Web/dist).

## 1) Buat Paket Release (direkomendasikan)
Di komputer lokal (project ini), jalankan:

```powershell
powershell -ExecutionPolicy Bypass -File .\make-release.ps1
```

Output ada di:
- `release/<timestamp>/deartbox-dist-<timestamp>.zip`
- `release/<timestamp>/SHA256SUMS.txt`
- `release/<timestamp>/manifest.json`

ZIP ini berisi **isi** `dist/` (bukan folder dist-nya), jadi aman di-extract langsung ke `public_html/`.

## 2) Persiapan di cPanel
- Login cPanel.
- Pastikan domain sudah ter-setup (Primary Domain / Addon Domain / Subdomain).
- Tentukan target folder:
  - Root domain biasanya: `public_html/`
  - Addon domain: sesuai “Document Root” addon domain tersebut (mis. `public_html/nama-domain/`)

## 3) Backup Site Lama (wajib)
Di cPanel → **File Manager**:
- Masuk ke folder target (mis. `public_html/`).
- Buat folder backup, mis. `backup-YYYYMMDD/`.
- Pindahkan file lama (mis. `index.html`, `assets/`, dll) ke folder backup itu.

## 4) Upload & Extract
Di folder target:
- Klik **Upload** → upload `deartbox-dist-<timestamp>.zip`
- Kembali ke File Manager → pilih zip → klik **Extract**

Pastikan file muncul seperti ini (contoh):
- `index.html`
- `optimized_styles.css`
- `optimized_script.js`
- `.htaccess`
- `assets/`
- `robots.txt`, `sitemap.xml`

Jika `.htaccess` tidak terlihat:
- File Manager → **Settings** → centang “Show Hidden Files (dotfiles)” → Save.

## 5) Aktifkan HTTPS (AutoSSL)
Karena `.htaccess` mengarahkan HTTP → HTTPS, pastikan SSL sudah aktif:
- cPanel → **SSL/TLS Status** → jalankan AutoSSL / “Run AutoSSL”.
- Tunggu sampai sertifikat aktif.
- Test:
  - Buka `http://domainanda.com` → harus redirect ke `https://domainanda.com`
  - Buka `https://domainanda.com` → halaman tampil normal

Jika SSL belum siap, nonaktifkan dulu rule redirect HTTPS (nanti saya siapkan varian `.htaccess` non-redirect bila diperlukan).

## 6) Quick Test Setelah Deploy
- Klik menu header (dropdown & non-dropdown) → scroll ke section benar
- Toggle dark mode
- Mobile menu buka/tutup + link bekerja
- RFQ form: validasi jalan, submit membuka WhatsApp
- Back to Top muncul saat scroll dan bisa balik ke atas
- `https://domainanda.com/robots.txt` bisa diakses
- `https://domainanda.com/sitemap.xml` bisa diakses
- `https://domainanda.com/halaman-tidak-ada` menampilkan 404 page

## 7) Troubleshooting Cepat
- CSS/JS tidak berubah (cache): purge cache browser + jika pakai Cloudflare, **Purge Everything**.
- CSS tidak ter-load: pastikan file berada di folder yang sama dengan `index.html` (jangan ada folder `dist/` tersisa).
- 403/500 setelah upload: biasanya `.htaccess` tidak didukung atau ada directive yang diblok; coba rename sementara `.htaccess` untuk isolasi lalu aktifkan lagi bertahap.

