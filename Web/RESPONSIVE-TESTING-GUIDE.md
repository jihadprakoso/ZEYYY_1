# 📱 RESPONSIVE TESTING GUIDE - deartbox Packaging

**Tanggal:** 2 Februari 2026  
**Status:** Ready for comprehensive testing

---

## 🎯 **Testing Objectives:**

1. ✅ Verify layout tidak break di berbagai screen sizes
2. ✅ Ensure text readable di semua devices
3. ✅ Check touch targets minimum 48px (mobile)
4. ✅ Verify images load properly dan proportional
5. ✅ Test dark mode consistency
6. ✅ Check horizontal scroll (should be none)
7. ✅ Verify all interactions work (slideshow, FAQ, form, menu)

---

## 📐 **Screen Sizes to Test:**

### **🔴 CRITICAL - Mobile Devices:**

#### **Small Mobile (320px - 375px):**
- iPhone SE (375×667)
- iPhone 12 Mini (375×812)
- Samsung Galaxy S8 (360×740)
- **Smallest supported:** 320px

**What to Check:**
- [ ] Logo tidak terpotong
- [ ] Theme-toggle & mobile-toggle tidak overlap
- [ ] Hero title readable (28px)
- [ ] Buttons full-width dan tappable
- [ ] Form inputs tidak cramped
- [ ] Marketplace cards (3 columns) fit
- [ ] No horizontal scroll

---

#### **Medium Mobile (375px - 414px):**
- iPhone 13/14/15 (390×844)
- iPhone 13 Pro Max (428×926)
- Samsung Galaxy S20/S21 (360×800)
- Google Pixel 5 (393×851)

**What to Check:**
- [ ] All sections proportional
- [ ] Portfolio grid (1 column) looks good
- [ ] Testimonials (1 column) readable
- [ ] Process steps (1 column) clear
- [ ] Sticky CTA tidak block content
- [ ] Footer payment logos (3 columns) fit

---

### **🟡 IMPORTANT - Tablet Devices:**

#### **Small Tablet (768px - 834px):**
- iPad Mini (768×1024)
- iPad (810×1080)
- Samsung Galaxy Tab (800×1280)

**What to Check:**
- [ ] Desktop nav appears (768px+)
- [ ] Mobile toggle hidden
- [ ] Portfolio grid (2 columns) balanced
- [ ] Features grid (2-3 columns) proportional
- [ ] Process steps (2 columns) fit
- [ ] Form layout (2 columns) usable

---

#### **Large Tablet (834px - 1024px):**
- iPad Air (820×1180)
- iPad Pro 11" (834×1194)
- iPad Pro 12.9" (1024×1366)

**What to Check:**
- [ ] Desktop navigation fully visible
- [ ] Portfolio grid (2 columns) spacious
- [ ] All grids utilize space well
- [ ] No awkward gaps
- [ ] Typography scales smoothly

---

### **🟢 VERIFY - Desktop Devices:**

#### **Small Desktop (1024px - 1280px):**
- MacBook Air (1280×800)
- Standard laptop (1366×768)

**What to Check:**
- [ ] Max-width containers (1280px) work
- [ ] Portfolio grid (2 columns) optimal
- [ ] Hero slideshow (900px max) centered
- [ ] All sections balanced

---

#### **Medium Desktop (1280px - 1920px):**
- MacBook Pro 13" (1440×900)
- Standard monitor (1920×1080)

**What to Check:**
- [ ] Container padding (80px max) appropriate
- [ ] White space balanced
- [ ] Images not pixelated
- [ ] Typography hierarchy clear

---

#### **Large Desktop (1920px+):**
- 4K monitors (2560×1440, 3840×2160)
- Ultra-wide (3440×1440)

**What to Check:**
- [ ] Max-width containers prevent over-stretching
- [ ] Content centered properly
- [ ] No excessive white space
- [ ] Images maintain quality

---

## 🧪 **Testing Methods:**

### **Method 1: Chrome DevTools (Recommended)**

1. **Open DevTools:** `F12` atau `Ctrl+Shift+I`
2. **Toggle Device Toolbar:** `Ctrl+Shift+M`
3. **Select Device Presets:**
   - iPhone SE
   - iPhone 12 Pro
   - iPhone 14 Pro Max
   - Pixel 5
   - Samsung Galaxy S20 Ultra
   - iPad Air
   - iPad Pro
   - Nest Hub
   - Nest Hub Max

4. **Custom Dimensions:**
   - 320px (smallest)
   - 375px (iPhone)
   - 390px (iPhone 14)
   - 414px (iPhone Plus)
   - 768px (iPad)
   - 1024px (iPad Pro)
   - 1280px (laptop)
   - 1920px (desktop)

5. **Test Both Orientations:**
   - Portrait (vertical)
   - Landscape (horizontal)

---

### **Method 2: Responsive Design Mode (Firefox)**

1. **Open Responsive Design Mode:** `Ctrl+Shift+M`
2. **Test Presets:**
   - Galaxy S9/S9+ (320px, 360px)
   - iPhone 6/7/8 (375px)
   - iPhone X/XS (375px)
   - iPad (768px)
   - iPad Pro (1024px)

---

### **Method 3: Real Device Testing**

**If Available:**
- [ ] Test on actual iPhone
- [ ] Test on actual Android phone
- [ ] Test on actual iPad/tablet
- [ ] Test on actual laptop
- [ ] Test on actual desktop monitor

---

## 📋 **Section-by-Section Checklist:**

### **1. Header/Navigation:**
- [ ] Logo visible dan tidak terpotong
- [ ] Theme-toggle functional (light/dark switch)
- [ ] Mobile-toggle opens menu smoothly
- [ ] Desktop nav appears at 768px+
- [ ] Sticky header works on scroll
- [ ] No overlap between elements

---

### **2. Hero Section:**
- [ ] Title readable (32-56px desktop, 28px mobile)
- [ ] Subtitle clear (16-20px desktop, 15px mobile)
- [ ] Badge visible (13px desktop, 12px mobile)
- [ ] Slideshow images load properly
- [ ] Slideshow controls accessible
- [ ] CTA buttons full-width on mobile
- [ ] Microcopy readable (13px desktop, 12px mobile)

---

### **3. Trust Section (Logo Marquee):**
- [ ] Logos scroll smoothly
- [ ] No jank or stuttering
- [ ] Logos visible (28px desktop, 20px mobile)
- [ ] Dark mode: logos inverted (white)
- [ ] Pause on hover works
- [ ] Qualifier text centered

---

### **4. Video Section:**
- [ ] Video player responsive
- [ ] Controls accessible
- [ ] Poster image loads
- [ ] Video lazy loads (preload="none")
- [ ] Border-radius appropriate (16px desktop, 12px mobile)

---

### **5. Features Section:**
- [ ] Grid: 3 columns desktop, 1 column mobile
- [ ] Images: 240px height visible
- [ ] Cards not cramped
- [ ] Hover effects work (desktop)
- [ ] Text hierarchy clear
- [ ] No overflow

---

### **6. Portfolio Section:**
- [ ] Grid: 2 columns desktop, 1 column mobile
- [ ] Images prominent (larger than before)
- [ ] Overlay appears on hover (desktop)
- [ ] Aspect ratio maintained (4:3)
- [ ] No image distortion
- [ ] 4 items display properly

---

### **7. Process Section:**
- [ ] Grid: 4 columns desktop, 1 column mobile
- [ ] Step numbers visible (48px circles)
- [ ] Images: 200px height clear
- [ ] Cards balanced
- [ ] Text readable
- [ ] No overlap

---

### **8. Testimonials Section:**
- [ ] Grid: 3 columns desktop, 1 column mobile
- [ ] Initial avatars (SC, BS, DP) display
- [ ] Gradient background on avatars
- [ ] Quotes readable (italic)
- [ ] Rating stars visible
- [ ] Qualifier text centered

---

### **9. RFQ Form Section:**
- [ ] Layout: 2 columns desktop, 1 column mobile
- [ ] Form inputs: 48px min-height (mobile)
- [ ] Labels clear (14px)
- [ ] Sidebar simplified (only contact quick)
- [ ] Submit button prominent
- [ ] File upload works
- [ ] Validation messages visible

---

### **10. Marketplace Section:**
- [ ] Background red (#d71921) both modes
- [ ] Title white and readable (24-32px)
- [ ] Subtitle white (15-17px)
- [ ] Grid: 3 columns mobile, auto-fit desktop
- [ ] Logos: 28px desktop, 50px mobile
- [ ] No arrows (removed)
- [ ] Hover: grey → color works
- [ ] TikTok: grey → black works

---

### **11. FAQ Section:**
- [ ] Accordion opens/closes smoothly
- [ ] Questions readable (16px)
- [ ] Answers clear (15px)
- [ ] Icons rotate on expand
- [ ] No layout shift
- [ ] Touch targets adequate

---

### **12. CTA Section:**
- [ ] Background red gradient both modes
- [ ] Title white (28-40px)
- [ ] Subtitle white (14-16px)
- [ ] Features list readable (13px desktop, 12px mobile)
- [ ] WhatsApp button: green with white text
- [ ] Button full-width on mobile
- [ ] Hover: green dark (#128C7E)

---

### **13. Footer:**
- [ ] Grid: 5 columns desktop, 1 column mobile
- [ ] Logo visible
- [ ] Links clickable
- [ ] Social icons work
- [ ] Payment logos: 6 columns desktop, 3 columns mobile
- [ ] Address link works (Google Maps)
- [ ] Dark mode: #0a0a0a background

---

### **14. Sticky Elements:**
- [ ] Sticky CTA (WhatsApp): bottom-right, green
- [ ] Back to top: appears on scroll
- [ ] Sticky header: works on scroll
- [ ] No z-index conflicts
- [ ] Touch targets adequate (44-48px)

---

## 🔍 **Common Issues to Look For:**

### **Layout Issues:**
- [ ] Horizontal scroll (should be NONE)
- [ ] Text overflow
- [ ] Image distortion
- [ ] Grid breaking
- [ ] Overlapping elements
- [ ] Awkward gaps

### **Typography Issues:**
- [ ] Text too small to read
- [ ] Text too large (overwhelming)
- [ ] Line-height causing overlap
- [ ] Letter-spacing issues
- [ ] Font not loading

### **Interactive Issues:**
- [ ] Buttons too small to tap
- [ ] Links not clickable
- [ ] Hover states not working
- [ ] Animations janky
- [ ] Form inputs not focusable

### **Performance Issues:**
- [ ] Images loading slow
- [ ] Layout shift (CLS)
- [ ] Scroll jank
- [ ] Animation lag
- [ ] Memory leaks

---

## 🧪 **How to Test (Step-by-Step):**

### **Step 1: Open Website**
```
File: D:\Data User\Documents\GitHub\deartbox-Packaging\lightmode\index.html
```
Open di browser (Chrome recommended)

---

### **Step 2: Test Mobile Sizes**

**iPhone SE (375px):**
1. Open DevTools (`F12`)
2. Toggle Device Toolbar (`Ctrl+Shift+M`)
3. Select "iPhone SE"
4. Scroll through entire page
5. Test interactions:
   - [ ] Click mobile menu toggle
   - [ ] Toggle dark mode
   - [ ] Click slideshow arrows
   - [ ] Expand FAQ items
   - [ ] Click all CTA buttons
   - [ ] Test form inputs
6. Take screenshots of issues

**Repeat for:**
- iPhone 12 Pro (390px)
- iPhone 14 Pro Max (430px)
- Pixel 5 (393px)
- Samsung Galaxy S20 (360px)

---

### **Step 3: Test Tablet Sizes**

**iPad (768px):**
1. Select "iPad" in DevTools
2. Verify desktop nav appears
3. Check grid layouts (2-3 columns)
4. Test all interactions
5. Check both portrait & landscape

**Repeat for:**
- iPad Air (820px)
- iPad Pro (1024px)

---

### **Step 4: Test Desktop Sizes**

**Laptop (1280px):**
1. Set custom dimensions: 1280×720
2. Verify max-width containers (1280px)
3. Check padding (80px max)
4. Test hover effects
5. Verify all sections centered

**Repeat for:**
- 1440×900 (MacBook Pro)
- 1920×1080 (Full HD)
- 2560×1440 (2K)

---

### **Step 5: Test Dark Mode**

For EACH screen size above:
1. Toggle dark mode
2. Verify colors:
   - [ ] Background: #1a1a1a, #0f0f0f (alternating)
   - [ ] Cards: #2a2a2a
   - [ ] Text: #ffffff (white)
   - [ ] Borders: #3a3a3a
3. Check readability
4. Verify logo inversion (client logos white)
5. Test CTA section (red background, white text)

---

### **Step 6: Test Interactions**

**On Mobile (375px):**
- [ ] Mobile menu opens/closes
- [ ] Dark mode toggle works
- [ ] Hero slideshow auto-plays
- [ ] Slideshow manual controls work
- [ ] FAQ accordion expands/collapses
- [ ] Form validation works
- [ ] File upload works
- [ ] Sticky CTA clickable
- [ ] Back to top works
- [ ] All links open correctly

**On Desktop (1920px):**
- [ ] Desktop nav links work
- [ ] Hover effects smooth
- [ ] All above interactions work

---

## 📊 **Breakpoint Analysis:**

### **Current Breakpoints:**

```css
/* Mobile First (Default) */
0px - 767px: Mobile optimizations active

/* Desktop */
768px+: Desktop nav, hide mobile toggle

/* No tablet-specific breakpoint */
```

### **Potential Issues:**

⚠️ **Gap at 768px - 1023px:**
- Tablet range tidak ada specific optimization
- Might look awkward (desktop nav but mobile-ish layout)

**Recommendation:** Add tablet breakpoint

```css
@media (min-width: 768px) and (max-width: 1023px) {
  /* Tablet-specific styles */
}
```

---

## 🔧 **Quick Fix Checklist:**

### **If Layout Breaks:**

**Horizontal Scroll Appears:**
```css
/* Add to body or problematic section */
overflow-x: hidden;
max-width: 100vw;
```

**Images Overflow:**
```css
img {
  max-width: 100%;
  height: auto;
}
```

**Text Overflow:**
```css
.element {
  word-wrap: break-word;
  overflow-wrap: break-word;
}
```

**Grid Breaks:**
```css
.grid {
  grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
}
```

---

## 📱 **Mobile-Specific Tests:**

### **Touch Interactions:**
- [ ] Tap hero CTA buttons (should be easy)
- [ ] Tap mobile menu (48px target)
- [ ] Tap theme toggle (48px target)
- [ ] Tap slideshow controls (40px - acceptable)
- [ ] Tap FAQ questions (48px target)
- [ ] Tap form inputs (48px target)
- [ ] Tap submit button (52px target)
- [ ] Tap sticky CTA (44px - acceptable)
- [ ] Tap marketplace cards (entire card clickable)

### **Scroll Behavior:**
- [ ] Smooth scroll to anchors (#features, #showcase, etc)
- [ ] No scroll jank
- [ ] Sticky header stays on top
- [ ] Sticky CTA doesn't interfere
- [ ] Back to top appears after scroll

### **Performance:**
- [ ] Images lazy load (check Network tab)
- [ ] Video doesn't auto-load
- [ ] Animations smooth (60fps)
- [ ] No layout shift (CLS)
- [ ] Fast interaction (FID)

---

## 🌓 **Dark Mode Tests:**

### **Color Contrast (WCAG AA):**
- [ ] White text on dark bg: 15:1+ ratio ✅
- [ ] White text on red bg: 4.5:1+ ratio ✅
- [ ] Grey text readable: 4.5:1+ ratio
- [ ] Links distinguishable
- [ ] Buttons have sufficient contrast

### **Visual Consistency:**
- [ ] All sections use correct dark colors
- [ ] Cards: #2a2a2a (consistent)
- [ ] Borders: #3a3a3a (visible but subtle)
- [ ] Client logos inverted (white)
- [ ] No color bleeding
- [ ] Smooth transitions

---

## 📸 **Screenshot Checklist:**

Take screenshots at these sizes for documentation:

**Mobile:**
- [ ] 375px - iPhone (portrait)
- [ ] 390px - iPhone 14 (portrait)
- [ ] 768px - iPad (portrait)
- [ ] 768px - iPad (landscape)

**Desktop:**
- [ ] 1280px - Laptop
- [ ] 1920px - Full HD

**Both Modes:**
- [ ] Light mode screenshots
- [ ] Dark mode screenshots

---

## 🐛 **Known Issues to Verify Fixed:**

### **Previously Fixed:**
- ✅ Theme-toggle collision (added spacing)
- ✅ Marketplace text not readable (white color)
- ✅ CTA subtitle dark mode (white color)
- ✅ Logo client dark mode (inverted)
- ✅ Sticky CTA shadow (green not red)
- ✅ Portfolio hover (no red glow)

### **Potential New Issues:**
- ⚠️ Tablet range (768-1023px) - no specific optimization
- ⚠️ Very small screens (320px) - might be tight
- ⚠️ Ultra-wide (3440px+) - might have excessive whitespace

---

## ✅ **Testing Workflow:**

### **Quick Test (15 minutes):**
1. Test 3 sizes: 375px, 768px, 1920px
2. Toggle dark mode on each
3. Scroll through all sections
4. Click main CTAs
5. Check for obvious breaks

### **Thorough Test (45 minutes):**
1. Test all 8+ screen sizes
2. Test both orientations
3. Test all interactions
4. Test dark mode on all sizes
5. Take screenshots
6. Document issues
7. Verify fixes

### **Complete Test (2 hours):**
1. All above +
2. Test on real devices
3. Test different browsers (Chrome, Firefox, Safari, Edge)
4. Test slow 3G network
5. Test with ad blockers
6. Test accessibility (screen reader)
7. Performance profiling

---

## 🎯 **Success Criteria:**

Website passes if:
- ✅ No horizontal scroll on any size
- ✅ All text readable (minimum 12px)
- ✅ All touch targets 44px+ (mobile)
- ✅ All interactions work
- ✅ Dark mode consistent
- ✅ Images load and display properly
- ✅ No layout breaks
- ✅ Performance 90+ on mobile
- ✅ Lighthouse scores maintained

---

## 📝 **Issue Reporting Template:**

```markdown
**Screen Size:** 375px (iPhone SE)
**Mode:** Dark mode
**Section:** Hero
**Issue:** Title text overlaps with image
**Screenshot:** [attach]
**Priority:** High/Medium/Low
**Suggested Fix:** Reduce title font-size to 26px on small screens
```

---

## 🚀 **Next Steps:**

1. **Test manually** using Chrome DevTools
2. **Document issues** using template above
3. **Share findings** with me
4. **I'll fix** any issues found
5. **Re-test** after fixes
6. **Deploy** when all green ✅

---

**Start testing now!** Open `index.html` in Chrome, press `F12`, then `Ctrl+Shift+M` to start! 📱✨

**Report back dengan:**
- ✅ "All good, no issues" → Deploy
- ⚠️ "Found issues: [list]" → I'll fix
- 🐛 "Screenshot attached" → I'll analyze

Good luck! 🍀
