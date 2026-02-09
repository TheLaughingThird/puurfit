import { defineConfig } from "vite";
import { resolve } from "node:path";

export default defineConfig({
  plugins: [
    {
      name: "css-before-module-script",
      // Vite injects hashed CSS link tags late; ensure CSS is discovered before module scripts
      // to reduce FOUC/CLS on slow connections.
      transformIndexHtml(html) {
        return html.replace(
          /(<script\b[^>]*type="module"[^>]*><\/script>)\s*(<link\b[^>]*rel="stylesheet"[^>]*>)/g,
          "$2\n  $1"
        );
      }
    }
  ],
  server: {
    port: 5173,
    strictPort: true
  },
  build: {
    outDir: "dist",
    assetsDir: "assets",
    manifest: true,
    cssMinify: true,
    // Multi-page build: ensure all static pages are processed and emitted to dist/.
    rollupOptions: {
      input: {
        index: resolve(__dirname, "index.html"),
        lessen: resolve(__dirname, "lessen.html"),
        rooster: resolve(__dirname, "rooster.html"),
        prijzen: resolve(__dirname, "prijzen.html"),
        over: resolve(__dirname, "over.html"),
        contact: resolve(__dirname, "contact.html"),
        blog: resolve(__dirname, "blog.html"),
        // Root 404 for static hosts (Netlify/GitHub Pages/etc.).
        "404": resolve(__dirname, "404.html"),
        privacy: resolve(__dirname, "privacy.html"),
        voorwaarden: resolve(__dirname, "voorwaarden.html")
      }
    }
  }
});
