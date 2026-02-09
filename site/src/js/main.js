import Alpine from "alpinejs";

window.Alpine = Alpine;

Alpine.data("nav", () => ({
  open: false,
  toggle() { this.open = !this.open; }
}));

Alpine.data("faq", () => ({
  openId: null,
  toggle(id) { this.openId = this.openId === id ? null : id; }
}));

Alpine.start();

function setupShare() {
  const btns = document.querySelectorAll("[data-share-button]");
  const menu = document.querySelector("[data-share-menu]");
  if (!btns.length || !menu) return;

  const title = document.title || "Puurfit";
  const url = window.location.href;
  const description =
    document.querySelector('meta[name="description"]')?.getAttribute("content") || "";

  // Populate fallback share links (used when Web Share API is unavailable).
  const links = menu.querySelectorAll("[data-share-link]");
  for (const a of links) {
    const platform = a.getAttribute("data-share-link");
    let href = "#";

    switch (platform) {
      case "whatsapp":
        href = `https://wa.me/?text=${encodeURIComponent(`${title} ${url}`)}`;
        break;
      case "facebook":
        href = `https://www.facebook.com/sharer/sharer.php?u=${encodeURIComponent(url)}`;
        break;
      case "linkedin":
        href = `https://www.linkedin.com/sharing/share-offsite/?url=${encodeURIComponent(url)}`;
        break;
      case "x":
        href = `https://twitter.com/intent/tweet?text=${encodeURIComponent(title)}&url=${encodeURIComponent(url)}`;
        break;
      case "email":
        href = `mailto:?subject=${encodeURIComponent(title)}&body=${encodeURIComponent(url)}`;
        break;
      default:
        break;
    }

    a.setAttribute("href", href);
    if (href.startsWith("http")) {
      a.setAttribute("target", "_blank");
      a.setAttribute("rel", "noopener noreferrer");
    }
  }

  function setMenuOpen(open) {
    menu.classList.toggle("hidden", !open);
    for (const b of btns) b.setAttribute("aria-expanded", open ? "true" : "false");
  }

  for (const b of btns) {
    b.addEventListener("click", async () => {
      // Prefer native share on mobile if available.
      if (navigator.share) {
        try {
          await navigator.share({ title, text: description, url });
          return;
        } catch {
          // User cancelled or share failed; fall back to menu.
        }
      }

      const isHidden = menu.classList.contains("hidden");
      setMenuOpen(isHidden);
    });
  }

  document.addEventListener("click", (e) => {
    if (menu.classList.contains("hidden")) return;
    const target = e.target;
    if (!(target instanceof Node)) return;
    if (menu.contains(target)) return;
    if ([...btns].some((b) => b.contains(target))) return;
    setMenuOpen(false);
  });

  document.addEventListener("keydown", (e) => {
    if (e.key !== "Escape") return;
    setMenuOpen(false);
  });
}

setupShare();
