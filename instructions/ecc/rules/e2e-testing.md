# E2E Testing (Playwright) — Rules

## Organization
- Tests in `tests/e2e/` grouped by domain (auth, features, api).
- Page Object Model: one class per page/section exposing locators + actions. No raw locators scattered across specs.
- Fixtures in `tests/fixtures/`.

## Config
- fullyParallel true; forbidOnly on CI; retries 2 on CI; 1 worker on CI; HTML + JUnit + JSON reporters; trace on-first-retry; screenshot only-on-failure; video retain-on-failure; 10s action / 30s navigation timeouts; chromium + firefox + webkit + mobile projects; webServer auto-start with reuseExistingServer locally.

## Flaky Tests
- Quarantine: `test.fixme(true, 'Flaky - Issue #123')` or `test.skip(cond, '...')`.
- Reproduce: `--repeat-each=10`, `--retries=3`.
- Root causes and fixes:
  - Race conditions -> auto-wait locators (`.locator().click()`), never raw `page.click` on a selector without waiting.
  - Network timing -> wait for a specific condition (`waitForResponse`), never arbitrary `waitForTimeout`.
  - Animation timing -> wait for visibility/stability before click.

## Artifacts
- Screenshots: `page.screenshot({ path, fullPage? })`, element-level via locator screenshot.
- Traces: browser tracing with screenshots + snapshots.
- Video: retain-on-failure, artifacts/videos/.
- Upload HTML report artifact in CI with retention.

## CI
- GitHub Actions: checkout, setup-node, `npm ci`, `npx playwright install --with-deps`, `npx playwright test`, upload report on `always()`.

## Sensitive Flows
- Financial/critical flows: skip on production (`test.skip(process.env.NODE_ENV === 'production', ...)`).
- Web3: mock wallet provider via `context.addInitScript` (eth_requestAccounts, eth_chainId); verify wallet address renders.

## Reporting
- Summary template: date, duration, status; total/passed/failed/flaky/skipped; failed tests with file:line, error, screenshot path, recommended fix; artifact paths.