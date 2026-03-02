## Temuan
- Section **“Produksi yang Terstruktur & Terkontrol”** ada di [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L794-L809).
- Mekanisme video saat ini **lazy on click**: tombol “Putar Video” membuat elemen `iframe` berdasarkan atribut `data-video-embed` (lihat [optimized_script.js](file:///d:/Data%20User/Documents/Jihad/Web/optimized_script.js#L254-L277)).
- Karena `data-video-embed` masih kosong, saat klik tombol sekarang fallback-nya membuka WhatsApp.

## Dampak ke performance
- Kalau iframe YouTube dipasang langsung (tanpa click-to-load), Lighthouse mobile biasanya turun karena third-party scripts ikut load di awal.
- Struktur kamu sudah benar (poster + tombol + iframe dibuat saat klik), jadi kita **cukup isi URL embed** saja supaya tetap cepat.

## Perubahan yang akan saya lakukan
1) **Update HTML section video**
- Isi atribut `data-video-embed` pada `<div class="video-embed" data-video-embed="">` menjadi URL embed dari kamu:
  - `https://www.youtube.com/embed/mI1S7vqK4QU?si=3WW9y2Ny2aD1Jl45`
- (Opsional tapi saya rekomendasikan) tambahkan autoplay saat klik:
  - `https://www.youtube.com/embed/mI1S7vqK4QU?si=3WW9y2Ny2aD1Jl45&autoplay=1`

2) **Verifikasi cepat**
- Buka halaman, klik “Putar Video”, pastikan iframe tampil dan video bisa diputar.
- Pastikan tidak ada perubahan ke loading awal (tetap tidak memuat YouTube sebelum klik).

Setelah Anda setuju, saya langsung terapkan edit di `index.html` dan pastikan tombol memutar video YouTube tersebut.