# Puurfit (hybride leerproject)

Doel: een **super snelle Vite build** (SEO/Lighthouse, caching) die later eenvoudig als **WordPress theme + WooCommerce** kan worden ingezet.

Basis opzet compleet. Wil meteen clean houden en performance en mobile first te werk gaan.
Code kwaliteit is belangrijkste wat er is, houd je aan coding best practices and coding standards.
Gemaakt om later eventueel naar WordPress te verplaatsen met Woocommerce als dat nodig is.


Project-structuur (hybride):
- `site/` → Vite + Tailwind + Alpine (snelle frontend / static build)
- `wp-theme/` → WordPress theme skeleton (later: Vite `dist/` enqueuen via manifest)
- `docs/` → documentatie, checklists
- `AGENTS.md` → contributor guide (commands, style, PR expectations)

---

## 1) Node + deps installeren

Werk altijd in de `site/` map.

### Lokaal (WSL)
```bash
cd site
npm install
```

### Via DDEV (generic project)
```bash
# install (als node_modules nog niet bestaat)
ddev exec bash -lc 'cd site && npm install'
```

Check versions:
```bash
ddev exec node -v
ddev exec npm -v
```

---

## 2) Vite build workflow

Vite commands:
```bash
cd site
npm run dev      # dev server
npm run build    # productie build -> dist/
npm run preview  # serve dist/ lokaal (test)
```

### Belangrijk om te snappen
- `vite build` genereert geoptimaliseerde assets in `dist/` (hashing/caching-ready).
- `vite preview` is alleen om de build lokaal te testen (geen productie server).

### Relevante Vite docs (officieel)
- https://vite.dev/guide/build
- https://vite.dev/config/build-options
- https://vite.dev/guide/assets
- https://vite.dev/guide/static-deploy
- https://vite.dev/guide/cli
- https://vite.dev/guide/env-and-mode

---

## 3) E2E tests (Playwright)

We gebruiken Playwright voor snelle regressiechecks (SEO tags, basis structuur) tegen de **production build** (`vite preview`).

Eenmalig (download browsers):
```bash
cd site
npx playwright install --with-deps
```

Run E2E:
```bash
npm run test:e2e
```

---

## Studio (content)
Puurfit: Yoga • Pilates • Reformer • Fitness  
Solo of groepslessen met ervaren instructeur.

---

## Tech stack
- Vite
- Tailwind CSS
- Alpine.js
- Later: WordPress theme + (optioneel) WooCommerce
