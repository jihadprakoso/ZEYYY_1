## Ringkasan perubahan yang diminta

- Fade-up on scroll untuk **semua section**
- Hover zoom tipis untuk image portfolio: **scale 1 → 1.05**
- Button lift hover: **translateY(-2/-3px)**
- Sticky header: **backdrop-filter blur(10px)** + **background rgba(0,0,0,.7)**

## Kondisi code sekarang (biar nyambung)

- JS sudah punya IntersectionObserver untuk elemen `.reveal` dan menambah class `active`, tapi CSS untuk `.reveal/.active` belum ada (jadi belum kelihatan animasinya).
- Portfolio hover sekarang `scale(1.02)`.
- Button hover kebanyakan sudah `translateY(-2px)`.
- Header sudah sticky, blur 12px, background masih gradient abu.

## Plan implementasi

1. **Aktifkan animasi fade-up berbasis `.reveal` (tanpa ubah logic JS)**
   - Tambah CSS:
     - `.reveal { opacity: 0; transform: translateY(14px); transition: opacity/transform; }`
     - `.reveal.active { opacity: 1; transform: none; }`
     - Support `prefers-reduced-motion: reduce` (matikan animasi).
   - Optional tapi recommended: hidupkan `.delay-1/.delay-2/.delay-3` sebagai `transition-delay` supaya animasi card lebih rapih.

2. **Pasang fade-up untuk semua section**
   - Update [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html): tambahkan class `reveal` ke semua tag `<section>`.
   - Untuk section hero (paling atas), set `class="... reveal active"` supaya tidak blank saat first paint.

3. **Hover zoom portfolio 1 → 1.05**
   - Update `.showcase-item:hover { transform: scale(1.05); }`.
   - Bungkus dengan `@media (hover: hover) and (pointer: fine)` biar tidak ganggu device touch.

4. **Button lift translateY(-2/-3px)**
   - Standarisasi hover:
     - Primary CTA (`.btn-hero-primary`, `.btn-cta-wa`, `.btn-submit-rfq`, `.btn-wa-compact`, `.sticky-cta`) → `translateY(-3px)`.
     - Secondary (`.btn-hero-secondary` dan button sekunder lain) → `translateY(-2px)`.
   - Pastikan tetap di `@media (hover: hover) and (pointer: fine)`.

5. **Sticky header blur(10px) + rgba(0,0,0,.7)**
   - Ubah header styling agar konsisten:
     - `header` dan `header::before` pakai `background: rgba(0,0,0,0.7)`
     - `backdrop-filter: blur(10px)`
   - Update juga state `header.scrolled` agar sama (karena JS menambah class `scrolled` saat scroll > 50px).
   - Sesuaikan variable `--header-text` supaya tetap kontras (putih) untuk nav/link.

6. **Verifikasi**
   - Cek scroll: tiap section fade-up smooth.
   - Cek hover: portfolio 1.05, tombol lift sesuai.
   - Cek header: blur 10 + rgba(0,0,0,.7) tetap readable di light/dark.
   - Cek `prefers-reduced-motion` aman.

File yang akan disentuh: [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css), [optimized_script.js](file:///d:/Data%20User/Documents/Jihad/Web/optimized_script.js) (kemungkinan tidak perlu ubah logic), [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html).