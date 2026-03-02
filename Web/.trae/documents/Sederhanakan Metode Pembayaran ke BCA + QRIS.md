## Perubahan 1 — Metode Pembayaran (hanya BCA + QRIS)
### Kondisi sekarang
- Footer Metode Pembayaran di [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L1466-L1476) masih menampilkan 6 logo.
- Source `assets/images/payments/` belum memiliki `qris.svg`, tapi `dist/assets/images/payments/` sudah ada `qris.svg`.

### Yang akan saya lakukan
1. Edit [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L1466-L1476):
   - Hapus semua logo pembayaran selain `bca.svg`.
   - Tambahkan logo `qris.svg` sehingga yang tampil hanya:
     - BCA
     - QRIS
2. Sinkronkan aset supaya build tidak menghapus QRIS:
   - Salin `dist/assets/images/payments/qris.svg` → `assets/images/payments/qris.svg`.
   - Hapus file logo pembayaran lain di `assets/images/payments/` (mandiri/bni/bri/visa/mastercard/BSI, dll) sehingga hanya tersisa `bca.svg` dan `qris.svg`.

## Perubahan 2 — Menu Portofolio jadi 2 kategori
### Kondisi sekarang
- Filter portofolio ada 3 tombol: Custom Box / Hardbox / Softbox: [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L786-L790)
- Item portofolio memakai `data-category="hardbox|softbox|custom"`.
- Script default filter mengaktifkan `hardbox`: [optimized_script.js](file:///d:/Data%20User/Documents/Jihad/Web/optimized_script.js#L324-L357)

### Yang akan saya lakukan
1. Ubah tombol filter di [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L786-L790) menjadi 2 saja:
   - `Signature Box`
   - `Essentials Box`
2. Sesuaikan kategori item portofolio agar tetap bisa difilter:
   - Gabungkan kategori `hardbox` + `custom` → `signature`
   - Kategori `softbox` → `essentials`
3. Update script filter di [optimized_script.js](file:///d:/Data%20User/Documents/Jihad/Web/optimized_script.js#L324-L357):
   - Default filter dari `hardbox` menjadi `signature`.
4. Rapikan teks yang tampil di kartu portofolio agar konsisten (judul/alt yang berawalan “Custom Box:” atau “Softbox:” akan disesuaikan ke “Signature Box:” / “Essentials Box:”).

## Perubahan 3 — Tombol “Portofolio Lainnya” sebelum CTA text
### Lokasi
- Di akhir section portofolio, sebelum teks `Ingin hasil seperti ini untuk brand Anda?`: [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L883-L901)

### Yang akan saya lakukan
- Tambahkan tombol/link `Portofolio Lainnya` tepat sebelum elemen `<h3>` tersebut.
- Tombol akan diarahkan ke kanal portofolio eksternal yang paling masuk akal (default: Instagram `https://www.instagram.com/de_artbox/`) dan dibuka di tab baru.
- Tambahkan styling minimal di [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css) agar spacing tombol rapi tanpa mengganggu layout CTA yang sudah ada.

## Export ke dist + Verifikasi
1. Jalankan `build-dist.ps1` untuk refresh `dist/`.
2. Verifikasi:
   - `dist/index.html` menampilkan 2 logo pembayaran dan 2 tombol filter portofolio.
   - `dist/assets/images/payments/` hanya berisi `bca.svg` dan `qris.svg`.
   - Filter portofolio berfungsi untuk dua kategori baru.
   - Tombol `Portofolio Lainnya` tampil sebelum teks CTA dan link-nya benar.