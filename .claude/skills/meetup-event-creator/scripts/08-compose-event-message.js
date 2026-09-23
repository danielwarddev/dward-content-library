async (page) => {
  const event = {
    groupSlug: "austin-net-user-group",
    eventId: "316529217",
    date: "2026-09-24",
    timeZone: "America/Chicago",
    title: "Generate the code once, so nobody has to write it again",
    presenter: "Arturo Nereu",
    url: "https://www.meetup.com/austin-net-user-group/events/316529217",
    sender: "Daniel Ward",
  };

  const localDateParts = new Intl.DateTimeFormat("en-US", {
    timeZone: event.timeZone,
    year: "numeric",
    month: "numeric",
    day: "numeric",
  }).formatToParts(new Date());
  const localDate = Object.fromEntries(localDateParts.map(part => [part.type, part.value]));
  const [eventYear, eventMonth, eventDay] = event.date.split("-").map(Number);
  const daysUntil = Math.round((
    Date.UTC(eventYear, eventMonth - 1, eventDay)
    - Date.UTC(Number(localDate.year), Number(localDate.month) - 1, Number(localDate.day))
  ) / 86_400_000);

  if (daysUntil < 0) {
    throw new Error("The event date has passed; update the event-specific message values.");
  }

  const timing = daysUntil === 0 ? "today" : daysUntil === 1 ? "tomorrow" : `in ${daysUntil} days`;
  const subject = daysUntil === 0
    ? ".NET meetup today at noon!"
    : daysUntil === 1
      ? ".NET meetup tomorrow!"
      : `.NET meetup in ${daysUntil} days!`;
  const body = [
    "Hi all,",
    `As a reminder, the next .NET User Group meetup will be ${timing}! We hope to see you there!`,
    `${event.presenter} will be presenting on ${event.title}.`,
    `Click here to sign up and get the Zoom link: ${event.url}`,
    "Thank you,",
    event.sender,
  ].join("\n");

  if (!page.url().includes(`/${event.groupSlug}/events/${event.eventId}/`)) {
    await page.goto(`${event.url}/`);
  }

  const [messagePage] = await Promise.all([
    page.context().waitForEvent("page"),
    page.getByRole("button", { name: "Contact", exact: true }).click(),
  ]);
  await messagePage.waitForURL(`**/${event.groupSlug}/messages/send/?eventId=${event.eventId}`);

  const rsvpRecipients = messagePage.getByRole("radio", {
    name: /Members based on RSVP status to a given event/,
  });
  const rsvpYes = messagePage.getByRole("checkbox", {
    name: "Members who RSVPed Yes for this event",
    exact: true,
  });
  const rsvpNo = messagePage.getByRole("checkbox", {
    name: "Members who RSVPed No for this event",
    exact: true,
  });
  const noResponse = messagePage.getByRole("checkbox", {
    name: "Members who haven't RSVPed for this event yet",
    exact: true,
  });

  if (!await rsvpRecipients.isChecked() || !await rsvpYes.isChecked()
    || await rsvpNo.isChecked() || await noResponse.isChecked()) {
    throw new Error("Expected only members who RSVPed Yes to be selected.");
  }

  await messagePage.locator("#subject").fill(subject);
  const editor = messagePage.locator(".ProseMirror:visible");
  await editor.fill(body);

  const selectEditorText = target => editor.evaluate((root, text) => {
    const walker = document.createTreeWalker(root, NodeFilter.SHOW_TEXT);
    let node;
    while ((node = walker.nextNode())) {
      const start = node.textContent.indexOf(text);
      if (start !== -1) {
        const range = document.createRange();
        range.setStart(node, start);
        range.setEnd(node, start + text.length);
        const selection = window.getSelection();
        selection.removeAllRanges();
        selection.addRange(range);
        return true;
      }
    }
    return false;
  }, target);

  const boldTexts = [`${timing}!`, event.presenter, event.title];
  for (const boldText of boldTexts) {
    if (!await selectEditorText(boldText)) {
      throw new Error(`Could not select text for bold formatting: ${boldText}`);
    }
    await messagePage.getByRole("button", { name: "Bold", exact: true }).click();
  }

  if (!await selectEditorText(event.url)) {
    throw new Error("Could not select the event URL for link formatting.");
  }
  await messagePage.getByRole("button", { name: "Insert link", exact: true }).click();
  await messagePage.getByRole("textbox", { name: "URL", exact: true }).fill(event.url);
  await messagePage.getByRole("button", { name: "OK", exact: true }).click();

  if (await messagePage.locator("#subject").inputValue() !== subject) {
    throw new Error("Message subject was not populated correctly.");
  }
  if (!await editor.innerText()
    .then(text => text.replace(/\n{2,}/g, "\n").includes(body.replace(/\n{2,}/g, "\n")))) {
    throw new Error("Message body was not populated correctly.");
  }
  if (await editor.locator("p").evaluateAll(
    paragraphs => paragraphs.some(paragraph => !paragraph.textContent.trim()),
  )) {
    throw new Error("Message body contains an unwanted empty paragraph.");
  }
  const actualBoldTexts = await editor.locator("strong").allInnerTexts();
  if (actualBoldTexts.join("|") !== boldTexts.join("|")) {
    throw new Error(`Bold formatting mismatch: found ${actualBoldTexts.join(", ")}.`);
  }
  const links = await editor.locator("a").evaluateAll(anchors => anchors.map(anchor => ({
    text: anchor.textContent,
    href: anchor.href,
  })));
  if (links.length !== 1 || links[0].text !== event.url || links[0].href !== event.url) {
    throw new Error("Event URL link formatting mismatch.");
  }

  return {
    recipient: "Members who RSVPed Yes for this event",
    subject,
    messageComposed: true,
    sent: false,
    messageUrl: messagePage.url(),
  };
}