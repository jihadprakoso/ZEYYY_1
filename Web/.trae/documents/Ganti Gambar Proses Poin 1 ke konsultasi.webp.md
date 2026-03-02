## Temuan
- Di “Proses Kerja Kami” poin 1 (Konsultasi Gratis), gambar saat ini masih mengarah ke `assets/images/features/mesinauto.webp`: [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L1021-L1030)
- Di folder source `assets/images/process/` belum ada `konsultasi.webp`, yang ada adalah `consultation.webp`: [assets/images/process](file:///d:/Data%20User/Documents/Jihad/Web/assets/images/process/)

## Rencana Perubahan
1. Buat file `assets/images/process/konsultasi.webp` sebagai duplikat dari `assets/images/process/consultation.webp` (supaya sesuai nama yang diminta).
2. Update poin 1 “Konsultasi Gratis” agar `data-src` mengarah ke `assets/images/process/konsultasi.webp`.
3. Build ulang `dist/` lalu verifikasi:
   - `dist/index.html` poin 1 memakai `assets/images/process/konsultasi.webp`
   - `dist/assets/images/process/konsultasi.webp` ikut ter-copy.

## Output
- Update 1 gambar pada [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html)
- Tambah file `assets/images/process/konsultasi.webp`
- Update `dist/` hasil build