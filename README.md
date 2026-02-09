# Puurfit (hybride leerproject)

Doel: een **super snelle Vite build** (SEO/Lighthouse, caching) die later eenvoudig als **WordPress theme + WooCommerce** kan worden ingezet.

Project-structuur (hybride):
- `site/` → Vite + Tailwind + Alpine (snelle frontend / static build)
- `wp-theme/` → WordPress theme skeleton (later: Vite `dist/` enqueuen via manifest)
- `docs/` → documentatie, checklists

---

## 1) Node + deps installeren (latest)

Werk altijd in de `site/` map.

### Lokaal (WSL)
```bash
cd site
npm init -y
npm install alpinejs
npm install -D vite tailwindcss postcss autoprefixer
```

### Via DDEV (generic project)
```bash
# install (als node_modules nog niet bestaat)
ddev exec bash -lc 'cd site && npm install'

# of: direct de deps installeren (latest)
ddev exec bash -lc 'cd site && npm init -y'
ddev exec bash -lc 'cd site && npm install alpinejs'
ddev exec bash -lc 'cd site && npm install -D vite tailwindcss postcss autoprefixer'
```

Check versions:
```bash
ddev exec node -v
ddev exec npm -v
```

---

## 2) Vite build workflow (documentatie focus)

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

## 3) Test: build draaien met index pagina

Assumptie: je hebt minimaal `site/index.html` en Vite scripts/config staan.

Run:
```bash
cd site
npm run build
```

Verwacht:
- output in `site/dist/`
- logs met bundling info

Test lokaal:
```bash
npm run preview
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
