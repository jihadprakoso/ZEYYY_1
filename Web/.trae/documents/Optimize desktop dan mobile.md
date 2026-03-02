## Tujuan Optimasi
- **Desktop & mobile konsisten**: tidak ada overflow horizontal, spacing proporsional, grid rapi, dan elemen tidak tabrakan.
- **Lebih ringan**: kurangi CSS duplikat/override yang tidak perlu, dan batasi efek berat di perangkat kecil.
- **Terukur**: verifikasi dengan preview + audit performa (Lighthouse) untuk desktop dan mobile.

## Temuan Cepat (dari kode saat ini)
- Di [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css) ada **banyak aturan responsif yang berulang** (grid-template-columns untuk section yang sama muncul berkali-kali, termasuk beberapa `!important`). Ini bikin maintenance sulit dan bisa memicu konflik layout.
- `--container-pad: clamp(16px, 6vw, 80px)` cenderung **terlalu besar di laptop 1024–1366px** (konten terasa sempit). Ini kandidat utama untuk “optimisasi desktop”.
- Ada potensi overflow di desktop karena `.hero-subtitle-line` memakai `white-space: nowrap` pada `min-width: 1024px`.

## Rencana Eksekusi
### 1) Audit responsif desktop + mobile (terarah)
- Test viewport: **320, 360, 375, 390, 414, 768, 834, 1024, 1280, 1366, 1440, 1920** (portrait/landscape untuk mobile).
- Fokus cek:
  - Ada/tidak **horizontal scroll**.
  - Header/nav: tidak overlap (logo, theme toggle, hamburger; dropdown desktop aman di sisi kanan).
  - Hero: teks tidak overflow, CTA tidak kepotong.
  - Grid (features/showcase/process/testimonials/footer): jumlah kolom sesuai breakpoint dan jarak antar kartu konsisten.
  - Modal sukses & menu mobile: aman di layar pendek.

### 2) Rapikan sistem spacing dan breakpoint (desktop + mobile)
- Sesuaikan `--container-pad` agar **lebih kecil di 1024–1366px**, tapi tetap lega di 1440+.
- Pastikan `--section-pad`/`--grid-gap` punya skala yang mulus antar breakpoint.
- Ubah `.hero-subtitle-line` agar **tidak memaksa nowrap** pada lebar borderline (mis. pindahkan nowrap ke breakpoint lebih besar, atau jadikan wrap-safe).

### 3) Konsolidasi CSS responsif (hapus duplikasi & konflik)
- Identifikasi dan gabungkan aturan berulang untuk:
  - `.features-grid`, `.showcase-grid`, `.footer-grid`, dan aturan grid lain yang muncul berulang.
- Kurangi `!important` yang tidak diperlukan dengan:
  - Memindahkan rule ke urutan yang benar.
  - Menyatukan responsive section menjadi satu blok yang jelas.
- Hasil: CSS lebih ringan, perilaku responsif lebih stabil.

### 4) Optimisasi performa visual (tanpa mengubah desain inti)
- Tambahkan penghematan untuk perangkat kecil/low-power:
  - `@media (prefers-reduced-motion: reduce)` untuk marquee/animasi lain yang masih jalan.
  - Kurangi efek berat (blur/backdrop/filter) pada mobile bila terlihat membebani.
- (Opsional) Tambahkan mode debug `?debug=1` untuk **mendeteksi elemen penyebab overflow** dan log ke console (mempercepat iterasi).

### 5) Verifikasi dan output
- Rebuild dist.
- Jalankan pengecekan:
  - Referensi lokal (root & dist).
  - Lighthouse **desktop & mobile** (Performance/A11y/BP/SEO).
- Pastikan tidak ada diagnostics baru.

## File yang Akan Disentuh
- [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css) (utama)
- [optimized_script.js](file:///d:/Data%20User/Documents/Jihad/Web/optimized_script.js) (opsional untuk debug overflow/throttle resize)
- [dist/index.html](file:///d:/Data%20User/Documents/Jihad/Web/dist/index.html) (via rebuild)

Jika Anda setuju, saya lanjut eksekusi langkah-langkah di atas: rapikan spacing desktop, konsolidasi responsive rules, dan jalankan verifikasi desktop+mobile sampai aman.