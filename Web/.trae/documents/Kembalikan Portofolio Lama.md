## Tujuan

Mengembalikan section Portofolio (#showcase) ke desain sebelumnya (grid gambar + overlay judul/deskripsi) dan menghapus styling Case Study agar CSS tidak “berantakan”.

## Yang akan saya lakukan

1. **Restore markup Portofolio di HTML**
   - Ubah judul & subtitle kembali ke:
     - `Portofolio Kami`
     - `Premium packaging untuk brand beauty, fashion, F&B, dan electronics`
   - Ganti seluruh isi `.showcase-grid` dari `case-study-card` kembali ke item lama:
     - `<img ...>` + `<div class="showcase-overlay"><h4>...</h4><p>...</p></div>`
     - Susunan kategori hardbox/softbox/custom seperti sebelumnya (tetap kompatibel dengan filter JS).
   - Bagian filter buttons dan “Inline CTA after Portofolio” tetap dipertahankan.

2. **Bersihkan CSS khusus Case Study**
   - Hapus rule yang hanya dipakai Case Study:
     - `.showcase-item.case-study-item { ... }`
     - `.showcase-item.case-study-item::after { ... }`
     - `.case-study-card`, `.case-study-brand`, `.case-study-list`, `.case-study-row`, `.case-study-btn`, dll.
   - Ini mencegah style yang tidak terpakai mengganggu / membingungkan.

## File yang akan diubah

- [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html)
- [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css)

## Verifikasi

- Portofolio tampil seperti semula (gambar + overlay muncul saat hover).
- Filter Hardbox/Softbox/Custom tetap berfungsi.
- Tidak ada error CSS/console yang baru.