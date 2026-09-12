async (page) => {
  const topics = [
    ["net framework", ".NET"],
    ["C sharp", "C#"],
    ["artificial intelligence", "Artificial Intelligence"],
    ["game development", "Game Programming"],
    ["game design", "Game Design"],
  ];
  const hosts = [
    ["Daniel Ward", "Daniel Ward"],
    ["Ashish", "Ashish Patel"],
  ];

  const ensureOff = async (toggle) => {
    if (await toggle.isChecked()) {
      await toggle.click();
    }
    if (await toggle.isChecked()) {
      throw new Error("Expected setting to be disabled.");
    }
  };

  const registrationSwitch = page.getByText("Registration form", { exact: true })
    .locator("xpath=following::*[@role='switch'][1]");
  const eventChatSwitch = page.getByRole("switch", { name: "Enable event chat" });
  const commentsSwitch = page.getByRole("switch", { name: "Allow comments" });
  await ensureOff(registrationSwitch);
  await ensureOff(eventChatSwitch);
  await ensureOff(commentsSwitch);

  const topicSearch = page.locator("input[placeholder='Search topics (max 5)...']");
  const topicsSection = topicSearch.locator("xpath=ancestor::div[contains(@class, 'gap-ds2-16')][1]");
  const desiredTopics = topics.map(([, topic]) => topic);
  const selectedTopics = topicsSection.locator('button[aria-pressed="true"]');
  for (const selectedTopicName of await selectedTopics.allInnerTexts()) {
    if (!desiredTopics.includes(selectedTopicName.trim())) {
      await topicsSection.getByRole("button", { name: selectedTopicName.trim(), exact: true })
        .filter({ visible: true })
        .first()
        .click({ force: true });
    }
  }
  for (const [query, topic] of topics) {
    const selectedTopic = topicsSection.getByRole("button", { name: topic, exact: true })
      .filter({ visible: true })
      .first();
    if (await selectedTopic.getAttribute("aria-pressed").catch(() => null) === "true") {
      continue;
    }
    await topicSearch.fill(query);
    await page.getByRole("option", { name: topic, exact: true }).first().click();
    await selectedTopic.waitFor();
  }

  const hostsSection = page.getByText("Hosts", { exact: true })
    .locator("xpath=ancestor::*[.//input[@placeholder='Search hosts...']][1]");
  const hostSearch = hostsSection.locator("input[placeholder='Search hosts...']");
  const missingHosts = [];
  for (const [query, host] of hosts) {
    const assignedHost = hostsSection.locator(`xpath=.//p[normalize-space()="${host}" and not(ancestor::button)]`);
    if (await assignedHost.count()) {
      continue;
    }
    await hostSearch.fill(query);
    const result = page.getByText(host, { exact: true }).locator("xpath=ancestor::li[1]");
    await result.waitFor({ state: "visible", timeout: 3000 }).catch(() => {});
    if (!await result.isVisible().catch(() => false)) {
      missingHosts.push(host);
      continue;
    }
    await result.click();
    await assignedHost.waitFor();
  }
  if (missingHosts.length) {
    throw new Error(`Required hosts unavailable: ${missingHosts.join(", ")}`);
  }

  return {
    registrationFormEnabled: await registrationSwitch.isChecked(),
    topics: desiredTopics,
    hosts: hosts.map(([, host]) => host),
    eventChatEnabled: await eventChatSwitch.isChecked(),
    commentsEnabled: await commentsSwitch.isChecked(),
  };
}