# Tutorial: Setting Database untuk Form RFQ (cPanel + MySQL + PHP)

Repo ini adalah static site, jadi supaya RFQ tersimpan ke database Anda butuh endpoint server-side. Implementasi endpoint PHP sudah disiapkan di:

- [api/rfq.php](file:///d:/Data%20User/Documents/Jihad/Web/api/rfq.php)
- [api/db.php](file:///d:/Data%20User/Documents/Jihad/Web/api/db.php)

## 1) Buat Database di cPanel
1. Buka **cPanel → MySQL® Databases**.
2. Buat database, contoh: `deartbox_rfq`.
3. Buat user, contoh: `deartbox_rfq_user` + password kuat.
4. **Add User To Database** lalu beri privilege **ALL PRIVILEGES**.

Catat:
- DB name lengkap (biasanya ada prefix cPanel, contoh `cpaneluser_deartbox_rfq`)
- Username lengkap
- Password
- Host (umumnya `localhost`)

## 2) Buat Tabel `rfq_requests`
Buka **cPanel → phpMyAdmin**, pilih database yang baru dibuat, lalu jalankan SQL berikut:

```sql
CREATE TABLE rfq_requests (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(120) NOT NULL,
  email VARCHAR(190) NOT NULL,
  whatsapp VARCHAR(20) NOT NULL,
  message TEXT NOT NULL,
  files_json JSON NULL,
  ip VARCHAR(45) NOT NULL,
  user_agent VARCHAR(255) NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  INDEX idx_created_at (created_at),
  INDEX idx_ip_created_at (ip, created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

Catatan:
- `files_json` menyimpan metadata file upload (nama asli, nama tersimpan, mime, size, path).
- Index `idx_ip_created_at` dipakai untuk rate limiting sederhana di endpoint.

## 3) Konfigurasi Kredensial DB di `api/db.php`
Edit file [api/db.php](file:///d:/Data%20User/Documents/Jihad/Web/api/db.php) lalu isi:

- `CHANGE_ME_DB_NAME` → nama database lengkap
- `CHANGE_ME_DB_USER` → username database lengkap
- `CHANGE_ME_DB_PASS` → password database

Jika hosting Anda support environment variables, Anda juga bisa set:
- `RFQ_DB_HOST`
- `RFQ_DB_NAME`
- `RFQ_DB_USER`
- `RFQ_DB_PASS`

## 4) Deploy ke Hosting (public_html)
Deploy standar repo ini sudah ada di [CPANEL_DEPLOY_TUTOR.md](file:///d:/Data%20User/Documents/Jihad/Web/CPANEL_DEPLOY_TUTOR.md).

Yang penting untuk fitur database:
- Pastikan folder `api/` ikut ter-upload ke `public_html/api/`
- Pastikan folder `uploads/` ikut ada di `public_html/uploads/`

Build script sudah diperbarui agar `api/` dan `uploads/` ikut masuk ke `dist/`:
- [build-dist.ps1](file:///d:/Data%20User/Documents/Jihad/Web/build-dist.ps1)

## 5) Cara Test Setelah Deploy
1. Buka website Anda dan submit form RFQ.
2. Cek phpMyAdmin → tabel `rfq_requests` → pastikan ada baris baru.
3. Jika Anda upload file, cek folder `public_html/uploads/rfq/` apakah file tersimpan.

## 6) Perilaku Form Setelah Update
- Frontend akan POST ke `api/rfq.php` terlebih dulu.
- Jika sukses tersimpan, website akan:
  - membuka WhatsApp (seperti sebelumnya), dan
  - menampilkan success modal.
- Jika gagal, akan muncul toast error dan tombol submit aktif kembali.

