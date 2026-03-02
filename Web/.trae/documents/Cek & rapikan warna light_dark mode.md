## Status saat ini (hasil cek)

- Perubahan warna **sebagian sudah bekerja** karena tema utama sekarang memakai variabel baru (mis. `--off-white`, `--light-grey`, `--green`, `--red`) dan dipetakan ke `--bg/--card/--text` di [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L304-L544).
- Namun masih ada **banyak warna hardcoded** yang menimpa tema baru (contoh: `#d71921`, `#a01419`, `#f8f8f8`, `#fef1f2`, dan beberapa CTA). Ini bikin beberapa komponen masih tampil “warna lama”. Contoh yang jelas: `.hero-badge` masih pakai pink + `#d71921` di [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L1719-L1732), dan override dark-mode mobile CTA masih hardcoded di [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L910-L929).

## Kesimpulan

- Kalau kamu lihat di preview, background/body dan sebagian section sudah berubah, tapi beberapa badge/button/gradient/komponen tertentu **belum konsisten** karena masih memakai nilai warna langsung.

## Plan perbaikan (biar 100% konsisten)

1. Audit & daftar semua warna hardcoded yang masih aktif
   - Cari semua `#d71921`, `#a01419`, `#f8f8f8`, `#fef1f2`, `rgba(215,25,33,…)`, `#25D366`, `#ff2d3a`, dll.
2. Ganti hardcoded color dengan design tokens
   - `#d71921` → `var(--accent)` (merah baru)
   - `#a01419` / hover merah → turunan `var(--accent-2)` atau `rgba(var(--red-rgb), …)`
   - `#25D366` → `var(--green)`
   - `#f8f8f8` / `#ffffff` untuk section → `var(--light-grey)` / `var(--off-white)` sesuai konteks
   - Pink badge (`#fef1f2`, `#fecdd3`) → ganti ke versi berbasis `rgba(var(--red-rgb), …)` supaya tetap “tone merah” tapi sesuai palet baru
3. Rapikan override dark mode agar mengikuti sistem baru
   - Mobile CTA, back-to-top hover, file upload hover, dsb: ubah semua hardcoded ke `var(--green)` / `var(--accent)`.
4. Validasi visual
   - Jalankan preview lokal, cek:
     - Light: body bg = off-white, section alt = light-grey, CTA utama = WhatsApp green
     - Dark: bg = #121212, surface = #1E1E1E, teks = #E0E0E0, accent merah = #FF4C4C
     - Tidak ada elemen yang balik ke `#d71921`.

Kalau kamu setuju, aku lanjutkan dengan mengganti semua hardcoded color yang tersisa supaya warna light/dark mode benar-benar konsisten.