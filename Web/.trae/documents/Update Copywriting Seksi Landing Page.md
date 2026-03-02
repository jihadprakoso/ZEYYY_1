## Ringkasan
Update copywriting sesuai teks yang kamu kirim untuk section: Hero, Pain/Problem, Solusi/Promise (Video), Features (Kenapa Brand Pilih), Portofolio, Proses Kerja, RFQ/Form, FAQ, dan Closing CTA. Tambah tombol CTA di section yang belum punya.

## Mapping ke elemen yang akan diubah (index.html)
- **Hero**: `.hero-title`, `.hero-subtitle`, dan `.hero-microcopy` + pastikan tombol CTA ada (sudah ada 2). [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L362-L437)
- **Pain/Problem**: judul `<h2>` dan `.pain-points-subtitle` diganti; kalimat `.pain-points-conclusion` disesuaikan (atau dihapus jika redundant). [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L540-L567)
- **Solusi/Promise (Video)**: ganti `h2.section-title` dan `p.section-subtitle`; tambahkan CTA button ke WhatsApp/#rfq bila belum ada. [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L571-L586)
- **Features (Kenapa Brand Pilih)**: ganti subtitle section + semua `p.feature-description` untuk 6 card sesuai copy baru; tambahkan CTA bawah section: tombol **Konsultasi** (WA) + **Cek Estimasi Harga** (#rfq). [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L588-L652)
- **Portofolio**: ganti judul + subtitle; tambahkan tombol **Lihat Portofolio Lengkap** (link ke WA untuk minta katalog/portofolio lengkap) jika belum ada. [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L654-L779)
- **Proses Kerja**: ganti judul + subtitle; sesuaikan 4 step (title+desc) sesuai urutan yang kamu tulis; ubah teks CTA bawah menjadi lebih relevan (mis. “Request Quotation” atau “Cek Estimasi Harga”). [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L781-L846)
- **RFQ/Form**: ganti judul + subtitle sesuai copy; sesuaikan micro-trust badges menjadi “Respon max 24 jam • No spam • Konsultasi gratis”; ubah label tombol submit menjadi “Request Quotation”. [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L906-L1005)
- **FAQ**: ringkas jadi 4 item sesuai pertanyaan/jawaban yang kamu kirim (MOQ, durasi produksi, full custom, pengiriman luar kota). [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L1031-L1214)
- **Closing CTA**: ganti title+subtitle sesuai closing copy; tombol sudah ada dan akan diset teksnya jadi “Chat WhatsApp Sekarang” bila belum sama persis. [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L1216-L1253)

## Tombol yang akan ditambahkan (kalau belum ada)
- Video/Solusi: 1 tombol (WA atau #rfq).
- Features: 2 tombol bawah section (Konsultasi + Cek Estimasi Harga).
- Portofolio: 1 tombol “Lihat Portofolio Lengkap” (WA minta katalog/portofolio).

## Sinkronisasi dist
- Terapkan update copywriting yang sama ke [dist/index.html](file:///d:/Data%20User/Documents/Jihad/Web/dist/index.html) sejauh struktur section-nya ada (Hero/Pain/Video/Features/Showcase/Process/RFQ/FAQ/CTA). Jika dist punya section yang berbeda/lebih sedikit, copy akan disesuaikan tanpa merusak layout.

## Verifikasi
- Pastikan tidak ada sisa copy lama lewat pencarian kata kunci.
- Jalankan diagnostics untuk memastikan tidak ada error.
- Cek tampilan cepat via preview lokal untuk memastikan button/link tampil dan section tidak rusak.