## Temuan Utama (sumber jarak “kejauhan”)
- Global section padding di-set besar: `section { padding: var(--section-pad) 0; }` dengan `--section-pad: 120px` di [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L355-L400) dan rule section di [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L1397-L1400).
- Hero paling dominan bikin whitespace: `.hero-modern { padding: clamp(80px..140px) 0 clamp(60px..100px) }` + `.hero-container { gap: var(--grid-gap) }` (grid-gap 40–60px) di [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L1952-L1993).
- Ada override mobile untuk `section` yang dobel (dua blok) yang “mengalahkan” sistem variable mobile: [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L4462-L4466) dan [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L5284-L5288).
- Banyak jarak blok 48px/40px (testimonials grid, inline CTA, FAQ list, dll) yang bisa dirapikan jadi konsisten dan lebih rapat, contoh: [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L3000-L3017) dan [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L3533-L3617).
- Ada “tweak” di bagian akhir CSS yang menambah spacing (mis. `.hero-slideshow-container { margin-bottom: 48px !important; }`) dan banyak `!important`, di [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L6021-L6072).

## Target Spacing
- Turunkan jarak vertikal global sekitar 15–30% (lebih rapat tapi tetap premium).
- Konsistenkan “scale” spacing (mis. 12/16/20/24/32/40/48/64/96) dan pakai variable, supaya tidak ada 1–2 section yang tiba-tiba jauh sendiri.

## Rencana Perubahan (yang akan saya kerjakan)
1. **Buat 1 sistem spacing sebagai sumber kebenaran**
   - Ubah `--section-pad` desktop dari 120px → ~96px (atau clamp yang lebih kecil).
   - Ubah `--section-pad-mobile` dari 80px → ~64px.
   - Tambah `--grid-gap-mobile` (mis. clamp 16–24px) dan di mobile set `--grid-gap: var(--grid-gap-mobile)` supaya layout 1 kolom tidak “kosong jauh”.
2. **Rapikan konflik/duplikasi mobile section spacing**
   - Hapus/merge dua blok `@media (max-width: 767px) { section { padding-top/bottom: 60px; } }` dan ganti dengan pendekatan variable (`:root { --section-pad: var(--section-pad-mobile); --grid-gap: var(--grid-gap-mobile); }`).
3. **Perbaiki spacing hero yang paling terasa**
   - Turunkan `.hero-modern` padding (atas & bawah) dari clamp(80–140/60–100) ke clamp yang lebih kecil.
   - Ubah `.hero-container` gap dari `var(--grid-gap)` ke gap yang lebih kecil (pakai `--gap` atau variable khusus hero).
   - Turunkan `margin-bottom` slideshow (yang sekarang 48px `!important`) ke nilai lebih rapat dan hilangkan `!important` bila sudah tidak perlu.
4. **Rapikan spacing antar blok konten (yang 48px/40px)**
   - Ubah `margin-top: 48px` di grid/list jadi 32px (contoh testimonials-grid).
   - Ubah `margin-top`/`padding` inline CTA yang 48px jadi lebih rapat (mis. 32px) sambil menjaga keterbacaan.
   - Pastikan `section-header` dan elemen pemisah blok konsisten.
5. **Sinkronkan root vs dist**
   - Terapkan perubahan yang sama ke [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css) dan [dist/optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/dist/optimized_styles.css) (atau rebuild dist setelah edit root).

## Verifikasi Setelah Perubahan
- Jalankan preview lokal untuk root dan dist, cek desktop + mobile (terutama section yang paling panjang: hero, testimonials, RFQ, FAQ).
- Jalankan pengecekan asset refs (tools/check-local-refs.js) dan Lighthouse sanity check supaya tidak ada efek samping besar.

## Output
- Spacing global lebih rapat dan konsisten, tidak ada section yang terasa “kejauhan”.
- dist ikut rapi sehingga siap upload (cPanel).