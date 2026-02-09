<?php
$href = $href ?? '#';
$label = $label ?? 'Button';
$variant = $variant ?? 'primary'; // primary | ghost
$extraClass = $extraClass ?? '';
$attrs = $attrs ?? '';

$variantClass = $variant === 'ghost' ? 'btn-ghost' : 'btn-primary';
$cls = trim("btn {$variantClass} {$extraClass}");
?>
<a href="<?= esc_url($href) ?>" class="<?= esc_attr($cls) ?>" <?= $attrs ?>>
  <?= esc_html($label) ?>
</a>
