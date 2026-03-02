## Diagnosa
- Di mobile, `.sticky-cta` diposisikan `fixed` di bawah (full width) dengan `z-index: 100`.
- Mobile menu juga `fixed` dan memenuhi tinggi viewport.
- Saat menu dibuka (`body.menu-open`), elemen fixed ini saling overlap sehingga salah satunya terlihat “ketutup/ketiban” atau menu bagian bawah jadi tidak nyaman.

## Perbaikan (tanpa ubah desain, hanya behavior saat menu terbuka)
- Tambahkan rule CSS khusus mobile: `body.menu-open .sticky-cta { transform: translateY(100%); }`.
  - Ini memanfaatkan transisi yang sudah ada di `.sticky-cta` pada mobile.
  - Efeknya: ketika hamburger/menu terbuka, sticky CTA otomatis “slide down” (tidak mengganggu menu).

## File yang akan diubah
- [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css)

## Verifikasi
- Buka mobile view, klik mobile toggle:
  - Menu tampil penuh tanpa tertutup.
  - Sticky CTA otomatis menghilang saat `menu-open`.
- Pastikan saat menu ditutup, sticky CTA kembali normal.