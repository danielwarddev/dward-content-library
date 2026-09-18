async (page) => {
  const event = {
    title: "Generate the code once, so nobody has to write it again",
    dateLabel: "Thursday, September 24th, 2026",
    startTime: "12:00",
    duration: "1 hour",
    onlineUrl: "https://simpat.zoom.us/j/89601187468",
    description: `The current approaches to game development mimic how the industry has worked in previous years. Coding agents are reinventing the wheel over and over. If a developer asks for a shooting mechanic, the LLM will write variations of it.

I'm building a game engine that tackles the problem from the other side. Generating the code once, then letting each developer and their agent repurpose what's out there. This allows developers to iterate faster. The code is not simply functions and classes, but higher level concepts that are well proven and standard in the games industry. Previously difficult to have in a single code base.

In this talk I'll show how I'm translating that domain knowledge into a tool that unlocks game development to a higher number of people, letting people express their creativity without the regular blockers: coding, and asset generation.

I'll share how I'm designing, architecting and implementing Nereu, a new kind of game development tool, along with Claude Code and Codex.`,
  };

  await page.locator("#title").fill(event.title);
  const descriptionEditor = page.locator(".ProseMirror:visible").first();
  await descriptionEditor.fill(event.description);

  const currentDate = await page.locator('#startDateTime button[aria-label="Open date picker"]').innerText();
  if (currentDate !== "Thu, Sep 24") {
    await page.locator('#startDateTime button[aria-label="Open date picker"]').click();
    await page.getByRole("button", { name: new RegExp(event.dateLabel) }).click();
  }

  await page.locator('#startDateTime input[type="time"]').fill(event.startTime);

  const durationTrigger = page.locator('#duration [aria-haspopup="menu"]');
  if ((await durationTrigger.innerText()).trim() !== event.duration) {
    await durationTrigger.click();
    await page.getByRole("menuitem", { name: event.duration, exact: true }).click();
  }

  const onlineTabs = page.getByText("Online", { exact: true });
  const visibleOnlineTabs = [];
  for (let index = 0; index < await onlineTabs.count(); index++) {
    if (await onlineTabs.nth(index).isVisible()) visibleOnlineTabs.push(onlineTabs.nth(index));
  }
  if (visibleOnlineTabs.length !== 1) {
    throw new Error(`Expected one visible Online tab, found ${visibleOnlineTabs.length}.`);
  }
  await visibleOnlineTabs[0].click();
  await page.locator('input[placeholder="https://zoom.us/"]').fill(event.onlineUrl);

  return {
    title: await page.locator("#title").inputValue(),
    date: await page.locator('#startDateTime button[aria-label="Open date picker"]').innerText(),
    startTime: await page.locator('#startDateTime input[type="time"]').inputValue(),
    duration: (await durationTrigger.innerText()).trim(),
    onlineUrl: await page.locator('input[placeholder="https://zoom.us/"]').inputValue(),
    descriptionLength: (await descriptionEditor.innerText()).length,
  };
}