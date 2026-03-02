## Observasi
- Tombol `.mobile-toggle` memakai `display:flex` + `flex-direction: column`, tapi belum ada `justify-content`, jadi 3 garis (ikon hamburger) cenderung nempel ke atas area tombol.
- Di mobile, `.theme-toggle` sudah punya tinggi tetap (mis. 24px pada breakpoint tertentu) dan ikon di dalamnya dipusatkan, jadi terlihat lebih “tengah” dibanding hamburger.

## Perubahan yang Akan Dilakukan
- Update CSS `.mobile-toggle` agar konten (3 span) benar-benar berada di tengah area tombol:
  - Tambah `justify-content: center;` (pusat vertikal)
  - Tambah `align-items: center;` (pusat horizontal)
- Khusus mobile (`@media (max-width: 767px)`), samakan feel/tinggi tombol hamburger dengan theme toggle:
  - Set `height` mengikuti theme toggle (24px pada breakpoint itu), lalu sesuaikan `padding` supaya tidak mengubah posisi border/box.
- Evaluasi rule yang sebelumnya menggeser `.nav .mobile-toggle` `translateY(2px)`:
  - Kalau setelah ikon dipusatkan posisi border tetap sejajar, rule itu bisa dipertahankan.
  - Kalau jadi terlalu turun/naik, rule itu akan dikurangi atau dipindah ke span (ikon) agar border tidak berubah.

## Verifikasi
- Cek di mobile widths umum (360/375/390/414px):
  - Border/area `.mobile-toggle` sejajar dengan `.theme-toggle`
  - Garis hamburger tepat di tengah box dan sejajar secara visual dengan ikon sun/moon.
- Rebuild dist dan pastikan perubahan muncul di `dist/optimized_styles.css`.
