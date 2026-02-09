# Repository Guidelines

## Project Structure

- `site/`: Static frontend built with Vite + Tailwind CSS + Alpine (and HTMX imported in `site/src/js/main.js`). Source lives in `site/src/`; build output is `site/dist/`.
- `wp-theme/`: Minimal WordPress theme skeleton (PHP templates/components under `wp-theme/puurfit/`). Intended future state: enqueue Vite-built assets via a manifest and place artifacts under `wp-theme/puurfit/dist/`.
- `assets/`: Repo-level assets (non-build artifacts).
- `docs/`: Project checklists and notes (see `docs/SEO-CHECKLIST.md`, `docs/PERFORMANCE-CHECKLIST.md`).

## Build, Test, and Development Commands

Run commands from `site/` unless you are working on the WP theme:

```bash
cd site
npm run dev      # Vite dev server
npm run build    # Production build to site/dist/
npm run preview  # Serve the production build locally
```

If using DDEV:

```bash
ddev exec bash -lc 'cd site && npm install'
ddev exec bash -lc 'cd site && npm run build'
```

## Coding Style & Naming Conventions

- Indentation: 2 spaces (see `.editorconfig`).
- HTML: one `<h1>` per page; keep heading hierarchy logical (`h2`/`h3`).
- URLs: keep internal links consistent with the deployed routing (avoid dev-only paths like `/src/...`).
- WP theme: use small, composable templates and the `component('name', $props, $slot)` helper (see `wp-theme/puurfit/inc/components.php`).

## Testing Guidelines

No automated test framework is configured yet. Minimum bar before PR:

- `npm run build` succeeds in `site/`.
- Smoke test with `npm run preview` and click through key pages/links.

## Commit & Pull Request Guidelines

Existing history uses short, lowercase, summary-style subjects (examples: `cleanup`, `basic setup ...`). Follow that pattern:

- One-line subject, present tense, no ticket required.
- Keep commits focused (frontend vs theme changes separated when practical).

PRs should include:

- What changed and why (SEO/perf impact if relevant).
- Screenshots for visual changes (mobile + desktop).
- Notes on deployment implications (e.g., changes in `site/dist/` or theme asset enqueues).

## SEO/Performance Notes

Use `docs/SEO-CHECKLIST.md` and `docs/PERFORMANCE-CHECKLIST.md` as the acceptance criteria for changes targeting Google Lighthouse and indexing.
