import Alpine from "alpinejs";

window.Alpine = Alpine;

Alpine.data("nav", () => ({
  open: false,
  toggle() { this.open = !this.open; }
}));

Alpine.data("faq", () => ({
  openId: null,
  toggle(id) {
    this.openId = (this.openId === id) ? null : id;
  }
}));

Alpine.start();
