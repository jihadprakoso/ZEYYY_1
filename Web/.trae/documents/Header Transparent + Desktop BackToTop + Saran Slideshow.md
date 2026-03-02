## 1) Header: “Before” transparan seperti “After”
- **Tujuan**: saat di posisi paling atas (belum scroll), header terlihat transparan (nyatu dengan hero). Saat scroll > 50px, header tetap pakai glassmorphism seperti sekarang.
- **Implementasi** (CSS-only):
  - Ubah rule `header { ... }` agar **default** `background: transparent`, `box-shadow: none`, `border-bottom: transparent`, `backdrop-filter: none`.
  - Pertahankan `header.scrolled { ... }` sebagai state “after” (glassmorphism) dan pastikan `header.scrolled::before` ikut konsisten.
  - Atur `header::before` supaya tidak bikin warna strip tambahan di atas ketika belum scroll.
- File: [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L1152-L1176)

## 2) Desktop-only: tampilkan Back to Top
- **Tujuan**: tombol back-to-top hanya muncul di desktop, dan tidak pernah muncul di tablet/mobile.
- **Implementasi** (CSS-only):
  - Tambahkan rule `@media (max-width: 1024px) { .back-to-top { display: none !important; } }`.
  - Pastikan rule yang ada sekarang (beberapa `display: none` di mobile) tidak bentrok.
- File: [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L3262-L3291)

## 3) Saran desain alternatif untuk slideshow hero (tanpa ubah dulu)
- Saya akan berikan 3–4 opsi desain yang cocok untuk vibe “premium packaging”, masing-masing dengan:
  - konsep visual,
  - elemen UI (caption/progress/thumbs),
  - plus/minus (performa & fokus CTA),
  - tingkat effort implementasi (CSS saja vs butuh sedikit JS).

## Verifikasi setelah implementasi
- Cek desktop: header transparan di top, berubah glass saat scroll, back-to-top muncul setelah scroll (sesuai JS) dan bisa klik scroll-to-top.
- Cek tablet/mobile: back-to-top tidak tampil sama sekali.
- Cek dark/light mode: header tetap readable dan konsisten.