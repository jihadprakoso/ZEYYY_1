$file = "D:\Data User\Documents\GitHub\deartbox-Packaging\lightmode\notion-feel-v2-cleaned.html"
$content = Get-Content $file -Raw -Encoding UTF8

# Replace video element with image placeholder (using existing flow.webp)
$oldVideo = @'
      <div class="video-wrapper">
        <video controls poster="assets/images/video-thumbnail.jpg" preload="metadata">
          <source src="assets/video/company-video.mp4" type="video/mp4">
          Your browser does not support the video tag.
        </video>
      </div>
'@

$newVideo = @'
      <div class="video-wrapper">
        <!-- TODO: Replace with actual video file -->
        <img src="assets/images/flow.webp" alt="deartbox Production Process" loading="lazy" width="1000" height="562">
        <p style="text-align: center; margin-top: 16px; color: #767676; font-size: 14px;">
          📹 Video produksi akan segera ditambahkan
        </p>
      </div>
'@

$content = $content -replace [regex]::Escape($oldVideo), $newVideo

# Save file
Set-Content $file -Value $content -Encoding UTF8 -NoNewline

Write-Host "Video section replaced with image placeholder successfully!"
