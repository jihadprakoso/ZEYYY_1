## Penyebab (kenapa masih terlihat center)
- Di CSS ada **rule duplikat** untuk footer yang saling override.
- Ada rule yang membuat kolom terakhir (Metode Pembayaran) punya `margin-left` **unconditional** sehingga saat mobile `.footer-grid` jadi 1 kolom, kolom terakhir terdorong ke kanan dan terlihat seperti “center”. [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L5684-L5700)
- Ada juga media query mobile lain yang meng-override `.footer-payment-grid` kembali ke `repeat(3, 1fr)`, sehingga kontrol align-left yang sudah dibuat sebelumnya tidak kepakai. [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L5831-L5862)

## Target
- Di mobile (≤767px), section **Metode Pembayaran** harus rata kiri dan sejajar seperti section **Hubungi Kami**.

## Rencana Perubahan
1. **Batasi margin-left kolom terakhir hanya untuk desktop**
   - Ubah rule `.footer-grid .footer-column:last-child { margin-left: ... }` yang sekarang berlaku global agar hanya aktif di viewport besar (mis. `@media (min-width: 768px)` atau `@media (min-width: 900px)`).
   - Pastikan di mobile ada override eksplisit: `margin-left: 0`.

2. **Kunci align-left untuk Metode Pembayaran di mobile**
   - Di `@media (max-width: 767px)` tambahkan/rapikan rule:
     - `.footer-grid .footer-column:last-child { margin-left: 0; text-align: left; }`
     - `.footer-payment-grid { grid-template-columns: repeat(3, max-content); justify-content: start; justify-items: start; }`
   - Ini bikin judul h4 dan grid logo mulai dari kiri (tidak center).

3. **Hapus/ubah rule duplikat yang meng-override**
   - Di blok “Responsive” bawah file, ubah `grid-template-columns: repeat(3, 1fr)` menjadi versi align-left (max-content + start) agar tidak menimpa.

4. **Samakan di dist**
   - Terapkan perubahan yang sama ke `dist/optimized_styles.css` supaya hasil deploy sama.

## Verifikasi
- Cek mobile 320–767px: posisi “Metode Pembayaran” sejajar kiri seperti “Hubungi Kami”, dan logo payment mulai dari kiri.
- Pastikan tidak ada error diagnostics.

## File yang akan disentuh
- [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css)
- [dist/optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/dist/optimized_styles.css)