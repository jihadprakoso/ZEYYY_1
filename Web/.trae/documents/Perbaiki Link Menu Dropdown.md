## Ringkasan masalah
- Menu desktop **“Layanan Kami”** dan **“Hubungi Kami”** adalah `\u003csummary\u003e` (dropdown), jadi saat judulnya diklik memang **tidak melakukan navigasi anchor**.

## Perbaikan yang akan saya lakukan

### 1) Jadikan judul dropdown sebagai link anchor
- Ubah isi summary menjadi link:
  - **Layanan Kami → `#features`**
  - **Hubungi Kami → `#contact`**
- Dropdown items di dalamnya tetap sama (Keunggulan/Portofolio/Proses/FAQ, Testimoni/WA/Email).

### 2) Rapikan style link di summary
- Tambah class (mis. `.nav-dropdown-anchor`) supaya link tidak underline dan ikut style menu (warna/typography inherit).

### 3) Pastikan klik link tidak “ngaco” dengan dropdown
- Tambah handler kecil di JS:
  - Jika klik link anchor di dalam summary, tutup dropdown (`removeAttribute('open')`) dan `stopPropagation()`.

### 4) Tambahkan script Microsoft Clarity
- Masukkan script Clarity (tag: `v8wcnxphfq`) ke bagian `<head>` dekat script analytics lain.
- Saya akan menuliskan versi yang valid (tanpa backtick / concatenation yang salah), yaitu:
  - `t.src = 'https://www.clarity.ms/tag/' + i;`

## File yang akan diubah
- [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html) (summary dropdown + Clarity script)
- [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css) (style `.nav-dropdown-anchor`)
- [optimized_script.js](file:///d:/Data%20User/Documents/Jihad/Web/optimized_script.js) (close dropdown saat klik anchor di summary)

## Verifikasi
- Klik “Layanan Kami” scroll ke section `#features`.
- Klik “Hubungi Kami” scroll ke footer `#contact`.
- Dropdown tetap bisa dibuka via hover/click, dan item di dalamnya tetap berfungsi.
- Clarity script ter-load (tanpa error JS).