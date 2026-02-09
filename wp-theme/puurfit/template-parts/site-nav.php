<nav>
  <?php
  wp_nav_menu([
    'theme_location' => 'primary',
    'container' => false,
    'menu_class' => 'flex gap-6',
    'fallback_cb' => '__return_false'
  ]);
  ?>
</nav>
