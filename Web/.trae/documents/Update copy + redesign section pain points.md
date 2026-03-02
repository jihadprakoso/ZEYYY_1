## Perubahan Copy (teks)
- Ubah judul CTA di [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L1311-L1347) dan [dist/index.html](file:///d:/Data%20User/Documents/Jihad/Web/dist/index.html) dari:
  - “Siap mulai bikin packaging brand Anda?”
  - menjadi “Siap untuk bikin packaging brand Anda ?”

## Samakan Style Judul “Produksi packaging sering ribet?”
- Di section pain points (sekarang pakai `<h2>` polos di [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L634-L662)):
  - Ubah `<h2>` menjadi `<h2 class="section-title reveal">…</h2>`
  - Ubah subtitle jadi `<p class="section-subtitle">…</p>`
  - Bungkus judul+subtitle dengan `<div class="section-header">…</div>` agar konsisten dengan section “Produksi yang Terstruktur & Terkontrol”.
  - Hapus inline `style="text-align:center"` karena `.section-header` sudah center.

## Saran Desain (biar ngeblend, tidak “aneh”)
- Jadikan section ini sebagai “Problem → Solution bridge”:
  - Tambahkan badge kecil di atas judul: `<span class="section-badge">Masalah Umum</span>` (class sudah ada).
  - Tambahkan background lembut seperti section lain dengan class `stretch-bg` + rule baru `.pain-points-section.stretch-bg::before { … }` (gradient halus merah transparan) supaya menyatu dengan tema.
  - (Opsional) Tambahkan panel/container halus di belakang grid (background `var(--glass)` + border) agar kartu pain points terasa satu blok premium.

## Implementasi CSS
- Tambah rule baru di [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css) untuk:
  - `.pain-points-section` (spacing/typography konsisten)
  - `.pain-points-section.stretch-bg::before` (gradient halus)
  - (Opsional) `.pain-points-panel` jika dipakai

## Sinkronisasi dist
- Setelah edit root, rebuild dist memakai [build-dist.ps1](file:///d:/Data%20User/Documents/Jihad/Web/build-dist.ps1) agar hasil upload konsisten.

## Verifikasi
- Preview lokal untuk cek visual blend (desktop+mobile)
- Cek asset refs via `tools/check-local-refs.js` (root + dist)
- Lighthouse sanity check (desktop) untuk memastikan tidak ada regresi besar