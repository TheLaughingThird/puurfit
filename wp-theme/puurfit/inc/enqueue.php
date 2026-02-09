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
