## Tujuan
Mengganti teks overlay (judul + subjudul) di kartu portofolio **berdasarkan visual/finishing yang terlihat**, bukan mengikuti judul lama seperti “Premium Beauty Box / Luxury Fashion Packaging”.

## Copywriting Baru (per file gambar)
Catatan: dibuat berbasis finishing yang memang tercantum/terlihat (foil/emboss, magnetic, UV, matte, insert, soft touch), jadi lebih “sesuai gambar” daripada kategori lama.

### Signature
1) `Signature/Custom_1.webp`
- Judul: **Foil Emas Bertekstur**
- Subjudul: **Emboss tegas, kesan high-end**

2) `Signature/Custom_2.webp`
- Judul: **Magnetic + UV Highlight**
- Subjudul: **Tutup rapat, detail mengkilap**

3) `Signature/Custom_3.webp`
- Judul: **Matte + Insert Presisi**
- Subjudul: **Rapi saat unboxing, aman saat kirim**

4) `Signature/Custom_4.webp`
- Judul: **Soft Touch Rose Gold**
- Subjudul: **Feel lembut, branding terlihat mahal**

5) `Signature/custom-4.webp`
- Judul: **Gold Foil Statement**
- Subjudul: **Logo menonjol, emboss lebih hidup**

6) `Signature/custom-5.webp`
- Judul: **Magnetic Shine Detail**
- Subjudul: **UV spot fokus, tampilan eksklusif**

### Essentials
1) `Essentials/essentials-1.webp`
- Judul: **Foil & Emboss Clean**
- Subjudul: **Premium look, tetap efisien**

2) `Essentials/essentials-2.webp`
- Judul: **Magnetic Minimal**
- Subjudul: **Tutup rapat, aksen UV elegan**

3) `Essentials/essentials-3.webp`
- Judul: **Shipping-Ready Matte**
- Subjudul: **Insert custom, minim geser**

4) `Essentials/essentials-4.webp`
- Judul: **Soft Touch Clean**
- Subjudul: **Rose gold foil, feel lembut**

5) `Essentials/essentials-5.webp`
- Judul: **Insert Rapi**
- Subjudul: **Proteksi rapi, siap produksi**

6) `Essentials/essentials-6.webp`
- Judul: **Soft Touch Launch**
- Subjudul: **Finishing elegan, siap display**

## Langkah Implementasi
1) Update teks `h4` dan `p` pada `.showcase-overlay` di section “Portofolio Kami” pada `index.html`.
2) Rebuild `dist/`.
3) Generate ulang `cpanel-deploy.zip`.

## Verifikasi
- Pastikan di `dist/index.html` seluruh 12 card menampilkan judul/subjudul baru.
- Pastikan `cpanel-deploy.zip` berisi `index.html` terbaru.

Jika Anda setuju, saya lanjut eksekusi perubahan di file dan regenerate ZIP deploy.