## Jawaban
- Bisa: link nav “Testimoni” di header dapat dipindahkan menjadi item di dropdown “Hubungi Kami”, sehingga header lebih ringkas.
- Di file saat ini, desktop nav punya link terpisah [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L137-L145): “Testimoni” → `#testimonials` dan “Hubungi Kami” → `#rfq`.

## Perubahan yang Akan Dibuat
- Ubah markup desktop nav di [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L137-L145):
  - Hapus link “Testimoni” sebagai link mandiri.
  - Ganti “Hubungi Kami” menjadi dropdown (misalnya memakai elemen `details/summary` agar jalan tanpa JavaScript).
  - Isi dropdown minimal:
    - “Request Quotation” → `#rfq`
    - “Testimoni” → `#testimonials`
    - (Opsional) “WhatsApp” → `https://wa.me/628195181427`
    - (Opsional) “Email” → `mailto:deartboxpackaging@gmail.com`

## Styling (CSS)
- Tambah styling dropdown di [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css):
  - `position: relative` untuk container.
  - Menu dropdown absolute, style mengikuti tema (pakai variabel seperti `--glass`, `--text`).
  - Tampilkan menu saat `details[open]` dan saat fokus (keyboard-friendly).

## Interaksi & Aksesibilitas
- Pastikan bisa dipakai keyboard:
  - `summary` dapat di-tab, menu terbuka saat enter/space.
  - Item menu dapat di-tab.
- (Opsional) Tambah JavaScript kecil di [optimized_script.js](file:///d:/Data%20User/Documents/Jihad/Web/optimized_script.js) agar dropdown otomatis menutup setelah klik item dan menutup jika klik di luar.

## Verifikasi
- Cek desktop (≥768px): dropdown muncul, link “Testimoni” membawa ke section testimoni, “Request Quotation” ke RFQ.
- Cek mobile (<768px): mobile menu tetap normal (atau kalau Anda mau, saya juga bisa rapikan mobile menu supaya konsisten).
- Pastikan tidak ada error HTML/CSS dan tampilan dark mode tetap rapi.

Jika Anda setuju, saya lanjutkan implementasi dropdown ini.