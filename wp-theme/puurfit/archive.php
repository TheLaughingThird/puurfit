<?php get_header(); ?>
<section class="container section">
  <h1 class="h2"><?php the_archive_title(); ?></h1>
  <div class="mt-8 grid gap-4 md:grid-cols-2">
    <?php if (have_posts()): while (have_posts()): the_post(); ?>
      <article class="card">
        <h2 class="h3"><a class="hover:underline" href="<?php the_permalink(); ?>"><?php the_title(); ?></a></h2>
        <p class="p-muted mt-2 text-sm"><?php echo wp_trim_words(get_the_excerpt(), 22); ?></p>
      </article>
    <?php endwhile; else: ?>
      <p class="p-muted">Geen posts gevonden.</p>
    <?php endif; ?>
  </div>
</section>
<?php get_footer(); ?>
