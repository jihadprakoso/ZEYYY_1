## Tujuan
- Di semua ukuran mobile (≤767px, termasuk landscape/layar pendek), drawer **menu toggle** tidak memunculkan scroll vertikal.

## Temuan
- Panel drawer sudah punya `overflow-y: auto` dan konten cukup banyak (9 link + divider + 2 CTA). [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L268-L357)
- Spasi vertikal masih besar:
  - `.mobile-menu-inner { padding: 24px; gap: 8px; }` dan link `padding: 14px 16px`. [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L1765-L1779)
  - Ada minimum touch target 48px untuk `.mobile-nav-link` pada mobile. [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L4387-L4393)
- Untuk device height pendek (landscape), kombinasi padding + min-height + CTA membuat total tinggi melebihi viewport drawer → muncul scroll.

## Rencana Perubahan
1. **Kompresi default mobile (≤767px)**
   - Kurangi padding drawer:
     - `.mobile-menu-inner { padding: 14px–16px; }`
   - Kurangi tinggi item menu tanpa mengorbankan keterbacaan:
     - `.mobile-nav-link { padding: 10px 12px; font-size: 14px; }`
     - `.mobile-nav-link svg { width: 16px; height: 16px; }`
   - Kurangi jarak divider:
     - `.mobile-menu-divider { margin: 10px 0; }`
   - Kompres CTA:
     - `.mobile-cta { padding: 12px 16px; font-size: 14px; }`
     - Kurangi `margin-top` CTA primary/secondary.

2. **Mode ekstra-compact untuk layar pendek (berdasarkan tinggi viewport)**
   - Tambahkan breakpoint berbasis tinggi, misalnya:
     - `@media (max-width: 767px) and (max-height: 600px)`
   - Di mode ini:
     - Turunkan `min-height` `.mobile-nav-link` dari 48px → 42–44px.
     - Kurangi `gap` antar item.
   - Ini target utama untuk menghilangkan scroll di landscape.

3. **Fallback anti-scroll paling agresif (untuk height sangat pendek)**
   - Jika masih overflow pada device tertentu, gunakan layout 2 kolom untuk daftar link agar tinggi total turun:
     - `@media (max-width: 767px) and (max-height: 520px)`
     - `.mobile-menu-inner { display: grid; grid-template-columns: 1fr 1fr; gap: 8px; }`
     - Divider + CTA dibuat full width: `grid-column: 1 / -1;`
   - Dengan ini, konten tetap terlihat tanpa harus scroll.

4. **Samakan untuk versi dist**
   - Terapkan aturan yang sama pada `dist/optimized_styles.css` agar hasil deploy konsisten.

## Verifikasi
- Uji visual di beberapa viewport mobile: 320×568, 360×640, 390×844, dan landscape (mis. 844×390 / 640×360).
- Pastikan drawer tidak menampilkan scrollbar/scroll bounce, link tetap bisa diklik, dan CTA tetap terlihat.
- Pastikan diagnostics tidak ada error baru.

## File yang akan disentuh
- [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css)
- [dist/optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/dist/optimized_styles.css)