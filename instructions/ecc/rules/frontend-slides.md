# Frontend Slides — Rules

## Non-Negotiables
1. Zero dependencies: one self-contained HTML file, inline CSS/JS.
2. Viewport fit is a HARD GATE: every slide must fit one viewport, no internal scrolling.
3. Show, don't tell: visual previews, not abstract style questionnaires.
4. Distinctive design: no generic purple-gradient, Inter-on-white, template-looking decks.
5. Production quality: commented, accessible, responsive, performant.

## Workflow
- Detect mode: new deck / PPT conversion / enhancement.
- Discover minimum content: purpose, length, content state. Ask user to paste content before styling.
- Style discovery: default to visual exploration — 3 single-slide preview files in `.ecc-design/slide-previews/` (~100 lines each), ask user which to keep or mix.
- Build `presentation.html` (or `[name].html`). Required: semantic slide sections, viewport-safe CSS base, CSS custom properties for theme, controller class for keyboard/wheel/touch nav, Intersection Observer reveals, reduced-motion support.

## Viewport Fit Rules
- Every `.slide`: `height: 100vh; height: 100dvh; overflow: hidden;`.
- Type/spacing scale with `clamp()`.
- Overflow → split into more slides. Never shrink text below readable size. Never allow slide scrollbars.

## Validate
- Check at 1920x1080, 1280x720, 768x1024, 375x667, 667x375. Use browser automation if available to verify no overflow + keyboard nav.

## Deliver
- Delete temp previews unless user wants them. Open with platform opener (macOS `open`, Linux `xdg-open`, Windows `start ""`). Summarize path, preset, slide count, theme customization points.

## PPT Conversion
- Prefer `python3` + `python-pptx` to extract text/images/notes. Cross-platform only — no macOS-only tools when Python works.

## Content Density Limits
- Title: 1 heading + 1 subtitle + optional tagline. Content: 1 heading + 4-6 bullets or 2 short paragraphs. Feature grid: 6 cards max. Code: 8-10 lines max. Quote: 1 quote + attribution.

## Anti-Patterns
- Generic gradients, system-font decks, long bullet walls, scrolling code blocks, fixed-height boxes that break on short screens, invalid negated CSS like `-clamp(...)`.

## JS Requirements
- Keyboard + touch/swipe + wheel navigation, progress indicator or slide index, reveal-on-enter triggers.

## Accessibility
- Semantic structure (`main`, `section`, `nav`), readable contrast, keyboard-only support, respect `prefers-reduced-motion`.