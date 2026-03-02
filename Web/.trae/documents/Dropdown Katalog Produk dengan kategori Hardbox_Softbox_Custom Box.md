## Tujuan
- Ubah menu header desktop “Katalog Produk” menjadi dropdown berisi kategori: **Hardbox**, **Softbox**, **Custom Box**.
- Saat kategori dipilih, halaman scroll ke section katalog/portfolio dan konten ter-filter sesuai kategori.

## Perubahan yang Akan Dibuat
1. **Header desktop (index.html)**
   - Ganti link `Katalog Produk` (yang sekarang menuju `#showcase`) menjadi dropdown `details.nav-dropdown`.
   - Isi dropdown:
     - Hardbox → `#showcase` + atribut `data-showcase-filter="hardbox"`
     - Softbox → `#showcase` + atribut `data-showcase-filter="softbox"`
     - Custom Box → `#showcase` + atribut `data-showcase-filter="custom"`

2. **UI filter di section showcase (index.html)**
   - Tambahkan bar filter (3 tombol) di atas `.showcase-grid`:
     - Hardbox, Softbox, Custom Box
   - Tambahkan elemen “empty state” (mis. teks kecil) yang muncul kalau kategori belum punya item.
   - Tag item existing `.showcase-item` dengan `data-category="hardbox"` (karena konten saat ini semuanya hardbox).

3. **CSS (optimized_styles.css)**
   - Style filter bar agar konsisten dengan tema (pill buttons / tab style).
   - Tambahkan kelas utilitas untuk menyembunyikan item saat filter aktif (mis. `.is-hidden { display:none; }`).
   - Style empty state.

4. **JavaScript (optimized_script.js)**
   - Tambahkan fungsi `applyShowcaseFilter(category)`:
     - Set active state tombol filter.
     - Show/hide `.showcase-item` berdasarkan `data-category`.
     - Tampilkan empty state bila hasil 0.
   - Hook event:
     - Klik tombol filter → apply filter.
     - Klik item dropdown nav kategori → apply filter + (scroll sudah ditangani oleh smooth scroll global).
   - Default saat page load: aktifkan **Hardbox**.

## Verifikasi
- Desktop: hover “Katalog Produk” → dropdown muncul, klik kategori → scroll ke `#showcase` dan filter berubah.
- Tombol filter di section showcase bisa mengubah kategori dan state active.
- Tidak ada perubahan untuk mobile (sesuai permintaan sebelumnya).

Jika sudah OK, saya langsung implementasikan.