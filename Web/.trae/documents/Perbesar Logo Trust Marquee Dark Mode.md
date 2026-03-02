## Penyebab
Di dark mode, logo trust marquee terasa lebih kecil karena:
- Ada styling khusus dark mode yang memberi **background putih + padding** pada logo (membuat area logo terlihat “mengecil”), di [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L864-L871).
- Tinggi logo dark mode saat ini masih mengikuti override (sekarang 36.4px).

## Perubahan yang akan saya lakukan
1) **Naikkan tinggi logo khusus dark mode**
- Ubah `[data-theme="dark"] .trust-marquee img`:
  - Dari: `height: 36.4px;`
  - Menjadi: **`height: 44px;`** (lebih besar dan lebih “nendang” di dark mode)
Lokasi: [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L878-L880)

2) **Kecilkan padding background agar logo makin dominan (rekomendasi)**
- Ubah padding pada `[data-theme="dark"] .trust-marquee img, [data-theme="dark"] .trust-logo img`:
  - Dari: `padding: 6px 10px;`
  - Menjadi: **`padding: 4px 8px;`**
Lokasi: [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L864-L871)

## Build & verifikasi
- Build ulang `dist`.
- Pastikan `dist/optimized_styles.css` berisi height/padding baru, dan di dark mode logo marquee terlihat lebih besar dari light mode sesuai permintaan.