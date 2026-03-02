## Tujuan
Menyederhanakan form RFQ supaya hanya berisi:
- Nama
- Email
- Nomor WhatsApp
- Deskripsi Project
- Referensi Design (Opsional)

## Perubahan yang akan saya lakukan

### 1) Ubah struktur form di HTML
- Hapus field yang bikin ribet:
  - Brand/Perusahaan
  - Industri
  - Tipe Packaging
  - Kuantitas
- Susun ulang layout supaya tetap rapi:
  - Row 1: Nama + Email
  - Lalu: Nomor WhatsApp (full width)
  - Lalu: Deskripsi Project
  - Lalu: Referensi Design (opsional)

### 2) Update validasi & logic form di JavaScript
- Sesuaikan validator attachment:
  - Hapus listener untuk `rfq-industry` dan `rfq-box`
- Sesuaikan required fields saat submit:
  - Wajib: Nama, WhatsApp, Email, Deskripsi Project
  - Opsional: Referensi Design
- Update auto-save localStorage:
  - Simpan hanya `rfq-name`, `whatsapp`, `rfq-email`, `rfq-message`
  - Clear data juga hanya untuk field tersebut
- Update format pesan WhatsApp yang dikirim:
  - Hanya kirim 4 field utama
  - Jika ada file referensi, tambahkan catatan jumlah file + nama file (ringkas)

### 3) (Jika perlu) Rapikan CSS kecil
- Karena select/qty dihapus, umumnya CSS tetap aman.
- Kalau ada spacing yang jadi terlalu renggang/aneh, saya rapikan di rule RFQ saja.

## File yang akan diubah
- [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html)
- [optimized_script.js](file:///d:/Data%20User/Documents/Jihad/Web/optimized_script.js)
- (Opsional) [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css)

## Verifikasi
- Form RFQ tampil simpel dengan 5 item sesuai permintaan.
- Submit membuka WhatsApp dengan pesan yang sudah disederhanakan.
- Upload referensi tetap bisa dipilih/drag-drop, tapi tidak wajib.
- Tidak ada error JS/CSS baru.