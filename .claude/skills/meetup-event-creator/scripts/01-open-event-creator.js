async (page) => {
  const groupUrl = "https://www.meetup.com/sadnug/";
  await page.goto(groupUrl);
  await page.waitForLoadState("domcontentloaded");

  const loginButton = page.getByRole("button", { name: "Log in", exact: true });
  const authenticationRequired = await loginButton.isVisible().catch(() => false);
  if (authenticationRequired) {
    return {
      url: page.url(),
      title: await page.title(),
      authenticationRequired: true,
    };
  }

  await page.getByRole("button", { name: "Create event", exact: true }).click();
  await Promise.all([
    page.waitForURL(/\/sadnug\/schedule\//),
    page.getByRole("menuitem", { name: "Create a new event", exact: true }).click(),
  ]);

  return {
    url: page.url(),
    title: await page.title(),
    authenticationRequired: false,
  };
}