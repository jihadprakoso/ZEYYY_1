## Temuan Cepat
- Landing page saat ini adalah HTML statis (bukan SPA framework). Itu berarti secara praktik sudah “prerender/SSR-friendly”: konten utama (hero, FAQ, dll) ada di HTML dan bisa dibaca crawler tanpa menjalankan JS.
- Bagian yang masih perlu dibenahi untuk “desktop & mobile” ada di meta tags (viewport, theme-color fallback, konsistensi OG/Twitter) dan kompatibilitas gambar untuk preview sosial.

## Target Perubahan
- Memastikan landing page benar-benar siap untuk prerender/crawler (tanpa ketergantungan rendering JS).
- Memperbaiki meta SEO + social preview agar konsisten dan aman untuk tampilan desktop & mobile.

## Langkah Implementasi
1. **Pastikan prerender/SSR landing page**
   - Pastikan semua konten penting tetap ada di HTML statis (tidak di-generate oleh JS).
   - Pastikan output deploy memakai `dist/index.html` (hasil build-dist) sehingga yang dipublish adalah versi “prerendered”.

2. **Perbaiki meta “mobile” (viewport + theme)**
   - Ubah viewport menjadi `width=device-width, initial-scale=1, viewport-fit=cover` untuk iOS notch.
   - Tambah `meta name="color-scheme" content="light dark"`.
   - Tambah `theme-color` default (tanpa `media`) + pertahankan yang berbasis `prefers-color-scheme` sebagai override.

3. **Rapikan meta SEO & Social (desktop/mobile)**
   - Samakan `title`, `og:title`, dan `twitter:title` agar konsisten.
   - Samakan `description`, `og:description`, `twitter:description` (atau minimal selaras copy-nya).
   - Tambahkan detail OG yang sering dibutuhkan untuk preview yang stabil:
     - `og:image:alt`, `og:image:type`.
     - `og:image:width` dan `og:image:height` sesuai aset yang dipakai.
   - Tambahkan `twitter:image:alt`.

4. **Perkuat kompatibilitas gambar preview (opsional tapi direkomendasikan)**
   - Karena `og:image` saat ini memakai `.webp`, beberapa platform bisa bermasalah.
   - Opsi terbaik: sediakan aset preview `jpg/png` (mis. 1200×630) di `assets/images/social/` lalu:
     - Set OG/Twitter ke JPG/PNG sebagai utama.
     - (Opsional) Tambahkan WebP sebagai fallback.
   - Implementasinya: saya akan mencoba generate JPG/PNG dari gambar hero yang ada menggunakan tool konversi yang tersedia di mesin (mis. ImageMagick/ffmpeg). Kalau tidak tersedia, saya akan tetap rapikan meta dengan WebP + type/size.

## Verifikasi
- Rebuild `dist/`.
- Cek local refs untuk memastikan tidak ada asset yang hilang.
- Jalankan audit Lighthouse SEO untuk desktop & mobile (serve `dist/` secara lokal) dan pastikan:
  - Title/Description/Canonical/OG/Twitter terdeteksi benar.
  - Preview image bisa di-fetch.

## File yang Akan Diubah
- `index.html` (meta tags)
- (Opsional) tambah file image preview baru di `assets/images/social/` bila konversi memungkinkan
- `dist/*` akan di-regenerate melalui proses build