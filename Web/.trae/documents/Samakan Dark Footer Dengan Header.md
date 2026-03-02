## Tujuan
- Saat **dark mode**, background footer dibuat sama seperti background header dark mode.

## Temuan di CSS
- Header pakai `background: var(--header-bg)` dan di dark mode `--header-bg` = `rgba(15, 15, 15, 0.95)` serta `--header-bg-solid` = `#0f0f0f`.
- Footer dark mode saat ini: `[data-theme="dark"] footer { background: #0a0a0a; ... }` di [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L786-L789).

## Perubahan yang akan dilakukan
- Ubah rule footer dark mode menjadi memakai variabel yang sama dengan header:
  - `background: var(--header-bg-solid);` (atau `background: var(--header-bg);` jika mau efek semi-transparan seperti header).
- Pertahankan `border-top` yang sudah ada.

## File yang akan diubah
- [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L786-L789)

## Verifikasi
- Toggle dark mode: warna footer match dengan header.
- Rebuild dist dan cek di preview.