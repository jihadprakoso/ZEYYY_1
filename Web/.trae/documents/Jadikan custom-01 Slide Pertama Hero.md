## Tujuan
Menjadikan gambar `custom-01.webp` sebagai slide **urutan pertama** (slide awal) pada hero slideshow.

## Kondisi Saat Ini
- Slide pertama (aktif) sekarang: `hardbox-hmns2.webp`.
- `custom-01.webp` saat ini ada di slide ke-4.
- Script slideshow selalu mulai dari `currentSlide = 0` dan menjalankan `showSlide(currentSlide, ...)`, jadi **slide pertama di DOM** adalah yang tampil pertama.

## Perubahan yang Akan Dilakukan
1. **Reorder urutan `.hero-slide` di [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L501-L554)**
   - Pindahkan blok `<div class="hero-slide">` yang berisi `assets/images/halamanutama/custom-01.webp` menjadi **slide pertama**.
   - Jadikan slide tersebut `<div class="hero-slide active">`.
   - Ubah slide yang sebelumnya aktif (`hardbox-hmns2.webp`) menjadi non-aktif (hapus `active`).

2. **Optimasi loading untuk slide pertama**
   - Pada `custom-01.webp`: set `loading="eager"` dan `fetchpriority="high"`.
   - Pastikan slide lain tetap `loading="lazy"`.

3. **(Opsional tapi aman) Sesuaikan gambar awal pada hero ghost**
   - Update `hero-ghost-prev/prev2/next/next2` agar mengikuti urutan baru (mengurangi kemungkinan “kedip” sebelum JS meng-update). Script tetap akan meng-update otomatis setelah inisialisasi.

4. **Build ulang dist + verifikasi**
   - Jalankan `build-dist.ps1`.
   - Verifikasi di `dist/index.html` bahwa slide pertama adalah `custom-01.webp` dan dot pertama aktif.