## Penyebab
- Di desktop, dropdown “Layanan Kami” dan “Hubungi Kami” memang **dibuka lewat hover** (JS memakai `pointerenter/pointerleave` saat perangkat mendukung hover).
- Labelnya adalah `\<summary\>` (bukan `\<a href\>`) jadi saat diklik tidak otomatis menuju anchor.

## Target Perilaku (Desktop)
- Hover tetap menampilkan dropdown (seperti sekarang).
- Klik pada label:
  - “Layanan Kami” → scroll ke `#features`
  - “Hubungi Kami” → scroll ke `#testimonials`
- Di device tanpa hover (mobile/tablet), klik tetap berfungsi **membuka dropdown** (tidak diubah).

## Implementasi
1) Update [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html)
- Tambahkan atribut `data-default-href` pada 2 `\<summary\>`:
  - `data-default-href="#features"`
  - `data-default-href="#testimonials"`

2) Update [optimized_script.js](file:///d:/Data%20User/Documents/Jihad/Web/optimized_script.js)
- Di blok `navDropdowns` yang sudah punya `hoverMedia`:
  - Jika `hoverMedia.matches`:
    - pasang listener `click` pada `summary`:
      - `e.preventDefault()` agar tidak toggle details
      - ambil `data-default-href`
      - scroll ke target dengan offset tinggi header (pakai fungsi `scrollToTargetWithOffset` yang sudah ada)
      - tutup dropdown (`removeAttribute('open')`) supaya rapi

3) Rebuild dist
- Jalankan build agar perubahan masuk ke [dist/index.html](file:///d:/Data%20User/Documents/Jihad/Web/dist/index.html) dan [dist/optimized_script.js](file:///d:/Data%20User/Documents/Jihad/Web/dist/optimized_script.js).

## Verifikasi
- Desktop:
  - Hover “Layanan Kami” → dropdown muncul
  - Klik “Layanan Kami” → pindah ke section Keunggulan
  - Hover “Hubungi Kami” → dropdown muncul
  - Klik “Hubungi Kami” → pindah ke section Testimoni
- Mobile: klik summary tetap membuka dropdown (tidak jadi lompat anchor).