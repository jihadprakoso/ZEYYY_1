# Deartbox Blog - WordPress Theme

Custom WordPress theme untuk blog deartbox Packaging yang terintegrasi dengan design website utama.

## 📁 Struktur File

```
deartbox-theme/
├── assets/
│   ├── css/
│   ├── images/
│   └── js/
│       └── main.js
├── inc/
│   └── template-tags.php
├── template-parts/
│   └── content-card.php
├── 404.php
├── comments.php
├── footer.php
├── functions.php
├── header.php
├── index.php
├── page.php
├── screenshot.png
├── searchform.php
├── single.php
└── style.css
```

## 🚀 Instalasi

### Langkah 1: Upload Theme

**Via cPanel File Manager:**
1. Login ke cPanel hosting
2. Buka **File Manager**
3. Navigate ke `public_html/blog/wp-content/themes/`
4. Upload folder `deartbox-theme` (atau ZIP file)
5. Jika upload ZIP, extract file tersebut

**Via FTP:**
1. Connect ke server via FTP (FileZilla, etc.)
2. Navigate ke `/public_html/blog/wp-content/themes/`
3. Upload folder `deartbox-theme`

### Langkah 2: Aktivasi Theme

1. Login ke WordPress Admin (`deartbox.com/blog/wp-admin`)
2. Pergi ke **Appearance → Themes**
3. Cari theme "Deartbox Blog"
4. Klik **Activate**

### Langkah 3: Konfigurasi Theme

#### A. Setup Menu
1. Pergi ke **Appearance → Menus**
2. Buat menu baru dengan nama "Primary Menu"
3. Tambahkan halaman/kategori yang diinginkan
4. Set **Display location** ke "Primary Menu"
5. Save Menu

#### B. Setup Logo
1. Pergi ke **Appearance → Customize → Site Identity**
2. Upload logo (atau biarkan default menggunakan logo dari website utama)
3. Set Site Title dan Tagline
4. Publish

#### C. Setup Social Media & Contact
1. Pergi ke **Appearance → Customize**
2. Buka section **Social Media Links**
   - Instagram URL
   - LinkedIn URL
   - YouTube URL
   - Facebook URL
3. Buka section **Contact Information**
   - Phone Number
   - Email Address
   - Address
4. Buka section **Main Site Settings**
   - Main Site URL: `https://deartbox.com`
5. Publish

#### D. Setup Widgets (Opsional)
1. Pergi ke **Appearance → Widgets**
2. Tambahkan widget ke "Blog Sidebar":
   - Search
   - Recent Posts
   - Categories
   - Tags

### Langkah 4: Buat Konten

1. Pergi ke **Posts → Add New**
2. Tulis artikel dengan:
   - Judul yang menarik
   - Featured Image (1200x630 px recommended)
   - Kategori
   - Tags
3. Publish

## ⚙️ Fitur Theme

### Design
- ✅ Matching dengan website utama deartbox
- ✅ Dark mode support
- ✅ Fully responsive (mobile-first)
- ✅ Modern typography (Inter + Poppins)

### Functionality
- ✅ Custom post cards dengan thumbnail
- ✅ Reading time estimation
- ✅ Related posts
- ✅ Social share buttons
- ✅ Comment system
- ✅ Search functionality
- ✅ Pagination
- ✅ Breadcrumbs

### Performance
- ✅ Optimized CSS
- ✅ Lazy loading images
- ✅ Minimal JavaScript
- ✅ No jQuery dependency

### SEO
- ✅ Semantic HTML5
- ✅ Schema markup ready
- ✅ Open Graph meta tags ready
- ✅ Clean URL structure

## 🎨 Customization

### Warna
Edit CSS variables di `style.css`:

```css
:root {
  --accent: #d71921;      /* Warna utama */
  --accent-2: #620d0d;    /* Warna sekunder */
  --text: #0c1019;        /* Warna teks */
  --bg: #ffffff;          /* Background */
}
```

### Typography
```css
:root {
  --font-body: 'Inter', sans-serif;
  --font-heading: 'Poppins', sans-serif;
}
```

## 📱 Responsive Breakpoints

- Mobile: < 480px
- Tablet: 481px - 768px
- Desktop: 769px - 1024px
- Large: > 1024px

## 🔧 Troubleshooting

### Theme tidak muncul di WordPress
- Pastikan folder theme bernama `deartbox-theme`
- Pastikan file `style.css` ada di root folder theme
- Check permission folder (755 untuk folder, 644 untuk file)

### Logo tidak muncul
- Pastikan URL website utama sudah benar di Customizer
- Check path logo di `header.php`

### Dark mode tidak bekerja
- Clear browser cache
- Check console untuk JavaScript errors

## 📞 Support

Jika ada pertanyaan atau masalah:
- Email: deartboxpackaging@gmail.com
- WhatsApp: +62 819-5181-427

---

© 2026 deartbox Packaging - PT. Xerography Indonesia
