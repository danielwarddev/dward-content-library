import { mkdir, readFile } from "node:fs/promises";
import { dirname, resolve } from "node:path";
import { fileURLToPath } from "node:url";
import { google } from "googleapis";
import QRCode from "qrcode";
import { authorize } from "./google-auth.js";

const scriptDirectory = dirname(fileURLToPath(import.meta.url));
const templatePath = resolve(scriptDirectory, "feedback-form-template.json");

function parseArguments(argumentsToParse) {
  const options = {};

  for (let index = 0; index < argumentsToParse.length; index += 1) {
    const argument = argumentsToParse[index];
    if (argument === "--date") {
      options.eventDate = argumentsToParse[index + 1];
      index += 1;
    } else {
      throw new Error(`Unknown argument: ${argument}`);
    }
  }

  if (!options.eventDate || !/^\d{1,2}\/\d{1,2}\/\d{4}$/.test(options.eventDate)) {
    throw new Error("Provide the event date as --date M/D/YYYY.");
  }

  return options;
}

async function loadTemplate(eventDate) {
  const template = JSON.parse(await readFile(templatePath, "utf8"));
  return {
    ...template,
    title: template.title.replace("{{eventDate}}", eventDate),
  };
}

function buildBatchUpdate(template) {
  return {
    includeFormInResponse: true,
    requests: [
      {
        updateFormInfo: {
          info: { description: template.description },
          updateMask: "description",
        },
      },
      ...template.items.map((item, index) => ({
        createItem: {
          item,
          location: { index },
        },
      })),
    ],
  };
}

function validateForm(form, template) {
  if (form.info?.title !== template.title) {
    throw new Error(`Created form title does not match "${template.title}".`);
  }
  if (form.info?.description !== template.description) {
    throw new Error("Created form description does not match the template.");
  }
  if (form.items?.length !== template.items.length) {
    throw new Error(`Expected ${template.items.length} questions, found ${form.items?.length ?? 0}.`);
  }
  for (const [index, item] of template.items.entries()) {
    if (form.items[index]?.title !== item.title) {
      throw new Error(`Question ${index + 1} does not match the template.`);
    }
  }
}

async function main() {
  const options = parseArguments(process.argv.slice(2));
  const template = await loadTemplate(options.eventDate);
  const createRequest = {
    info: {
      title: template.title,
      documentTitle: template.title,
    },
  };
  const batchUpdateRequest = buildBatchUpdate(template);

  const auth = await authorize();
  const forms = google.forms({ version: "v1", auth });
  const createResult = await forms.forms.create({ requestBody: createRequest });
  const formId = createResult.data.formId;
  console.log(`Created form ${formId}.`);

  await forms.forms.batchUpdate({
    formId,
    requestBody: batchUpdateRequest,
  });

  const getResult = await forms.forms.get({ formId });
  validateForm(getResult.data, template);

  const publishResult = await forms.forms.setPublishSettings({
    formId,
    requestBody: {
      publishSettings: {
        publishState: {
          isPublished: true,
          isAcceptingResponses: true,
        },
      },
      updateMask: "publishState",
    },
  });
  const publishState = publishResult.data.publishSettings?.publishState;
  if (!publishState?.isPublished || !publishState.isAcceptingResponses) {
    throw new Error("Google did not confirm that the form is published and accepting responses.");
  }

  const publishedResult = await forms.forms.get({ formId });
  const responderUrl = publishedResult.data.responderUri;
  if (!responderUrl) {
    throw new Error("Google did not return a responder URL for the published form.");
  }

  const qrCodeDirectory = resolve(scriptDirectory, "generated");
  const qrCodePath = resolve(
    qrCodeDirectory,
    `feedback-form-${options.eventDate.replaceAll("/", "-")}.png`,
  );
  await mkdir(qrCodeDirectory, { recursive: true });
  await QRCode.toFile(qrCodePath, responderUrl, {
    errorCorrectionLevel: "H",
    margin: 4,
    width: 1024,
  });

  console.log(JSON.stringify({
    formId,
    title: publishedResult.data.info.title,
    editUrl: `https://docs.google.com/forms/d/${formId}/edit`,
    responderUrl,
    qrCodePath,
    published: true,
  }, null, 2));
}

main().catch((error) => {
  console.error(error.message);
  process.exitCode = 1;
});