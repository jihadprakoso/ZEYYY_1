## Kenapa Menu Tidak Scroll
- Saat mobile menu terbuka, `body.menu-open` membuat `overflow: hidden` (scroll terkunci). Kalau class ini tidak terhapus saat klik link tertentu, halaman memang tidak bisa scroll.
- Di script saat ini, yang otomatis menutup menu hanya `.mobile-nav-link`. Tombol di mobile menu seperti **Request Quotation** pakai class `.mobile-cta` (bukan `.mobile-nav-link`), jadi bisa kejadian: klik → scroll tetap terkunci.

## Tujuan
- Klik menu apa pun yang anchor internal (`#...`) selalu scroll (desktop maupun mobile).
- Mobile menu selalu tertutup saat klik item menu (termasuk `.mobile-cta`).

## Perubahan yang Akan Dilakukan
1) **optimized_script.js**
- Tambah handler untuk `.mobile-cta` agar selalu `document.body.classList.remove('menu-open')` saat diklik.
- Perkuat handler anchor `a[href^="#"]`:
  - Selalu close `menu-open` + tutup dropdown.
  - Jalankan scroll di `requestAnimationFrame` setelah menu ditutup (biar lock scroll sudah lepas saat `scrollTo`).
  - (Opsional aman) ganti `offsetTop` ke `scrollIntoView` + fallback `scrollTo` bila perlu.

2) **Rebuild dist + verifikasi**
- Mobile: buka menu → klik Keunggulan/Portofolio/Proses/FAQ/Request Quote → menu nutup dan halaman scroll.
- Desktop: klik item dropdown → scroll normal.

## File yang Akan Diubah
- [optimized_script.js](file:///d:/Data%20User/Documents/Jihad/Web/optimized_script.js)
- rebuild ke [dist/optimized_script.js](file:///d:/Data%20User/Documents/Jihad/Web/dist/optimized_script.js)