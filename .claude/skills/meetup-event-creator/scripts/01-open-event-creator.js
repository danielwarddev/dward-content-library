async (page) => {
  const groupUrl = "https://www.meetup.com/austin-net-user-group/";
  await page.goto(groupUrl);
  await page.waitForLoadState("domcontentloaded");

  const loginButton = page.getByTestId("login-link");
  await loginButton.waitFor({ state: "visible", timeout: 5000 }).catch(() => {});
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
    page.waitForURL(/\/austin-net-user-group\/schedule\//),
    page.getByRole("menuitem", { name: "Create a new event", exact: true }).click(),
  ]);

  return {
    url: page.url(),
    title: await page.title(),
    authenticationRequired: false,
  };
}