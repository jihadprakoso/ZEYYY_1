## Target

- Di **mobile**, tombol sticky CTA jadi **ikon WhatsApp saja** (lingkaran) di **kanan bawah**.
- Di desktop/tablet, sticky CTA tetap seperti sekarang (ikon + teks).

## Kondisi sekarang

- Markup sticky CTA di [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html) masih berupa `svg` + teks langsung.
- CSS mobile saat ini mengubah sticky CTA jadi **bottom bar full-width** (ada 2 blok media query yang mengatur ini) di [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css).

## Perubahan yang akan dilakukan

1. **Update markup sticky CTA agar teks bisa di-hide khusus mobile**
   - Bungkus teks `Chat Sekarang` jadi `<span class="sticky-cta-text">Chat Sekarang</span>`.
   - Tambahkan `aria-label="Chat via WhatsApp"` pada link `.sticky-cta` agar aksesibilitas tetap bagus saat teks disembunyikan.

2. **Ubah CSS khusus mobile (max-width: 767px) dari bottom-bar → floating icon**
   - Di semua blok `@media (max-width: 767px)` yang mengatur `.sticky-cta`:
     - Hapus/override properti full-width: `left: 0/16px`, `right: 0/16px`, `border-radius: 0/12px`, `justify-content: center` versi bar.
     - Set bentuk ikon:
       - `left: auto; right: 16px; bottom: 16px;`
       - `width/height` (mis. 56px), `padding: 0`, `border-radius: 999px`
       - `display: grid; place-items: center; gap: 0`
       - `box-shadow` tetap premium
     - Sembunyikan teks: `.sticky-cta-text { display: none; }`
     - Besarkan ikon: `.sticky-cta svg { width: 26px; height: 26px; }`

3. **Rapikan spacing bawah mobile**
   - Karena bukan bottom bar lagi, hapus/kurangi padding bawah ekstra (mis. `main#main-content padding-bottom: calc(72px + ...)`) supaya tidak ada whitespace besar.
   - Tetap aman untuk notch: pakai `env(safe-area-inset-bottom)` seperlunya.

4. **Verifikasi**
   - Mobile: terlihat ikon WA bulat di kanan bawah, tidak menutupi konten, animasi hide tetap berfungsi.
   - Desktop: CTA tetap ikon + teks.

File yang akan diubah: [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html), [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css).