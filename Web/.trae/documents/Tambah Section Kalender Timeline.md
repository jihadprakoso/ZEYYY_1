## Tujuan
Menambahkan section baru berjudul **“Kalender Timeline”** yang menampilkan Google Calendar embed sesuai URL yang Anda kirim.

## Penempatan Section
- Saya akan letakkan section **setelah “Proses Kerja Kami”** dan sebelum **“Testimoni Klien”** supaya alurnya: proses → timeline → social proof.
- Section akan punya `id="calendar"` agar mudah di-link kalau nanti mau ditambahkan ke menu.

## Perubahan yang akan saya lakukan
### 1) Update [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html)
- Tambahkan section baru:
  - Judul: `Kalender Timeline`
  - Embed: `iframe` Google Calendar.
- Saya akan rapikan `src` iframe menjadi URL **tanpa backtick/spasi** (kalau ada backtick/spasi, bisa bikin embed tidak konsisten).
- Tambahkan atribut performa & keamanan:
  - `loading="lazy"`
  - `referrerpolicy="strict-origin-when-cross-origin"`

Contoh struktur yang akan ditambahkan:
- `section.calendar-section.reveal#calendar`
- `div.calendar-container.container`
- `div.calendar-wrapper` berisi `iframe`

### 2) Update [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css)
- Tambahkan styling khusus calendar agar **responsif di mobile**:
  - `iframe { width: 100%; max-width: 100%; border: 1px solid #777; border-radius: 16px; }`
  - Tinggi default desktop: `height: 600px`
  - Mobile: `height` diturunkan (mis. `520px` atau `70vh`) supaya tidak kepanjangan.
  - Wrapper mengikuti pola `video-wrapper` (max-width dan shadow) agar konsisten dengan desain.

### 3) Verifikasi
- Build ulang `dist`.
- Pastikan `dist/index.html` memuat section “Kalender Timeline”.
- Cek tampilan di viewport mobile: iframe full width dan tidak overflow.

Jika Anda setuju, saya langsung implement perubahan ini di HTML + CSS dan build dist.