## Tujuan
- Ghost kecil (kiri kecil/kanan kecil) tampil jelas namun berada di belakang ghost besar (kiri/kanan).

## Perubahan CSS (tanpa ubah HTML/JS)
- Atur layering dengan z-index berjenjang:
  - `.hero-slide` tetap paling depan (z-index 2).
  - Ghost besar (`.hero-ghost-prev`, `.hero-ghost-next`) di tengah (z-index 1).
  - Ghost kecil (`.hero-ghost-prev2`, `.hero-ghost-next2`) di belakang ghost besar (z-index 0).
- Supaya ghost kecil tidak “ketiban” pseudo background container:
  - Turunkan `.hero-slideshow-container::before` dan `::after` ke z-index negatif (mis. -2 dan -1), sehingga semua ghost tetap di atas background layer.

## File yang akan diubah
- [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L1853-L1957)

## Verifikasi
- Di desktop: ghost kecil terlihat di kiri/kanan dan jelas berada di belakang ghost besar.
- Tidak mengganggu tombol nav/dots (tetap clickable) karena ghost tetap `pointer-events: none`.
- Mobile: ghost tetap hidden sesuai rule yang sudah ada.