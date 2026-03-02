## Penyebab efek hitam
Efek hitam/bayangan yang masih terlihat di foto tengah itu bukan dari gambar, tapi dari CSS layer di slideshow:
- **Shadow utama yang nempel di frame foto tengah**: `.hero-slide { box-shadow: var(--hero-slideshow-shadow); }` → ini yang paling “kerasa” gelap. Lihat [optimized_styles.css:L2264-L2271](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L2264-L2271).
- **Shadow depth di belakang frame** (double-card effect): `.hero-slideshow-container::before` dan `::after` punya `box-shadow` (opacity kecil) yang bisa tetap terlihat sebagai “bayangan” di area sekitar frame. Lihat [optimized_styles.css:L2165-L2191](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L2165-L2191).
- **(Opsional) Ghost preview kiri/kanan** juga punya `box-shadow` sendiri, tapi itu harusnya tidak nempel ke foto tengah; hanya bikin depth di samping. Lihat [optimized_styles.css:L2193-L2206](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L2193-L2206).

## Rencana perubahan
1. **Hilangkan shadow di foto tengah**
   - Ubah `.hero-slide` menjadi `box-shadow: none;` (tetap ada border + radius).

2. **Jika masih terlihat efek gelap di sekitar frame**
   - Matikan shadow pada `.hero-slideshow-container::before` dan `::after` (set `box-shadow: none;` atau `opacity: 0;`) agar benar-benar flat tanpa depth.

3. **Verifikasi di desktop**
   - Pastikan foto tengah clean (tanpa bayangan hitam), transisi slide tetap normal, dan ghost preview (kalau masih dipakai) tidak mengganggu.

Kalau kamu setuju, saya akan terapkan langkah 1 dulu; kalau masih ada “gelap” tipis di sekitar frame, lanjut langkah 2.