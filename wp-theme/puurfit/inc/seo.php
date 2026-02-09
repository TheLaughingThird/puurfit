<?php
// Minimal SEO hooks (expand later).
add_action('wp_head', function () {
  if (!is_front_page()) return;
  echo '<meta name="description" content="Puurfit studio: yoga, pilates, reformer, groepslessen en 1-op-1 training.">' . "\n";
}, 1);
