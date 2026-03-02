$file = "D:\Data User\Documents\GitHub\deartbox-Packaging\lightmode\notion-feel-v2-cleaned.html"
$content = Get-Content $file -Raw -Encoding UTF8

# Comment out payment methods section (temporarily until images are added)
$paymentSection = @'
<!-- ================= PAYMENT METHODS ================= -->
<div class="footer-payments">
  <p class="footer-payments-title">Metode Pembayaran</p>
  <div class="footer-payments-logos">
    <img src="assets/images/payments/bca.png" alt="BCA">
    <img src="assets/images/payments/mandiri.png" alt="Mandiri">
    <img src="assets/images/payments/bni.png" alt="BNI">
    <img src="assets/images/payments/bri.png" alt="BRI">
    <img src="assets/images/payments/visa.png" alt="Visa">
    <img src="assets/images/payments/mastercard.png" alt="Mastercard">
  </div>
</div>
'@

$paymentSectionCommented = @'
<!-- ================= PAYMENT METHODS (COMMENTED OUT - ADD IMAGES TO ENABLE) ================= -->
<!-- 
<div class="footer-payments">
  <p class="footer-payments-title">Metode Pembayaran</p>
  <div class="footer-payments-logos">
    <img src="assets/images/payments/bca.png" alt="BCA">
    <img src="assets/images/payments/mandiri.png" alt="Mandiri">
    <img src="assets/images/payments/bni.png" alt="BNI">
    <img src="assets/images/payments/bri.png" alt="BRI">
    <img src="assets/images/payments/visa.png" alt="Visa">
    <img src="assets/images/payments/mastercard.png" alt="Mastercard">
  </div>
</div>
-->
'@

$content = $content -replace [regex]::Escape($paymentSection), $paymentSectionCommented

# Save file
Set-Content $file -Value $content -Encoding UTF8 -NoNewline

Write-Host "Payment section commented out successfully!"
