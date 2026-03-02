## Penyebab dropdown cepat ketutup
- Saat ini menu dropdown diposisikan dengan jarak dari tombolnya (`top: calc(100% + 10px)`).
- Jadi ada “gap” kosong 10px di antara tombol `summary` dan menu.
- Ketika mouse bergerak dari teks “Layanan Kami / Hubungi Kami” ke item menu, mouse melewati gap itu → status hover hilang → dropdown menutup sebelum sempat diklik.
- Selain itu, JavaScript juga menutup dropdown pada event `mouseleave`, sehingga efeknya makin terasa “ketutup lagi”.

## Cara klik (workaround sementara)
- Bisa pakai keyboard: `Tab` sampai fokus ke “Layanan Kami”, lalu `Enter`, pilih item dengan `Tab` lalu `Enter`.
- Atau klik dulu (bukan hover) supaya `details` jadi `open`.

## Perbaikan yang akan saya lakukan
1. **CSS: hilangkan gap hover**
   - Ubah posisi menu dari `top: calc(100% + 10px)` menjadi `top: 100%` (atau gap dibuat sangat kecil), supaya mouse bisa langsung turun ke menu tanpa melewati area kosong.
   - Tetap pakai animasi (opacity/transform) supaya tampilannya tetap halus.

2. **JavaScript: jangan auto-close pada mouseleave**
   - Hapus logika `mouseenter/mouseleave` yang set/unset `open`.
   - Tetap pertahankan behavior yang sudah enak:
     - Klik di luar → tutup
     - Klik item → tutup
     - Tekan `Esc` → tutup

## Verifikasi
- Cek desktop: hover lalu arahkan mouse ke item menu → bisa diklik tanpa menutup.
- Pastikan dropdown masih bisa ditutup dengan klik luar dan ESC.
- Mobile tidak diubah (sesuai permintaan sebelumnya).

Jika Anda approve, saya langsung terapkan perubahan CSS + JS ini.