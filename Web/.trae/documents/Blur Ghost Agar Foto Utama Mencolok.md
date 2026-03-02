## Tujuan
- Tambahkan blur pada semua ghost (besar & kecil) supaya foto utama di tengah terlihat paling tajam dan "mencolok".

## Implementasi (CSS saja)
- Update rule [.hero-ghost img](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L1933-L1938):
  - Tambah blur ringan untuk ghost besar (mis. `blur(2px)`), tetap mempertahankan saturate/contrast agar masih kebaca sebagai preview.
- Tambah rule spesifik untuk ghost kecil:
  - `.hero-ghost-prev2 img, .hero-ghost-next2 img { filter: blur(4px) saturate(...) contrast(...); }`
  - Blur ghost kecil lebih kuat dibanding ghost besar supaya depth lebih terasa.
- (Opsional, tapi saya rekomendasikan): tambahkan `filter: none` atau sedikit sharpen untuk `.hero-slide img` kalau diperlukan, supaya benar-benar kontras dengan ghost (kita cek dulu hasilnya; kalau sudah cukup, tidak perlu).

## File yang akan diubah
- [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L1918-L1962)

## Verifikasi
- Desktop: ghost kiri/kanan dan yang kecil terlihat blur, foto utama tetap tajam.
- Tidak mengganggu performa (blur hanya di ghost) dan tombol nav/dots tetap bisa diklik.
- Mobile: ghost tetap hidden (rule sudah ada), jadi tidak ada beban tambahan.

Kalau di-approve, saya langsung apply CSS ini, rebuild dist, lalu cek di preview.