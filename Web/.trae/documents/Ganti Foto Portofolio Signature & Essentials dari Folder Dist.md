## Temuan
- Card portofolio saat ini masih memakai `assets/images/portfolio/Project_*.webp` untuk kedua kategori: [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L895-L982)
- Jumlah card di halaman:
  - Signature: **6 card**
  - Essentials: **6 card**
- Foto yang diminta (sumber dari dist):
  - Signature folder berisi **7 file**: [dist/assets/images/portfolio/Signature](file:///d:/Data%20User/Documents/Jihad/Web/dist/assets/images/portfolio/Signature)
  - Essentials folder berisi **6 file**: [dist/assets/images/portfolio/Essentials](file:///d:/Data%20User/Documents/Jihad/Web/dist/assets/images/portfolio/Essentials)
- Build ke `dist/` mengambil folder `assets/` dari root project (bukan dari `dist/`), jadi supaya perubahan tidak hilang saat build, fotonya harus ada di `assets/images/portfolio/...`: [build-dist.ps1](file:///d:/Data%20User/Documents/Jihad/Web/build-dist.ps1#L36-L39)

## Rencana Perubahan
1. Buat folder baru di source:
   - `assets/images/portfolio/Signature/`
   - `assets/images/portfolio/Essentials/`
2. Copy semua foto dari:
   - `dist/assets/images/portfolio/Signature/*` → `assets/images/portfolio/Signature/`
   - `dist/assets/images/portfolio/Essentials/*` → `assets/images/portfolio/Essentials/`
3. Update `index.html`:
   - Untuk 6 card Signature yang sudah ada, ganti `data-src` menjadi 6 foto dari folder Signature.
   - Karena folder Signature punya 7 foto, tambahkan **1 card Signature** ekstra agar **semua** foto Signature tampil.
   - Untuk 6 card Essentials, ganti `data-src` menjadi `Essentials/essentials-1.webp` s/d `essentials-6.webp`.
4. Build ulang `dist/`.
5. Verifikasi di `dist/index.html`:
   - Semua card Signature memakai path `assets/images/portfolio/Signature/...`
   - Semua card Essentials memakai path `assets/images/portfolio/Essentials/...`
   - File gambar ikut ter-copy ke `dist/assets/images/portfolio/Signature/` dan `dist/assets/images/portfolio/Essentials/`.

## Catatan Mapping (yang akan dipakai)
- Signature (urut 7 file):
  1) Custom_1.webp
  2) Custom_2.webp
  3) Custom_3.webp
  4) Custom_4.webp
  5) custom-4.webp
  6) custom-5.webp
  7) custom-6.webp
- Essentials:
  1) essentials-1.webp
  2) essentials-2.webp
  3) essentials-3.webp
  4) essentials-4.webp
  5) essentials-5.webp
  6) essentials-6.webp

## Output
- Tambah folder & file gambar di `assets/images/portfolio/Signature/` dan `assets/images/portfolio/Essentials/`
- Update markup portofolio di [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html)
- Update hasil build di `dist/`