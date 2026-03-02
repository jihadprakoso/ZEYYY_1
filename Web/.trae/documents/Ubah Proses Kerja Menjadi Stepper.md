## Target
- Ganti tampilan section **Proses Kerja Kami** dari layout card (`.process-steps` / `.process-step`) menjadi **vertical stepper/timeline** yang clean (tanpa card) dan tetap responsif.

## Kondisi Saat Ini
- Markup proses ada di [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L541-L598) memakai `.process-steps` (grid) berisi `.process-step` (card) + `.step-number` + gambar.
- Styling card proses ada di [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L2308-L2376).

## Contoh Markup (pengganti `.process-steps`)
Akan saya ganti menjadi list stepper (lebih semantik + mudah di-mobile):

```html
<ol class="process-stepper" aria-label="Tahapan proses kerja">
  <li class="process-stepper-item">
    <div class="process-stepper-marker" aria-hidden="true">1</div>
    <div class="process-stepper-body">
      <h3 class="process-stepper-title">Konsultasi Gratis</h3>
      <p class="process-stepper-desc">Diskusi kebutuhan & budget via WhatsApp</p>
    </div>
    <div class="process-stepper-media" aria-hidden="true">
      <img src="assets/images/process/consultation.webp" alt="" loading="lazy" decoding="async" width="300" height="160">
    </div>
  </li>

  <li class="process-stepper-item">
    <div class="process-stepper-marker" aria-hidden="true">2</div>
    <div class="process-stepper-body">
      <h3 class="process-stepper-title">Design & Sample</h3>
      <p class="process-stepper-desc">Revisi unlimited sampai hasilnya sesuai kebutuhan</p>
    </div>
    <div class="process-stepper-media" aria-hidden="true">
      <img src="assets/images/process/design.webp" alt="" loading="lazy" decoding="async" width="300" height="160">
    </div>
  </li>

  <li class="process-stepper-item">
    <div class="process-stepper-marker" aria-hidden="true">3</div>
    <div class="process-stepper-body">
      <h3 class="process-stepper-title">Produksi</h3>
      <p class="process-stepper-desc">14-21 hari kerja dengan QC ketat</p>
    </div>
    <div class="process-stepper-media" aria-hidden="true">
      <img src="assets/images/process/production.webp" alt="" loading="lazy" decoding="async" width="300" height="160">
    </div>
  </li>

  <li class="process-stepper-item">
    <div class="process-stepper-marker" aria-hidden="true">4</div>
    <div class="process-stepper-body">
      <h3 class="process-stepper-title">Pengiriman</h3>
      <p class="process-stepper-desc">Packing aman ke seluruh Indonesia</p>
    </div>
    <div class="process-stepper-media" aria-hidden="true">
      <img src="assets/images/process/delivery.webp" alt="" loading="lazy" decoding="async" width="300" height="160">
    </div>
  </li>
</ol>
```

Catatan:
- Gambar tetap ada, tapi jadi **thumbnail** (bukan card). `alt` gambar saya kosongkan karena informasi utamanya sudah ada di teks step (lebih aksesibel).

## Contoh CSS (tanpa card, responsif)
Akan saya tambahkan di section process (dekat rules `.process-section`) dan tidak mengubah komponen lain.

```css
.process-stepper {
  list-style: none;
  margin: 48px 0 0;
  padding: 0;
  position: relative;
}

.process-stepper::before {
  content: '';
  position: absolute;
  left: 22px;
  top: 22px;
  bottom: 22px;
  width: 2px;
  background: rgba(0, 0, 0, 0.10);
}

.process-stepper-item {
  position: relative;
  display: grid;
  grid-template-columns: 44px 1fr minmax(120px, 180px);
  gap: 16px;
  align-items: center;
  padding: 16px 0;
}

.process-stepper-item:not(:last-child) {
  border-bottom: 1px solid rgba(0, 0, 0, 0.06);
}

.process-stepper-marker {
  width: 44px;
  height: 44px;
  border-radius: 999px;
  background: var(--accent);
  color: #ffffff;
  display: grid;
  place-items: center;
  font-weight: 800;
  position: relative;
  z-index: 1;
}

.process-stepper-title {
  margin: 0 0 6px;
  font-size: 18px;
  font-weight: 700;
  color: var(--text);
}

.process-stepper-desc {
  margin: 0;
  font-size: 14px;
  color: var(--text-muted);
  line-height: 1.6;
}

.process-stepper-media {
  justify-self: end;
  width: 100%;
  max-width: 180px;
  aspect-ratio: 3 / 2;
  border-radius: 12px;
  overflow: hidden;
  border: 1px solid rgba(0, 0, 0, 0.08);
  background: var(--glass);
}

.process-stepper-media img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  display: block;
}

.process-stepper-item:hover {
  background: linear-gradient(90deg, rgba(215, 25, 33, 0.08), rgba(215, 25, 33, 0));
}

[data-theme="dark"] .process-stepper::before {
  background: rgba(255, 255, 255, 0.14);
}

[data-theme="dark"] .process-stepper-item:not(:last-child) {
  border-bottom-color: rgba(255, 255, 255, 0.08);
}

[data-theme="dark"] .process-stepper-media {
  border-color: rgba(255, 255, 255, 0.10);
}

@media (max-width: 720px) {
  .process-stepper-item {
    grid-template-columns: 44px 1fr;
    align-items: start;
  }

  .process-stepper-media {
    grid-column: 2;
    justify-self: start;
    max-width: 320px;
    margin-top: 10px;
  }
}
```

## Implementasi di Repo (setelah kamu OK)
1. Update markup di section process: ganti `<div class="process-steps">...</div>` menjadi `<ol class="process-stepper">...</ol>`.
2. Tambahkan CSS stepper di [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css) dekat block **13. PROCESS SECTION**.
3. Verifikasi responsif (desktop + mobile) dan dark mode tidak rusak.

## Verifikasi
- Cek tampilan di lebar 375px, 768px, 1024px.
- Pastikan hover highlight halus, teks terbaca, thumbnail tidak bikin layout “semrawut”.

Kalau desain ini sudah pas, saya lanjutkan implementasi persis seperti contoh di atas.