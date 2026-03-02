## Tujuan
- Link menu/button internal (anchor `#...`) harus **sinkron**: setiap `href="#..."` punya target elemen `id="..."` yang benar.
- **Blog & Artikel tidak diubah**.

## Hasil Re-scan Saat Ini (Internal Anchors)
**Yang sudah valid (target id ada):**
- `#main-content` → `\<main id="main-content"\>`
- `#home` → `\<section id="home"\>`
- `#features` → `\<section id="features"\>`
- `#showcase` → `\<section id="showcase"\>`
- `#process` → `\<section id="process"\>`
- `#testimonials` → `\<section id="testimonials"\>`
- `#rfq` → `\<section id="rfq"\>`
- `#faq` → `\<section id="faq"\>`
- `#video` → `\<section id="video"\>`

**Yang belum valid:**
- `#contact` → belum ada `id="contact"`.

**`href="#"` (dibiarkan karena Blog):**
- Logo (`.logo`) saat ini `href="#"` (akan diperbaiki)
- Blog & Artikel desktop/mobile `href="#"` (dibiarkan)

## Perubahan yang Akan Dilakukan
1) **Logo header**
- Ubah `.logo` dari `href="#"` → `href="#home"`.

2) **Kontak (footer)**
- Tambahkan `id="contact"` pada elemen `\<footer\>` supaya link `href="#contact"` valid dan scroll ke footer.

3) **Re-scan ulang setelah perubahan**
- Scan ulang semua `href="#..."` di index:
  - Pastikan setiap anchor selain Blog memiliki target `id`.
  - Pastikan tidak ada anchor baru yang “nyasar” (mis. typo id).

## File yang Akan Diubah
- [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html)

## Verifikasi UI
- Klik logo → scroll ke hero.
- Klik footer “Kontak” → scroll ke footer.
- Pastikan smooth scroll tetap bekerja (script sudah handle `a[href^="#"]` dan mengabaikan `href="#"`).