## Gambaran Singkat
Website di folder `dist/` saat ini adalah static site (HTML + vanilla JS). Form RFQ sekarang tidak mengirim data ke server/DB; ia hanya membuka WhatsApp (lihat handler submit di [optimized_script.js](file:///d:/Data%20User/Documents/Jihad/Web/dist/optimized_script.js#L1320-L1475)). Supaya data RFQ masuk database, kita butuh **backend endpoint** (mis. PHP di cPanel) yang menerima POST, menyimpan ke MySQL/MariaDB, dan (opsional) menyimpan file upload.

## Opsi Arsitektur (yang paling cocok untuk dist + cPanel)
1. **(Direkomendasikan) cPanel PHP + MySQL**
   - Kelebihan: tidak butuh server terpisah, cocok dengan deploy `public_html` yang sudah ada.
   - Kekurangan: perlu bikin file endpoint `.php` dan konfigurasi DB.
2. **SaaS DB (Supabase/Firebase)**
   - Kelebihan: tanpa backend sendiri.
   - Kekurangan: butuh project eksternal + API key, dan biasanya tetap perlu rules/security yang rapi.

Plan ini mengambil opsi (1) karena repo Anda sudah punya panduan deploy cPanel.

## Perubahan yang Akan Saya Buat di Repo
- Tambah endpoint API berbasis PHP:
  - `dist/api/rfq.php` (terima form + validasi + simpan ke DB + simpan file)
  - `dist/api/db.php` (koneksi PDO)
  - `dist/api/.htaccess` (hardening sederhana: batasi method, no listing)
- Tambah folder upload aman:
  - `dist/uploads/rfq/` + `.htaccess` untuk mencegah eksekusi script
- Update frontend agar benar-benar mengirim ke endpoint:
  - Update handler submit di [optimized_script.js](file:///d:/Data%20User/Documents/Jihad/Web/dist/optimized_script.js#L1320-L1475) dari “simulate + open WA” menjadi:
    1) Buat `FormData` dari field,
    2) Append file dari `uploadedFiles` (karena drag&drop saat ini tidak mengisi `input.files`),
    3) `fetch('/api/rfq.php')`,
    4) Jika sukses: tetap buka WhatsApp + tampilkan success modal, jika gagal: tampilkan error dan re-enable tombol.
- (Opsional tapi kuat) Ubah `name` file input di [index.html](file:///d:/Data%20User/Documents/Jihad/Web/dist/index.html#L1188-L1204) ke `files[]` agar kompatibel dengan PHP saat ada multiple upload.

## Setup cPanel (Langkah Tutorial yang Akan Didokumentasikan)
- **Buat database & user** via “MySQL Databases”:
  - DB: mis. `deartbox_rfq`
  - User: mis. `deartbox_rfq_user`
  - Grant: ALL PRIVILEGES
- **Buat tabel** (akan saya sediakan SQL siap copy-paste), contoh kolom:
  - `id`, `name`, `email`, `whatsapp`, `message`, `files_json`, `created_at`, `ip`, `user_agent`
- **Konfigurasi kredensial** di `dist/api/db.php` (host/db/user/pass) dengan best practice:
  - Tidak logging password
  - PDO prepared statements

## Validasi & Keamanan yang Akan Ditambahkan
- Validasi server-side (wajib): panjang nama, format email, nomor WA, panjang pesan.
- Limit upload (server-side): tipe (jpg/png/webp/pdf) + size max 5MB/file + max jumlah file.
- Rate limit sederhana per IP (mis. max N request/15 menit) via query DB.
- Sanitasi output (DB menerima raw text; UI jangan render HTML dari DB).

## Cara Saya Akan Memverifikasi
- Tes lokal dengan PHP built-in server (untuk memastikan endpoint menerima FormData & file).
- Setelah deploy ke cPanel: lakukan submit RFQ, cek:
  - Row masuk ke DB,
  - File tersimpan di `uploads/rfq/` (jika upload),
  - WhatsApp tetap terbuka dan success modal muncul.

## Deliverable
- Endpoint PHP siap upload bersama isi `dist/`.
- SQL schema tabel.
- Update JS agar RFQ tersimpan ke DB tanpa menghilangkan flow WhatsApp.

Jika Anda setuju, saya lanjut implementasi semua perubahan di atas di repo Anda.