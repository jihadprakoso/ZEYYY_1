## Tujuan
- Mengembalikan copy **HERO** dan **FAQ** ke versi sebelumnya (sebelum update copywriting terakhir).

## Temuan
- HERO saat ini sudah memakai copy baru (Hardbox Premium untuk Brand Kamu + microcopy “MOQ mulai 200 pcs …”). [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L360-L437)
- FAQ saat ini sudah diringkas jadi 4 pertanyaan. [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L1065-L1131)
- Versi copy HERO sebelumnya masih tersedia di backup proyek (judul “Solusi Packaging Premium…” + subtitle “Desain custom…” + microcopy “MOQ 200 pcs …”). [master_site/index.html](file:///d:/Data%20User/Documents/Jihad/Web/_master_backup/2026-02-04_112023/master_site/index.html#L256-L321)
- Versi FAQ sebelumnya (format FAQ lengkap dengan beberapa item) juga tersedia di backup proyek. [master_site/index.html](file:///d:/Data%20User/Documents/Jihad/Web/_master_backup/2026-02-04_112023/master_site/index.html#L821-L949)

## Rencana Perubahan
1. **Revert HERO di index.html**
   - Kembalikan:
     - `.hero-title` → “Solusi Packaging Premium untuk Tampilan Brand yang Lebih Baik”
     - `.hero-subtitle` → “Desain custom sepenuhnya— pilih model, atur ukuran & bahan sesuai keinginan Anda.\nProses cepat, anti ribet.”
     - `.hero-microcopy` → “MOQ 200 pcs • Gratis Konsultasi • 14-21 Hari Produksi”
   - Tombol CTA hero tetap (WhatsApp + Portofolio).

2. **Revert FAQ di index.html**
   - Kembalikan struktur dan isi FAQ ke versi sebelumnya (beberapa item, bukan 4 item ringkas).
   - Pertahankan markup accordion (`.faq-item`, `.faq-question`, `.faq-answer`) supaya JS existing tetap jalan.

3. **Samakan perubahan untuk dist**
   - Terapkan revert HERO + FAQ yang sama pada [dist/index.html](file:///d:/Data%20User/Documents/Jihad/Web/dist/index.html) agar versi deploy konsisten.

4. **Verifikasi**
   - Pastikan teks HERO/FAQ yang baru sudah hilang dari `index.html` dan `dist/index.html`.
   - Pastikan diagnostics bersih dan FAQ accordion masih bisa expand/collapse.

## File yang akan diubah
- [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html)
- [dist/index.html](file:///d:/Data%20User/Documents/Jihad/Web/dist/index.html)