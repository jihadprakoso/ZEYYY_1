## Tujuan
1) Membuat 3 teks microcopy lebih readable di desktop & mobile.
2) Mengubah card **Special-Made Board** menjadi **Material Berkualitas** + copywriting baru.

## Analisa singkat
- `.hero-microcopy`, `.trust-qualifier`, `.testimonials-qualifier` saat ini memakai warna yang terlalu pudar di light mode (contoh `--text-light` = `#BDBDBD`) dan untuk hero variant `g` `rgba(255,255,255,0.62)` (terlalu tipis).
- Card “Special-Made Board” ada di [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L880-L887).

## Perubahan yang akan saya lakukan
### 1) Update warna microcopy (CSS)
Di [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css):
- Naikkan kontras hero microcopy untuk variant `g`:
  - Ubah `html[data-hero-variant="g"]:not([data-theme="dark"]) .hero-microcopy` dari `rgba(255,255,255,0.62)` menjadi `rgba(255,255,255,0.86)`.
- Buat `.trust-qualifier` lebih terbaca:
  - Ubah `color` dari `var(--text-light)` menjadi `var(--text-muted)`.
- Buat `.testimonials-qualifier` lebih terbaca:
  - Ubah `color` dari `var(--text-light)` menjadi `var(--text-muted)`.
- Dark mode: rapikan rule dark mode agar tetap konsisten (tambahkan `.testimonials-qualifier` ke grup dark mode jika perlu).

### 2) Update copywriting card Board (HTML)
Di [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L880-L887) **dan** [html-calendar.html](file:///d:/Data%20User/Documents/Jihad/Web/html-calendar.html#L880-L887) agar konsisten:
- Ubah judul:
  - Dari: `Special-Made Board`
  - Menjadi: `Material Berkualitas`
- Ubah subtitle menjadi copywriting yang menekankan board tebal/kuat, contoh:
  - `Board tebal & rigid, tidak mudah penyok, hasil finishing lebih presisi.`
- Sesuaikan `alt` gambar dan teks WA query (`href`) agar selaras dengan judul baru.

### 3) Build & verifikasi
- Build ulang `dist`.
- Pastikan:
  - `dist/index.html` tidak berubah struktur selain teks.
  - `dist/optimized_styles.css` memuat warna baru.
  - Tampilan lebih kontras di desktop & mobile (light/dark).
