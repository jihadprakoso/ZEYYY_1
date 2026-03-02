## Penyebab Utama
Ghost kiri/kanan terlihat “stuck” (kiri selalu W3B, kanan selalu HMNS) karena **ghost `<img>` punya `srcset` milik gambar awalnya**, sehingga walaupun JS mengganti `src`, browser tetap memilih gambar dari `srcset` lama.

Ini terjadi karena:
- Ghost images di [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L520-L533) punya `data-srcset`.
- Saat lazy loader jalan, [loadDeferredImage](file:///d:/Data%20User/Documents/Jihad/Web/optimized_script.js#L943-L971) memindahkan `data-srcset` -> `img.srcset`.
- Lalu `updateGhostPreviews()` hanya mengganti `ghostImg.src` (lihat [optimized_script.js](file:///d:/Data%20User/Documents/Jihad/Web/optimized_script.js#L397-L419)), **tanpa** mengganti `srcset`. Akibatnya browser masih menampilkan gambar dari `srcset` lama (W3B/HMNS).

## Perbaikan yang akan saya lakukan
1) **Update `updateGhostPreviews()`** di [optimized_script.js](file:///d:/Data%20User/Documents/Jihad/Web/optimized_script.js#L397-L419)
- Buat helper kecil `syncGhostImage(ghostImg, sourceImg)` yang:
  - Mengambil sumber yang paling akurat dari `sourceImg` (prioritas `currentSrc`, lalu `data-src`, lalu `src`).
  - Meng-update ghost **bukan hanya `src`**, tapi juga:
    - `ghostImg.srcset` (diisi dari `sourceImg.dataset.srcset` / `sourceImg.srcset` bila ada)
    - `ghostImg.sizes` (diisi dari `sourceImg.dataset.sizes` / `sourceImg.sizes` bila ada)
  - Jika kita pakai `currentSrc`, saya akan **kosongkan `ghostImg.srcset`** supaya tidak override.

2) **Verifikasi**
- Build ulang `dist`.
- Cek: setelah slide bergeser beberapa kali, ghost kiri/kanan berubah mengikuti urutan slide (tidak terkunci W3B/HMNS).

Jika Anda setuju, saya langsung implement fix ini di [optimized_script.js](file:///d:/Data%20User/Documents/Jihad/Web/optimized_script.js) dan build ulang dist.