## Ringkasan Perubahan
1. Card **MOQ Fleksibel**: ganti gambar jadi `MOQ.webp`.
2. Tombol **Portofolio Lainnya**: pindahkan keluar dari blok `.inline-cta-visual`.
3. Filter **Signature Box** & **Essentials Box**: pastikan masing-masing menampilkan **6 card**.
4. Hover **logo social footer**: ubah hover jadi warna **oranye yang sama** untuk light/dark.
5. Hero slideshow: tambahkan foto `custom-01.webp`, `custom-02.webp`, `hardbox-W3B.webp`.

## Temuan Saat Ini
- `MOQ.webp`, `timeline.webp`, `board.webp`, `machine.webp` sudah ada di `dist/assets/images/features/`, tapi `MOQ.webp` belum ada di source `assets/images/features/`.
- `custom-01.webp` dan `custom-02.webp` ada di `dist/assets/images/halamanutama/`, namun belum ada di source `assets/images/halamanutama/`.
- Hero slideshow di [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L501-L543) saat ini berisi 3 slide dan 3 dot.
- Tombol `Portofolio Lainnya` saat ini berada di dalam `.inline-cta-visual`: [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L880-L901).
- CSS hover social footer saat ini memakai `var(--accent)` dan warna link putih: [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L3853-L3887).

## Langkah Implementasi
### 1) Aset gambar yang belum ada di source
- Salin file berikut dari `dist/` ke `assets/`:
  - `dist/assets/images/features/MOQ.webp` → `assets/images/features/MOQ.webp`
  - `dist/assets/images/halamanutama/custom-01.webp` → `assets/images/halamanutama/custom-01.webp`
  - `dist/assets/images/halamanutama/custom-02.webp` → `assets/images/halamanutama/custom-02.webp`

### 2) Update card MOQ Fleksibel
- Edit [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L720-L728):
  - Ubah `data-src` MOQ dari `assets/images/features/moq-flexible.webp` → `assets/images/features/MOQ.webp`.

### 3) Pindahkan tombol Portofolio Lainnya (di luar inline CTA)
- Edit [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L880-L901):
  - Keluarkan anchor `Portofolio Lainnya` dari `.inline-cta-visual`.
  - Tempatkan sebagai tombol terpisah setelah grid portofolio (mis. setelah `.showcase-empty`) agar bukan bagian dari CTA block.
- Update CSS di [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css):
  - Hapus/abaikan aturan spesifik `.btn-inline-more` dan ganti dengan wrapper baru (mis. `.showcase-more`) untuk spacing/align.

### 4) Setiap filter 6 card (Signature & Essentials)
- Saat ini signature berjumlah lebih dari essentials.
- Edit bagian `.showcase-grid` di [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L791-L878):
  - Ubah `data-category` pada 2 card signature menjadi essentials (dan sesuaikan teks prefix “Signature Box:” → “Essentials Box:” pada card yang dipindahkan) sehingga total:
    - `signature`: 6 card
    - `essentials`: 6 card

### 5) Hover social footer jadi oranye
- Edit [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L3853-L3887):
  - Ubah `.social-link:hover { background: var(--orange); }` (menggantikan `var(--accent)`).
  - Pertahankan icon tetap kontras (ikon tetap putih saat hover) agar hover terlihat “oranye” di background untuk light/dark.

### 6) Tambah slide hero + dot
- Edit [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L501-L543):
  - Tambahkan 3 `.hero-slide` baru dengan image:
    - `assets/images/halamanutama/custom-01.webp`
    - `assets/images/halamanutama/custom-02.webp`
    - `assets/images/halamanutama/hardbox-W3B.webp`
  - Tambahkan 3 `span.slide-dot` baru agar jumlah dot = jumlah slide.
  - Pastikan slide pertama tetap `loading="eager"` + `fetchpriority="high"`.

## Build dist + Verifikasi
- Jalankan `build-dist.ps1`.
- Verifikasi:
  - `dist/index.html`:
    - MOQ pakai `MOQ.webp`.
    - Tombol `Portofolio Lainnya` berada di luar `.inline-cta-visual`.
    - Filter signature/essentials masing-masing menampilkan 6 card.
    - Hero punya 6 slide + 6 dot.
  - `dist/assets/images/features/` memiliki `MOQ.webp`.
  - `dist/assets/images/halamanutama/` memiliki `custom-01.webp` dan `custom-02.webp`.