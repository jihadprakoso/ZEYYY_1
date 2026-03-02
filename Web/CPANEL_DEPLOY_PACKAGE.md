# Deploy cPanel (ZIP Ready)

File paket deploy yang siap upload:
- `cpanel-deploy.zip`

Generator paket (auto build + zip):
- [deploy-cpanel.ps1](file:///d:/Data%20User/Documents/Jihad/Web/deploy-cpanel.ps1)

## Cara Generate ZIP di Lokal
Jalankan:

```powershell
powershell -ExecutionPolicy Bypass -File .\deploy-cpanel.ps1
```

Output:
- `dist/` (hasil build)
- `cpanel-deploy.zip` (isi `dist/*` dibungkus zip)

## Cara Upload ke cPanel
1. Buka **cPanel → File Manager**.
2. Masuk ke folder `public_html/`.
3. Upload `cpanel-deploy.zip`.
4. Extract ZIP di `public_html/` (pastikan file seperti `index.html`, `assets/`, `api/`, `uploads/` berada langsung di `public_html/`).

## Catatan Penting RFQ (Database)
Jika Anda memakai fitur simpan RFQ ke database:
- Endpoint ada di `public_html/api/rfq.php`
- Konfigurasi DB ada di `public_html/api/db.php` (isi kredensial DB Anda)
- Struktur tabel dan langkah setup DB ada di: [RFQ_DATABASE_TUTORIAL.md](file:///d:/Data%20User/Documents/Jihad/Web/RFQ_DATABASE_TUTORIAL.md)

Folder upload untuk lampiran RFQ:
- `public_html/uploads/rfq/` (sudah ada `.htaccess` untuk keamanan dasar)

## Troubleshooting Singkat
- Jika upload/POST ke `api/rfq.php` gagal: pastikan hosting support PHP + PDO MySQL dan `file_uploads` aktif.
- Jika website redirect loop HTTPS: pastikan SSL aktif di domain dan konfigurasi proxy/Cloudflare sesuai.

