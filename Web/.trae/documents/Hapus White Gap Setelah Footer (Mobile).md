## Diagnosa
- Di mobile, ada rule `@media (max-width: 767px)` yang menambahkan `body { padding-bottom: 72px; }` agar konten tidak ketutup sticky CTA.
- Karena `footer` berada di luar `<main>`, padding pada `body` ini ikut menambah ruang *setelah footer*, sehingga terlihat “gap putih” paling bawah.

## Perbaikan (tanpa ubah UI, hanya pergeseran padding)
- Pindahkan kompensasi ruang sticky CTA dari `body` ke `main#main-content`:
  - Mobile: set `main#main-content { padding-bottom: 72px; }`
  - Mobile: set `body { padding-bottom: 0; }` (override khusus mobile)
- (Opsional aman untuk iPhone): gunakan `calc(72px + env(safe-area-inset-bottom))` supaya tetap nyaman di perangkat dengan safe area.

## File yang akan diubah
- [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css)

## Verifikasi
- Mobile view scroll sampai paling bawah:
  - Tidak ada gap putih setelah footer.
  - Konten section terakhir tidak ketutup sticky CTA.
  - Sticky CTA tetap berfungsi normal.