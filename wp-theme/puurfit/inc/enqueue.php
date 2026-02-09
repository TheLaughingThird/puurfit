<?php
/**
 * Enqueue styles/scripts.
 * Vite manifest.json mapping.
 * Theme expects built assets under `wp-theme/puurfit/dist/` (copied from `site/dist/`).
 */
add_action('wp_enqueue_scripts', function () {
  $dist = get_template_directory_uri() . '/dist';
  $dist_path = get_template_directory() . '/dist';

  $manifest_path = $dist_path . '/.vite/manifest.json';
  if (file_exists($manifest_path)) {
    try {
      $raw = file_get_contents($manifest_path);
      if ($raw !== false) {
        /** @var array<string, array<string, mixed>> $manifest */
        $manifest = json_decode($raw, true, 512, JSON_THROW_ON_ERROR);

        // Find the JS entrypoint. We use "name":"main" if present, else first *.js entry.
        $entry = null;
        foreach ($manifest as $item) {
          if (is_array($item) && ($item['name'] ?? null) === 'main') {
            $entry = $item;
            break;
          }
        }
        if (!$entry) {
          foreach ($manifest as $item) {
            if (is_array($item) && isset($item['file']) && str_ends_with($item['file'], '.js')) {
              $entry = $item;
              break;
            }
          }
        }

        if ($entry && isset($entry['file'])) {
          // Enqueue CSS chunks (if any) before JS.
          if (is_array($entry['css'] ?? null)) {
            foreach ($entry['css'] as $i => $css_file) {
              wp_enqueue_style("puurfit-$i", $dist . '/' . $css_file, [], null);
            }
          }

          wp_enqueue_script('puurfit', $dist . '/' . $entry['file'], [], null, true);
          // Vite outputs ES modules.
          wp_script_add_data('puurfit', 'type', 'module');
          return;
        }
      }
    } catch (Throwable) {
      // Ignore invalid JSON / missing fields.
    }
  }
});
