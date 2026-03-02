## Catatan penting
- Snippet yang Anda kirim ada backtick/spasi di URL (`https://www.googletagmanager.com/gtm.js?id=`) yang bisa memicu request **400 Bad Request**. Saya akan pakai **snippet GTM standar** (tanpa backtick/spasi) agar valid.
- Di `index.html` saat ini sudah ada loader GA4 (`gtag/js?id=...`) + Meta Pixel + Clarity di dalam `<head>` (lihat [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L202-L284)). GTM juga memakai `dataLayer`, jadi setelah GTM aktif mungkin terjadi **double tracking** bila GA4/Pixel juga dipasang lagi lewat GTM.

## Lokasi pemasangan yang benar
- Kode GTM `<script>`: dipasang **setinggi mungkin** di dalam `<head>` (tepat setelah `<head>`), sebelum script/stylesheet lain.
- Kode GTM `<noscript>`: dipasang **tepat setelah `<body>` dibuka**, sebelum konten lain.

## Perubahan yang akan saya lakukan
1) **Tambah GTM script di `<head>`**
- Tambahkan snippet GTM untuk container `GTM-KG4RSDLX` tepat setelah tag `<head>`.
- Saya akan buat URL persis: `https://www.googletagmanager.com/gtm.js?id=GTM-KG4RSDLX` (tanpa backtick/spasi).

2) **Tambah GTM noscript setelah `<body>`**
- Tambahkan:
  - `<noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-KG4RSDLX" ...></iframe></noscript>`
  tepat setelah `<body>`.

3) **(Rekomendasi) Cegah GTM jalan di domain selain produksi**
- Karena file ini juga dipakai lokal/staging, saya akan mengikuti pola yang sudah ada (allowedHosts `deartbox.com` dan `www.deartbox.com`) supaya GTM hanya load di domain tersebut.

4) **Verifikasi**
- Build ulang `dist`.
- Pastikan di `dist/index.html` snippet GTM ada di posisi yang benar.

Jika Anda setuju, saya langsung pasang snippet GTM dan build ulang dist.