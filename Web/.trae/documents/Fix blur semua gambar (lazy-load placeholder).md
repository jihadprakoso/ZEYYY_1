## Kenapa semua gambar jadi blur
- Saat ini gambar non-hero pakai placeholder (`src` data-URI) + URL asli di `data-src`.
- CSS memang sengaja memberi blur+shimmer untuk `img[data-src]:not(.loaded)`.
- JS baru mulai memuat gambar setelah “scroll pertama”. Kalau user:
  - membuka link dengan `#anchor` (browser sudah scroll sebelum JS pasang listener), atau
  - sudah berada di bagian bawah tanpa melakukan scroll lagi,
  maka loader tidak pernah start → class `.loaded` tidak pernah terpasang → blur tidak hilang.

## Perbaikan yang akan dibuat
1. **JS: jangan tunggu scroll jika page sudah berada di posisi scroll/anchor**
   - Jika `location.hash` ada atau `window.scrollY > 0` saat load, langsung panggil `startDeferredImageLoading()`.
   - Tambahkan fallback timer kecil (mis. 1500–2500ms) agar tidak pernah stuck walau event scroll terlewat.

2. **CSS: blur hanya saat masih placeholder**
   - Ubah selector dari `img[data-src]:not(.loaded)` menjadi `img[data-src][src^="data:"]:not(.loaded)` (dan varian untuk `data-srcset` bila ada).
   - Jadi begitu `src` sudah diganti ke URL asli, blur langsung hilang walau `.loaded` telat.

3. **Verifikasi**
   - Rebuild dist.
   - Cek di local preview: buka halaman langsung dengan `#showcase` dan pastikan gambar tidak stuck blur.

## File yang akan diubah
- `d:\Data User\Documents\Jihad\Web\optimized_script.js`
- `d:\Data User\Documents\Jihad\Web\optimized_styles.css`
- Rebuild `dist/` untuk memastikan output deploy ikut fix.