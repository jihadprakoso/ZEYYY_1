## Target
- Terapkan **Opsi A (Premium Halo Red)** untuk hero agar foto slideshow lebih eyecatching.
- Siapkan switch cepat ke **Opsi B (Dark Pedestal)** tanpa redesign ulang.

## Implementasi yang akan saya lakukan
1) **CSS variable untuk tema hero**
- Tambahkan variable khusus hero (bg gradient + halo + frame) di `optimized_styles.css`.
- Default value = Opsi A.

2) **Halo + frame pada slideshow**
- Tambahkan efek highlight di `.hero-slideshow-container`:
  - `::before` radial-gradient merah + blur (halo)
  - border tipis untuk “frame” premium
  - shadow sedikit lebih tegas (tetap halus)

3) **(Opsional ringan) Pop pada gambar**
- Tambah filter sangat kecil untuk bikin foto lebih “hidup” tanpa mengubah tone brand berlebihan.

4) **Switch ke Opsi B kalau Opsi A kurang**
- Saya siapkan override CSS untuk Opsi B di selector `html[data-hero-variant="b"]`.
- Untuk aktifkan Opsi B nanti, cukup ubah 1 atribut di `<html>` (tanpa ubah CSS lagi).

## File yang akan diubah
- `optimized_styles.css` (utama)
- `index.html` (opsional: hanya untuk mengaktifkan Opsi B kalau diperlukan; default tetap Opsi A)

## Verifikasi
- Cek hero di light mode & dark mode
- Pastikan teks hero tetap terbaca, tombol tetap kontras, dan slideshow terasa lebih highlighted