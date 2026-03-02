## Temuan Utama (Kenapa Terasa Jauh)
- Jarak paling besar berasal dari padding section dan hero.
- Di versi deploy `dist/`, ada beberapa nilai besar:
  - `.hero-modern` punya padding vertikal `clamp(80px…140px)` (atas) dan `clamp(60px…100px)` (bawah) → ini sumber “blank space” paling terasa. [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/dist/optimized_styles.css#L1726-L1731)
  - `.hero-container` gap `clamp(32px…64px)` → jarak antar blok hero (judul–slideshow–cta) cukup renggang. [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/dist/optimized_styles.css#L1756-L1766)
  - Banyak `margin-top: 48px` / `margin-bottom: 40px` (FAQ list, grid, inline CTA, dll) yang bikin antar blok terasa “lompat”.
- Di versi root (non-dist) ada sistem `--section-pad: 120px` / mobile `80px` yang juga cenderung besar untuk halaman sales landing. [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L354-L392)

## Target Spacing (Agar Rapi tapi Tidak Padat)
- Turunkan jarak vertikal global sekitar 15–30%.
- Konsistenkan pola:
  - Section padding: turun 120→96 (desktop), 80→64 (mobile) atau pakai clamp yang lebih kecil.
  - Header section (judul + subtitle): margin-bottom turun (mis. 64 max → 48 max).
  - Grid/list: margin-top 48→32, gap besar → sedikit diperkecil.
  - Inline CTA: padding/margin-top 48→32.

## Perubahan yang Akan Saya Lakukan
1. Audit semua spacing besar di:
   - [dist/optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/dist/optimized_styles.css)
   - [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css)
   Fokus ke `padding: clamp(...)`, `margin-top/bottom: 40–60px`, dan `gap` yang terlalu besar.
2. Terapkan penyesuaian angka yang konsisten (contoh konkret):
   - `.hero-modern` padding diturunkan (mis. `clamp(64px, 10vw, 112px)` atas dan `clamp(48px, 8vw, 80px)` bawah).
   - `.hero-container` gap diturunkan (mis. `clamp(24px, 4vw, 48px)`).
   - Semua `margin-top: 48px` yang bersifat pemisah blok → jadi `32px`.
   - Semua `margin-bottom: 40px` yang berperan pemisah header/section → jadi `28–32px`.
   - Untuk versi root: turunkan `--section-pad` dan `--grid-gap` agar antar section dan antar card lebih rapat.
3. Sinkronkan perubahan antara root dan `dist/` supaya hasilnya sama saat kamu upload ke cPanel.

## Verifikasi
- Jalankan preview lokal dan cek:
  - Desktop + mobile (viewport sempit) untuk memastikan tidak terlalu padat.
  - Tidak ada section yang “ketiban” header sticky.
  - CTA, form, FAQ masih nyaman dibaca.
- Quick Lighthouse sanity check (fokus layout shift/CLS) untuk memastikan tidak muncul efek samping.

## Output
- CSS spacing yang lebih rapat dan konsisten di versi deploy (`dist/`) + versi root.
- Daftar perubahan angka utama yang bisa kamu tweak lagi kalau mau lebih rapat/lebih lega.