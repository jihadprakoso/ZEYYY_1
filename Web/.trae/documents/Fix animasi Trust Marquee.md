## Diagnosis (dari kode saat ini)
- Animasi marquee sudah didefinisikan dengan benar:
  - `.marquee-track { animation: marquee 34s linear infinite; }` dan keyframes `@keyframes marquee`: [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L2533-L2593)
- Ada rule yang bisa membuat marquee terlihat “tidak jalan” pada perangkat touch:
  - `.trust-marquee:hover .marquee-track { animation-play-state: paused; }` (di mobile, state `:hover` kadang “nyangkut” setelah tap/scroll sehingga animasi bisa berhenti): [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L2573-L2575)
- Jika OS/browser user mengaktifkan “Reduce motion”, animasi memang dimatikan di blok:
  - `@media (prefers-reduced-motion: reduce) { ... .marquee-track { animation: none !important; ... } }`: [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L5228-L5245)

## Perubahan yang Akan Saya Terapkan
1. Batasi pause-on-hover hanya untuk device yang benar-benar punya hover (desktop):
   - Pindahkan rule pause ke:
     - `@media (hover: hover) and (pointer: fine) { .trust-marquee:hover .marquee-track { animation-play-state: paused; } }`
   - Tujuan: di mobile/touch animasi tidak “ke-pause permanen”.
2. Tambahkan fallback untuk Safari/WebKit (opsional tapi aman):
   - Tambah `-webkit-mask-image` untuk `.trust-marquee` agar efek fade-edge tetap konsisten di Safari.
3. (Opsional) Jika Anda ingin marquee tetap bergerak walau Reduce Motion aktif:
   - Ubah blok `prefers-reduced-motion` untuk marquee menjadi pelan (mis. 120s) alih-alih `animation: none`. Ini akan membuat animasi tetap jalan, tapi lebih halus.

## Verifikasi
- Buka preview dan cek marquee bergerak di:
  - Desktop (hover di marquee harus pause, lepas hover jalan lagi)
  - Mobile/touch (scroll/tap tidak membuat animasi berhenti permanen)
- Cek computed style pada `.marquee-track` memastikan `animation-name: marquee` dan `animation-play-state: running`.
- Rebuild dist dan quick check refs lokal.

Jika sudah OK, saya lanjut implementasi perubahan CSS-nya dan verifikasi di preview.