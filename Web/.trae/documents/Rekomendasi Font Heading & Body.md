## Pilihan font (Opsi A)

- **Heading:** Poppins (Bold 700)
- **Body:** Inter (Regular 400 / Medium 500)
- Ini sudah sesuai setup sekarang (Google Fonts sudah load Inter + Poppins), jadi fokusnya tinggal **skala ukuran + line-height**.

## Target ukuran (sesuai arahan kamu)

- **H1:** 56–64px (dipakai untuk hero title)
- **H2:** 36–40px (dipakai untuk section title)
- **H3:** 24px
- **Body:** 16–18px
- **Line-height body:** 1.6–1.8 (pakai 1.7 sebagai default)

## Perubahan yang akan dilakukan

1. **Update base typography** di [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css)
   - `body { font-size: clamp(16px, ..., 18px); line-height: 1.7; }`
   - `p { line-height: 1.7; }`
   - `h3 { font-size: 24px; }`
   - `h1/h2` global boleh tetap responsif, tapi tidak dipakai untuk hero/section utama (hero pakai `.hero-title`, section pakai `.section-title`).
   - Pastikan `.logo-text h1` tetap kecil (sudah ada override), jadi header tidak ikut membesar.

2. **Mapping H1/H2 ke komponen yang dipakai di page**
   - **Hero title** sekarang pakai `.hero-title` (element-nya `h2`), jadi kita set **`.hero-title` = 56–64px**.
   - **Section title** pakai `.section-title`, jadi kita set **`.section-title` = 36–40px**.
   - Untuk mobile, pakai `clamp()` supaya tidak kepotong (di desktop tetap masuk range yang kamu minta).

3. **Verifikasi**
   - Reload preview lokal dan cek:
     - Hero title berada di range H1 (desktop).
     - Section title berada di range H2 (desktop).
     - H3 konsisten 24px.
     - Body berada 16–18px dan line-height nyaman.
   - Pastikan header/logo tidak berubah ukuran."}