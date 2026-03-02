## Rekomendasi warna header
Untuk hero kamu yang sekarang dominan **charcoal (#3E4445) + glow terang**, header paling “nyambung” biasanya bukan putih solid, tapi **charcoal glass** (semi-transparan) supaya:
- Nyatu dengan hero gelap (blend), tapi tetap enak saat sticky di section bawah yang lebih terang.
- Kontras teks/nav tetap aman.

### Opsi 1 (Rekomendasi): Charcoal Glass
- Background: `rgba(62, 68, 69, 0.82)` (basis #3E4445)
- Border bawah: `rgba(255,255,255,0.14)`
- Shadow: `0 10px 30px rgba(0,0,0,0.18)`
- Nav link: `rgba(255,255,255,0.92)`
- Hover pill: `rgba(255,255,255,0.08)`
- Active/underline: tetap **brand red** `#d71921`
- Logo: pakai `deartbox-logo-dark.svg` (yang putih)

### Opsi 2: Light Glass (kalau ingin lebih “clean corporate”)
- Background: `rgba(255,255,255,0.90)` + blur
- Border: `rgba(0,0,0,0.08)`
- Link tetap gelap, accent merah untuk active

## Kondisi kode saat ini (supaya nyambung)
- Header sekarang: `background: var(--bg)` + border var(--border) di [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L1150-L1157)
- Nav link hover/active: pakai `var(--glass)` dan `#fef1f2` di [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L1248-L1284)
- Logo light/dark swap saat `data-theme` di [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L1214-L1229) dan markup logo di [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L106-L131)

## Rencana implementasi (tanpa JS)
1) Tambah CSS variables khusus header (bg/border/text/hover/active) di area variables.
2) Set default variables untuk tampilan normal (tetap seperti sekarang).
3) Buat override khusus variant gelap (mis. `html[data-hero-variant="g"] header { … }`) agar header jadi **charcoal glass**.
4) Override warna `.nav-link`, hover, active supaya tetap kontras di header gelap.
5) Override logo swap untuk variant g (di light theme): tampilkan `.logo-dark` (logo putih) dan sembunyikan `.logo-light`.
6) Verifikasi kontras + tampilan sticky di hero dan saat scroll ke section terang.

Kalau Anda approve, saya implement **Opsi 1 (Charcoal Glass)** untuk variant `g` dulu (yang lagi kamu pakai), tanpa mengubah header di variant lain.