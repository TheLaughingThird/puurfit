const { test, expect } = require("@playwright/test");

test.describe("SEO smoke", () => {
  test("home has basic SEO metadata", async ({ page }) => {
    await page.goto("/", { waitUntil: "domcontentloaded" });

    // Title
    await expect(page).toHaveTitle(/Puurfit/i);

    // Description
    const description = page.locator('meta[name="description"]');
    await expect(description).toHaveCount(1);
    await expect(description).toHaveAttribute("content", /.+/);

    // Canonical
    const canonical = page.locator('link[rel="canonical"]');
    await expect(canonical).toHaveCount(1);
    await expect(canonical).toHaveAttribute("href", /https?:\/\/.+/);

    // OpenGraph basics
    await expect(page.locator('meta[property="og:title"]')).toHaveCount(1);
    await expect(page.locator('meta[property="og:description"]')).toHaveCount(1);
    await expect(page.locator('meta[property="og:url"]')).toHaveCount(1);

    // Structured data (JSON-LD)
    const jsonLd = page.locator('script[type="application/ld+json"]');
    await expect(jsonLd).toHaveCount(1);

    // Content structure
    await expect(page.locator("h1")).toHaveCount(1);
  });
});

