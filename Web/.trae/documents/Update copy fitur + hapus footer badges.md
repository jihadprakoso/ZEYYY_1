## Yang Akan Diubah
- Hapus badge footer “Made in Indonesia” dan “🔒 Aman  Terpercaya”.
- Ganti **subtitle/description** tiap kartu di section “Kenapa Brand Pilih deartbox?” (bukan judulnya).
- Ubah label tombol kartu dari “Tanya Harga” menjadi “Informasi Selengkapnya”.

## Detail Implementasi
1. **Footer badges**
   - Hapus 2 badge di footer pada [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L1466-L1473) (blok `.footer-badges`).

2. **Section “Kenapa Brand Pilih deartbox?”**
   - Di [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L686-L750) biarkan `h3.feature-title` tetap.
   - Ganti `p.feature-description` (subtitle kartu) menjadi persis:
     - Card 1 (MOQ): “Mulai Produksi dengan MOQ Fleksibel: Hanya 200 Pcs”
     - Card 2 (QC): “Quality Control yang Teliti untuk Hasil Konsisten”
     - Card 3 (Design): “Desain Kustom 100% untuk Menyesuaikan dengan Brand Anda”
     - Card 4 (Timeline): “Timeline Produksi yang Jelas dan Terukur”
     - Card 5 (Board): “Board Kustom untuk Kekuatan, Kualitas Premium, dan Konsistensi”
     - Card 6 (Mesin): “Mesin Produksi Semi-Automatis untuk Konsistensi dan Akurasi”
   - Ubah text `a.feature-card-cta` dari “Tanya Harga” → “Informasi Selengkapnya”.

3. **Sinkronisasi dist**
   - Rebuild dist via [build-dist.ps1](file:///d:/Data%20User/Documents/Jihad/Web/build-dist.ps1) agar [dist/index.html](file:///d:/Data%20User/Documents/Jihad/Web/dist/index.html) ikut berubah.

## Verifikasi
- Cek asset refs via `tools/check-local-refs.js` untuk `index.html` dan `dist/index.html`.
- Preview lokal untuk memastikan section fitur dan footer rapi.