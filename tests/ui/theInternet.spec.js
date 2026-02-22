import { test, expect } from '@playwright/test';
import { handleFailure } from '../utils/aiFailureHandler.js';

test.afterEach(async ({ page }, testInfo) => {
  if (testInfo.status !== testInfo.expectedStatus) {
    await handleFailure(testInfo, testInfo.error, page);
  }
});

test('Valid login works', async ({ page }) => {
  await page.goto('https://the-internet.herokuapp.com/login');
  await page.fill('#username', 'tomsmith');
  await page.fill('#password', 'SuperSecretPassword!');
  await page.click('button[type="submit"]');

  await expect(page.locator('#flash'))
    .toContainText('You logged into a secure area!');
});

test('Invalid login fails (AI explained)', async ({ page }) => {
  await page.goto('https://the-internet.herokuapp.com/login');
  await page.fill('#username', 'wrong');
  await page.fill('#password', 'wrong');
  await page.click('button[type="submit"]');

  // Intentionally incorrect expectation
  await expect(page.locator('#flash'))
    .toHaveText('Invalid credentials');
});
