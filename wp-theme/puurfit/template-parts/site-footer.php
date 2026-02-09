<footer class="border-t border-slate-200 bg-white">
  <div class="container flex flex-col gap-2 py-8 text-sm text-slate-600 md:flex-row md:items-center md:justify-between">
    <p>© <?php echo date('Y'); ?> Puurfit</p>
    <p class="flex flex-wrap gap-4">
      <?php
      $privacy_url = function_exists('get_privacy_policy_url') ? get_privacy_policy_url() : '';
      if (!$privacy_url) $privacy_url = home_url('/privacy');
      $voorwaarden_url = home_url('/voorwaarden');
      ?>
      <a class="hover:underline" href="<?php echo esc_url($privacy_url); ?>">Privacy</a>
      <a class="hover:underline" href="<?php echo esc_url($voorwaarden_url); ?>">Algemene voorwaarden</a>
      <button class="hover:underline" type="button" data-share-button aria-controls="share-menu" aria-expanded="false">Delen</button>
    </p>
  </div>
  <div class="container pb-8">
    <div class="surface hidden max-w-md rounded-2xl p-3 text-sm" id="share-menu" data-share-menu>
      <p class="text-xs text-slate-500">Delen via</p>
      <div class="mt-2 flex flex-wrap gap-3">
        <a class="hover:underline" data-share-link="whatsapp" href="#">WhatsApp</a>
        <a class="hover:underline" data-share-link="facebook" href="#">Facebook</a>
        <a class="hover:underline" data-share-link="linkedin" href="#">LinkedIn</a>
        <a class="hover:underline" data-share-link="x" href="#">X</a>
        <a class="hover:underline" data-share-link="email" href="#">Email</a>
      </div>
    </div>
  </div>
</footer>
