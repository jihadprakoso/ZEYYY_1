## Diagnosa
- Di mobile (touch device), ada rule global:
  - `@media (hover: none) and (pointer: coarse) { button, a, input, select, textarea { min-height: 44px; } }`
  - Ini ikut mengenai `.theme-toggle` yang seharusnya tingginya 24–30px.
- Akibatnya, track tombol jadi lebih tinggi (min 44px), tapi knob/dot (`.theme-toggle::before` dengan `top: 3px`) tetap berada dekat atas, jadi terlihat tidak center.

## Perbaikan
- Ubah rule tap-target agar **tidak** memaksa `min-height: 44px` untuk `.theme-toggle`.
  - Opsi paling aman: ganti selector `button` menjadi `button:not(.theme-toggle)`.
  - Alternatif/backup: tambah override `.theme-toggle { min-height: 0; }` di media query yang sama.

## File yang akan diubah
- [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css)

## Verifikasi
- Cek mobile view:
  - Dots/knob di theme toggle center di tengah track.
  - Tidak mengubah ukuran tap-target tombol lain (CTA/menu/link) di touch device.