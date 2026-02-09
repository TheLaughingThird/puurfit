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
