## Pemahaman requirement (sesuai revisi Anda)
- Lightmode: tombol berwarna **orange**, **kecuali**:
  - Tombol/link ke WhatsApp (tetap hijau/apa adanya)
  - CTA ke RFQ / `#rfq`
  - Tombol “Lihat Portofolio” / `#showcase`
  - Back-to-top (normal & hover)
  - Skip-to-content
  - File-upload label hover/dragover

## Scope yang akan diubah (yang tersisa relevan)
Dari tombol yang ada di halaman, yang saat ini masih memakai warna aksen merah di lightmode dan tidak termasuk pengecualian Anda adalah:
1. Tombol putar video:
   - `.video-play-btn` memakai `rgba(var(--red-rgb), ...)`: [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L2652-L2671)
2. Tombol filter portfolio saat aktif:
   - `.showcase-filter-btn.is-active` memakai `background: var(--accent)` (merah): [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L2821-L2842)

## Implementasi yang akan saya lakukan
1. Tambahkan variable warna orange di `:root` (mis. `--orange` + `--orange-rgb`).
2. Override khusus lightmode (`html:not([data-theme="dark"])`) untuk:
   - `.video-play-btn` + hover: ubah background dari merah -> orange.
   - `.showcase-filter-btn.is-active`: ubah background/border dari `var(--accent)` -> orange.
3. Tidak menyentuh style tombol yang Anda sebutkan “tidak usah oren” (RFQ, portofolio, back-to-top, skip, file-upload) dan tidak mengubah tombol WhatsApp.

## Verifikasi
- Rebuild `dist/`.
- Cek di preview (lightmode):
  - Tombol “Putar Video” jadi orange.
  - Filter aktif di portfolio jadi orange.
  - Pengecualian yang Anda sebut tetap tidak berubah.
  - Dark mode tidak berubah.