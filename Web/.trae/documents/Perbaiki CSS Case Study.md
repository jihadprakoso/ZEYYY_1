## Diagnosis yang paling mungkin

- Tidak ada indikasi syntax CSS rusak (brace/kurung tutup terlihat rapi di file).
- “Error” yang kamu lihat kemungkinan **visual bug**: style lama untuk portofolio masih aktif, khususnya `.showcase-item::after` (gradient overlay) yang sekarang ikut menimpa card case study dan muncul saat hover, bikin tampilan seperti “rusak”.

## Perbaikan yang akan dilakukan

1. **Matikan overlay gradient untuk case study**
   - Tambah override:
     - `.showcase-item.case-study-item::after { content: none; }`
     - dan pastikan hover overlay tidak mempengaruhi case study.

2. **Rapikan clipping + border radius**
   - Ubah `.showcase-item.case-study-item` dari `overflow: visible` menjadi `overflow: hidden` supaya sudut card rapi dan tidak ada elemen pseudo yang nyelonong.

3. **(Opsional tapi aman) Pastikan pointer/hover behavior konsisten**
   - Karena case study bukan gambar overlay lagi, set `cursor: default` tetap.
   - Pastikan hanya transform dari `.showcase-item.case-study-item:hover` yang berlaku (sudah), tapi kita pastikan tidak ada efek overlay tersisa.

## File yang akan diubah

- [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css)

## Verifikasi

- Hover di card case study tidak memunculkan layer gelap/gradient.
- Card case study tetap rapi (border radius dan shadow benar) dan tidak mengganggu teks.