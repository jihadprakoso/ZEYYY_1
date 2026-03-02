## Kenapa Sekarang “Tidak Ada Perubahan”
- CSS sudah punya style `.nav-link.active`, tapi di script **belum ada logic yang menambahkan/menghapus class `active`** untuk menu. Di [optimized_script.js](file:///d:/Data%20User/Documents/Jihad/Web/optimized_script.js#L380-L383) baru dideklarasikan `sections` dan `navLinks` tanpa implementasi.
- Akibatnya, walaupun anchor `href="#features"` dkk valid dan smooth-scroll jalan, menu header **tidak pernah terlihat “aktif/berubah”**.

## Tujuan
- Saat klik menu header (atau saat scroll manual), menu terkait jadi **active** (underline + background) sesuai section yang sedang terlihat.
- Dropdown `details` otomatis **menutup** setelah memilih item.

## Perubahan yang Akan Dilakukan
1) **Tambah fungsi setActiveNav(hash)**
- Cari semua link `.nav-link` dan `.mobile-nav-link` yang `href`-nya sama dengan `hash`.
- Hapus `active` dari semua, lalu tambahkan `active` ke yang cocok.

2) **Update handler klik anchor internal** (`a[href^="#"]`)
- Setelah scroll ke target, panggil `setActiveNav(href)`.
- Jika klik terjadi di dalam dropdown, tutup semua `details.nav-dropdown` (remove `open`).

3) **Implement Active-on-Scroll**
- Pakai `IntersectionObserver` untuk semua `section[id]`.
- Saat section dominan terlihat, panggil `setActiveNav('#' + section.id)`.

4) **Rebuild dist & verifikasi**
- Klik menu → scroll + menu jadi active.
- Scroll manual → active ikut berubah.
- Dropdown menutup setelah pilih item.

## File yang Akan Diubah
- [optimized_script.js](file:///d:/Data%20User/Documents/Jihad/Web/optimized_script.js)
- Rebuild ke [dist/optimized_script.js](file:///d:/Data%20User/Documents/Jihad/Web/dist/optimized_script.js) via build-dist.ps1