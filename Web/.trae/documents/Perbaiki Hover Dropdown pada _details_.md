## Kenapa tidak keluar saat hover
- Dropdown Anda memakai elemen `<details>`. Secara default browser menyembunyikan semua isi `<details>` selain `<summary>` kalau atribut `open` belum aktif.
- Karena itu, meskipun CSS sudah ada `:hover`, list tetap tidak akan tampil kalau `<details>` tidak dibuat `open`.
- Saat tadi hover sempat bekerja, itu karena ada JavaScript yang menambahkan `open` saat mouse masuk—lalu kita hapus saat perbaikan “ketutup cepat”, jadi hover tidak memunculkan list lagi.

## Perbaikan yang akan saya lakukan
1. Update [optimized_script.js](file:///d:/Data%20User/Documents/Jihad/Web/optimized_script.js)
   - Tambahkan lagi logic untuk desktop (hover + pointer fine):
     - `pointerenter` pada `.nav-dropdown` → set `open`
     - `pointerleave` → remove `open` (dengan guard: jangan tutup kalau sedang `:focus-within`)
   - Tetap pertahankan: klik di luar menutup, klik item menutup, `Esc` menutup.

2. (Opsional kecil) Rapikan CSS
   - Boleh tetap seperti sekarang, karena state `open` akan membuat menu tampil.
   - Kalau perlu, saya bisa sederhanakan selector supaya tampilan menu bergantung pada `[open]` + `:focus-within` saja.

## Verifikasi
- Test desktop: hover “Layanan Kami/Hubungi Kami” → list muncul, bisa diarahkan dan diklik tanpa menutup sendiri.
- Test keyboard: Tab ke summary + Enter, lalu Esc untuk tutup.

Saya lanjut eksekusi perubahan JS ini setelah Anda approve.