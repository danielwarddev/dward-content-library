async (page) => {
  const event = {
    title: "Herding Clankers into the Pit of Success",
    description: `The San Antonio .NET User Group will be represented at this year's San Antonio Startup + Tech Week! They'll be spotlighting multiple groups at this, and our time will be on the 29th from 1-2 PM. We'll be on the 3rd floor (The Rand) at Geekdom, 110 E Houston St.

Event info: https://www.sasw.co/schedule

Our event: https://www.sasw.co/schedule/dotnet-user-group

Talk description:

AI agents can be coaxed into creating reliably creating quality code, but it takes more than just the perfect prompt. Your stack, tools, and architecture contribute to success just as much as process and harness, if not more. In this talk we’ll step through the F# .net codebase and functional architecture that make both you-thon.com and it’s agentic maintainers hum.`,
  };

  const title = page.locator("#title");
  await title.click();
  await title.press("ControlOrMeta+A");
  await title.pressSequentially(event.title);
  await title.press("Tab");
  const descriptionEditor = page.locator(".ProseMirror:visible").first();
  await descriptionEditor.fill(event.description);

  if (await title.inputValue() !== event.title) {
    throw new Error("Event title was not populated.");
  }

  return {
    title: await title.inputValue(),
    date: await page.locator('#startDateTime button[aria-label="Open date picker"]').innerText(),
    startTime: await page.locator('#startDateTime input[type="time"]').inputValue(),
    duration: (await page.locator('#duration [aria-haspopup="menu"]').innerText()).trim(),
    descriptionLength: (await descriptionEditor.innerText()).length,
  };
}