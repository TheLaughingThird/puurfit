<?php
$id = $id ?? '';
$title = $title ?? '';
$subtitle = $subtitle ?? '';
$variant = $variant ?? 'plain'; // plain | muted | border
$extraClass = $extraClass ?? '';

$wrap = 'section';
if ($variant === 'muted') $wrap .= ' bg-slate-50';
if ($variant === 'border') $wrap .= ' border-y border-slate-200';
?>
<section <?= $id ? 'id="'.esc_attr($id).'"' : '' ?> class="<?= esc_attr(trim($wrap . " " . $extraClass)) ?>">
  <div class="container">
    <?php if ($title): ?><h2 class="h2"><?= esc_html($title) ?></h2><?php endif; ?>
    <?php if ($subtitle): ?><p class="p-muted mt-2 max-w-2xl"><?= esc_html($subtitle) ?></p><?php endif; ?>
    <?php if (!empty($slotContent)): ?><div class="mt-8"><?= $slotContent ?></div><?php endif; ?>
  </div>
</section>
