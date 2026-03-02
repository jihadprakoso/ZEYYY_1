## Ringkasan Kebutuhan
- Semua elemen yang kamu sebutkan harus memakai warna oranye #FA4616 untuk state normal + hover.
- Warna tidak boleh di-hardcode per selector; harus lewat CSS variable.

## Temuan Kode (Supaya Tepat Sasaran)
- Tombol header “Minta Penawaran” memakai class `.cta-nav-secondary` (desktop) dan `.mobile-cta-secondary` (menu mobile) di [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html).
- Warna oranye sudah ada sebagai variable `--orange` dan `--orange-rgb`, tapi sekarang nilainya masih #ff7a00.
- Banyak komponen yang masih pakai `var(--accent)` / `rgba(var(--red-rgb), …)` untuk warna merah, jadi perlu dialihkan ke oranye sesuai daftar request.

## Rencana Implementasi
1. **Set warna oranye global via variable**
   - Ubah `:root { --orange: ...; --orange-rgb: ... }` menjadi:
     - `--orange: #FA4616`
     - `--orange-rgb: 250, 70, 22`
   - Semua perubahan warna berikutnya pakai `var(--orange)` / `rgba(var(--orange-rgb), …)`.

2. **Header “Minta Penawaran” jadi oranye (hover + non-hover)**
   - Update `.cta-nav-secondary` (base/hover/active), termasuk override di hero variant g (`html[data-hero-variant="g"] .cta-nav-secondary`).
   - Update `.mobile-cta-secondary` (base/hover) agar konsisten di menu mobile.

3. **Hero badge “Dipercaya 50+ brand…” jadi oranye**
   - Update `.hero-badge` (background/border) dari merah ke oranye.
   - Pastikan override variant g (`html[data-hero-variant="g"] ...`) juga ikut oranye.

4. **Trust section title “Dipercaya 50+ brand di Indonesia” jadi oranye**
   - Update `.trust-title { color: var(--orange); }`.

5. **Hero button “Lihat Portofolio” hover oranye**
   - Update `.btn-hero-secondary:hover` dan juga override variant g agar hovernya oranye.

6. **Pain points: “Lihat Portofolio” hover oranye + font samakan dengan “Konsultasi Gratis”**
   - Update `.pain-cta-secondary`:
     - Samakan tipografi (font-size, font-weight, padding, border-radius, align-items, gap) mengikuti `.btn-cta-wa`.
     - Hover/background pakai `var(--orange)`.

7. **Tombol “Putar Video” pakai oranye**
   - Update `.video-play-btn` dan `:hover` ke oranye (sebelumnya masih rgba oranye lama).

8. **Semua “Informasi Selengkapnya” jadi oranye**
   - Update `.feature-card-cta` (text/background/border + hover) dari accent/red-rgb ke oranye.

9. **Filter “Custom Box / Hardbox / Softbox” jadi oranye**
   - Update `.showcase-filter-btn` (default/hover/active) ke oranye.

10. **Inline CTA: tombol “Minta Penawaran” setelah portofolio jadi oranye**
   - Update `.btn-inline-secondary` (base/hover) dari accent ke oranye.

11. **Proses Kerja: nomor (marker) jadi oranye**
   - Update `.process-stepper-marker` background ke oranye.
   - Update hover highlight `.process-stepper-item:hover` dari `red-rgb` ke `orange-rgb`.

12. **RFQ: tombol “Kirim Permintaan” jadi oranye (hover + non-hover)**
   - Update `.btn-submit-rfq` dan hover (saat ini hijau) ke oranye.

13. **Marketplace section background jadi oranye**
   - Update `.marketplace-section { background: var(--orange); }`.
   - Update `.marketplace-arrow` jika masih pakai accent.

14. **CTA “Siap bikin packaging brand Anda?” background jadi oranye**
   - Update `.cta-section-modern` background (saat ini gradient accent) menjadi oranye (solid atau gradient berbasis `--orange`).

## File yang Akan Diubah
- `d:\Data User\Documents\Jihad\Web\optimized_styles.css`
- (Jika diperlukan untuk konsistensi theme variant) bagian override terkait di file yang sama.
- Lalu rebuild output ke `dist/`.

## Verifikasi
- Rebuild `dist`.
- Cek local refs root+dist.
- Preview lokal untuk memastikan semua state hover/non-hover sesuai di desktop dan mobile.