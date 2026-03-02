## Ringkasan
Update 4 kartu di bagian **“Kenapa Brand Pilih deartbox?”**:
- MOQ Fleksibel: gambar `moq-flexible.webp` (sudah sesuai)
- Timeline Jelas: ganti gambar ke `timeline.webp`
- Special made board: ganti judul jadi `Special-Made Board` dan ganti gambar ke `board.webp`
- Mesin Produksi Semi-Auto: ganti gambar ke `machine.webp`

## Temuan File Aset
- Source `assets/images/features/` saat ini hanya punya: `custom-design.webp`, `moq-flexible.webp`, `quality-control.webp`.
- Di `dist/assets/images/features/` sudah tersedia file yang dibutuhkan: `timeline.webp`, `board.webp`, `machine.webp`.

## Langkah Implementasi
1. **Tambahkan aset ke source**
   - Salin file berikut dari `dist/assets/images/features/` ke `assets/images/features/` agar tidak hilang saat build:
     - `timeline.webp`
     - `board.webp`
     - `machine.webp`

2. **Update kartu pada section “Kenapa Brand Pilih deartbox?”**
   - Edit [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L716-L774):
     - Kartu **Timeline Jelas**: ubah `data-src` dari `assets/images/features/moq-flexible.webp` → `assets/images/features/timeline.webp`.
     - Kartu **Special made Board**:
       - Ubah judul `Special made Board` → `Special-Made Board`.
       - Ubah `data-src` dari `assets/images/features/quality-control.webp` → `assets/images/features/board.webp`.
       - Sesuaikan `alt` agar konsisten menjadi `Special-Made Board`.
     - Kartu **Mesin Produksi Semi-Auto**: ubah `data-src` dari `assets/images/features/custom-design.webp` → `assets/images/features/machine.webp`.

3. **Build ulang dist**
   - Jalankan `build-dist.ps1` untuk menyalin perubahan HTML + aset terbaru ke `dist/`.

## Verifikasi
- Cek `dist/index.html` memastikan 3 kartu tersebut sudah pakai `timeline.webp`, `board.webp`, `machine.webp`.
- Cek `dist/assets/images/features/` memastikan file gambar baru ikut tersalin.
- Quick visual check (buka dist) memastikan gambar tampil dan layout kartu tetap rapi.