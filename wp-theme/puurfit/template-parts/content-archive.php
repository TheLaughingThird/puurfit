<article class="card">
  <h2 class="h3"><a class="hover:underline" href="<?php the_permalink(); ?>"><?php the_title(); ?></a></h2>
  <p class="p-muted mt-2 text-sm"><?php echo wp_trim_words(get_the_excerpt(), 22); ?></p>
</article>
