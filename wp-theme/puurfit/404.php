<?php get_header(); ?>
<section class="container section">
  <h1 class="h2">Pagina niet gevonden</h1>
  <p class="p-muted mt-2">Ga terug naar de homepage.</p>
  <div class="mt-6">
    <?php component('button', ['href'=>home_url('/'), 'label'=>'Naar home', 'variant'=>'primary']); ?>
  </div>
</section>
<?php get_footer(); ?>
