## Target
- Kembalikan **HERO** dan **FAQ** ke versi copy “sebelum terakhir” yang kamu maksud (bukan versi backup lama).
- Untuk **FAQ**, patokan versinya adalah yang seperti di screenshot (list pertanyaan panjang dengan item “Saya tidak punya desain…” dst).

## Perubahan yang akan dilakukan
### 1) HERO (index.html + dist/index.html)
- Set ulang ke copy versi yang lebih baru (yang sempat terpasang saat update copywriting terakhir):
  - Judul: “Solusi Packaging Hardbox Premium untuk Brand Kamu”
  - Subtitle: “Full custom (ukuran, bahan, finishing) dengan hasil rapi dan konsisten—bikin produk terlihat lebih mahal, tanpa proses yang bikin pusing.”
  - Microcopy: “MOQ mulai 200 pcs • Produksi cepat • Konsultasi via WhatsApp”
- Tombol CTA hero tidak diubah (tetap WhatsApp + Portofolio).

### 2) FAQ (index.html + dist/index.html)
- Ganti seluruh isi `.faq-list` menjadi versi seperti screenshot:
  - “Saya tidak punya desain, apakah deartbox bisa bantu buatkan desain kemasannya?”
  - “Berapa minimum order quantity (MOQ) untuk hardbox custom?”
  - “Apakah saya bisa memesan di bawah MOQ?”
  - “Berapa lama waktu produksi hardbox custom?”
  - “Apa saja finishing premium yang tersedia?”
  - “Apakah bisa request sample sebelum mass production?”
  - “Saya punya contoh cetakan yang sebelumnya dari tempat lain, apakah warnanya bisa sama?”
  - Dan item lanjutan yang biasanya ada di versi ini (pembayaran/DP, pengiriman seluruh Indonesia, pengiriman partial), supaya konsisten dengan versi FAQ panjang.
- Heading FAQ tetap seperti di layout sekarang:
  - Title: “FAQ”
  - Subtitle: “Pertanyaan umum tentang MOQ, timeline, finishing, dan pembayaran”
- Struktur accordion (`.faq-item`, `.faq-question`, `.faq-answer`) dipertahankan agar JS expand/collapse tetap jalan.

### 3) Verifikasi
- Pastikan tidak ada sisa:
  - Hero versi “Solusi Packaging Premium…”
  - FAQ versi ringkas 4 item
- Jalankan diagnostics untuk memastikan tidak ada error.
- Quick-check: FAQ masih bisa expand/collapse normal.

## File yang akan diubah
- d:/Data User/Documents/Jihad/Web/index.html
- d:/Data User/Documents/Jihad/Web/dist/index.html