<?php
$title = $title ?? '';
$extraClass = $extraClass ?? '';
?>
<article class="<?= esc_attr(trim("card {$extraClass}")) ?>">
  <?php if ($title): ?>
    <h3 class="h3"><?= esc_html($title) ?></h3>
  <?php endif; ?>
  <?php if (!empty($slotContent)): ?>
    <div class="mt-2"><?= $slotContent ?></div>
  <?php endif; ?>
</article>
