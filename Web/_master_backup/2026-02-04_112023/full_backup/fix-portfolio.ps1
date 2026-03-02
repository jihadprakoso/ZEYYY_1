$file = "D:\Data User\Documents\GitHub\deartbox-Packaging\lightmode\notion-feel-v2-cleaned.html"
$content = Get-Content $file -Raw -Encoding UTF8

# Replace portfolio image references to match actual files
$content = $content -replace 'portfolio/box-1\.webp', 'portfolio/Project_1.webp'
$content = $content -replace 'portfolio/box-2\.webp', 'portfolio/Project_2.webp'
$content = $content -replace 'portfolio/box-3\.webp', 'portfolio/Project_3.webp'
$content = $content -replace 'portfolio/box-4\.webp', 'portfolio/Project_4.webp'
$content = $content -replace 'portfolio/box-5\.webp', 'portfolio/Project_5.webp'
$content = $content -replace 'portfolio/box-6\.webp', 'portfolio/Project_6.webp'

# Save file
Set-Content $file -Value $content -Encoding UTF8 -NoNewline

Write-Host "Portfolio image references fixed successfully!"
