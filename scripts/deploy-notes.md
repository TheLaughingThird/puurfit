# Deploy notes (Puurfit)

## Build
- `cd site && npm run build`
- Output: `site/dist`

## Cache headers (prod)
- `dist/assets/*`: Cache-Control: public, max-age=31536000, immutable
- `*.html`: Cache-Control: max-age=0, must-revalidate

## Later WP
- Vite manifest-based enqueue vanuit `wp-theme/puurfit/dist/`
