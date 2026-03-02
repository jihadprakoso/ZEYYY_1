## Perubahan Teks yang Diminta
- FAQ Q1:
  - Dari: "Saya punya contoh cetakan yang sebelumnya dari tempat lain, apakah warnanya bisa sama?"
  - Menjadi: "Punya cetakan sebelumnya dari tempat lain, apakah warna nya bisa sama ?"
- FAQ Q2:
  - Dari: "Saya tidak punya desain, apakah deartbox bisa bantu buatkan desain kemasannya?"
  - Menjadi: "Jika tidak punya desain, apakah bantu dibuatkan desain kemasannya?"
- Hero title:
  - Dari: "Solusi Packaging Premium untuk Tampilan Brand yang Lebih Baik"
  - Menjadi: "Upgrade Kemasan, Naikkan Nilai Brand"

## Lokasi yang Akan Diubah
- [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html)
  - Schema FAQ JSON-LD (field `name` pada dua pertanyaan): sekitar [index.html:L92-L176](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L92-L176)
  - Hero title: [index.html:L456-L473](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L456-L473)
  - FAQ section (teks yang terlihat di UI): [index.html:L1127-L1241](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L1127-L1241)

## Langkah Eksekusi
1. Update 3 teks di `index.html` (hero + 2 FAQ) di **dua tempat** (JSON-LD dan UI FAQ) agar konsisten.
2. Rebuild `dist/` (supaya [dist/index.html](file:///d:/Data%20User/Documents/Jihad/Web/dist/index.html) ikut ter-update dari source).
3. Verifikasi:
   - Pastikan tidak ada typo/duplikasi.
   - Jalankan pengecekan referensi lokal (root + dist).
   - Buka preview dan cek FAQ tampil sesuai dan schema JSON-LD masih valid.

Jika Anda setuju, saya langsung terapkan perubahan copy tersebut dan rebuild dist.