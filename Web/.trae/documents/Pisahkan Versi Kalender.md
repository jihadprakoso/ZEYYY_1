## Tujuan
- Simpan versi `index.html` yang **ada section Kalender** sebagai file baru **html-calendar.html**.
- Kembalikan `index.html` menjadi versi **tanpa section Kalender**.

## Perubahan yang akan saya lakukan
1) **Duplikasi file**
- Copy file saat ini: `index.html` → `html-calendar.html` (isi sama persis, termasuk section Kalender Timeline).

2) **Hapus section Kalender dari index.html**
- Di `index.html`, hapus blok ini saja:
  - Mulai: `<section class="calendar-section reveal" id="calendar" ...>`
  - Sampai: `</section>` sebelum komentar `<!-- ================ TESTIMONIALS SECTION ... -->`
- Area yang dihapus ada di sekitar [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L1099-L1119).

3) **Sinkronkan output build**
- Build ulang `dist` supaya `dist/index.html` mengikuti `index.html` yang baru (tanpa kalender).

## Verifikasi
- Pastikan `html-calendar.html` ada dan mengandung judul “Kalender Timeline”.
- Pastikan `index.html` tidak lagi mengandung section Kalender Timeline.
- Pastikan `dist/index.html` sesuai versi `index.html`.
