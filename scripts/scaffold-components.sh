#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

THEME_DIR="$ROOT/wp-theme/puurfit"
SITE_DIR="$ROOT/site"

# --- sanity
[ -d "$THEME_DIR" ] || { echo "Missing: $THEME_DIR"; exit 1; }
[ -d "$SITE_DIR" ]  || { echo "Missing: $SITE_DIR"; exit 1; }

echo "Scaffolding components in:"
echo "  THEME: $THEME_DIR"
echo "  SITE : $SITE_DIR"

# --- dirs
mkdir -p \
  "$THEME_DIR/template-parts/components" \
  "$THEME_DIR/template-parts/partials" \
  "$THEME_DIR/inc" \
  "$THEME_DIR/htmx" \
  "$SITE_DIR/src/css" \
  "$SITE_DIR/src/js"

# ============================================================
# THEME: helpers (component render)
# ============================================================
cat > "$THEME_DIR/inc/components.php" <<'PHP'
<?php
/**
 * Minimal component renderer (props + optional slot)
 * Usage:
 *   component('button', ['href'=>'/contact', 'label'=>'Proefles', 'variant'=>'primary']);
 *   component('card', ['title'=>'Yoga'], function(){ ?>slot html<?php });
 */

if (!function_exists('component')) {
  function component(string $name, array $props = [], $slot = null): void {
    $path = get_template_directory() . "/template-parts/components/{$name}.php";
    if (!file_exists($path)) {
      echo "<!-- missing component: {$name} -->";
      return;
    }

    // expose props as variables
    extract($props, EXTR_SKIP);

    // slot rendering
    $slotContent = '';
    if (is_callable($slot)) {
      ob_start();
      $slot();
      $slotContent = (string) ob_get_clean();
    } elseif (is_string($slot)) {
      $slotContent = $slot;
    }

    include $path;
  }
}
PHP

# ============================================================
# THEME: enqueue (Vite manifest-ready placeholder)
# - keeps it simple now; you can wire manifest later
# ============================================================
cat > "$THEME_DIR/inc/enqueue.php" <<'PHP'
<?php
/**
 * Enqueue styles/scripts.
 * For now: load built CSS/JS if present.
 * Later: swap to Vite manifest.json mapping.
 */
add_action('wp_enqueue_scripts', function () {
  $dist = get_template_directory_uri() . '/dist';
  $dist_path = get_template_directory() . '/dist';

  // Try common Vite output names (you will refine with manifest later)
  $css = $dist_path . '/assets/index.css';
  $js  = $dist_path . '/assets/index.js';

  if (file_exists($css)) {
    wp_enqueue_style('puurfit', $dist . '/assets/index.css', [], null);
  }
  if (file_exists($js)) {
    wp_enqueue_script('puurfit', $dist . '/assets/index.js', [], null, true);
  }
});
PHP

# ============================================================
# THEME: SEO minimal helper placeholder
# ============================================================
cat > "$THEME_DIR/inc/seo.php" <<'PHP'
<?php
// Minimal SEO hooks (expand later).
add_action('wp_head', function () {
  if (!is_front_page()) return;
  echo '<meta name="description" content="Puurfit studio: yoga, pilates, reformer, groepslessen en 1-op-1 training.">' . "\n";
}, 1);
PHP

# ============================================================
# THEME: main functions.php (include our inc files)
# ============================================================
cat > "$THEME_DIR/functions.php" <<'PHP'
<?php
require_once __DIR__ . '/inc/components.php';
require_once __DIR__ . '/inc/enqueue.php';
require_once __DIR__ . '/inc/seo.php';

// Theme basics
add_action('after_setup_theme', function () {
  add_theme_support('title-tag');
  add_theme_support('post-thumbnails');
});
PHP

# ============================================================
# THEME: base templates (clean, component-based)
# ============================================================
cat > "$THEME_DIR/header.php" <<'PHP'
<!doctype html>
<html <?php language_attributes(); ?>>
<head>
  <meta charset="<?php bloginfo('charset'); ?>">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <?php wp_head(); ?>
</head>
<body <?php body_class('min-h-screen bg-white text-slate-900'); ?>>
<?php wp_body_open(); ?>
<?php component('header'); ?>
<main>
PHP

cat > "$THEME_DIR/footer.php" <<'PHP'
</main>
<?php component('footer'); ?>
<?php wp_footer(); ?>
</body>
</html>
PHP

cat > "$THEME_DIR/index.php" <<'PHP'
<?php get_header(); ?>
<section class="container section">
  <h1 class="h2">Puurfit</h1>
  <p class="p-muted mt-2">Startpunt. Maak straks templates per pagina.</p>
</section>
<?php get_footer(); ?>
PHP

cat > "$THEME_DIR/page.php" <<'PHP'
<?php get_header(); ?>
<section class="container section">
  <?php while (have_posts()): the_post(); ?>
    <h1 class="h2"><?php the_title(); ?></h1>
    <div class="prose mt-6"><?php the_content(); ?></div>
  <?php endwhile; ?>
</section>
<?php get_footer(); ?>
PHP

cat > "$THEME_DIR/404.php" <<'PHP'
<?php get_header(); ?>
<section class="container section">
  <h1 class="h2">Pagina niet gevonden</h1>
  <p class="p-muted mt-2">Ga terug naar de homepage.</p>
  <div class="mt-6">
    <?php component('button', ['href'=>home_url('/'), 'label'=>'Naar home', 'variant'=>'primary']); ?>
  </div>
</section>
<?php get_footer(); ?>
PHP

# ============================================================
# THEME: components (props + short HTML)
# ============================================================

# --- button
cat > "$THEME_DIR/template-parts/components/button.php" <<'PHP'
<?php
$href = $href ?? '#';
$label = $label ?? 'Button';
$variant = $variant ?? 'primary'; // primary | ghost
$extraClass = $extraClass ?? '';
$attrs = $attrs ?? '';

$variantClass = $variant === 'ghost' ? 'btn-ghost' : 'btn-primary';
$cls = trim("btn {$variantClass} {$extraClass}");
?>
<a href="<?= esc_url($href) ?>" class="<?= esc_attr($cls) ?>" <?= $attrs ?>>
  <?= esc_html($label) ?>
</a>
PHP

# --- card (with slot)
cat > "$THEME_DIR/template-parts/components/card.php" <<'PHP'
<?php
$title = $title ?? '';
$extraClass = $extraClass ?? '';
?>
<article class="<?= esc_attr(trim("card {$extraClass}")) ?>">
  <?php if ($title): ?>
    <h3 class="h3"><?= esc_html($title) ?></h3>
  <?php endif; ?>
  <?php if (!empty($slotContent)): ?>
    <div class="mt-2"><?= $slotContent ?></div>
  <?php endif; ?>
</article>
PHP

# --- header component (Alpine-friendly hooks)
cat > "$THEME_DIR/template-parts/components/header.php" <<'PHP'
<header x-data="nav" class="sticky top-0 z-50 border-b border-slate-200 bg-white/80 backdrop-blur">
  <div class="container flex items-center justify-between py-3">
    <a href="<?= esc_url(home_url('/')); ?>" class="flex items-center gap-2 font-semibold tracking-tight">
      <span class="logo-badge">P</span>
      <span>Puurfit</span>
    </a>

    <nav class="hidden items-center gap-6 md:flex">
      <a class="navlink" href="<?= esc_url(home_url('/lessen')); ?>">Lessen</a>
      <a class="navlink" href="<?= esc_url(home_url('/rooster')); ?>">Rooster</a>
      <a class="navlink" href="<?= esc_url(home_url('/prijzen')); ?>">Prijzen</a>
      <a class="navlink" href="<?= esc_url(home_url('/contact')); ?>">Contact</a>
      <?php component('button', ['href'=>home_url('/contact'), 'label'=>'Proefles', 'variant'=>'primary', 'extraClass'=>'rounded-xl px-4 py-2']); ?>
    </nav>

    <button class="surface rounded-xl px-3 py-2 md:hidden" @click="toggle()" aria-label="Menu" :aria-expanded="open.toString()">
      <span class="text-sm font-medium">Menu</span>
    </button>
  </div>

  <div class="md:hidden" x-show="open" x-transition>
    <div class="container pb-4">
      <div class="surface rounded-2xl p-3">
        <a class="navitem" href="<?= esc_url(home_url('/lessen')); ?>" @click="open=false">Lessen</a>
        <a class="navitem" href="<?= esc_url(home_url('/rooster')); ?>" @click="open=false">Rooster</a>
        <a class="navitem" href="<?= esc_url(home_url('/prijzen')); ?>" @click="open=false">Prijzen</a>
        <a class="navitem" href="<?= esc_url(home_url('/contact')); ?>" @click="open=false">Contact</a>
      </div>
    </div>
  </div>
</header>
PHP

# --- footer component
cat > "$THEME_DIR/template-parts/components/footer.php" <<'PHP'
<footer class="border-t border-slate-200 bg-white">
  <div class="container flex flex-col gap-2 py-8 text-sm text-slate-600 md:flex-row md:items-center md:justify-between">
    <p>© <?= date('Y'); ?> Puurfit</p>
    <p class="flex gap-4">
      <a class="hover:underline" href="<?= esc_url(home_url('/privacy')); ?>">Privacy</a>
      <a class="hover:underline" href="<?= esc_url(home_url('/voorwaarden')); ?>">Voorwaarden</a>
    </p>
  </div>
</footer>
PHP

# --- section helper component (optional)
cat > "$THEME_DIR/template-parts/components/section.php" <<'PHP'
<?php
$id = $id ?? '';
$title = $title ?? '';
$subtitle = $subtitle ?? '';
$variant = $variant ?? 'plain'; // plain | muted | border
$extraClass = $extraClass ?? '';

$wrap = 'section';
if ($variant === 'muted') $wrap .= ' bg-slate-50';
if ($variant === 'border') $wrap .= ' border-y border-slate-200';
?>
<section <?= $id ? 'id="'.esc_attr($id).'"' : '' ?> class="<?= esc_attr(trim($wrap . " " . $extraClass)) ?>">
  <div class="container">
    <?php if ($title): ?><h2 class="h2"><?= esc_html($title) ?></h2><?php endif; ?>
    <?php if ($subtitle): ?><p class="p-muted mt-2 max-w-2xl"><?= esc_html($subtitle) ?></p><?php endif; ?>
    <?php if (!empty($slotContent)): ?><div class="mt-8"><?= $slotContent ?></div><?php endif; ?>
  </div>
</section>
PHP

# ============================================================
# THEME: HTMX partial endpoint (server-rendered fragment)
# ============================================================
cat > "$THEME_DIR/htmx/rooster.php" <<'PHP'
<?php
// Very simple partial. In WP later, turn into a proper route.
// For now, can be served by PHP endpoint if you wire routing.
?>
<div class="card">
  <ul class="space-y-3 text-sm">
    <li class="flex items-center justify-between"><span class="font-medium">Ma</span><span class="text-slate-600">18:00 Pilates • 19:15 Yoga</span></li>
    <li class="flex items-center justify-between"><span class="font-medium">Wo</span><span class="text-slate-600">18:30 Reformer • 19:30 Core</span></li>
    <li class="flex items-center justify-between"><span class="font-medium">Za</span><span class="text-slate-600">09:30 Yoga • 10:45 Reformer</span></li>
  </ul>
  <p class="mt-4 text-xs text-slate-500">* voorbeeld tijden (later dynamisch)</p>
</div>
PHP

# ============================================================
# SITE: Tailwind component classes (short HTML)
# ============================================================
cat > "$SITE_DIR/src/css/tailwind.css" <<'CSS'
@tailwind base;
@tailwind components;
@tailwind utilities;

@layer components {
  .container { @apply mx-auto max-w-6xl px-4; }

  .surface { @apply bg-white border border-slate-200; }

  .btn { @apply inline-flex items-center justify-center rounded-2xl px-5 py-3 text-sm font-medium; }
  .btn-primary { @apply btn bg-slate-900 text-white hover:bg-slate-800; }
  .btn-ghost { @apply btn border border-slate-200 hover:bg-slate-50; }

  .card { @apply rounded-3xl border border-slate-200 bg-white p-6; }
  .section { @apply py-12; }

  .h2 { @apply text-2xl font-semibold tracking-tight; }
  .h3 { @apply text-lg font-semibold; }
  .p-muted { @apply text-slate-700; }

  .logo-badge { @apply inline-flex h-9 w-9 items-center justify-center rounded-xl border border-slate-200; }
  .navlink { @apply text-sm hover:underline; }
  .navitem { @apply block rounded-xl px-3 py-2 hover:bg-slate-50; }
}
CSS

# ============================================================
# SITE: main.js (Alpine tiny + HTMX load)
# - If you already have one, this overwrites. If you don’t want overwrite, edit script.
# ============================================================
cat > "$SITE_DIR/src/js/main.js" <<'JS'
import "../css/tailwind.css";
import Alpine from "alpinejs";
import htmx from "htmx.org";

window.Alpine = Alpine;
window.htmx = htmx;

Alpine.data("nav", () => ({
  open: false,
  toggle() { this.open = !this.open; }
}));

Alpine.start();
JS

echo "✅ Done."
echo "Next:"
echo "  - Use short classes in HTML: container / card / btn-primary / h2 etc."
echo "  - If you want HTMX partials on the static site, serve a PHP endpoint or swap to a static JSON/HTML file."
