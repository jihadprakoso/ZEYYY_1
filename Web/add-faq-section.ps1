$file = "D:\Data User\Documents\GitHub\deartbox-Packaging\lightmode\notion-feel-v2-cleaned.html"
$content = Get-Content $file -Raw -Encoding UTF8

# ========== ADD FAQ CSS ==========
$faqCSS = @'

/* ================ FAQ SECTION ================ */

.faq-section {
  padding: clamp(60px, 10vw, 100px) 0;
  background: var(--bg);
}

.faq-container {
  max-width: 800px;
  margin: 0 auto;
  padding: 0 var(--container-pad);
}

.faq-list {
  display: flex;
  flex-direction: column;
  gap: 16px;
  margin-top: 48px;
}

.faq-item {
  background: var(--card);
  border: 1px solid var(--border);
  border-radius: 12px;
  overflow: hidden;
  transition: all 0.3s ease;
}

.faq-item:hover {
  box-shadow: 0 4px 12px var(--shadow);
}

.faq-question {
  width: 100%;
  padding: 20px 24px;
  background: none;
  border: none;
  text-align: left;
  font-size: 16px;
  font-weight: 600;
  color: var(--text);
  cursor: pointer;
  display: flex;
  justify-content: space-between;
  align-items: center;
  gap: 16px;
  transition: all 0.3s ease;
}

.faq-question:hover {
  color: var(--accent);
}

.faq-icon {
  flex-shrink: 0;
  width: 24px;
  height: 24px;
  border-radius: 50%;
  background: #f5f5f5;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: all 0.3s cubic-bezier(0.16, 0.84, 0.44, 1);
}

[data-theme="dark"] .faq-icon {
  background: #2a2a2a;
}

.faq-icon svg {
  width: 16px;
  height: 16px;
  stroke: var(--text);
  transition: transform 0.3s cubic-bezier(0.16, 0.84, 0.44, 1);
}

.faq-item.active .faq-icon {
  background: var(--accent);
  transform: rotate(180deg);
}

.faq-item.active .faq-icon svg {
  stroke: white;
  transform: rotate(180deg);
}

.faq-answer {
  max-height: 0;
  overflow: hidden;
  transition: max-height 0.4s cubic-bezier(0.16, 0.84, 0.44, 1),
              padding 0.4s cubic-bezier(0.16, 0.84, 0.44, 1);
  padding: 0 24px;
}

.faq-item.active .faq-answer {
  max-height: 500px;
  padding: 0 24px 20px;
}

.faq-answer p {
  color: var(--text-muted);
  line-height: 1.7;
  font-size: 15px;
}

.faq-answer ul {
  margin: 12px 0;
  padding-left: 20px;
  color: var(--text-muted);
}

.faq-answer li {
  margin: 8px 0;
  line-height: 1.6;
}

'@

# Insert FAQ CSS
$content = $content -replace '(\/\* ================ DARK MODE ================ \*\/)', ($faqCSS + "`n`n" + '$1')

# ========== ADD FAQ HTML SECTION ==========
$faqHTML = @'

  <!-- ================ FAQ SECTION ================ -->
  <section class="faq-section" id="faq">
    <div class="faq-container">
      <div class="section-header">
        <span class="section-badge">FAQ</span>
        <h2 class="section-title" id="faq-title">Pertanyaan yang Sering Ditanyakan</h2>
        <p class="section-subtitle">Jawaban untuk pertanyaan umum tentang layanan kami</p>
      </div>

      <div class="faq-list">
        <div class="faq-item">
          <button class="faq-question" aria-expanded="false">
            <span>Berapa minimum order quantity (MOQ) untuk hardbox custom?</span>
            <div class="faq-icon">
              <svg viewBox="0 0 24 24" fill="none" stroke-width="2">
                <polyline points="6 9 12 15 18 9"></polyline>
              </svg>
            </div>
          </button>
          <div class="faq-answer">
            <p>MOQ kami mulai dari <strong>200 pcs</strong>. Ini adalah jumlah minimum yang memungkinkan kami memberikan harga terbaik sambil menjaga kualitas premium. Untuk brand yang baru launching atau ingin test market, ini adalah jumlah yang ideal.</p>
          </div>
        </div>

        <div class="faq-item">
          <button class="faq-question" aria-expanded="false">
            <span>Berapa lama waktu produksi hardbox custom?</span>
            <div class="faq-icon">
              <svg viewBox="0 0 24 24" fill="none" stroke-width="2">
                <polyline points="6 9 12 15 18 9"></polyline>
              </svg>
            </div>
          </button>
          <div class="faq-answer">
            <p>Waktu produksi standar adalah <strong>14-21 hari kerja</strong> setelah design approved dan DP diterima. Timeline ini sudah termasuk:</p>
            <ul>
              <li>Proses produksi dengan quality control ketat</li>
              <li>Finishing premium (emboss, hotprint, UV spot, dll)</li>
              <li>Final inspection sebelum packing</li>
            </ul>
            <p>Untuk urgent order, kami bisa diskusikan timeline khusus dengan biaya tambahan.</p>
          </div>
        </div>

        <div class="faq-item">
          <button class="faq-question" aria-expanded="false">
            <span>Apa saja finishing premium yang tersedia?</span>
            <div class="faq-icon">
              <svg viewBox="0 0 24 24" fill="none" stroke-width="2">
                <polyline points="6 9 12 15 18 9"></polyline>
              </svg>
            </div>
          </button>
          <div class="faq-answer">
            <p>Kami menyediakan berbagai finishing premium untuk meningkatkan value packaging Anda:</p>
            <ul>
              <li><strong>Hotprint</strong> - Gold, silver, rose gold, atau custom color</li>
              <li><strong>Emboss/Deboss</strong> - Tekstur timbul atau tenggelam</li>
              <li><strong>UV Spot</strong> - Glossy effect pada area tertentu</li>
              <li><strong>Soft Touch Lamination</strong> - Permukaan halus seperti beludru</li>
              <li><strong>Magnetic Closure</strong> - Penutup magnetik premium</li>
              <li><strong>Custom Insert</strong> - Foam atau cardboard insert sesuai produk</li>
            </ul>
          </div>
        </div>

        <div class="faq-item">
          <button class="faq-question" aria-expanded="false">
            <span>Apakah bisa request sample sebelum mass production?</span>
            <div class="faq-icon">
              <svg viewBox="0 0 24 24" fill="none" stroke-width="2">
                <polyline points="6 9 12 15 18 9"></polyline>
              </svg>
            </div>
          </button>
          <div class="faq-answer">
            <p><strong>Ya, tentu saja!</strong> Kami sangat merekomendasikan untuk membuat sample terlebih dahulu. Proses sample:</p>
            <ul>
              <li>Design mock-up gratis untuk approval</li>
              <li>Sample fisik dengan biaya produksi (akan dikembalikan jika jadi order)</li>
              <li>Revisi unlimited sampai design sesuai keinginan</li>
              <li>Waktu pembuatan sample: 7-10 hari kerja</li>
            </ul>
          </div>
        </div>

        <div class="faq-item">
          <button class="faq-question" aria-expanded="false">
            <span>Bagaimana sistem pembayaran dan apakah ada DP?</span>
            <div class="faq-icon">
              <svg viewBox="0 0 24 24" fill="none" stroke-width="2">
                <polyline points="6 9 12 15 18 9"></polyline>
              </svg>
            </div>
          </button>
          <div class="faq-answer">
            <p>Sistem pembayaran kami:</p>
            <ul>
              <li><strong>DP 50%</strong> - Saat design approved dan sebelum produksi dimulai</li>
              <li><strong>Pelunasan 50%</strong> - Sebelum pengiriman</li>
              <li>Metode pembayaran: Transfer bank (BCA, Mandiri, BNI, BRI)</li>
              <li>Invoice resmi akan diberikan untuk setiap transaksi</li>
            </ul>
            <p>Untuk repeat order atau partnership jangka panjang, kami bisa diskusikan terms khusus.</p>
          </div>
        </div>

        <div class="faq-item">
          <button class="faq-question" aria-expanded="false">
            <span>Apakah pengiriman ke seluruh Indonesia?</span>
            <div class="faq-icon">
              <svg viewBox="0 0 24 24" fill="none" stroke-width="2">
                <polyline points="6 9 12 15 18 9"></polyline>
              </svg>
            </div>
          </button>
          <div class="faq-answer">
            <p><strong>Ya, kami kirim ke seluruh Indonesia!</strong> Detail pengiriman:</p>
            <ul>
              <li>Packing aman dengan bubble wrap dan kardus tebal</li>
              <li>Menggunakan ekspedisi terpercaya (JNE, J&T, Sicepat, dll)</li>
              <li>Asuransi pengiriman tersedia</li>
              <li>Tracking number akan diberikan</li>
              <li>Untuk Jakarta dan sekitarnya bisa COD atau pickup</li>
            </ul>
          </div>
        </div>
      </div>
    </div>
  </section>

'@

# Insert FAQ section before CTA section
$content = $content -replace '(<!-- ================ CTA SECTION - AIDA: ACTION ================ -->)', ($faqHTML + "`n  " + '$1')

# ========== ADD FAQ JAVASCRIPT ==========
$faqJS = @'

      // ================ FAQ ACCORDION ================
      
      const faqItems = document.querySelectorAll('.faq-item');
      
      faqItems.forEach(function(item) {
        const question = item.querySelector('.faq-question');
        
        question.addEventListener('click', function() {
          const isActive = item.classList.contains('active');
          
          // Close all other items
          faqItems.forEach(function(otherItem) {
            if (otherItem !== item) {
              otherItem.classList.remove('active');
              otherItem.querySelector('.faq-question').setAttribute('aria-expanded', 'false');
            }
          });
          
          // Toggle current item
          if (isActive) {
            item.classList.remove('active');
            question.setAttribute('aria-expanded', 'false');
          } else {
            item.classList.add('active');
            question.setAttribute('aria-expanded', 'true');
          }
        });
      });

'@

# Insert FAQ JS
$content = $content -replace '(\/\/ ================ DARK MODE ================)', ($faqJS + "`n`n" + '$1')

# Save file
Set-Content $file -Value $content -Encoding UTF8 -NoNewline

Write-Host "FAQ section added successfully!"
