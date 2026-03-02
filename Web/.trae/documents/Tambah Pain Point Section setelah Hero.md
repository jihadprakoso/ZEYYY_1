## Tujuan

- Menambahkan “Pain Point Section” tepat setelah section hero di halaman utama, dengan struktur HTML mengikuti format yang kamu kirim.

## Lokasi Penyisipan

- File: [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html)
- Disisipkan **setelah** penutup `<section class="hero-modern" ...>` dan **sebelum** Trust Section (saat ini Trust Section mulai setelah hero selesai).

## Implementasi HTML (mengikuti format kamu)

- Tambahkan blok berikut persis setelah hero:

```html
<section class="section">
  <div class="container fade-up" style="text-align:center">
    <h2>Produksi packaging sering ribet?</h2>
    <div style="margin-top:40px;font-size:18px;line-height:2">
      ❌ Telat kirim<br>
      ❌ Hasil ga konsisten<br>
      ❌ Revisi bolak balik<br>
      ❌ Vendor susah dihubungi
    </div>
    <p style="margin-top:32px;font-weight:600">Makanya banyak brand pindah ke Deartbox.</p>
  </div>
</section>
```

## Styling minimal agar section tidak “nempel”

- Karena saat ini belum ada rule `.section { ... }` di CSS, tambahkan styling dasar di [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css) supaya spacing rapi dan mengikuti theme:
  - `.section { padding: clamp(40px, 6vw, 60px) 0; background: var(--bg); }`

## Verifikasi

- Reload preview lokal dan cek:
  - Section muncul tepat setelah hero.
  - Spacing atas/bawah rapi.
  - Warna tetap mengikuti light/dark mode (karena pakai `var(--bg)`).