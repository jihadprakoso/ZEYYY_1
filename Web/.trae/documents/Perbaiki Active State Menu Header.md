## Kenapa Masih Tidak Aktif
- Active state sekarang hanya berlaku untuk elemen yang punya class `.nav-link` / `.mobile-nav-link`.
- Tombol header **Request Quote** memakai class `.cta-nav-secondary` (bukan `.nav-link`), jadi walaupun scroll jalan, tampilannya tidak berubah karena:
  - Script tidak men-set `.active` ke `.cta-nav-secondary`.
  - CSS juga belum punya style `.cta-nav-secondary.active`.

## Tujuan
- Semua link header internal (termasuk **Request Quote**) terlihat aktif saat diklik dan saat scroll.

## Perubahan yang Akan Dilakukan
1) **JS (optimized_script.js)**
- Perluas daftar elemen yang di-toggle active:
  - Sertakan `.cta-nav-secondary` dalam selektor link.
- Update `setActiveNav(hash)`:
  - Hapus `.active` dari `.nav-link`, `.mobile-nav-link`, dan `.cta-nav-secondary`.
  - Tambahkan `.active` untuk elemen yang `href`-nya sama dengan `hash`.

2) **CSS (optimized_styles.css)**
- Tambahkan style `.cta-nav-secondary.active` agar terlihat berubah:
  - Light mode: background halus + border/warna ikut accent.
  - Dark mode: background `rgba(215,25,33,0.15)` biar konsisten dengan `.nav-link.active`.

3) **Rebuild dist + verifikasi**
- Klik **Request Quote** → scroll ke RFQ + tombol terlihat aktif.
- Klik item dropdown (Keunggulan/Portofolio/Proses/FAQ) → summary “Layanan Kami” ikut aktif.
- Scroll manual → active mengikuti section.

## File yang Akan Diubah
- [optimized_script.js](file:///d:/Data%20User/Documents/Jihad/Web/optimized_script.js)
- [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css)
- Rebuild ke folder dist via build-dist.ps1