## Analisa Penyebab (paling mungkin)
Di [dist/index.html](file:///d:/Data%20User/Documents/Jihad/Web/dist/index.html) ada **32 gambar** yang tidak memakai `src` asli, tapi memakai placeholder `src="data:image/svg+xml..."` + `data-src="assets/..."` (contoh di [dist/index.html](file:///d:/Data%20User/Documents/Jihad/Web/dist/index.html#L809-L872)).
- Gambar jenis ini **baru akan di-set `src`-nya oleh JavaScript** (lihat logic `startDeferredImageLoading()` di [optimized_script.js](file:///d:/Data%20User/Documents/Jihad/Web/dist/optimized_script.js#L903-L994)).
- Kalau `optimized_script.js` tidak jalan/terblokir (sering terjadi di beberapa hosting karena MIME type `.js` tidak benar + header `nosniff`), hasilnya: **banyak gambar blank**.

Tambahan temuan:
- Ada beberapa nama file gambar yang mengandung spasi (mis. `hardbox-Love in Motion.webp`) (lihat [dist/index.html](file:///d:/Data%20User/Documents/Jihad/Web/dist/index.html#L513-L525)). Ini biasanya aman, tapi pada beberapa proses extract/upload cPanel bisa jadi sumber 404. (Opsional kita rapikan.)

## Target
- Semua gambar tampil normal setelah deploy, **tanpa bergantung pada JS** untuk sekadar menampilkan gambar.
- JS tetap boleh dipakai sebagai optimasi (reveal, observer, dsb), tapi gambar harus tetap muncul walau JS gagal.

## Rencana Perbaikan
1. **Ubah markup gambar di source `index.html` agar pakai `src` asli**
   - Untuk semua `<img src="data:image/svg+xml..." data-src="assets/...">`, saya akan:
     - set `src` menjadi nilai `data-src`,
     - hapus `data-src` (atau biarkan tapi `src` tetap real),
     - tetap pertahankan `loading="lazy"` + `decoding="async"`.
   - Ini memastikan gambar tetap muncul walau `optimized_script.js` tidak termuat.

2. **Perkuat MIME type di `.htaccess` (anti-nosniff block)**
   - Tambah `<IfModule mod_mime.c>` dengan `AddType` minimal:
     - `application/javascript .js`
     - `text/css .css`
     - `image/webp .webp`
     - `image/svg+xml .svg`
   - Ini menghindari kasus umum: JS/CSS diblok browser karena `X-Content-Type-Options: nosniff` tapi server mengirim `text/plain`.

3. **(Opsional tapi recommended) Rapikan nama file yang mengandung spasi**
   - Rename file yang ada spasi jadi kebab-case (tanpa spasi), lalu update referensi di HTML.
   - Ini menghindari edge-case saat upload/extract di cPanel.

4. **Rebuild `dist/` + generate ulang `cpanel-deploy.zip`**
   - Jalankan `build-dist.ps1` lalu `deploy-cpanel.ps1`.

## Verifikasi
- Scan `dist/index.html`: pastikan tidak ada lagi gambar penting yang bergantung pada `data-src` (atau kalau masih ada, `src` sudah real file).
- Cek `.htaccess` sudah mengandung `AddType`.
- Generate ulang ZIP dan pastikan aset tetap ada.

## Output
- Setelah upload ZIP terbaru, gambar tampil normal di cPanel bahkan jika JS gagal load.