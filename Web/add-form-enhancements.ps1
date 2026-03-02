$file = "D:\Data User\Documents\GitHub\deartbox-Packaging\lightmode\notion-feel-v2-cleaned.html"
$content = Get-Content $file -Raw -Encoding UTF8

# ========== ADD FORM VALIDATION CSS ==========
$formCSS = @'

/* ================ FORM VALIDATION STYLES ================ */

.form-field {
  position: relative;
}

.form-field.valid input,
.form-field.valid select,
.form-field.valid textarea {
  border-color: #22c55e;
  background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' viewBox='0 0 24 24' fill='none' stroke='%2322c55e' stroke-width='3'%3E%3Cpolyline points='20 6 9 17 4 12'%3E%3C/polyline%3E%3C/svg%3E");
  background-repeat: no-repeat;
  background-position: right 12px center;
  padding-right: 40px;
}

.form-field.error input,
.form-field.error select,
.form-field.error textarea {
  border-color: #ef4444;
}

.form-error {
  display: none;
  color: #ef4444;
  font-size: 13px;
  margin-top: 6px;
  animation: slideDown 0.3s ease;
}

.form-field.error .form-error {
  display: block;
}

.form-success {
  display: none;
  color: #22c55e;
  font-size: 13px;
  margin-top: 6px;
}

.form-field.valid .form-success {
  display: block;
}

@keyframes slideDown {
  from {
    opacity: 0;
    transform: translateY(-10px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

/* File Upload Styles */
.file-upload-wrapper {
  position: relative;
  margin-top: 8px;
}

.file-upload-input {
  display: none;
}

.file-upload-label {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  padding: 32px 16px;
  border: 2px dashed #e5e5e5;
  border-radius: 8px;
  cursor: pointer;
  transition: all 0.3s ease;
  background: #fafafa;
}

.file-upload-label:hover {
  border-color: #d71921;
  background: #fef1f2;
}

.file-upload-label.dragover {
  border-color: #d71921;
  background: #fef1f2;
  transform: scale(1.02);
}

.file-preview {
  display: none;
  margin-top: 12px;
  padding: 12px;
  background: #f5f5f5;
  border-radius: 8px;
  align-items: center;
  gap: 12px;
}

.file-preview.show {
  display: flex;
}

.file-preview img {
  width: 60px;
  height: 60px;
  object-fit: cover;
  border-radius: 4px;
}

.file-info {
  flex: 1;
}

.file-name {
  font-size: 14px;
  font-weight: 600;
  color: #1a1a1a;
  margin-bottom: 4px;
}

.file-size {
  font-size: 12px;
  color: #767676;
}

.file-remove {
  padding: 8px;
  background: #ef4444;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  transition: background 0.3s ease;
}

.file-remove:hover {
  background: #dc2626;
}

/* Success Modal */
.success-modal {
  display: none;
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0,0,0,0.5);
  backdrop-filter: blur(4px);
  z-index: 9999;
  align-items: center;
  justify-content: center;
  animation: fadeIn 0.3s ease;
}

.success-modal.show {
  display: flex;
}

.success-modal-content {
  background: white;
  padding: 40px;
  border-radius: 16px;
  max-width: 500px;
  width: 90%;
  text-align: center;
  animation: slideUp 0.4s ease;
  box-shadow: 0 20px 60px rgba(0,0,0,0.3);
}

@keyframes fadeIn {
  from { opacity: 0; }
  to { opacity: 1; }
}

@keyframes slideUp {
  from {
    opacity: 0;
    transform: translateY(30px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.success-icon {
  width: 80px;
  height: 80px;
  margin: 0 auto 24px;
  background: #22c55e;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  animation: scaleIn 0.5s ease 0.2s both;
}

@keyframes scaleIn {
  from {
    transform: scale(0);
  }
  to {
    transform: scale(1);
  }
}

.success-icon svg {
  width: 40px;
  height: 40px;
  stroke: white;
  stroke-width: 3;
}

.success-modal h3 {
  font-size: 24px;
  margin-bottom: 12px;
  color: #1a1a1a;
}

.success-modal p {
  color: #525252;
  margin-bottom: 24px;
  line-height: 1.6;
}

.success-modal-actions {
  display: flex;
  gap: 12px;
  justify-content: center;
}

.btn-modal {
  padding: 12px 24px;
  border-radius: 8px;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s ease;
  border: none;
}

.btn-modal-primary {
  background: #d71921;
  color: white;
}

.btn-modal-primary:hover {
  background: #a01419;
}

.btn-modal-secondary {
  background: #f5f5f5;
  color: #1a1a1a;
}

.btn-modal-secondary:hover {
  background: #e5e5e5;
}

'@

# Insert form CSS before </style>
$content = $content -replace '(\/\* ================ RESPONSIVE ENHANCEMENTS ================ \*\/)', ($formCSS + "`n`n" + '$1')

# Save file
Set-Content $file -Value $content -Encoding UTF8 -NoNewline

Write-Host "Form validation CSS added successfully!"
