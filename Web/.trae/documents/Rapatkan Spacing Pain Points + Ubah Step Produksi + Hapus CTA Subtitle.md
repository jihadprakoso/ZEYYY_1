## Jawaban: Waktu agar logo trust marquee terlihat semua
- Di CSS saat ini, animasi trust marquee berjalan **34 detik** untuk baris 1 dan **38 detik** untuk baris 2: [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L2553-L2565).
- Secara praktik, **dalam 34s (baris 1) / 38s (baris 2)** semua logo yang ada di track akan lewat dan terlihat (karena animasi menggeser track sampai `-50%`, pola umum untuk loop set logo yang diduplikasi).
- Kalau kursor berada di area marquee di desktop, animasi **pause**, jadi bisa terasa lebih lama: [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L2581-L2585).

## Perubahan yang Akan Dikerjakan
1. Rapatkan spacing teks “Masalah yang sering bikin produksi molor” dengan kotak (panel) di bawahnya.
2. “Proses Kerja Kami”: poin 3 ubah judul menjadi **Produksi & QC**.
3. CTA akhir: hapus teks “Konsultasi gratis untuk diskusi kebutuhan packaging Anda.”
4. Feature card **Mesin Produksi Semi-Auto**: ganti gambar menjadi `mesinauto.webp`.
5. Proses kerja poin 1 **Konsultasi Gratis**: ganti gambar menjadi `mesinauto.webp`.

## Temuan Penting
- File `mesinauto.webp` sudah ada di dist: [dist/assets/images/features/mesinauto.webp](file:///d:/Data%20User/Documents/Jihad/Web/dist/assets/images/features/mesinauto.webp), tetapi belum ada di source `assets/`.

## Rencana Implementasi
### 1) Pastikan aset mesinauto ada di source
- Salin `dist/assets/images/features/mesinauto.webp` → `assets/images/features/mesinauto.webp` agar aman saat build ulang.

### 2) Rapatkan spacing pain points
- Penyebab utama jarak besar: `.section-header { margin-bottom: clamp(40px, 8vw, 64px); }`: [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L2779-L2785).
- Tambahkan override khusus pain points:
  - `.pain-points-section .section-header { margin-bottom: 20px; }`
- Target HTML: [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L672-L704).

### 3) Update “Proses Kerja Kami”
- Poin 3: ubah judul `Produksi` → `Produksi & QC`: [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L947-L957).
- Poin 1: ubah gambar step 1 dari `assets/images/process/consultation.webp` → `assets/images/features/mesinauto.webp`: [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L928-L939).

### 4) Update feature card Mesin Produksi Semi-Auto
- Ganti `assets/images/features/machine.webp` → `assets/images/features/mesinauto.webp`: [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L774-L784).

### 5) Hapus subtitle CTA akhir
- Hapus elemen `p.cta-subtitle` di CTA section: [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html#L1342-L1348).
- Jika spacing CTA jadi terlalu kosong, rapikan lewat CSS CTA section saja (tanpa mengubah global header).

### 6) Build ulang dist + verifikasi
- Jalankan `build-dist.ps1`.
- Verifikasi di `dist/index.html`:
  - Spacing pain points lebih rapat.
  - Step 3 “Produksi & QC”.
  - Step 1 menggunakan gambar `mesinauto.webp`.
  - Feature card semi-auto memakai `mesinauto.webp`.
  - CTA akhir tidak menampilkan teks subtitle tersebut.

## Output
- Update [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html) dan [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css).
- Build ulang `dist/` agar siap deploy.