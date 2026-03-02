# Spesifikasi Desain Halaman — Integrasi Blog WordPress (Desktop-first)

## Global Styles (berlaku untuk semua halaman)
- **Pendekatan**: gunakan CSS yang sama dengan halaman utama (import stylesheet global yang sudah ada) dan tambah layer kecil `blog.css` untuk komponen blog.
- **Design tokens (disarankan via CSS variables)**:
  - `--color-bg`, `--color-surface`, `--color-text`, `--color-muted`, `--color-accent`, `--color-border`
  - Font: mengikuti font-family halaman utama; skala tipografi: H1/H2/body/small konsisten.
  - Button/Link: state default + hover + focus (outline jelas); link menggunakan warna aksen yang sama.
- **Layout baseline**:
  - Container desktop: max-width 1120–1200px, padding kiri/kanan 24px.
  - Spacing scale: 4/8/12/16/24/32/48.
  - Komponen global yang dipakai ulang: Header, Footer, Container.

---

## 1) Halaman Utama (Situs Statis)
### Layout
- Tetap memakai layout yang sudah ada.
- Navigasi (header) ditambah satu item: **Blog**.

### Meta Information
- Title: tetap sesuai halaman utama.
- Tidak perlu OG khusus untuk blog.

### Page Structure
- Header (global)
- Konten utama (existing)
- Footer (global)

### Sections & Components
1. **Header / Navigation**
   - Tambah menu item “Blog” (anchor/route) mengarah ke `/blog`.
   - State aktif (opsional): ketika berada di route blog, menu “Blog” tampil active (underline/warna aksen) mengikuti style homepage.

---

## 2) Halaman Blog (Daftar Artikel) — `/blog`
### Layout
- **Sistem**: CSS Grid untuk list artikel + Flexbox untuk header bar.
- Desktop-first:
  - List: 2–3 kolom kartu artikel (tergantung lebar container), gap 24px.
  - Pagination di bawah list, rata tengah.

### Meta Information
- Title: `Blog | {Nama Situs}`
- Description: ringkas (1 kalimat) tentang blog situs.
- Open Graph: `og:title`, `og:description`, `og:type=website`, `og:url`.

### Page Structure
- Header (global)
- Section: Page Heading
- Section: Article List
- Section: Pagination
- Footer (global)

### Sections & Components
1. **Page Heading**
   - H1: “Blog” (tipografi konsisten dengan heading homepage).
   - Subtext pendek (opsional) mengikuti tone konten homepage.

2. **Article Card Grid**
   - Komponen: `ArticleCard`
   - Isi kartu:
     - Judul (link ke detail)
     - Tanggal (format lokal)
     - Excerpt singkat
   - Hover state: elevasi ringan / border accent (mengikuti style homepage).

3. **Loading / Error State**
   - Loading: skeleton card 6–9 item.
   - Error: message box dengan tombol “Coba lagi” (mengikuti style tombol homepage).

4. **Pagination**
   - Tombol “Sebelumnya” / “Berikutnya”.
   - Disabled state jelas.

---

## 3) Halaman Artikel (Detail Artikel) — `/blog/:slug`
### Layout
- **Sistem**: layout bertumpuk (stacked) + typographic content area.
- Desktop-first:
  - Area konten max-width 760–820px (agar teks nyaman dibaca), center.
  - Header artikel full width container.

### Meta Information
- Title: `{Judul Artikel} | Blog | {Nama Situs}`
- Description: gunakan ringkasan dari excerpt (plain text bila memungkinkan).
- Open Graph: `og:title`, `og:description`, `og:type=article`, `og:url`.

### Page Structure
- Header (global)
- Breadcrumb / Back link
- Article Header (judul + meta)
- Article Content (render HTML WordPress)
- Footer (global)

### Sections & Components
1. **Back Link**
   - Link “← Kembali ke Blog” ke `/blog`.

2. **Article Header**
   - H1 judul artikel.
   - Meta bar: tanggal + penulis (jika tersedia).

3. **Article Content**
   - Render HTML dari WordPress dengan pembatas styling:
     - Default typography untuk `p`, `h2/h3`, `ul/ol`, `blockquote`, `img`, `a`.
     - Gambar: max-width 100%, border-radius sesuai style homepage.
     - Link: warna aksen + underline on hover.

4. **Not Found / Error State**
   - Jika slug tidak ditemukan: tampilkan heading “Artikel tidak ditemukan” + tombol kembali ke `/blog`.

---

## Responsive Behavior (ringkas)
- Tablet: grid daftar artikel turun ke 2 kolom.
- Mobile: grid 1 kolom; padding container 16px; H1 turun 1 step.
- Pastikan header/footer tetap identik dengan halaman utama.