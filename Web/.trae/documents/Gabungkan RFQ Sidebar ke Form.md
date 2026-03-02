## Rekomendasi posisi
Saya sarankan **dibawah (setelah form note)**.
- Fokus user tetap ke pengisian form dulu (konversi via RFQ), lalu kalau mereka ragu/mager, ada opsi cepat “Chat via WhatsApp”.
- Secara hierarchy, CTA WhatsApp jadi fallback, bukan distraksi di awal.

Alternatif kalau tujuannya mempercepat chat (lebih banyak klik WA daripada submit form): taruh **di atas (sebelum form)**, tapi dibuat lebih kecil/compact supaya tidak “menggeser” fokus.

## Perubahan yang akan saya lakukan (mengikuti rekomendasi: dibawah)
1. **Pindahkan blok `.rfq-contact-quick` ke dalam `form#rfqForm`**
   - Letakkan tepat setelah paragraf `.form-note`.
   - Hapus `aside.rfq-sidebar` karena sudah tidak dipakai.

2. **Ubah layout RFQ jadi 1 kolom**
   - Karena sidebar hilang, ubah `.rfq-layout` dari 2 kolom menjadi 1 kolom agar tidak ada kolom kosong.

3. **Rapikan spacing**
   - Tambahkan jarak atas untuk `.rfq-form .rfq-contact-quick` supaya tampil rapi setelah form note.

## File yang akan diubah
- [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html)
- [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css)

## Verifikasi
- Blok “Lebih suka berbicara langsung?” muncul setelah form note.
- Tampilan RFQ tetap rapi di desktop dan mobile (tanpa kolom kosong).