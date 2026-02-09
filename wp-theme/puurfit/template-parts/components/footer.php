<footer class="border-t border-slate-200 bg-white">
  <div class="container flex flex-col gap-2 py-8 text-sm text-slate-600 md:flex-row md:items-center md:justify-between">
    <p>© <?= date('Y'); ?> Puurfit</p>
    <p class="flex gap-4">
      <a class="hover:underline" href="<?= esc_url(home_url('/privacy')); ?>">Privacy</a>
      <a class="hover:underline" href="<?= esc_url(home_url('/voorwaarden')); ?>">Voorwaarden</a>
    </p>
  </div>
</footer>
