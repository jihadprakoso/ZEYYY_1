## Interpretasi
- “refresh directory” saya anggap maksudnya: menyegarkan folder hasil rilis (dist/) supaya isinya selalu sama dengan file sumber di root (index.html, optimized_styles.css, optimized_script.js, assets, dll).

## Kondisi Saat Ini
- Repo punya dua set file yang dipakai: file sumber di root dan hasil build di dist/.
- Ada script resmi untuk refresh dist: [build-dist.ps1](file:///d:/Data%20User/Documents/Jihad/Web/build-dist.ps1) (hapus dist/ lalu copy file-file utama + folder assets/).

## Rencana Eksekusi
1. Jalankan refresh dist dengan script build-dist.ps1 untuk regenerate folder dist/ dari file sumber.
2. Validasi hasil refresh:
   - Cek referensi asset lokal di dist/index.html (pakai tools/check-local-refs.js) agar tidak ada file yang hilang.
   - Jalankan Lighthouse sekali untuk dist (desktop) untuk memastikan tidak ada penurunan besar.
3. Jika kamu juga pakai folder release/:
   - (Opsional) jalankan make-release.ps1 untuk bikin zip release terbaru setelah dist sudah fresh.

## Catatan
- Baris CSS yang kamu buka (transform: translateY(-2px) !important) di [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L6040-L6059) terlihat normal untuk efek hover footer social—tidak perlu diubah untuk proses refresh directory.
