<?php get_header(); ?>
<section class="container section">
  <?php while (have_posts()): the_post(); ?>
    <h1 class="h2"><?php the_title(); ?></h1>
    <div class="prose mt-6"><?php the_content(); ?></div>
  <?php endwhile; ?>
</section>
<?php get_footer(); ?>
