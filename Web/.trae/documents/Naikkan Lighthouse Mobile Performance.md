## Diagnosis (kenapa score mobile 64)
Dari report mobile yang ada di repo, bottleneck utamanya bukan JS:
- **FCP ~2.4s (cukup bagus)**
- **TBT ~20ms (bagus)**
- **CLS 0 (bagus)**
- Yang menjatuhkan skor adalah **LCP ~9.2s (parah)**.

Lighthouse juga menunjuk elemen LCP sebagai gambar hero:
- `div.hero-slideshow-container > div.hero-slide > img` → `assets/images/halamanutama/hardbox-hmns2.webp`

Dan ada audit yang sangat relevan:
- **Improve image delivery**: estimasi penghematan **~1.5 MiB** dan bisa memperbaiki **LCP ~3.9s** (artinya gambar terlalu besar untuk tampilan mobile, dan/atau terlalu banyak gambar besar ikut ter-download di awal).
- **Render blocking requests**: Google Fonts CSS masih dianggap render-blocking (sekitar ratusan ms–~0.8s).

## Prinsip yang bikin naik cepat
Fokuskan resource awal ke 1 hal: **LCP image tampil secepat mungkin**. Yang lain (slide lain, poster video, portofolio, dll) harus ditunda.

## Rencana Perbaikan (yang akan saya implementasikan)
### 1) Hentikan “banjir download” gambar hero
- Pastikan **hanya 1 gambar hero (yang aktif)** yang benar-benar di-load saat initial load.
- Gambar slide lain dibuat **defer** (misalnya pakai `data-src` khusus untuk slide non-aktif dan baru diaktifkan setelah `load`/idle/interaction).
- Tetap aman: gambar LCP tetap pakai `fetchpriority="high"` dan `loading="eager"`.

### 2) Buat responsive images (srcset/sizes) untuk hero + poster video
- Generate beberapa ukuran untuk gambar hero LCP (mis. 480w/768w/1024w) dan pakai `srcset` + `sizes`.
- Ini menurunkan ukuran download drastis karena di mobile tampilnya cuma ~360px lebar.
- (Opsional) Tambahkan **AVIF** untuk browser yang support.

### 3) Kompres & sesuaikan dimensi aset besar
- Re-encode gambar yang sering jadi kandidat (hero, poster video, gambar di atas fold) dengan kompresi lebih agresif.
- Pastikan ukuran intrinsik tidak berlebihan (hindari 1600px kalau tampil 360px).

### 4) Optimasi font (hilangkan render-blocking)
Pilih salah satu (saya rekomendasikan opsi A untuk impact besar):
- **Opsi A (Recommended):** self-host font (subset + woff2) + preload, lalu drop Google Fonts request.
- **Opsi B:** kurangi weight/family, dan pastikan loading font CSS benar-benar non-blocking.

### 5) Optimasi tambahan (nice-to-have)
- Tambah `content-visibility: auto` untuk section jauh di bawah fold agar rendering mobile lebih ringan.
- Audit ulang script untuk memastikan tidak ada gambar non-kritis dipaksa preload.

## Verifikasi
- Re-run Lighthouse mobile dan bandingkan metrik:
  - Target utama: **LCP turun tajam** (biasanya ini yang mengangkat skor dari 60-an ke 80+).
  - Pastikan tidak ada regression: CLS tetap 0, TBT tetap rendah.

Jika Anda setuju, saya lanjut eksekusi perubahan (HTML/CSS + generate varian gambar) dan jalankan audit ulang dengan report terbaru.