$file = "D:\Data User\Documents\GitHub\deartbox-Packaging\lightmode\notion-feel-v2-cleaned.html"
$content = Get-Content $file -Raw -Encoding UTF8

# Find and comment out video section
$videoSectionStart = '<!-- ================ VIDEO SECTION - AIDA: INTEREST ================ -->'
$videoSectionEnd = '</section>'

# Use regex to find the video section and comment it out
$pattern = '(<!-- ================ VIDEO SECTION - AIDA: INTEREST ================ -->.*?</section>)'
$replacement = '<!-- VIDEO SECTION COMMENTED OUT - ADD VIDEO FILE TO ENABLE
$1
-->'

$content = $content -replace $pattern, $replacement

# Save file
Set-Content $file -Value $content -Encoding UTF8 -NoNewline

Write-Host "Video section commented out successfully!"
