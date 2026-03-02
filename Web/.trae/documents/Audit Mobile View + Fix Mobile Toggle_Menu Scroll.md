## Temuan Utama (Mobile)
- Tinggi drawer/overlay mobile memakai angka hardcode yang tidak konsisten:
  - `.mobile-menu { top: 75px; height: calc(100vh - 75px); }` dan `.mobile-overlay` sama. [optimized_styles.css:L1745-L1856](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L1745-L1856)
  - Ada override mobile lain: `.mobile-menu { top: 73px; height: calc(100vh - 73px); }` [optimized_styles.css:L5102-L5106](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L5102-L5106)
  - Ini sering bikin “sisa 1–2px” yang memicu scroll/ketidakpas di berbagai device.
- Header/nav di mobile masih cukup tinggi (`.nav { padding: 16px 0; }` + toggle `padding: 8px;`), jadi di layar pendek (mobile landscape / 320px height) lebih rentan terasa “kepotong/scroll”. [optimized_styles.css:L1432-L1759](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L1432-L1759)
- Ada pola `width: 100vw` pada background full-bleed yang berpotensi memicu horizontal overflow di mobile tertentu. [optimized_styles.css:L1389-L1397](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L1389-L1397)

## Target Audit
- Semua ukuran mobile (≤767px) termasuk 320/360/375/390/414/480/600/767 dan orientasi landscape.
- Tidak ada tabrakan layout (overlap/terpotong), tidak ada horizontal scroll.
- Mobile toggle/header dibuat lebih pendek agar tidak memicu scroll.

## Rencana Perubahan
1. **Bikin tinggi header/drawer dinamis (hilangkan hardcode 75/73px)**
   - Tambah CSS var `--header-h`.
   - Set `top: var(--header-h)` untuk `.mobile-menu` dan `.mobile-overlay`.
   - Ubah height ke dynamic viewport: `height: calc(100dvh - var(--header-h));` dengan fallback `100vh`.
   - Tambah JS kecil di `optimized_script.js` untuk mengisi `--header-h` dari `header.offsetHeight` (update saat load + resize/orientationchange).

2. **Kecilkan tinggi header & tombol toggle di breakpoint mobile**
   - Di `@media (max-width: 767px)`:
     - Kurangi `padding` `.nav` (mis. 16px → 12px atau 10px).
     - Kurangi `padding` `.mobile-toggle` (8px → 6px) + rapikan gap/span size bila perlu.
     - Jika perlu, kecilkan `.logo-mark` sedikit agar header total lebih pendek.
   - Tujuan: header lebih “ringkas” tanpa mengorbankan tap target.

3. **Audit dan eliminasi horizontal overflow**
   - Cari sumber overflow (utama: elemen `100vw` full-bleed).
   - Ganti pendekatan `width: 100vw` menjadi layout yang aman (mis. `left: 0; right: 0; width: auto;` atau `width: 100%;`) pada breakpoint mobile.

4. **Audit tabrakan layout section-by-section (mobile)**
   - Hero (judul/subtitle/CTA + slideshow)
   - Trust marquee
   - Features/showcase/process/testimonials
   - RFQ form + file upload + CTA WhatsApp
   - Footer + sticky CTA
   - Perbaiki spacing/line-height/overflow jika ada komponen yang kepotong.

## Verifikasi Setelah Implementasi
- Cek `scrollWidth > clientWidth` untuk pastikan tidak ada horizontal scroll.
- Cek mobile menu: tidak ada “scroll sisa” karena tinggi/offset, baik portrait maupun landscape.
- Cek visual di beberapa viewport (320/360/375/390/414/480/600/767).
- Cek console error/diagnostics.

## File yang Akan Disentuh
- [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css)
- [optimized_script.js](file:///d:/Data%20User/Documents/Jihad/Web/optimized_script.js)
- Jika perlu untuk deploy: versi [dist](file:///d:/Data%20User/Documents/Jihad/Web/dist/) yang relevan