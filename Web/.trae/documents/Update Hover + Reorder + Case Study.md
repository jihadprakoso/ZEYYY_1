## Yang akan diubah (sesuai request)

1. **Hover back-to-top jangan warna hijau**
   - Ubah semua rule `.back-to-top:hover` (termasuk yang `!important` dan versi dark mode) dari `background: var(--green)` menjadi warna non-hijau.
   - Paling konsisten dengan tema: `background: var(--accent)` (merah) + `color: #fff`.

2. **Tukar urutan section pain point ↔ trust**
   - Di [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html), pindahkan blok `trust-section` ke atas blok pain points (tepat setelah hero).
   - Tidak mengubah id/anchor, jadi navigasi tetap aman.

3. **Tambah CTA kecil “Tanya Harga” pada setiap card di section services**
   - Di HTML saat ini tidak ada section bernama `services`; card yang relevan adalah 3 card di section [features-modern](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L580-L614).
   - Tambahkan link kecil `Tanya Harga` di tiap `.feature-card` (arah ke WhatsApp dengan pesan otomatis mengikuti judul card).
   - Tambahkan styling mini button di [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css).

4. **PORTOFOLIO → UPGRADE jadi CASE STUDY + tombol “Lihat Detail”**
   - Di section `#showcase`, ganti isi setiap `.showcase-item` dari (gambar + overlay) menjadi card case study dengan format:
     - Brand
     - Masalah
     - Solusi
     - Hasil
     - Tombol `[Lihat Detail]` (aktif; link ke WhatsApp dengan teks “minta detail case study …”).
   - Filter kategori (hardbox/softbox/custom) tetap berfungsi karena JS hanya memakai `.showcase-item[data-category]`.
   - Tambahkan CSS baru untuk tampilan case study card (spacing, label, button) tanpa merusak grid.

5. **Ubah teks CTA section paling akhir**
   - Ganti heading: `Siap Upgrade Packaging Brand Anda?` → `Siap mulai packaging brand Anda?`.

6. **Tambahan: khusus mobile, saat mobile toggle/menu terbuka sticky CTA disembunyikan**
   - JS sudah toggle class `body.menu-open` saat mobile menu dibuka.
   - Perkuat rule CSS `body.menu-open .sticky-cta` khusus mobile: hide total (mis. `opacity: 0; pointer-events: none; transform: translateY(12px) scale(.96);`).
   - Ini memastikan CTA tidak nyangkut setengah terlihat (karena sebelumnya hanya `translateY(100%)`).

## File yang akan disentuh

- [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html)
- [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css)

## Verifikasi

- Back-to-top hover tidak hijau di light/dark.
- Urutan section: Trust muncul sebelum Pain Points.
- Tiap feature card punya CTA kecil “Tanya Harga”.
- Showcase jadi Case Study dan tombol “Lihat Detail” berfungsi, filter masih jalan.
- CTA terakhir berubah teks.
- Saat mobile menu open: sticky CTA benar-benar hilang (tidak bisa diklik).