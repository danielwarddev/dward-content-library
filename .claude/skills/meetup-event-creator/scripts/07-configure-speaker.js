async (page) => {
  const speaker = {
    name: "Arturo Nereu",
    bio: "Arturo is a software engineer who's spent the last decade helping developers build games, and AI and data applications. Ex Unity, ex MongoDB. He's now building Nereu, a 3D game engine where anyone can make a game by describing what they want.",
    photo: "c:\\repos\\dward-content-library\\arturo.jpg",
    x: "https://x.com/arturonereu",
    linkedIn: "https://www.linkedin.com/in/arturonereu/",
    website: "https://nereu.co",
  };

  if (!page.url().includes("/austin-net-user-group/schedule/") && !page.url().includes("/edit/")) {
    throw new Error("Open the Austin event scheduler or event editor before configuring the speaker.");
  }

  const speakersToggle = page.getByText("Speakers", { exact: true })
    .locator("xpath=following::*[@role='switch'][1]");
  const speakerRegion = page.getByRole("heading", { name: "Speaker bio *", exact: true })
    .locator("xpath=ancestor::*[@role='region'][1]");
  const speakerName = speakerRegion.locator('input[type="text"]').first();

  if (!await speakersToggle.isChecked()) {
    await speakersToggle.click();
    await speakerName.waitFor({ state: "visible" });
  }

  const labeledInput = (label) => speakerRegion.getByText(label, { exact: true })
    .locator("xpath=parent::div/parent::div")
    .locator('input[type="text"]');

  await speakerName.fill(speaker.name);
  await speakerRegion.locator(".ProseMirror:visible").fill(speaker.bio);
  await labeledInput("X").fill(speaker.x);
  await labeledInput("LinkedIn").fill(speaker.linkedIn);
  await labeledInput("Other").fill(speaker.website);

  const uploadButton = speakerRegion.getByRole("button", { name: "Upload photo", exact: true });
  if (await uploadButton.isVisible().catch(() => false)) {
    const uploadDialog = page.getByRole("dialog");
    if (!await uploadDialog.isVisible().catch(() => false)) {
      await uploadButton.click();
      await uploadDialog.waitFor({ state: "visible" });
    }
    await uploadDialog.locator('input[type="file"]').setInputFiles(speaker.photo);
    const cropDialog = page.locator('[data-slot="modal-content"]');
    await cropDialog.getByRole("button", { name: "Save", exact: true }).click();
    await cropDialog.waitFor({ state: "hidden" });
  }

  if (await speakerName.inputValue() !== speaker.name) {
    throw new Error("Speaker name was not populated.");
  }
  if (!await speakerRegion.locator(".ProseMirror:visible").innerText().then(text => text.includes(speaker.bio))) {
    throw new Error("Speaker bio was not populated.");
  }
  for (const [label, value] of [["X", speaker.x], ["LinkedIn", speaker.linkedIn], ["Other", speaker.website]]) {
    if (await labeledInput(label).inputValue() !== value) {
      throw new Error(`${label} link was not populated.`);
    }
  }

  const photo = speakerRegion.getByRole("heading", { name: "Speaker photo", exact: true })
    .locator("xpath=following-sibling::div[1]//div[contains(@style, 'background-image')]");
  await photo.waitFor({ state: "visible" });
  if (!await photo.getAttribute("style").then(style => style?.includes("meetupstatic.com/photos/event/"))) {
    throw new Error("Speaker photo was not uploaded.");
  }

  return {
    speaker: speaker.name,
    photoUploaded: true,
    linksConfigured: true,
    published: false,
  };
}