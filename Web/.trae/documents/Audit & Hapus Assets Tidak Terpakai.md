## Temuan Cepat (dari scan referensi di dist)
Dari file yang benar-benar dirender sekarang (utama: [dist/index.html](file:///d:/Data%20User/Documents/Jihad/Web/dist/index.html) + [dist/privacy-policy.html](file:///d:/Data%20User/Documents/Jihad/Web/dist/privacy-policy.html) + [dist/terms-of-service.html](file:///d:/Data%20User/Documents/Jihad/Web/dist/terms-of-service.html) + [dist/optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/dist/optimized_styles.css)):
- Yang terpakai terlihat hanya folder: `assets/logo/`, `assets/clients/`, `assets/images/halamanutama/`, `assets/images/features/`, `assets/images/portfolio/Essentials/`, `assets/images/portfolio/Signature/`, `assets/images/process/`, `assets/images/marketplace/`, `assets/images/payments/`, `assets/images/social/`.
- Folder seperti `assets/images/manufacturing/`, `assets/images/FOTO LAINYA/`, `assets/images/LOGO/`, `assets/images/SELECTED WORKS/`, `assets/images/services/`, `assets/images/testimonials/`, serta file seperti `assets/images/flow.webp` **tidak terlihat direferensikan** oleh HTML/CSS/JS saat ini (akan saya verifikasi otomatis sebelum hapus).

## Tujuan
Menghapus file di `assets/` (source) dan memastikan `dist/assets/` ikut bersih, tanpa ada link gambar/logo yang putus di HTML/CSS.

## Rencana Implementasi
1. **Buat alat audit otomatis (Node script)**
   - Tambah script (mis. `tools/audit-assets.mjs`) yang:
     - Membaca semua file sumber yang bisa mereferensikan assets: `index.html`, `privacy-policy.html`, `terms-of-service.html`, `404.html`, `optimized_styles.css`, `optimized_script.js` (dan versi `dist/` untuk cross-check).
     - Mengekstrak path asset dari:
       - `src=`, `href=`, `data-src=`, `content=` (meta og:image), `url('...')` di CSS.
       - Bentuk relatif `assets/...` dan bentuk absolut `https://deartbox.com/assets/...`.
     - Normalisasi path: decode `%20`, buang query/hash.
     - Menghasilkan daftar `used-assets`.

2. **Inventory file aktual di disk**
   - Walk folder `assets/` rekursif untuk dapatkan semua file aktual.
   - Bandingkan dengan `used-assets` → dapatkan `unused-assets`.

3. **Buat report sebelum hapus**
   - Tambah `ASSET_AUDIT_REPORT.md` berisi:
     - Ringkasan jumlah file terpakai vs tidak terpakai.
     - Daftar folder/file yang akan dihapus.

4. **Hapus asset yang tidak terpakai (aman dan terukur)**
   - Hapus hanya item yang 100% tidak ada referensinya.
   - Mulai dari kandidat besar (folder yang benar-benar tidak direferensikan) seperti `assets/images/manufacturing/` dll, tapi tetap berdasarkan hasil audit.

5. **Rebuild dist dan verifikasi**
   - Jalankan `build-dist.ps1` agar `dist/` mengikuti `assets/` yang sudah dibersihkan.
   - Jalankan audit ulang untuk memastikan:
     - Tidak ada “referenced but missing”.
     - Tidak ada asset “unused” tersisa di `dist/assets/`.

## Output Akhir
- `assets/` dan `dist/assets/` sudah bersih dari file yang tidak direferensikan.
- Report audit yang bisa Anda cek kapan saja.
- Jaminan tidak ada broken image/logo di HTML/CSS berdasarkan scan otomatis.