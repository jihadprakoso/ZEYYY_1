## Analisa penyebab
- **Footer “Hubungi Kami”** saat ini memakai inline style berbeda-beda: item Maps `align-items: flex-start` + `svg` pakai `margin-top: 5px`, sementara Telepon/Email `align-items: center`. Ini membuat ikon tidak sejajar konsisten di mobile (lihat [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L1541-L1571)).
- **Inline CTA “Ingin hasil seperti ini untuk brand Anda?”** dan tombol “Portofolio Lainnya” pakai `.btn-inline-*` yang di mobile dibuat `width: 100%`, tetapi tidak ada `justify-content: center`, sehingga isi tombol (ikon+teks/teks saja) jadi rata kiri (lihat [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L983-L1003) dan CSS [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L3733-L3754)).

## Perubahan yang akan saya lakukan
### 1) Footer: ikon + teks sejajar di mobile
- Ubah markup `ul` “Hubungi Kami” menjadi `class="footer-links footer-contact-links"`.
- Hapus inline style pada 3 `li` dan `svg` (display/align/margin-top) agar styling dikontrol CSS.
- Tambah CSS khusus mobile:
  - `.footer-contact-links li { display:flex; align-items:flex-start; gap:8px; }`
  - `.footer-contact-links svg { flex-shrink:0; margin-top:2px; }`
  - `.footer-contact-links a { line-height: 1.4; }`

### 2) Inline CTA & Portofolio: isi tombol center di mobile
- Tambah CSS di media query mobile:
  - `.btn-inline-primary, .btn-inline-secondary { justify-content:center; }`
  - `.btn-inline-primary svg, .btn-inline-secondary svg { display:block; }`
- Ini otomatis memperbaiki:
  - Tombol **Konsultasi Gratis** dan **Minta Penawaran** di block “Ingin hasil seperti ini…”
  - Tombol **Portofolio Lainnya** (karena juga pakai `.btn-inline-secondary`)

## Verifikasi setelah perubahan
- Build ulang dist.
- Cek di mobile viewport: footer contact (maps/telp/email) ikon sejajar dengan teks, dan semua tombol yang diminta sudah center.
