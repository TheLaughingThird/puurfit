<?php
require_once __DIR__ . '/inc/components.php';
require_once __DIR__ . '/inc/enqueue.php';
require_once __DIR__ . '/inc/seo.php';

// Theme basics
add_action('after_setup_theme', function () {
  add_theme_support('title-tag');
  add_theme_support('post-thumbnails');
});
