# Marquee Drag/Swipe Reimplementation

## Tasks

- [x] Add drag cursor CSS styles (inline `<style>` in `<head>` of `index.html`)
- [x] Add drag/swipe JavaScript (inline `<script>` before `</body>` in `index.html`)
  - [x] Mouse drag: mousedown / mousemove / mouseup
  - [x] Touch swipe: touchstart / touchmove / touchend
  - [x] Pause CSS animation on drag start (capture current translateX)
  - [x] Update inline transform on drag move (with loop wrapping)
  - [x] Apply momentum/inertia on drag end
  - [x] Resume CSS animation from correct position via animation-delay trick

---

## Bug Fix: Seamless Infinite Loop (Trust Logo Marquee)

- [x] **Root cause identified:** `init()` set `currentOffsets[i] = 0` for ALL tracks.
  - Reverse track (`reverse: true`) adds a **positive delta** each frame.
  - On frame 1: `wrap(0 + tiny, lw)` → `tiny > 0` → `tiny - lw ≈ -lw` — instant ~5000px jump.
  - Visually: marquee appeared to "reset to logo pertama" on every loop.
- [x] **Fix applied** in `index.html` `init()` function:
  - Forward tracks: `currentOffsets[i] = 0` (unchanged — scroll left toward -lw, wrap to 0)
  - Reverse tracks: `currentOffsets[i] = -(loopWidths[i] || 0)` (start at -lw, scroll right toward 0, wrap to -lw)
  - Both tracks now loop seamlessly with no visible reset.

---

## Feature: Random Logo Shuffle on Page Load

- [x] Added `shuffleArray(arr)` — Fisher-Yates in-place shuffle
- [x] Added `shuffleTrack(track)` — takes first 42 originals, shuffles, clears DOM, re-appends shuffled + cloned shuffled (seamless duplicate preserved)
- [x] `init()` calls `shuffleTrack` for each track **independently** before `cacheLoopWidths()`
  - Track 1 and Track 2 get different random orders every page load
  - All 42 logos visible in both tracks, in random order
  - `cacheLoopWidths()` runs after shuffle → correct width measurement
  - Reverse-track `-lw` offset init still applies correctly after shuffle
