async (page) => {
  const expected = {
    title: "Herding Clankers into the Pit of Success",
    date: "Tue, Sep 29",
    startTime: "13:00",
    duration: "1 hour",
    previewTime: "Tuesday, Sep 29 · 1:00 PM to 2:00 PM CDT",
    venue: "Geekdom",
    descriptionIncludes: [
      "The San Antonio .NET User Group will be represented",
      "https://www.sasw.co/schedule/dotnet-user-group",
      "AI agents can be coaxed into creating reliably creating quality code",
    ],
    descriptionExcludes: [
      "About Jon Roberts",
      "Jon Roberts has over 25 years of experience",
    ],
    speakerName: "Jon Roberts",
    speakerBioIncludes: "over 25 years of experience in software development",
    topics: [".NET", "C#", "Software Development", "Artificial Intelligence", "Technology"],
    hosts: ["Daniel Ward"],
  };

  if (page.url().includes("/schedule/") || page.url().includes("/edit/")) {
    const description = await page.locator(".ProseMirror:visible").first().innerText();
    const actual = {
      title: await page.locator("#title").inputValue(),
      date: await page.locator('#startDateTime button[aria-label="Open date picker"]').innerText(),
      startTime: await page.locator('#startDateTime input[type="time"]').inputValue(),
      duration: (await page.locator('#duration [aria-haspopup="menu"]').innerText()).trim(),
    };

    for (const field of ["title", "date", "startTime", "duration"]) {
      if (actual[field] !== expected[field]) {
        throw new Error(`${field} mismatch: expected "${expected[field]}", found "${actual[field]}".`);
      }
    }
    for (const text of expected.descriptionIncludes) {
      if (!description.includes(text)) {
        throw new Error(`Description is missing: ${text}`);
      }
    }
    for (const text of expected.descriptionExcludes) {
      if (description.includes(text)) {
        throw new Error(`Description contains speaker-profile content: ${text}`);
      }
    }

    const speakerRegion = page.getByRole("heading", { name: "Speaker bio *", exact: true })
      .locator("xpath=ancestor::*[@role='region'][1]");
    if (await speakerRegion.locator('input[type="text"]').first().inputValue() !== expected.speakerName) {
      throw new Error(`Speaker name mismatch: expected "${expected.speakerName}".`);
    }
    if (!await speakerRegion.locator(".ProseMirror:visible").innerText().then(text => text.includes(expected.speakerBioIncludes))) {
      throw new Error("Speaker bio mismatch.");
    }
    await speakerRegion.getByRole("heading", { name: "Speaker photo", exact: true })
      .locator("xpath=following-sibling::div[1]//div[contains(@style, 'background-image')]")
      .waitFor({ state: "visible" });

    const requiredOffSwitches = [
      page.getByRole("switch", { name: "Enable event chat" }),
      page.getByRole("switch", { name: "Allow comments" }),
      page.getByText("Registration form", { exact: true }).locator("xpath=following::*[@role='switch'][1]"),
    ];
    for (const toggle of requiredOffSwitches) {
      if (await toggle.isChecked()) {
        throw new Error("Chat, comments, and registration must be disabled.");
      }
    }

    const topicSearch = page.locator("input[placeholder='Search topics (max 5)...']");
    const topicsSection = topicSearch.locator("xpath=ancestor::div[contains(@class, 'gap-ds2-16')][1]");
    const actualTopics = (await topicsSection.locator('button[aria-pressed="true"]').allInnerTexts())
      .map(topic => topic.trim())
      .sort();
    if (actualTopics.join("|") !== [...expected.topics].sort().join("|")) {
      throw new Error(`Topic mismatch: found ${actualTopics.join(", ")}.`);
    }

    const hostsSection = page.getByText("Hosts", { exact: true })
      .locator("xpath=ancestor::*[.//input[@placeholder='Search hosts...']][1]");
    for (const host of expected.hosts) {
      if (!await hostsSection.locator(`xpath=.//p[normalize-space()="${host}" and not(ancestor::button)]`).count()) {
        throw new Error(`Required host is missing: ${host}.`);
      }
    }

    await Promise.all([
      page.waitForURL(/\/sadnug\/events\/\d+\//),
      page.getByTestId("event-preview-btn").first().click(),
    ]);
  }

  await page.getByRole("heading", { name: "Event preview", exact: true }).waitFor();
  await page.getByRole("heading", { name: expected.title, exact: true }).first().waitFor();
  await page.getByText(expected.previewTime, { exact: true }).waitFor();
  await page.getByText(expected.venue, { exact: true }).first().waitFor();
  await page.getByText(expected.descriptionIncludes[0], { exact: false }).waitFor();
  const speakerName = page.getByText(expected.speakerName, { exact: true }).last();
  await speakerName.waitFor();
  const speakerCard = speakerName.locator("xpath=ancestor::div[.//img[@alt='Speaker']][1]");
  const speakerPhoto = speakerCard.getByRole("img", { name: "Speaker", exact: true });
  await speakerPhoto.waitFor();
  if (!await speakerPhoto.getAttribute("src").then(src => src?.includes("meetupstatic.com/images/classic-events/"))) {
    throw new Error("Preview is missing the uploaded speaker photo.");
  }
  await page.getByText(expected.speakerBioIncludes, { exact: false }).waitFor();

  return {
    formValidated: true,
    previewValidated: true,
    eventUrl: page.url(),
    published: false,
  };
}