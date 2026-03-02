## Target

Blog WordPress berjalan di **<https://deartbox.com/blog/>**, sementara homepage statis Anda tetap seperti sekarang.

## Cara Paling Mudah (cPanel: WordPress Toolkit / Softaculous)

### 1) Persiapan

* Pastikan domain sudah pakai SSL aktif (https).

* Siapkan:

  * Email admin (untuk reset password)

  * Username admin (hindari `admin`)

  * Password kuat

### 2) Install WordPress ke Subdirectory `/blog`

**Opsi A: WordPress Toolkit (kalau ada di cPanel)**

* cPanel → **WordPress Management / WordPress Toolkit**

* Klik **Install**

* Pilih:

  * Domain: `deartbox.com`

  * Path/Directory: `blog` (ini yang membuat URL `/blog/`)

  * Site name: mis. “deartbox Blog”

  * Admin user/email/password

* Klik Install

**Opsi B: Softaculous (umum di cPanel)**

* cPanel → **Softaculous Apps Installer** → WordPress → Install

* Pilih:

  * Protocol: `https://`

  * Domain: `deartbox.com`

  * In Directory: `blog` (penting)

  * Site Settings + Admin Account

* Install

## Setup Wajib Setelah Install

### 3) Setting permalink (URL artikel rapi)

* WP Admin → **Settings → Permalinks**

* Pilih **Post name** (`/%postname%/`)

### 4) Tema (tampilan)

* Pilih theme yang cepat dan clean (mis. GeneratePress / Astra / Kadence).

* Buat halaman:

  * Blog (listing)

  * About / Contact (opsional)

* Matikan/hapus konten default (Hello World, Sample Page).

### 5) Plugin minimal yang saya sarankan

* SEO: **Rank Math** atau **Yoast** (pilih salah satu)

* Cache/performa:

  * Jika server pakai LiteSpeed (sering di cPanel): **LiteSpeed Cache**

  * Jika tidak: **WP Super Cache** atau **W3 Total Cache**

* Security dasar: **Wordfence** (opsional, tapi bagus)

### 6) Sitemap & indexing Google

* WordPress akan punya sitemap (biasanya):

  * `https://deartbox.com/blog/wp-sitemap.xml` (core WP)

  * atau `.../sitemap_index.xml` (kalau pakai plugin SEO)

* Daftarkan sitemap blog ini ke Google Search Console.

* (Opsional) Tambahkan link sitemap blog ke robots.txt utama, misalnya:

  * `Sitemap: https://deartbox.com/blog/wp-sitemap.xml`

### 7) Integrasi dengan website utama (statis)

* Ubah menu “Blog & Artikel” di homepage agar mengarah ke:

  * `https://deartbox.com/blog/`

* (Opsional) Tambahkan section “Artikel Terbaru” di homepage (manual link ke 3 artikel terbaru).

## Deploy / Struktur File di Hosting

* Website statis Anda saat ini tetap di `public_html/`.

* WordPress akan berada di `public_html/blog/`.

* Ini aman dan umum digunakan (dua sistem berbeda dalam satu domain).

## Checklist Verifikasi

* Buka `https://deartbox.com/blog/` (homepage blog muncul)

* Buat 1 artikel → pastikan URL rapi `https://deartbox.com/blog/judul-artikel/`

* Cek sitemap blog bisa diakses

* Cek tidak ada mixed content (selalu https)

## Yang Bisa Saya Kerjakan di Repo Setelah Anda OK

* Update [index.html](file:///d:/Data%20User/Documents/Jihad/Web/index.html) agar tombol/menu Blog mengarah ke `/blog/`.

* (Opsional) Tambahkan link sitemap blog ke `robots.txt` dan/atau update `sitemap.xml` utama untuk memasukkan `/blog/`.

