$file = "D:\Data User\Documents\GitHub\deartbox-Packaging\lightmode\notion-feel-v2-cleaned.html"
$content = Get-Content $file -Raw -Encoding UTF8

# ========== ADD COMPREHENSIVE FORM VALIDATION JAVASCRIPT ==========
$formValidationJS = @'

      // ================ FORM VALIDATION & ENHANCEMENTS ================
      
      // Real-time validation functions
      const validators = {
        name: function(value) {
          if (!value || value.trim().length < 2) {
            return { valid: false, message: 'Nama minimal 2 karakter' };
          }
          return { valid: true, message: 'Nama valid' };
        },
        
        whatsapp: function(value) {
          // Indonesian phone format: 08xx-xxxx-xxxx
          const cleaned = value.replace(/\D/g, '');
          if (!cleaned.startsWith('08')) {
            return { valid: false, message: 'Nomor harus diawali 08' };
          }
          if (cleaned.length < 10 || cleaned.length > 13) {
            return { valid: false, message: 'Nomor tidak valid (10-13 digit)' };
          }
          return { valid: true, message: 'Nomor valid' };
        },
        
        email: function(value) {
          const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
          if (!emailRegex.test(value)) {
            return { valid: false, message: 'Format email tidak valid' };
          }
          
          // Common typo suggestions
          const commonTypos = {
            'gmial.com': 'gmail.com',
            'gmai.com': 'gmail.com',
            'yahooo.com': 'yahoo.com',
            'hotmial.com': 'hotmail.com'
          };
          
          const domain = value.split('@')[1];
          if (commonTypos[domain]) {
            return { 
              valid: false, 
              message: `Maksud Anda ${value.replace(domain, commonTypos[domain])}?` 
            };
          }
          
          return { valid: true, message: 'Email valid' };
        }
      };

      // Phone number auto-formatting
      const whatsappInput = document.getElementById('whatsapp');
      if (whatsappInput) {
        whatsappInput.addEventListener('input', function(e) {
          let value = e.target.value.replace(/\D/g, '');
          
          // Format: 0819-1234-5678
          if (value.length > 4 && value.length <= 8) {
            value = value.slice(0, 4) + '-' + value.slice(4);
          } else if (value.length > 8) {
            value = value.slice(0, 4) + '-' + value.slice(4, 8) + '-' + value.slice(8, 12);
          }
          
          e.target.value = value;
          validateField(e.target, 'whatsapp');
        });
      }

      // Real-time validation for all fields
      function validateField(field, validatorName) {
        const fieldWrapper = field.closest('.form-field');
        if (!fieldWrapper) return;
        
        const value = field.value.trim();
        const validator = validators[validatorName];
        
        if (!validator) return;
        
        const result = validator(value);
        
        // Remove existing error/success messages
        let errorMsg = fieldWrapper.querySelector('.form-error');
        let successMsg = fieldWrapper.querySelector('.form-success');
        
        if (!errorMsg) {
          errorMsg = document.createElement('div');
          errorMsg.className = 'form-error';
          field.parentNode.appendChild(errorMsg);
        }
        
        if (!successMsg) {
          successMsg = document.createElement('div');
          successMsg.className = 'form-success';
          field.parentNode.appendChild(successMsg);
        }
        
        if (result.valid) {
          fieldWrapper.classList.remove('error');
          fieldWrapper.classList.add('valid');
          errorMsg.textContent = '';
          successMsg.textContent = result.message;
        } else {
          fieldWrapper.classList.remove('valid');
          fieldWrapper.classList.add('error');
          errorMsg.textContent = result.message;
          successMsg.textContent = '';
        }
      }

      // Attach validators to form fields
      const nameInput = document.getElementById('rfq-name');
      const emailInput = document.getElementById('rfq-email');
      
      if (nameInput) {
        nameInput.addEventListener('blur', function() {
          validateField(this, 'name');
        });
      }
      
      if (emailInput) {
        emailInput.addEventListener('blur', function() {
          validateField(this, 'email');
        });
      }

      // ================ FILE UPLOAD HANDLING ================
      
      const fileInput = document.getElementById('rfq-files');
      const fileLabel = document.querySelector('.file-upload-label');
      const filePreview = document.getElementById('filePreview');
      let uploadedFiles = [];

      if (fileInput && fileLabel) {
        // Click to upload
        fileInput.addEventListener('change', handleFiles);
        
        // Drag and drop
        fileLabel.addEventListener('dragover', function(e) {
          e.preventDefault();
          this.classList.add('dragover');
        });
        
        fileLabel.addEventListener('dragleave', function(e) {
          e.preventDefault();
          this.classList.remove('dragover');
        });
        
        fileLabel.addEventListener('drop', function(e) {
          e.preventDefault();
          this.classList.remove('dragover');
          
          const files = e.dataTransfer.files;
          handleFiles({ target: { files: files } });
        });
      }

      function handleFiles(e) {
        const files = Array.from(e.target.files);
        const maxSize = 5 * 1024 * 1024; // 5MB
        const allowedTypes = ['image/jpeg', 'image/png', 'image/webp', 'application/pdf'];
        
        files.forEach(file => {
          // Validate file size
          if (file.size > maxSize) {
            alert(`File ${file.name} terlalu besar. Maksimal 5MB.`);
            return;
          }
          
          // Validate file type
          if (!allowedTypes.includes(file.type)) {
            alert(`File ${file.name} format tidak didukung. Gunakan JPG, PNG, atau PDF.`);
            return;
          }
          
          uploadedFiles.push(file);
          displayFilePreview(file);
        });
      }

      function displayFilePreview(file) {
        const previewItem = document.createElement('div');
        previewItem.className = 'file-preview-item';
        previewItem.style.cssText = 'display: flex; align-items: center; gap: 12px; padding: 12px; background: #f5f5f5; border-radius: 8px; margin-bottom: 8px;';
        
        // File icon or image preview
        if (file.type.startsWith('image/')) {
          const img = document.createElement('img');
          img.style.cssText = 'width: 60px; height: 60px; object-fit: cover; border-radius: 4px;';
          const reader = new FileReader();
          reader.onload = function(e) {
            img.src = e.target.result;
          };
          reader.readAsDataURL(file);
          previewItem.appendChild(img);
        } else {
          const icon = document.createElement('div');
          icon.style.cssText = 'width: 60px; height: 60px; background: #d71921; border-radius: 4px; display: flex; align-items: center; justify-content: center; color: white; font-weight: bold;';
          icon.textContent = 'PDF';
          previewItem.appendChild(icon);
        }
        
        // File info
        const fileInfo = document.createElement('div');
        fileInfo.style.flex = '1';
        fileInfo.innerHTML = `
          <div class="file-name">${file.name}</div>
          <div class="file-size">${(file.size / 1024).toFixed(1)} KB</div>
        `;
        previewItem.appendChild(fileInfo);
        
        // Remove button
        const removeBtn = document.createElement('button');
        removeBtn.type = 'button';
        removeBtn.className = 'file-remove';
        removeBtn.innerHTML = '×';
        removeBtn.onclick = function() {
          uploadedFiles = uploadedFiles.filter(f => f !== file);
          previewItem.remove();
          if (uploadedFiles.length === 0) {
            filePreview.classList.remove('show');
          }
        };
        previewItem.appendChild(removeBtn);
        
        filePreview.appendChild(previewItem);
        filePreview.classList.add('show');
      }

      // ================ FORM AUTO-SAVE (localStorage) ================
      
      const formFields = ['rfq-name', 'whatsapp', 'rfq-email', 'rfq-brand', 'rfq-industry', 'rfq-box', 'rfq-qty', 'rfq-message'];
      
      // Load saved data on page load
      window.addEventListener('load', function() {
        formFields.forEach(fieldId => {
          const field = document.getElementById(fieldId);
          const savedValue = localStorage.getItem('rfq_' + fieldId);
          if (field && savedValue) {
            field.value = savedValue;
          }
        });
      });

      // Auto-save every 30 seconds
      setInterval(function() {
        formFields.forEach(fieldId => {
          const field = document.getElementById(fieldId);
          if (field && field.value) {
            localStorage.setItem('rfq_' + fieldId, field.value);
          }
        });
      }, 30000);

      // Clear saved data on successful submission
      function clearFormData() {
        formFields.forEach(fieldId => {
          localStorage.removeItem('rfq_' + fieldId);
        });
      }

      // ================ ENHANCED FORM SUBMISSION ================
      
      if (rfqForm) {
        rfqForm.addEventListener('submit', function(e) {
          e.preventDefault();
          
          // Validate all required fields
          let isValid = true;
          const requiredFields = [
            { id: 'rfq-name', validator: 'name' },
            { id: 'whatsapp', validator: 'whatsapp' },
            { id: 'rfq-email', validator: 'email' }
          ];
          
          requiredFields.forEach(field => {
            const input = document.getElementById(field.id);
            if (input) {
              validateField(input, field.validator);
              const wrapper = input.closest('.form-field');
              if (wrapper && wrapper.classList.contains('error')) {
                isValid = false;
              }
            }
          });
          
          if (!isValid) {
            alert('Mohon perbaiki field yang error terlebih dahulu.');
            return;
          }
          
          // Show loading state
          submitBtn.disabled = true;
          submitBtn.innerHTML = '<svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="animation: spin 1s linear infinite;"><circle cx="12" cy="12" r="10"/></svg> <span>Mengirim...</span>';
          
          const formData = new FormData(rfqForm);
          const name = formData.get('name');
          const whatsapp = formData.get('whatsapp');
          const email = formData.get('email');
          const brand = formData.get('brand') || '-';
          const industry = formData.get('industry');
          const boxType = formData.get('boxType');
          const quantity = formData.get('quantity') || '-';
          const message = formData.get('message');

          let waMessage = `Halo deartbox,\nSaya ingin request quotation:\n\nNama: ${name}\nWhatsApp: ${whatsapp}\nEmail: ${email}\nBrand: ${brand}\nIndustri: ${industry}\nTipe Box: ${boxType}\nKuantitas: ${quantity}\nDeskripsi: ${message}`;
          
          if (uploadedFiles.length > 0) {
            waMessage += `\n\nFile referensi: ${uploadedFiles.length} file terlampir`;
          }

          const waUrl = 'https://wa.me/628195181427?text=' + encodeURIComponent(waMessage);
          
          // Simulate sending delay
          setTimeout(function() {
            // Open WhatsApp
            window.open(waUrl, '_blank');
            
            // Show success modal
            document.getElementById('successModal').classList.add('show');
            
            // Reset form
            rfqForm.reset();
            uploadedFiles = [];
            filePreview.innerHTML = '';
            filePreview.classList.remove('show');
            
            // Clear localStorage
            clearFormData();
            
            // Reset button
            submitBtn.disabled = false;
            submitBtn.innerHTML = originalBtnText;
            
            // Remove validation classes
            document.querySelectorAll('.form-field').forEach(field => {
              field.classList.remove('valid', 'error');
            });
          }, 1500);
        });
      }

      // Close modal on outside click
      const successModal = document.getElementById('successModal');
      if (successModal) {
        successModal.addEventListener('click', function(e) {
          if (e.target === this) {
            this.classList.remove('show');
          }
        });
      }

'@

# Insert form validation JS before the closing of the main script
$content = $content -replace '(\/\/ ================ PERFORMANCE: DEBOUNCE SCROLL EVENTS ================)', ($formValidationJS + "`n`n" + '$1')

# Save file
Set-Content $file -Value $content -Encoding UTF8 -NoNewline

Write-Host "Form validation JavaScript added successfully!"
