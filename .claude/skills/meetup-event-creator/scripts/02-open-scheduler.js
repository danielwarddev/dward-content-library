async (page) => {
  if (!page.url().includes("/austin-net-user-group/schedule/")) {
    throw new Error("Run 01-open-event-creator.js from the Austin .NET User Group home page first.");
  }

  const startFromScratch = page.getByRole("button", { name: /Start from scratch/ });
  await startFromScratch.waitFor({ state: "visible", timeout: 3000 }).catch(() => {});
  if (await startFromScratch.isVisible().catch(() => false)) {
    await startFromScratch.click();
  }

  for (const buttonName of ["Continue", "Done"]) {
    const announcementButton = page.getByRole("button", { name: buttonName, exact: true });
    await announcementButton.waitFor({ state: "visible", timeout: 1000 }).catch(() => {});
    if (await announcementButton.isVisible().catch(() => false)) {
      await announcementButton.click();
    }
  }

  await page.locator("#title").waitFor({ state: "visible" });
  await page.getByRole("dialog", { name: "Start from" }).waitFor({ state: "hidden" });

  const blockingDialogs = await page.locator('[role="dialog"]:visible').count();
  if (blockingDialogs > 0) {
    throw new Error("A blocking Meetup dialog must be dismissed before editing the event.");
  }

  return {
    url: page.url(),
    ready: true,
  };
}