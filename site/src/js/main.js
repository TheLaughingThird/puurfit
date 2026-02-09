import "../css/tailwind.css";
import Alpine from "alpinejs";
import htmx from "htmx.org";

window.Alpine = Alpine;
window.htmx = htmx;

Alpine.data("nav", () => ({
  open: false,
  toggle() { this.open = !this.open; }
}));

Alpine.data("faq", () => ({
  openId: null,
  toggle(id) { this.openId = this.openId === id ? null : id; }
}));

Alpine.start();
