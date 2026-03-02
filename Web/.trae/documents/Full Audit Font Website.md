## Jawaban
Bisa. Paling rapi: **Montserrat untuk heading/display** dan **Inter untuk body/UI**.

## Dampak yang akan terjadi
- Semua judul (H1–H6, section title, dll) berubah dari Poppins → Montserrat.
- Teks isi (paragraph, form, button, microcopy) tetap Inter.
- Perlu update Google Fonts import supaya Montserrat benar-benar ter-load (kalau tidak, dia jatuh ke fallback).

## Rencana perubahan
1. **Update Google Fonts di HTML**
   - Ganti link `fonts.googleapis.com` di `index.html` dari `Inter + Poppins` menjadi `Inter + Montserrat`.
   - Set weight yang dibutuhkan:
     - Inter: 400/500/600/700
     - Montserrat: 600/700 (atau 500/600/700 jika ada heading yang pakai 600 juga)

2. **Buat token font dan terapkan global**
   - Tambahkan CSS variables:
     - `--font-body: 'Inter', system-ui, ...`
     - `--font-heading: 'Montserrat', 'Inter', system-ui, ...`
   - Terapkan:
     - `body { font-family: var(--font-body); }`
     - `h1,h2,h3,h4,h5,h6 { font-family: var(--font-heading); }`
   - Audit komponen yang sempat punya override supaya semua mengikuti `inherit`.

3. **Samakan halaman 404**
   - Tambahkan link Google Fonts yang sama ke `404.html`.
   - Ubah inline font-family agar pakai Inter (dan heading Montserrat bila ada).

4. **Samakan folder dist (kalau dipakai deploy)**
   - Terapkan perubahan yang sama ke `dist/index.html`, `dist/optimized_styles.css`, `dist/404.html`.

5. **Verifikasi**
   - Cek visual di desktop & mobile.
   - Grep `font-family` memastikan tidak ada Poppins tersisa.

## File yang akan diubah
- [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html)
- [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css)
- [404.html](file:///d:/Data%20User/Documents/Jihad/Web/404.html)
- (Jika diperlukan) [dist](file:///d:/Data%20User/Documents/Jihad/Web/dist/) versi yang sama