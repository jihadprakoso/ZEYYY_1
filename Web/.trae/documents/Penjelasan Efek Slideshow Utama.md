## Jawaban singkat
Bisa. Bayangan di foto tengah slideshow itu berasal dari `box-shadow` pada container slideshow, bukan dari gambarnya.

- Sumbernya: `.hero-slideshow-container { box-shadow: var(--hero-slideshow-shadow); }` di [optimized_styles.css:L2030-L2041](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L2030-L2041)

## Rencana perubahan
1. **Hilangkan shadow foto tengah slideshow**
   - Ubah `box-shadow` di `.hero-slideshow-container` menjadi `none` (shadow benar-benar hilang, border tetap ada).

2. **Opsional (kalau yang kamu maksud juga termasuk bayangan preview kiri/kanan)**
   - Ghost preview (kiri/kanan) juga punya efek depth (blur/rotate + beberapa `box-shadow`). Kalau kamu mau clean tanpa bayangan sama sekali, saya akan set `box-shadow: none` untuk `.hero-ghost` juga.
   - Lokasi efek ghost: [optimized_styles.css:L2193-L2291](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L2193-L2291)

## Verifikasi
- Di desktop, area foto utama slideshow tidak punya bayangan.
- Border dan radius tetap rapi.
- Tidak ada perubahan ke animasi/pergantian slide.