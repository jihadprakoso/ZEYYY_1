## Jawaban
- Durasi animasi trust marquee saat ini:
  - Baris 1: **34 detik** (`animation: marquee 34s linear infinite`)
  - Baris 2: **38 detik** (`animation: marquee 38s linear infinite reverse`)
  Referensi: [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L2553-L2565)
- Karena track berisi set logo yang diduplikasi dan animasi bergerak sampai `translateX(-50%)`, maka dalam **1 siklus** itu semua logo pada baris tersebut akan lewat dan terlihat.
- Jadi untuk “semua logo trust marquee” (dua baris), patokan amannya: **maksimal ±38 detik** untuk melihat semuanya lewat setidaknya 1x.

## Catatan yang Bisa Mengubah Perasaan Durasi
- Logo memakai `data-src` (lazy/deferred). Script baru mulai load gambar **setelah interaksi pertama** atau otomatis **±2 detik** setelah halaman diam, jadi awalnya mungkin terlihat placeholder dulu. Referensi: [optimized_script.js](file:///d:/Data%20User/Documents/Jihad/Web/optimized_script.js#L937-L994)
- Saat kursor hover di area marquee (desktop), animasi **pause**, sehingga waktu untuk melihat semua logo jadi lebih lama. Referensi: [optimized_styles.css](file:///d:/Data%20User/Documents/Jihad/Web/optimized_styles.css#L2581-L2585)

## Rencana (Tidak Ada Perubahan Kode)
- Tidak perlu edit apa pun untuk menjawab pertanyaan ini.
- Jika ingin semua logo lewat lebih cepat, langkah opsionalnya adalah menurunkan nilai 34s/38s (mis. 24s/28s) di CSS, lalu build dist.