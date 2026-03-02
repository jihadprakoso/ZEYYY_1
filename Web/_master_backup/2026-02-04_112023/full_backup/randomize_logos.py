import random

# All 36 logos
all_logos = list(range(1, 37))

# Shuffle and split into 2 rows
random.shuffle(all_logos)
row1_logos = all_logos[:18]
row2_logos = all_logos[18:]

# Create different random order for duplicates
row1_dup = row1_logos.copy()
random.shuffle(row1_dup)

row2_dup = row2_logos.copy()
random.shuffle(row2_dup)

print("=" * 60)
print("RANDOMIZED LOGO ORDER FOR MARQUEE")
print("=" * 60)

print("\n<!-- Row 1 -->")
print("<div class=\"marquee-track\">")
print("  <!-- ===== ROW 1 - LOGO SET 1 (Random 18 from 36) ===== -->")
for logo in row1_logos:
    print(f'  <img src="assets/clients/logo-{logo:02d}.svg" alt="Client Logo {logo}">')

print("  <!-- ===== ROW 1 - LOGO SET 2 (Different Random Order) ===== -->")
for logo in row1_dup:
    print(f'  <img src="assets/clients/logo-{logo:02d}.svg" alt="">')
print("</div>")

print("\n<!-- Row 2 -->")
print("<div class=\"marquee-track\">")
print("  <!-- ===== ROW 2 - LOGO SET 1 (Remaining 18) ===== -->")
for logo in row2_logos:
    print(f'  <img src="assets/clients/logo-{logo:02d}.svg" alt="Client Logo {logo}">')

print("  <!-- ===== ROW 2 - LOGO SET 2 (Different Random Order) ===== -->")
for logo in row2_dup:
    print(f'  <img src="assets/clients/logo-{logo:02d}.svg" alt="">')
print("</div>")

print("\n" + "=" * 60)
print("Copy the HTML above and replace the trust-marquee content!")
print("=" * 60)
