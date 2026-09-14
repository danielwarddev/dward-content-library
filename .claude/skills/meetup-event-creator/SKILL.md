---
name: meetup-event-creator
description: Create and preview .NET user group events on Meetup using saved Playwright MCP scripts, and create the matching Google feedback form. Use when scheduling, drafting, previewing, or publishing a Meetup event from prompt details or a Markdown event brief.
---

# Meetup Event Creator

Create Meetup events through Playwright MCP with an auditable script for each browser step. Create and publish the matching Google feedback form through the Forms API. Preview the Meetup event, then stop for user review. Never publish the Meetup event without explicit confirmation in the current conversation.

## Inputs

Accept event details directly from the prompt or from a Markdown file. Use [references/event-input-template.md](references/event-input-template.md) to identify missing fields.

Required:

- Event title
- Description or abstract
- Date, start time, duration, and time zone
- In-person, online, or hybrid format
- Online meeting URL or venue

When the event has a speaker, require their name, bio, and a local photo file; collect any available social or website links. Always ask for a missing speaker photo because Meetup's dedicated Speakers section requires one for a complete profile. Keep the speaker's name, bio, photo, and links in the dedicated Speakers fields; do not append an "About" section, speaker bio, or speaker links to the event description. The speaker photo is separate from the optional event image. Ask only for other required details that cannot be inferred safely. For SADNUG noon events, use the `.NET@NOON:` title prefix and Central time unless the user specifies otherwise.

Always create and publish one feedback form and generate its QR code for every Meetup event. Its title uses the event date as `.NET User Group Feedback - M/D/YYYY`. The form content comes from `scripts/google-forms/feedback-form-template.json`; do not skip form or QR-code creation or silently alter the questions or description for a single event.

Determine hosts from the group URL:

- For `meetup.com/sadnug/`, use Daniel Ward.
- For `meetup.com/austin-net-user-group/`, use Daniel Ward and Ashish Patel.
- For any other group, ask the user who should host the event.

If a required host is unavailable in Meetup's host picker, stop and report the missing host rather than silently omitting or substituting someone.

## Workflow

1. Read and normalize the event data. Preserve the user's wording unless asked to edit it.
2. Create or update event-specific scripts in `scripts/`. Keep event values embedded in the scripts so the exact automation is reviewable and repeatable.
3. Run `scripts/01-open-event-creator.js`. It opens the target group home page, clicks `Create event`, and selects `Create a new event`. Do not navigate through the Events tab. If it reports `authenticationRequired: true`, ask the user to log in directly in the visible browser, then rerun it. Never request or handle credentials.
4. Run `scripts/02-open-scheduler.js` to dismiss known startup dialogs. Start from scratch unless the user explicitly requests duplication.
5. Update and run `scripts/03-fill-event-details.js` for the normalized event data. The description must contain only event or talk content, not speaker-profile content. Use stable IDs, accessible labels, and the first visible `.ProseMirror` editor because enabling Speakers adds a second editor for the bio.
6. Update and run `scripts/04-configure-event.js`. Disable event chat, event comments, and the registration form, and verify all three are off. Configure the required hosts based on the group URL. Select up to five relevant topics from `.NET`, `C#`, `Software Development`, `Technology`, `ASP.NET`, `Web Development`, `Artificial Intelligence`, `Game Programming`, `Unity Game Engine`, and `Game Design`. Always use `.NET` and `C#` when available. Use five topics whenever five approved topics genuinely apply, but never add a broad, unrelated, or weakly related topic just to reach the limit. Prefer `Software Development` unless directly applicable, more specific topics fill the five-topic limit; use a specific topic only when the event content supports it.
7. When the event has a speaker, update and run `scripts/07-configure-speaker.js`. Enable Speakers, fill the dedicated name, bio, and link fields, and upload the local photo through the speaker's `Upload photo` control. Set the modal's hidden `input[type="file"]` with Playwright, save the crop, and verify Meetup renders the uploaded photo. Do not use the event-image `Select` control.
8. Update and run `scripts/05-preview-event.js`. Assert the form values, open Meetup's Event preview, and validate the rendered title, schedule, format, description, and speaker details.
9. For every new Meetup event, run `npm run create -- --date M/D/YYYY` from `scripts/google-forms/`. On the first run, complete Google authorization in the browser; never request or handle Google credentials. The helper creates, validates, and publishes the form with responses enabled, then generates a QR-code PNG in `scripts/google-forms/generated/`. Do not consider event creation complete if this step fails.
10. Report the Meetup preview URL and published Google Form responder URL together, along with the Google Form edit URL, QR-code image path, and any formatting caveats. Stop for Meetup review.
11. Publish the Meetup event only after the user explicitly approves the displayed preview. Create a separate event-specific publish script from the current preview UI, keep its action narrowly scoped to Publish, and run it once.
12. After publishing, report the final Meetup event URL, published Google Form responder URL, and QR-code image path together.

## Google Forms Setup

The helper uses a Desktop OAuth client and only requests `https://www.googleapis.com/auth/drive.file`. Install dependencies once with `npm install` from `scripts/google-forms/`.

It reads the OAuth client from `~/.config/gws/client_secret.json` and stores the authorized-user token at `~/.config/meetup-event-creator/token.json`. Both files must remain outside the repository.

Enable the Google Forms API for the OAuth client's Google Cloud project before the first live run. The initial authorization opens a browser and saves a refresh token for later events.

## Editing A Saved Draft

Update `scripts/06-open-event-editor.js` with the exact event title before running it. The script supports both verified entry points:

- From an open event preview, locate the banner headed `Event preview` and click its `Edit` button. Scope the button to that banner because the page can contain another Edit control.
- From elsewhere, open the target group home page and select `Create event` > `Edit a saved draft`. On the drafts page, select the event by its exact title, open its preview, and click the banner's `Edit` button.

Wait for the target group's `/events/{id}/edit/` URL and a visible `#title`, then verify the title before changing anything. Update the event-specific values and expectations in the fill, configure, and preview scripts as needed. Run only the affected scripts, finish by rerunning `scripts/05-preview-event.js`, and stop for review again. Editing a draft does not grant permission to publish it.

## Safety Rules

- Do not publish the Meetup event during population or preview.
- Do not infer a venue, meeting URL, date, or time.
- Do not duplicate an old event by default; hidden settings may carry over.
- Do not overwrite or discard an in-progress event unless the user approves.
- Treat a generated `/events/{id}/` page labeled `Event preview` as unpublished.
- Keep OAuth client secrets and tokens outside the repository. Never read, print, copy, or commit their contents.
- Keep the Google OAuth scope limited to `drive.file`.
- Validate after every substantive script change by running that exact saved script.

## Current Scripts

- `scripts/01-open-event-creator.js`: open the group home page, detect authentication, and use `Create event` > `Create a new event`.
- `scripts/02-open-scheduler.js`: prepare the blank scheduler and dismiss known startup dialogs.
- `scripts/03-fill-event-details.js`: fill and verify core event fields.
- `scripts/04-configure-event.js`: configure hosts and topics, and disable chat, comments, and registration.
- `scripts/05-preview-event.js`: validate the form and rendered preview without publishing.
- `scripts/06-open-event-editor.js`: reopen an existing draft through its preview and verify the editor before making changes.
- `scripts/07-configure-speaker.js`: populate the dedicated speaker profile, upload the speaker photo, and verify the result.
- `scripts/google-forms/create-form.js`: create, validate, and publish a feedback form with responses enabled, then generate its QR-code PNG.
- `scripts/google-forms/feedback-form-template.json`: define the shared feedback form title, description, and questions.

Meetup changes its markup periodically. Prefer IDs and roles already proven by these scripts. If a selector fails, inspect the smallest relevant page region, patch the script, and rerun it before continuing.