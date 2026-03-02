$file = "D:\Data User\Documents\GitHub\deartbox-Packaging\lightmode\notion-feel-v2-cleaned.html"
$content = Get-Content $file -Raw -Encoding UTF8

# Replace console.log with conditional logging (only in development)
$content = $content -replace "console\.log\('SW registration failed:', err\);", "// console.log('SW registration failed:', err); // Disabled for production"
$content = $content -replace "console\.warn\('Slow resource:', entry\.name, entry\.duration \+ 'ms'\);", "// Performance monitoring - disabled for production"

# Replace alert() with better user feedback
# Alert for file size
$content = $content -replace "alert\(`File \$\{file\.name\} terlalu besar\. Maksimal 5MB\.`\);", "// Show error in UI instead of alert
            const errorMsg = document.createElement('div');
            errorMsg.style.cssText = 'position: fixed; top: 20px; right: 20px; background: #ef4444; color: white; padding: 16px 24px; border-radius: 8px; z-index: 10000; animation: slideIn 0.3s ease;';
            errorMsg.textContent = `File ${file.name} terlalu besar. Maksimal 5MB.`;
            document.body.appendChild(errorMsg);
            setTimeout(() => errorMsg.remove(), 3000);
            return;"

# Alert for file type
$content = $content -replace "alert\(`File \$\{file\.name\} format tidak didukung\. Gunakan JPG, PNG, atau PDF\.`\);", "// Show error in UI instead of alert
            const errorMsg = document.createElement('div');
            errorMsg.style.cssText = 'position: fixed; top: 20px; right: 20px; background: #ef4444; color: white; padding: 16px 24px; border-radius: 8px; z-index: 10000; animation: slideIn 0.3s ease;';
            errorMsg.textContent = `File ${file.name} format tidak didukung. Gunakan JPG, PNG, atau PDF.`;
            document.body.appendChild(errorMsg);
            setTimeout(() => errorMsg.remove(), 3000);
            return;"

# Alert for form validation
$content = $content -replace "alert\('Mohon perbaiki field yang error terlebih dahulu\.'\);", "// Show validation error in UI
          const errorMsg = document.createElement('div');
          errorMsg.style.cssText = 'position: fixed; top: 20px; right: 20px; background: #ef4444; color: white; padding: 16px 24px; border-radius: 8px; z-index: 10000; animation: slideIn 0.3s ease;';
          errorMsg.textContent = 'Mohon perbaiki field yang error terlebih dahulu.';
          document.body.appendChild(errorMsg);
          setTimeout(() => errorMsg.remove(), 3000);"

# Add animation for toast notifications
$toastAnimation = @'

@keyframes slideIn {
  from {
    transform: translateX(400px);
    opacity: 0;
  }
  to {
    transform: translateX(0);
    opacity: 1;
  }
}

'@

# Insert toast animation CSS
$content = $content -replace '(\/\* ================ FAQ SECTION ================ \*\/)', ($toastAnimation + "`n" + '$1')

# Add use strict to main script
$content = $content -replace "(\(function\(\) \{)", ('$1' + "`n      'use strict';`n")

# Save file
Set-Content $file -Value $content -Encoding UTF8 -NoNewline

Write-Host "Production issues fixed successfully!"
Write-Host "- Removed/commented console.log statements"
Write-Host "- Replaced alert() with toast notifications"
Write-Host "- Added 'use strict' mode"
Write-Host "- Added toast animation CSS"
