## Target
- Di header, tombol **Minta Penawaran** dan **Konsultasi Gratis** pada state **non-hover** tidak punya fill (background transparan), hanya outline (border/stroke).

## Kondisi Saat Ini (Code)
- Desktop header:
  - Konsultasi Gratis: `.cta-nav` (sekarang fill hijau)
  - Minta Penawaran: `.cta-nav-secondary` (sekarang fill oranye)
  - Sumber: [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L1696-L1737)
- Dark mode overrides juga masih set fill untuk keduanya: [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L953-L972)
- Ada override hero variant g untuk `.cta-nav-secondary`: [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L2471-L2480)

## Implementasi (Recommended)
1. **Ubah non-hover jadi outline-only**
   - `.cta-nav`:
     - `background: transparent; border: 2px solid var(--green); color: var(--green);`
   - `.cta-nav-secondary`:
     - `background: transparent; border: 2px solid var(--orange); color: var(--orange);`
   - Ini menjaga keterbacaan di header light mode.

2. **Hover jadi filled (tetap premium dan jelas)**
   - `.cta-nav:hover`:
     - `background: var(--green); color: #fff;` (shadow tetap)
   - `.cta-nav-secondary:hover`:
     - `background: var(--orange); color: #fff;` (shadow tetap)

3. **Dark mode + hero header compatibility**
   - Pastikan `[data-theme="dark"]` tidak mengembalikan fill di state non-hover (tetap outline-only).
   - Untuk hero variant g (header berada di area gelap):
     - Override agar teks tetap terbaca (opsi aman): `color: #fff; border-color: var(--orange); background: transparent;` untuk `.cta-nav-secondary` (dan jika perlu `.cta-nav`).

4. **(Opsional, jika kamu anggap bagian header termasuk mobile menu CTA)**
   - Samakan gaya outline untuk `.mobile-cta-primary` dan `.mobile-cta-secondary` pada non-hover, hover tetap filled.

## File yang Akan Diubah
- `d:\Data User\Documents\Jihad\Web\optimized_styles.css`
- Rebuild `dist/` agar deploy output ikut update.

## Verifikasi
- Cek tampilan di header pada:
  - Light mode (background header terang)
  - Dark mode
  - Area hero (variant g)
- Pastikan hover berubah jadi filled dan kontras teks tetap aman.