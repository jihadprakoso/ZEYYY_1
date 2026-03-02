## Tujuan
- Saat **dark mode**, background semua section dibuat sama seperti background hero (gradient `var(--hero-bg-top)` → `var(--hero-bg-bottom)`).
- **Pengecualian:** `.marketplace-section` dan `.cta-section-modern` tetap merah seperti sekarang.

## Temuan di code
- Sudah ada blok [ALL SECTIONS DARK MODE](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L4484-L4533) yang sekarang ngasih background bergantian (`#1a1a1a` / `#0f0f0f`).
- Marketplace dan CTA sudah di-override merah di blok yang sama.

## Perubahan yang akan dilakukan (CSS saja)
- Di blok **ALL SECTIONS DARK MODE**:
  - Ubah background untuk:
    - `.trust-section`, `.video-section`, `.features-modern`, `.showcase-section`, `.process-section`, `.testimonials-section`, `.rfq-section`, `.faq-section`
  - Dari warna solid menjadi:
    - `background: linear-gradient(180deg, var(--hero-bg-top) 0%, var(--hero-bg-bottom) 100%) !important;`
- Biarkan ini tetap:
  - `.marketplace-section { background: #d71921 !important; }`
  - `.cta-section-modern { background: linear-gradient(135deg, #a01419 0%, #d71921 100%) !important; }`

## File yang akan diubah
- [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L4484-L4533)

## Verifikasi
- Toggle dark mode:
  - Semua section (selain marketplace & CTA akhir) punya background gradient yang sama seperti hero.
  - Marketplace dan CTA akhir tetap merah.
- Rebuild dist dan cek preview.