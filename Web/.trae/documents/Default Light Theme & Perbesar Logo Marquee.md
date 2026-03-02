## Ringkasan Kondisi Saat Ini
- Tema default untuk pengunjung baru mengikuti setting sistem: jika device `prefers-color-scheme: dark`, script akan set `data-theme="dark"` sehingga **dark bisa jadi default**. Ini terjadi di [optimized_script.js](file:///d:/Data%20User/Documents/Jihad/Web/optimized_script.js#L829-L877).
- Ukuran logo trust marquee saat ini `height: 28px` (dan di dark mode malah `24px`) di [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L2626-L2632) dan [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L864-L880).

## Perubahan yang Akan Saya Lakukan
### 1) Jadikan Light sebagai Default untuk Pengunjung Baru
- Di [optimized_script.js](file:///d:/Data%20User/Documents/Jihad/Web/optimized_script.js#L829-L877):
  - Tetap hormati preferensi user jika sudah ada `localStorage.getItem('theme')`.
  - Jika **belum ada** preferensi tersimpan, **jangan** lagi auto-set dark berdasarkan `prefers-color-scheme`.
  - Default akan selalu light (cukup dengan tidak men-set `data-theme="dark"`).
  - Sesuaikan juga update `theme-color` meta agar konsisten light saat default.
  - Listener perubahan system theme akan dibuat tidak mengubah tema jika user belum memilih (agar tetap light default).

### 2) Perbesar Trust Marquee 20%
- Di [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L2626-L2632): ubah `.trust-marquee img { height: 28px; }` menjadi **34px**.
- Di override dark mode [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L864-L880): ubah `height: 24px;` menjadi **29px** supaya proporsional saat user memilih dark.

### 3) Build & Verifikasi
- Build ulang `dist`.
- Pastikan:
  - Pengunjung baru selalu melihat light theme.
  - Toggle tetap bekerja dan tersimpan di localStorage.
  - Logo marquee terlihat ~20% lebih besar di desktop & mobile.
  - `dist/optimized_styles.css` dan `dist/optimized_script.js` sudah ter-update.