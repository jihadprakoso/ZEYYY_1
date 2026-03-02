## Kenapa preview next jadi “ngaco” setelah kartu bergeser
Masalahnya bukan di rumus urutan index (prev/next sudah benar), tapi di **state animasi ghost yang tidak selalu dibersihkan**.

Di [optimized_script.js](file:///d:/Data%20User/Documents/Jihad/Web/optimized_script.js#L428-L497):
- Setiap slide mulai animasi, kita `classList.add('ghost-animating-next'/'ghost-animating-prev')`.
- Class ini baru dihapus **di akhir animasi** (di `setTimeout`, baris [optimized_script.js](file:///d:/Data%20User/Documents/Jihad/Web/optimized_script.js#L482-L496)).
- Tapi kalau user klik next/prev cepat (atau autoplay keburu jalan) saat animasi sebelumnya belum selesai, kita **meng-cancel timeout** (`clearTimeout(slideCleanupTimer)`) tanpa menghapus class ghost yang sedang aktif.
- Akibatnya container bisa menyimpan class lama, bahkan bisa punya **dua class sekaligus** (`ghost-animating-next` dan `ghost-animating-prev`). CSS ghost jadi konflik, posisi/preview ghost terlihat salah.

## Perbaikan yang akan saya lakukan
### 1) Rapikan state ghost di awal `showSlide`
- Selalu hapus `ghost-animating-next` dan `ghost-animating-prev` **sebelum** menambahkan class baru.
- Kalau ada `slideCleanupTimer` yang dicancel, saya juga akan langsung melakukan cleanup state ghost dan state slide.

### 2) Pastikan update urutan ghost terjadi pada state yang benar
- Panggil `updateGhostPreviews()` setelah ghost class dibersihkan (supaya preview yang diset tidak “terbaca” oleh style yang salah).

### 3) Verifikasi
- Build ulang `dist`.
- Cek: klik next/prev cepat beberapa kali, preview ghost kanan/kiri tetap konsisten sesuai urutan slide.

Jika Anda setuju, saya langsung implement perbaikan ini di [optimized_script.js](file:///d:/Data%20User/Documents/Jihad/Web/optimized_script.js).