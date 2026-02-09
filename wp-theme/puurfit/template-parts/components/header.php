<header x-data="nav" class="sticky top-0 z-50 border-b border-slate-200 bg-white/80 backdrop-blur">
  <div class="container flex items-center justify-between py-3">
    <a href="<?= esc_url(home_url('/')); ?>" class="flex items-center gap-2 font-semibold tracking-tight">
      <span class="logo-badge">P</span>
      <span>Puurfit</span>
    </a>

    <nav class="hidden items-center gap-6 md:flex">
      <a class="navlink" href="<?= esc_url(home_url('/lessen')); ?>">Lessen</a>
      <a class="navlink" href="<?= esc_url(home_url('/rooster')); ?>">Rooster</a>
      <a class="navlink" href="<?= esc_url(home_url('/prijzen')); ?>">Prijzen</a>
      <a class="navlink" href="<?= esc_url(home_url('/contact')); ?>">Contact</a>
      <?php component('button', ['href'=>home_url('/contact'), 'label'=>'Proefles', 'variant'=>'primary', 'extraClass'=>'rounded-xl px-4 py-2']); ?>
    </nav>

    <button class="surface rounded-xl px-3 py-2 md:hidden" @click="toggle()" aria-label="Menu" :aria-expanded="open.toString()">
      <span class="text-sm font-medium">Menu</span>
    </button>
  </div>

  <div class="md:hidden" x-show="open" x-transition>
    <div class="container pb-4">
      <div class="surface rounded-2xl p-3">
        <a class="navitem" href="<?= esc_url(home_url('/lessen')); ?>" @click="open=false">Lessen</a>
        <a class="navitem" href="<?= esc_url(home_url('/rooster')); ?>" @click="open=false">Rooster</a>
        <a class="navitem" href="<?= esc_url(home_url('/prijzen')); ?>" @click="open=false">Prijzen</a>
        <a class="navitem" href="<?= esc_url(home_url('/contact')); ?>" @click="open=false">Contact</a>
      </div>
    </div>
  </div>
</header>
