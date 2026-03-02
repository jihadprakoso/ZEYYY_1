## Penyebab
Di dark mode ada override khusus yang membuat logo marquee lebih kecil:
- `[data-theme="dark"] .trust-marquee img { height: 31.2px; }` di [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L864-L880)

Sementara light mode sudah pakai `36.4px`, jadi wajar dark terasa jauh lebih kecil.

## Perubahan yang akan saya lakukan
1) **Samakan ukuran dark mode dengan light mode**
- Ubah:
  - Dari: `height: 31.2px;`
  - Menjadi: `height: 36.4px;`
Pada selector `[data-theme="dark"] .trust-marquee img` di [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L864-L880)

2) **(Opsional tapi saya rekomendasikan) Rapikan padding agar logo terlihat lebih “besar” secara visual**
Saat ini logo diberi background putih + padding `6px 10px` (masih oke), tapi kalau setelah disamakan masih terasa kecil, saya akan kecilkan padding jadi `4px 8px` supaya area logo lebih dominan.

## Build & verifikasi
- Build ulang `dist`.
- Pastikan `dist/optimized_styles.css` memuat height baru dan logo marquee di dark mode terlihat setara dengan light mode.