async (page) => {
  const groupUrl = "https://www.meetup.com/sadnug/";
  const eventTitle = "SADNUG @ SA Startup + Tech Week";

  if (page.url().includes("/edit/")) {
    await page.locator("#title").waitFor({ state: "visible" });
  } else {
    const previewHeading = page.getByRole("heading", { name: "Event preview", exact: true });
    if (!await previewHeading.isVisible().catch(() => false)) {
      await page.goto(groupUrl);
      await page.waitForLoadState("domcontentloaded");

      const loginButton = page.getByTestId("login-link");
      await loginButton.waitFor({ state: "visible", timeout: 5000 }).catch(() => {});
      if (await loginButton.isVisible().catch(() => false)) {
        throw new Error("Meetup authentication is required.");
      }

      await page.getByRole("button", { name: "Create event", exact: true }).click();
      await Promise.all([
        page.waitForURL(/\/sadnug\/events\/drafts\//),
        page.getByRole("menuitem", { name: "Edit a saved draft", exact: true }).click(),
      ]);

      const draftHeading = page.getByRole("heading", { name: eventTitle, exact: true });
      const draftLink = draftHeading.locator("xpath=ancestor::a[1]");
      await Promise.all([
        page.waitForURL(/\/sadnug\/events\/\d+\//),
        draftLink.click(),
      ]);
    }

    const previewBanner = page.getByRole("heading", { name: "Event preview", exact: true })
      .locator("xpath=ancestor::*[.//button[normalize-space()='Publish']][1]");
    await Promise.all([
      page.waitForURL(/\/sadnug\/events\/\d+\/edit\//),
      previewBanner.getByRole("button", { name: "Edit", exact: true }).click(),
    ]);
    await page.locator("#title").waitFor({ state: "visible" });
  }

  const actualTitle = await page.locator("#title").inputValue();
  if (actualTitle !== eventTitle) {
    throw new Error(`Opened the wrong event: expected "${eventTitle}", found "${actualTitle}".`);
  }

  return {
    url: page.url(),
    title: actualTitle,
    ready: true,
  };
}