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

## Wat zit er nu in (en waar)

Static pagina's (Vite multi-page build):
- Bron: `site/*.html` (o.a. `index.html`, `lessen.html`, `rooster.html`, `prijzen.html`, `over.html`, `contact.html`, `blog.html`, `privacy.html`, `voorwaarden.html`, `404.html`)
- Build output: `site/dist/` (alle bovenstaande pagina's + gehashte assets)

SEO/social:
- Canonical URLs staan hard-coded per pagina.
- Home heeft JSON-LD (SportsActivityLocation + FAQPage) en OG/Twitter meta.
- Overige pagina's hebben OG/Twitter meta toegevoegd voor consistente social previews.
- `site/public/robots.txt` en `site/public/sitemap.xml` worden gekopieerd naar `site/dist/`.

E2E:
- `site/tests/seo.spec.js` draait tegen de **production build** via `vite preview` (webServer in `site/playwright.config.js`).

---

## 1) Docker/DDEV (primary workflow)

We werken Docker-first: run Node/npm tooling **altijd** via `ddev exec ...` (dus niet lokaal op je host).

Start DDEV (in repo root):
```bash
ddev start
```

Node deps installeren (in container):
```bash
ddev exec bash -lc 'cd site && npm ci'
```

Check versions:
```bash
ddev exec bash -lc 'node -v'
ddev exec bash -lc 'npm -v'
```

---

## 2) Vite build workflow

Vite commands (in container):
```bash
ddev exec bash -lc 'cd site && npm run dev'      # dev server (Vite)
ddev exec bash -lc 'cd site && npm run build'    # productie build -> dist/
ddev exec bash -lc 'cd site && npm run preview'  # serve dist/ lokaal (test)
```

### Belangrijk om te snappen
- `vite build` genereert geoptimaliseerde assets in `dist/` (hashing/caching-ready).
- `vite preview` is alleen om de build lokaal te testen (geen productie server).
- De build is multi-page: alle `site/*.html` pagina's worden meegebouwd en komen als losse HTML files in `site/dist/`.

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
ddev exec bash -lc 'cd site && npx playwright install --with-deps'
```

Run E2E:
```bash
ddev exec bash -lc 'cd site && npm run test:e2e'
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

---

## Wat nog mist / aandachtspunten

- `site/public/sitemap.xml` is nu hard-coded; als routes veranderen of er pages bijkomen, moet dit mee aangepast worden.
- `privacy.html` en `voorwaarden.html` staan bewust op `noindex` tot de content echt klaar is.
- WP theme SEO in `wp-theme/puurfit/inc/seo.php` is nog minimaal (alleen front-page description). Als WP live gaat: titles/descriptions/OG per template goed zetten (of via SEO plugin).
