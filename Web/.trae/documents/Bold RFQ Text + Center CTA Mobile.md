## Tujuan
- “Lebih suka berbicara langsung?” jadi **bold**.
- Di mobile, tombol “Konsultasi Gratis” pada section `container fade-up` teksnya **center** (tidak rata kiri saat tombol full width).
- Di mobile, section footer **Metode Pembayaran** dibuat **align left**.

## Temuan
- “Lebih suka berbicara langsung?” adalah `p.form-note form-note-center` di `.rfq-contact-quick`. [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L989-L992)
- Di mobile, `.btn-cta-wa` dibuat `width: 100%` pada media query, tetapi karena `inline-flex` tanpa `justify-content`, label tombol bisa terlihat rata kiri. [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L4459-L4463)
- “Metode Pembayaran” di footer memakai `.footer-payment-grid` (grid 3 kolom di mobile). [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L1356-L1363) dan [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L5369-L5379)

## Rencana Perubahan
1. **Bold RFQ quick-contact text**
   - Tambah rule: `.rfq-contact-quick p.form-note { font-weight: 700; }`
   - Tidak mengubah rule warna light/dark yang sudah ada.

2. **Mobile center untuk tombol “Konsultasi Gratis”**
   - Di media query mobile yang mengatur `.btn-cta-wa { width: 100%; ... }`, tambahkan:
     - `.btn-cta-wa { justify-content: center; }`
   - Efeknya: saat tombol full width di mobile, teksnya tetap berada di tengah.

3. **Mobile align-left untuk “Metode Pembayaran”**
   - Di `@media (max-width: 767px)`, ubah layout `.footer-payment-grid` agar “nempel kiri”:
     - `grid-template-columns: repeat(3, max-content);`
     - `justify-content: start;`
     - (opsional) tweak `gap` agar tetap rapi.
   - Hilangkan margin kiri khusus kolom terakhir pada mobile bila mengganggu: `.footer-grid .footer-column:last-child { margin-left: 0; }`

4. **Samakan versi dist (jika dipakai deploy)**
   - Terapkan perubahan CSS yang sama pada `dist/optimized_styles.css`.

## Verifikasi
- Cek tampilan mobile (320–767px):
  - “Lebih suka berbicara langsung?” tebal.
  - Tombol “Konsultasi Gratis” teks centered.
  - Logo “Metode Pembayaran” mulai dari kiri dan tidak terlihat center.
- Pastikan diagnostics/console tidak ada error baru.

## File yang akan disentuh
- [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css)
- (Jika deploy pakai dist) [dist/optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/dist/optimized_styles.css)