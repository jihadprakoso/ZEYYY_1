$file = "D:\Data User\Documents\GitHub\deartbox-Packaging\lightmode\notion-feel-v2-cleaned.html"
$content = Get-Content $file -Raw -Encoding UTF8

# ========== ADD FILE UPLOAD FIELD TO FORM ==========
$fileUploadHTML = @'

          <div class="form-field">
            <label for="rfq-files">Referensi Design (Opsional)</label>
            <div class="file-upload-wrapper">
              <input type="file" id="rfq-files" name="files" class="file-upload-input" accept="image/*,.pdf" multiple>
              <label for="rfq-files" class="file-upload-label">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path>
                  <polyline points="17 8 12 3 7 8"></polyline>
                  <line x1="12" y1="3" x2="12" y2="15"></line>
                </svg>
                <span>Klik atau drag & drop file di sini</span>
              </label>
              <div class="file-preview" id="filePreview"></div>
            </div>
            <small class="form-note">Max 5MB per file. Format: JPG, PNG, PDF</small>
          </div>
'@

# Insert file upload before the submit button
$content = $content -replace '(<button type="submit" class="btn-submit-rfq">)', ($fileUploadHTML + "`n`n" + '$1')

# ========== ADD SUCCESS MODAL HTML ==========
$successModalHTML = @'

  <!-- Success Modal -->
  <div class="success-modal" id="successModal">
    <div class="success-modal-content">
      <div class="success-icon">
        <svg viewBox="0 0 24 24" fill="none">
          <polyline points="20 6 9 17 4 12"></polyline>
        </svg>
      </div>
      <h3>Request Terkirim!</h3>
      <p>Terima kasih atas minat Anda. Tim kami akan menghubungi Anda melalui WhatsApp dalam 1x24 jam.</p>
      <div class="success-modal-actions">
        <button class="btn-modal btn-modal-primary" onclick="window.location.href='https://wa.me/628195181427'">
          Buka WhatsApp
        </button>
        <button class="btn-modal btn-modal-secondary" onclick="document.getElementById('successModal').classList.remove('show')">
          Tutup
        </button>
      </div>
    </div>
  </div>

'@

# Insert success modal before closing body tag
$content = $content -replace '(</body>)', ($successModalHTML + '$1')

# Save file
Set-Content $file -Value $content -Encoding UTF8 -NoNewline

Write-Host "Form HTML enhancements added successfully!"
