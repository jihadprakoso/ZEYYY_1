## Kondisi Saat Ini
- Ukuran trust marquee saat ini sudah +20%:
  - Light/default: `.trust-marquee img { height: 34px; }` (dari 28px) di [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L2626-L2632)
  - Dark override: `[data-theme="dark"] .trust-marquee img { height: 29px; }` (dari 24px) di [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L878-L880)

## Perubahan yang Akan Saya Lakukan (jadi +30%)
Agar benar-benar 30% (bukan pembulatan), saya akan pakai nilai desimal:
- Light/default: 28px × 1.3 = **36.4px**
- Dark override: 24px × 1.3 = **31.2px**

File yang diubah:
1) [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css)
   - Ubah `.trust-marquee img` height dari `34px` → `36.4px`
   - Ubah `[data-theme="dark"] .trust-marquee img` height dari `29px` → `31.2px`

## Build & Verifikasi
- Build ulang `dist`.
- Pastikan `dist/optimized_styles.css` memuat height baru dan logo marquee tampak lebih besar di desktop & mobile.