## Target
- Terapkan animasi **crossfade premium** + **directional slide** (next dari kanan, prev dari kiri) untuk hero slideshow.

## Perubahan Utama
### 1) CSS: ubah sistem slide dari `display:none` menjadi overlay + transisi
- Ganti `.hero-slide` yang sekarang `display:none/block` menjadi:
  - selalu ada di layout (pakai **grid overlay** atau `position:absolute`) supaya bisa fade-out + slide-in/out.
  - base state: `opacity:0`, `transform: translateX(...)`, `pointer-events:none`.
  - active state: `opacity:1`, `transform: translateX(0)`, `pointer-events:auto`.
- Tambah easing “premium” (mis. `cubic-bezier(0.22, 1, 0.36, 1)`), durasi ~450–700ms.
- Tambah selector berdasarkan arah:
  - container `data-slide-dir="next|prev"`
  - outgoing slide class `is-exiting`
  - incoming slide class `is-entering`

### 2) JS: orchestrate transisi masuk/keluar
- Update `showSlide(index)` agar menerima parameter arah (`'next' | 'prev'`).
- Logika:
  - tentukan outgoing (slide aktif sekarang) dan incoming (slide tujuan)
  - set `slideshowContainer.dataset.slideDir = dir`
  - outgoing: tambah `is-exiting`
  - incoming: tambah `active` + `is-entering`
  - `requestAnimationFrame`: remove `is-entering` supaya transisi jalan
  - cleanup outgoing via `transitionend` (atau timeout sesuai durasi) → remove `active` + `is-exiting`
- Pastikan klik dots tetap crossfade (arah bisa ditentukan dari perbandingan index atau default ke `next`).

### 3) Aksesibilitas
- Tambah `@media (prefers-reduced-motion: reduce)` → transisi dimatikan (langsung ganti slide) untuk pengguna yang sensitif animasi.

## File yang akan diubah
- [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L1754-L1795) (rule slideshow awal)
- [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L1852-L1960) (rule option C + ghost)
- [optimized_script.js](file:///d:/Data%20User/Documents/Jihad/Web/optimized_script.js#L211-L296) (logic slideshow)

## Verifikasi
- Next: slide baru masuk dari kanan, slide lama keluar ke kiri sambil fade.
- Prev: kebalikannya.
- Auto-play pakai animasi yang sama.
- Ghost preview tetap sync (fungsi updateGhostPreviews tetap dipakai).
- Mobile tetap aman (ghost hidden), transisi tetap halus atau dimatikan jika `prefers-reduced-motion`.

Kalau plan ini di-approve, aku langsung implement + rebuild dist dan cek di preview.