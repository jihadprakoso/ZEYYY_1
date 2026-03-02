## Temuan
- Toggle theme di darkmode masih pakai merah karena `[data-theme="dark"] .theme-toggle { background: var(--accent); }` dan `.theme-toggle-icon.sun { color: var(--accent); }` di [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L781-L900).
- Back-to-top hover sebenarnya sudah diset oranye di beberapa tempat, tapi ada override paling bawah yang memaksa merah pakai `!important`:
  - `.back-to-top:hover { background: var(--accent) !important; }`
  - `[data-theme="dark"] .back-to-top:hover { background: var(--accent) !important; }`
  di [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L5469-L5481)
  Ini yang bikin hover balik merah.

## Perubahan yang Akan Dilakukan
1. **Darkmode: toggle theme jadi oranye**
   - Ubah `[data-theme="dark"] .theme-toggle` background dari `var(--accent)` ke `var(--orange)`.
   - Ubah `.theme-toggle-icon.sun` dari `var(--accent)` ke `var(--orange)` supaya tidak merah.

2. **Back-to-top hover: pastikan oranye di light dan dark**
   - Ubah override `!important` di bagian bawah agar pakai `var(--orange)` (light & dark).
   - Pastikan tidak ada rule lain yang masih memaksa `var(--accent)` untuk hover.

3. **Rebuild & cek**
   - Rebuild `dist/`.
   - Preview lokal untuk memastikan:
     - Toggle theme di darkmode tidak merah.
     - Back-to-top hover oranye di lightmode dan darkmode.

## File yang Akan Diubah
- `d:\Data User\Documents\Jihad\Web\optimized_styles.css`
- Rebuild output ke `dist/`