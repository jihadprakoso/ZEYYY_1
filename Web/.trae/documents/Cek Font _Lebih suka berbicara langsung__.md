## Penyebab sekarang
- Teks **“Lebih suka berbicara langsung?”** adalah elemen `p.form-note.form-note-center` di dalam `.rfq-contact-quick`. [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L989-L992)
- Warnanya saat ini mengikuti rule `.rfq-contact-quick p { color: var(--text-muted); }` sehingga di dark mode tidak otomatis jadi putih. [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L3246-L3254)

## Target yang kamu minta
- Light mode: **hitam**
- Dark mode: **putih**

## Rencana perubahan
1. Tambahkan override khusus untuk teks itu (lebih spesifik supaya tidak mengganggu `.form-note` lain):
   - Light mode: `.rfq-contact-quick p.form-note { color: var(--text); }` (hasilnya hitam di light theme)
   - Dark mode: `[data-theme="dark"] .rfq-contact-quick p.form-note { color: #ffffff; }`
2. Letakkan rule ini dekat blok RFQ contact quick (area CSS RFQ) agar mudah dirawat.
3. Verifikasi:
   - Light mode: teks tampil hitam.
   - Dark mode: teks tampil putih.
   - Elemen lain (form-note di bawah tombol submit) tetap mengikuti styling semula.