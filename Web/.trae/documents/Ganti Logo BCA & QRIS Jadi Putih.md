## Target

1. Logo pembayaran BCA dan QRIS menjadi **warna putih** untuk **lightmode dan darkmode**.
2. Section testimoni: ganti avatar inisial jadi foto:

   * Sarah Chen → `testimoni-1.webp`

   * Budi Santoso → `testimoni-2.webp`

   * Diana Putri → `testimoni-3.webp`

## Temuan

* Logo pembayaran dipakai di footer: `assets/images/payments/bca.svg` dan `assets/images/payments/qris.svg` (lihat [index.html](file:///d:/Data%20User/Documents/Jihad/Web/dist/index.html#L1573-L1579)).

* SVG saat ini berwarna:

  * BCA biru `#0060af` (banyak `fill:#0060af` di [bca.svg](file:///d:/Data%20User/Documents/Jihad/Web/dist/assets/images/payments/bca.svg)).

  * QRIS hitam `#010101` lewat `.cls-1` di [qris.svg](file:///d:/Data%20User/Documents/Jihad/Web/dist/assets/images/payments/qris.svg).

* Footer background selalu gelap (`background: var(--header-bg-solid); color: white;` di [optimized\_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/dist/optimized_styles.css#L3735-L3761)), jadi logo putih akan tetap terlihat di kedua mode.

* Section testimoni saat ini pakai inisial (SC/BS/DP) via `.testimonial-avatar-initial` di [index.html](file:///d:/Data%20User/Documents/Jihad/Web/dist/index.html#L1088-L1129), padahal CSS sudah mendukung avatar foto `.testimonial-avatar img` (lihat [optimized\_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/dist/optimized_styles.css#L3098-L3110)).

* File foto testimoni sudah tersedia:

  * [testimoni-1.webp](file:///d:/Data%20User/Documents/Jihad/Web/assets/images/testimonials/testimoni-1.webp)

  * [testimoni-2.webp](file:///d:/Data%20User/Documents/Jihad/Web/assets/images/testimonials/testimoni-2.webp)

  * [testimoni-3.webp](file:///d:/Data%20User/Documents/Jihad/Web/assets/images/testimonials/testimoni-3.webp)

## Rencana Implementasi

### A) Ubah logo pembayaran jadi putih

1. Edit **source**:

   * `assets/images/payments/bca.svg`: ubah semua `fill:#0060af` → `fill:#ffffff`.

   * `assets/images/payments/qris.svg`: ubah `.cls-1{fill:#010101;}` → `.cls-1{fill:#ffffff;}`.
2. Rebuild `dist/` supaya versi deploy ikut berubah.

### B) Pasang foto pada card testimoni

1. Edit **source** `index.html` di section testimonials:

   * Ganti `<div class="testimonial-avatar-initial">SC</div>` menjadi:

     * `<div class="testimonial-avatar"><img ... data-src="assets/images/testimonials/testimoni-1.webp" ...></div>`

   * Ganti BS → `testimoni-2.webp`.

   * Ganti DP → `testimoni-3.webp`.
2. Ikuti pola lazy-load yang sudah dipakai di page (placeholder SVG + `data-src`) dan set `width/height` 56x56.
3. Rebuild `dist/`.

## Verifikasi

* Scan cepat:

  * Pastikan tidak ada `#0060af` di BCA dan `#010101` di QRIS (baik di `assets/` maupun `dist/`).

  * Pastikan `dist/index.html` sudah berisi `.testimonial-avatar` + path foto yang benar.

* Re-run build-dist dan cek file output `dist/assets/images/payments/*.svg` dan `dist/assets/images/testimonials/*.webp` ada.

## Output

* Logo BCA dan QRIS tampil putih.

* Tiga kartu testimoni menampilkan foto sesuai file yang Anda sebutkan.

