## Tujuan
- Semua gambar **selain Hero** (logo, galeri, portofolio, process, marketplace, payment, dll) **tidak download** saat initial load.
- Download gambar dimulai **setelah user scroll**.
- Sebelum load, tampil **placeholder blur/shimmer** yang **rapi di desktop & mobile** (tidak bikin layout lompat / CLS).

## Implementasi yang Akan Saya Terapkan
### 1) HTML (index.html): JS-lazy untuk semua gambar non-hero
- Untuk setiap `img` di luar Hero:
  - Pindahkan URL asli ke `data-src`.
  - Isi `src` dengan placeholder inline SVG ringan.
  - Tambahkan class `lazy-img`.
  - Pertahankan `width`/`height` (atau tambahkan jika ada yang belum) supaya tinggi elemen sudah “fix” sebelum gambar load.
- Hero tidak diubah (hero utama tetap eager).

### 2) CSS (optimized_styles.css): placeholder yang rapi di desktop & mobile
- Tambahkan style `.lazy-img`:
  - Placeholder terlihat (tidak hidden oleh rule lazy lama).
  - Shimmer background + blur sampai `.loaded`.
  - Setelah `.loaded`, blur/shimmer hilang (gambar tajam).
- Tambahkan aturan khusus untuk logo kecil (SVG) agar placeholder tidak terlihat “pecah”:
  - Jaga `object-fit: contain` dan ukuran konsisten.
- Pastikan warna placeholder mengikuti theme (light/dark) agar tetap rapi.

### 3) JS (optimized_script.js): mulai load setelah scroll + IntersectionObserver
- Buat loader untuk `img.lazy-img[data-src]`:
  - **Tidak aktif saat page load**.
  - Aktif setelah event **scroll pertama**.
  - Observer load gambar ketika mendekati viewport (rootMargin ~300px) agar smooth di mobile.
  - Setelah `load`, tambahkan `.loaded`.

## Verifikasi (desktop & mobile)
- Rebuild dist.
- Cek di preview:
  - Initial load: hanya hero yang langsung tampil.
  - Non-hero: placeholder tampil rapi (tidak collapse).
  - Setelah scroll: gambar muncul dan tajam.
- Test viewport: 360, 390, 414, 768, 1024, 1366.
- Pastikan tidak ada horizontal scroll/overlap akibat placeholder.
- Jalankan pengecekan refs lokal (root + dist).