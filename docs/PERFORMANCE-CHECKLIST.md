# Performance Checklist (Puurfit)

## Build
- [ ] `dist/assets` klein: check `ls -lah dist/assets | sort -h`
- [ ] Geen sourcemaps in prod build
- [ ] Alleen 1 CSS entry: `src/css/tailwind.css`

## HTML/CSS
- [ ] Geen externe fonts (of self-host WOFF2 + swap)
- [ ] Images: AVIF/WebP + width/height + lazy onder de fold
- [ ] Geen zware embeds boven de fold

## JS
- [ ] Alpine/HTMX only where needed
- [ ] Geen third-party scripts op home (later pas)

## Caching (prod)
- [ ] `assets/*` immutable, 1 jaar
- [ ] HTML revalidate
