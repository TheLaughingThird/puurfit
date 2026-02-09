// Playwright E2E checks run against the production build served by `vite preview`.
// Keep this lightweight and SEO/perf-oriented; avoid adding heavy test fixtures.

/** @type {import('@playwright/test').PlaywrightTestConfig} */
const config = {
  testDir: "tests",
  timeout: 30_000,
  retries: process.env.CI ? 2 : 0,
  reporter: process.env.CI ? [["list"], ["html", { open: "never" }]] : "list",
  use: {
    baseURL: "http://127.0.0.1:4173",
    trace: "retain-on-failure"
  },
  webServer: {
    command: "npm run preview -- --port 4173 --strictPort",
    url: "http://127.0.0.1:4173",
    reuseExistingServer: !process.env.CI
  }
};

export default config;
