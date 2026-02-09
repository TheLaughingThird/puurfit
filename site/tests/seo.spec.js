import { test, expect } from "@playwright/test";

test.describe("SEO smoke", () => {
  const pages = [
    { path: "/", canonical: "https://puurfit.nl/" },
    { path: "/lessen.html", canonical: "https://puurfit.nl/lessen.html" },
    { path: "/rooster.html", canonical: "https://puurfit.nl/rooster.html" },
    { path: "/prijzen.html", canonical: "https://puurfit.nl/prijzen.html" },
    { path: "/over.html", canonical: "https://puurfit.nl/over.html" },
    { path: "/contact.html", canonical: "https://puurfit.nl/contact.html" },
    { path: "/blog.html", canonical: "https://puurfit.nl/blog.html" },
    // Legal pages are intentionally noindex until filled with real content.
    { path: "/privacy.html", canonical: "https://puurfit.nl/privacy.html", noindex: true },
    { path: "/voorwaarden.html", canonical: "https://puurfit.nl/voorwaarden.html", noindex: true }
  ];

  for (const p of pages) {
    test(`${p.path} has basic SEO + social metadata`, async ({ page }) => {
      await page.goto(p.path, { waitUntil: "domcontentloaded" });

      // Title
      await expect(page).toHaveTitle(/Puurfit/i);

      // Description
      const description = page.locator('meta[name="description"]');
      await expect(description).toHaveCount(1);
      await expect(description).toHaveAttribute("content", /.+/);

      // Canonical
      const canonical = page.locator('link[rel="canonical"]');
      await expect(canonical).toHaveCount(1);
      await expect(canonical).toHaveAttribute("href", p.canonical);

      // OpenGraph
      await expect(page.locator('meta[property="og:title"]')).toHaveCount(1);
      await expect(page.locator('meta[property="og:description"]')).toHaveCount(1);
      await expect(page.locator('meta[property="og:type"]')).toHaveAttribute("content", "website");
      await expect(page.locator('meta[property="og:url"]')).toHaveAttribute("content", p.canonical);
      await expect(page.locator('meta[property="og:image"]')).toHaveAttribute("content", /^https?:\/\/.+/);

      // Twitter
      await expect(page.locator('meta[name="twitter:card"]')).toHaveCount(1);
      await expect(page.locator('meta[name="twitter:title"]')).toHaveCount(1);
      await expect(page.locator('meta[name="twitter:description"]')).toHaveCount(1);
      await expect(page.locator('meta[name="twitter:image"]')).toHaveCount(1);

      // Robots
      const robots = page.locator('meta[name="robots"]');
      if (p.noindex) {
        await expect(robots).toHaveCount(1);
        await expect(robots).toHaveAttribute("content", /noindex/i);
      } else {
        await expect(robots).toHaveCount(0);
      }

      // Structured data (JSON-LD) is required on the homepage.
      const jsonLd = page.locator('script[type="application/ld+json"]');
      if (p.path === "/") await expect(jsonLd).toHaveCount(1);

      // Content structure
      await expect(page.locator("h1")).toHaveCount(1);

      // No dev-only paths in prod HTML.
      await expect(page.locator('a[href^="/src/"]')).toHaveCount(0);
      await expect(page.locator('script[src^="/src/"]:not([type="module"])')).toHaveCount(0);
    });
  }

  test("404 is noindex", async ({ page }) => {
    await page.goto("/404.html", { waitUntil: "domcontentloaded" });
    const robots = page.locator('meta[name="robots"]');
    await expect(robots).toHaveCount(1);
    await expect(robots).toHaveAttribute("content", /noindex/i);
    await expect(page.locator("h1")).toHaveCount(1);
  });
});
