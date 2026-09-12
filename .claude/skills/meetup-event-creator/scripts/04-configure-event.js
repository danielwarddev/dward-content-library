async (page) => {
  const topics = [
    ".NET",
    "Game Programming",
    "Unity Game Engine",
    "Software Development",
    "C#",
  ];

  const registrationSwitch = page.getByText("Registration form", { exact: true })
    .locator("xpath=following::*[@role='switch'][1]");
  if (await registrationSwitch.isChecked()) {
    await registrationSwitch.click();
  }

  const topicsSection = page.getByText("Topics", { exact: true }).locator("xpath=ancestor::*[.//input[@placeholder='Search topics (max 5)...']][1]");
  for (const topic of topics) {
    const topicButton = topicsSection.getByRole("button", { name: topic, exact: true }).first();
    const isSelected = (await topicButton.getAttribute("aria-pressed")) === "true"
      || (await topicButton.locator('img[alt*="minus" i], img[alt*="close" i]').count()) > 0;
    if (!isSelected) {
      await topicButton.click();
    }
  }

  return {
    registrationFormEnabled: await registrationSwitch.isChecked(),
    topics,
    eventChatEnabled: await page.getByRole("switch", { name: "Enable event chat" }).isChecked(),
    commentsEnabled: await page.getByRole("switch", { name: "Allow comments" }).isChecked(),
  };
}