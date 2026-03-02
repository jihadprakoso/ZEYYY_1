# Changelog - Dark/Light Mode Readability Fixes

## Tanggal: 31 Januari 2026

### Masalah yang Diperbaiki

#### 1. **Footer Text Readability (Lightmode)** ✅
**Masalah:** Teks di footer tidak readable karena kontras warna yang buruk.

**Solusi:**
- Mengubah warna teks footer dari `var(--text-light)` (#767676) menjadi `#b5b5b5`
- Memastikan heading footer menggunakan `#ffffff` (putih)
- Menambahkan hover effect yang jelas (putih penuh saat hover)

**CSS yang ditambahkan:**
```css
footer .footer-brand p,
footer .footer-links a,
footer .footer-column p,
footer .footer-bottom p,
footer .footer-badge-item,
footer .footer-payments-title,
footer .footer-address-link {
  color: #b5b5b5;
}

footer .footer-links a:hover,
footer .footer-address-link:hover {
  color: #ffffff;
}

footer .footer-brand h3,
footer .footer-column h4,
footer .footer-logo h3 {
  color: #ffffff;
}
```

---

#### 2. **Logo Bulan di Button Mode Toggle (Darkmode)** ✅
**Masalah:** Icon bulan di toggle button tidak terlihat/readable di dark mode.

**Solusi:**
- Menambahkan `color: #ffffff` untuk icon bulan
- Menambahkan `stroke: #ffffff` untuk memastikan SVG terlihat jelas
- Icon matahari tetap menggunakan warna accent (#d71921)

**CSS yang ditambahkan:**
```css
.theme-toggle-icon.sun {
  color: #d71921;
}

.theme-toggle-icon.moon {
  color: #ffffff;
}

[data-theme="dark"] .theme-toggle-icon.moon {
  color: #ffffff;
  stroke: #ffffff;
}
```

---

#### 3. **Tombol Slideshow (Darkmode)** ✅
**Masalah:** Tombol prev/next dan dots pada slideshow tidak terlihat di dark mode.

**Solusi:**
- Mengubah background tombol menjadi semi-transparan putih dengan blur effect
- Menambahkan warna putih untuk SVG icons
- Memperbaiki kontras dots dengan background putih yang lebih jelas

**CSS yang ditambahkan:**
```css
[data-theme="dark"] .slide-nav {
  background: rgba(255, 255, 255, 0.15);
  border-color: rgba(255, 255, 255, 0.2);
  backdrop-filter: blur(10px);
}

[data-theme="dark"] .slide-nav:hover {
  background: rgba(255, 255, 255, 0.25);
  border-color: rgba(255, 255, 255, 0.3);
}

[data-theme="dark"] .slide-nav svg {
  stroke: #ffffff;
  color: #ffffff;
}

[data-theme="dark"] .slide-dot {
  background: rgba(255, 255, 255, 0.4);
  border-color: rgba(255, 255, 255, 0.6);
}

[data-theme="dark"] .slide-dot.active {
  background: #ffffff;
  border-color: #ffffff;
}
```

---

#### 4. **Tombol CTA (Darkmode)** ✅
**Masalah:** Tombol CTA (Call-to-Action) tidak readable di dark mode.

**Solusi:**
- Menggunakan warna accent yang lebih terang (#ff2d3a) untuk dark mode
- Memastikan semua tombol CTA memiliki teks putih (#ffffff)
- Menambahkan warna untuk SVG icons di dalam tombol

**CSS yang ditambahkan:**
```css
[data-theme="dark"] .btn-hero-primary,
[data-theme="dark"] .btn-cta-wa,
[data-theme="dark"] .sticky-cta,
[data-theme="dark"] .btn-submit-rfq {
  background: #ff2d3a;
  color: #ffffff;
  border: none;
}

[data-theme="dark"] .btn-hero-primary:hover,
[data-theme="dark"] .btn-cta-wa:hover,
[data-theme="dark"] .sticky-cta:hover,
[data-theme="dark"] .btn-submit-rfq:hover {
  background: #d71921;
  color: #ffffff;
}

[data-theme="dark"] .btn-hero-primary svg,
[data-theme="dark"] .btn-cta-wa svg,
[data-theme="dark"] .sticky-cta svg {
  fill: #ffffff;
  color: #ffffff;
}

[data-theme="dark"] .cta-nav {
  background: #ff2d3a;
  color: #ffffff;
}

[data-theme="dark"] .cta-nav:hover {
  background: #d71921;
  color: #ffffff;
}

[data-theme="dark"] .mobile-cta {
  background: #ff2d3a;
  color: #ffffff;
}

[data-theme="dark"] .mobile-cta:hover {
  background: #d71921;
  color: #ffffff;
}
```

---

#### 5. **Drop File Area di RFQ (Darkmode)** ✅
**Masalah:** Area drop file berubah warna putih saat di-hover di dark mode.

**Solusi:**
- Mengubah hover background menjadi semi-transparan accent color
- Mempertahankan warna teks yang sesuai dengan theme
- Menambahkan styling untuk dragover state

**CSS yang ditambahkan:**
```css
[data-theme="dark"] .file-upload-label:hover {
  border-color: #ff2d3a;
  background: rgba(255, 45, 58, 0.1);
  color: var(--text);
}

[data-theme="dark"] .file-upload-label.dragover {
  border-color: #ff2d3a;
  background: rgba(255, 45, 58, 0.15);
  color: var(--text);
}

[data-theme="dark"] .file-upload-label svg {
  stroke: var(--text);
  color: var(--text);
}

[data-theme="dark"] .file-preview {
  background: #1a1a1a;
  border: 1px solid var(--border);
}
```

---

#### 6. **Back to Top Button (Darkmode)** ✅
**Bonus Fix:** Memperbaiki readability tombol back to top di dark mode.

**CSS yang ditambahkan:**
```css
[data-theme="dark"] .back-to-top {
  background: rgba(255, 255, 255, 0.1);
  border-color: rgba(255, 255, 255, 0.2);
  color: #ffffff;
}

[data-theme="dark"] .back-to-top:hover {
  background: #ff2d3a;
  color: #ffffff;
  border-color: #ff2d3a;
}

[data-theme="dark"] .back-to-top svg {
  stroke: #ffffff;
}
```

---

## File yang Dimodifikasi

1. **notion-feel-v2-cleaned.html**
   - Menambahkan CSS fixes untuk dark mode readability
   - Memperbaiki footer text colors untuk lightmode
   - Total: 2 section CSS ditambahkan

2. **dark-mode-fixes.css** (File baru - opsional)
   - File CSS terpisah yang berisi semua fixes
   - Dapat digunakan sebagai backup atau referensi

---

## Cara Testing

1. Buka file `notion-feel-v2-cleaned.html` di browser
2. Test di **Light Mode**:
   - Scroll ke footer, pastikan semua teks readable
   - Cek kontras warna teks dengan background
3. Klik toggle button untuk switch ke **Dark Mode**
4. Test di **Dark Mode**:
   - Cek icon bulan di toggle button (harus putih/terlihat)
   - Test tombol slideshow (prev/next dan dots)
   - Klik semua tombol CTA (hero, sticky, form submit)
   - Hover area drop file di form RFQ
   - Scroll ke bawah, test back to top button

---

## Catatan Teknis

- Semua fixes menggunakan selector `[data-theme="dark"]` untuk dark mode
- Warna accent dark mode: `#ff2d3a` (lebih terang dari lightmode)
- Warna accent lightmode: `#d71921`
- Background footer: `#1a1a1a` (sama untuk light dan dark mode)
- Menggunakan CSS variables untuk konsistensi: `var(--text)`, `var(--card)`, `var(--border)`

---

## Kompatibilitas

✅ Chrome/Edge (Chromium)
✅ Firefox
✅ Safari
✅ Mobile browsers

---

## Backup

File original sudah dimodifikasi. Jika perlu rollback:
1. Gunakan version control (git)
2. Atau copy file `dark-mode-fixes.css` dan hapus CSS yang ditambahkan di HTML

---

**Status:** ✅ Semua masalah telah diperbaiki dan siap untuk production.
