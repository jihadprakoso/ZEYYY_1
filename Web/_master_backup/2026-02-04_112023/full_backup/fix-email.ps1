$file = "D:\Data User\Documents\GitHub\deartbox-Packaging\lightmode\notion-feel-v2-cleaned.html"
$content = Get-Content $file -Raw -Encoding UTF8

# Remove Cloudflare email decode script
$content = $content -replace '<script data-cfasync="false" src="/cdn-cgi/scripts/5c5dd728/cloudflare-static/email-decode\.min\.js"></script>', ''

# Replace obfuscated email with plain email
$content = $content -replace '<a href="/cdn-cgi/l/email-protection#[^"]+"><span class="__cf_email__" data-cfemail="[^"]+">\[email&#160;protected\]</span></a>', '<a href="mailto:info@deartbox.com">info@deartbox.com</a>'

# Save file
Set-Content $file -Value $content -Encoding UTF8 -NoNewline

Write-Host "Email protection fixed successfully!"
