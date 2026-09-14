import { readFile, mkdir, writeFile } from "node:fs/promises";
import { homedir } from "node:os";
import { dirname, resolve } from "node:path";
import { authenticate } from "@google-cloud/local-auth";
import { google } from "googleapis";

const scope = "https://www.googleapis.com/auth/drive.file";
const clientSecretPath = resolve(homedir(), ".config", "gws", "client_secret.json");
const tokenPath = resolve(homedir(), ".config", "meetup-event-creator", "token.json");

async function loadSavedCredentials() {
  try {
    return google.auth.fromJSON(JSON.parse(await readFile(tokenPath, "utf8")));
  } catch (error) {
    if (error.code === "ENOENT") {
      return null;
    }
    throw error;
  }
}

async function saveCredentials(client) {
  const clientKeys = JSON.parse(await readFile(clientSecretPath, "utf8"));
  const key = clientKeys.installed ?? clientKeys.web;
  if (!key) {
    throw new Error("OAuth client JSON must contain an installed or web client.");
  }

  const credentials = {
    type: "authorized_user",
    client_id: key.client_id,
    client_secret: key.client_secret,
    refresh_token: client.credentials.refresh_token,
  };
  await mkdir(dirname(tokenPath), { recursive: true });
  await writeFile(tokenPath, JSON.stringify(credentials), { mode: 0o600 });
}

export async function authorize() {
  const savedCredentials = await loadSavedCredentials();
  if (savedCredentials) {
    try {
      await savedCredentials.getAccessToken();
      return savedCredentials;
    } catch {
      console.log("Saved Google authorization is no longer valid; opening browser authorization.");
    }
  }

  const client = await authenticate({
    scopes: [scope],
    keyfilePath: clientSecretPath,
  });
  if (client.credentials.refresh_token) {
    await saveCredentials(client);
  }
  return client;
}