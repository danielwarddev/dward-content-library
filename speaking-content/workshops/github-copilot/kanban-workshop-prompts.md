# Kanban Board: Workshop Prompts by Step

**Generated:** April 12, 2026
**Context:** Exact copy-paste prompts for attendees to use at each stage of the workshop. Mapped to the workshop blocks. App starts as an empty Vite + React + TS project.

---

## Step 1: Scaffold the App (Block 3 demo / Block 4 hands-on)

Attendees start with a bare `npm create vite@latest` project (React + TypeScript template). This prompt one-shots the full MVP.

### Prompt: One-Shot the Kanban Board

```
Build a Kanban board app in this Vite + React + TypeScript project. Use only plain CSS (no Tailwind, no UI libraries). No backend — use localStorage for persistence.

The board has three fixed columns: "To Do" (blue #4a90d9 header), "In Progress" (amber #e6a817 header), and "Done" (green #2ecc71 header). Column headers show the name and card count like "To Do (3)" with white text.

Each column has a "+ Add Card" button at the bottom. Clicking it shows an inline form with a title input (required, max 100 chars), an optional description textarea (max 500 chars), and Add/Cancel buttons. Enter submits, Escape cancels. Don't create a card if the title is empty or whitespace.

Cards are white rounded cards with a subtle shadow. They show a bold title (truncated with ellipsis after 60 chars) and an optional description (truncated after 120 chars). Each card has a "Move to" dropdown to move it to another column and a red Delete button that uses window.confirm().

Save the full board state to localStorage on every change under the key "kanban-board". On load, restore from localStorage or start with three empty columns.

Use crypto.randomUUID() for all IDs. Make columns stack vertically on screens narrower than 768px. App background is #f5f5f5.
```

> **Facilitator note:** Project the prompt on screen. Tell attendees to switch to plan mode first so they can see the plan before executing. Narrate the plan review during your live demo.

---

## Step 2: Explore the Codebase (Block 4 hands-on)

After the app is running, attendees explore what was generated using different Copilot features. These are quick ~2 min activities.

### Prompt: Explain the data flow

```
Walk me through how adding a new card works end-to-end in this codebase. Start from the user clicking "+ Add Card" and trace through the component hierarchy, state updates, and localStorage persistence.
```

### Prompt: Explain the localStorage hook

```
Explain how the useLocalStorage hook in this project works. What happens on first load when there's no saved data? What happens when the data in localStorage is corrupt or invalid JSON?
```

### Prompt: Ask about component structure

```
Draw an ASCII diagram of the component tree in this project showing parent-child relationships and what props flow between them.
```

### Prompt: CLI rubber duck (in terminal)

```
gh copilot explain "$(cat src/hooks/useLocalStorage.ts)"
```

> **Facilitator note:** Show these on screen as suggestions. Attendees pick whichever interests them. The goal is to practice using Copilot to understand unfamiliar code — even code they just generated.

---

## Step 3: Add Custom Instructions (Block 4 hands-on)

Attendees create a `copilot-instructions.md` that shapes all future Copilot interactions on the project.

### Prompt: Create instructions file

```
Create a .github/copilot-instructions.md file for this project with the following guidelines:

- This is a Kanban board built with React, TypeScript, and plain CSS (Vite)
- Use functional components with hooks, never class components
- Use crypto.randomUUID() for all IDs
- All state is managed in the Board component and passed down as props
- Use localStorage for persistence — no backend, no fetch calls
- CSS goes in component-specific .css files (e.g., Card.css for Card.tsx)
- Prefer semantic HTML elements over divs when possible
- Keep components small and focused — one responsibility per component
```

---

## Step 4: Add a Feature with Agent Mode (Block 4 hands-on)

Pick one of these. Each is a self-contained feature that takes ~5-10 min with agent mode.

### Prompt: Inline card editing

```
Add inline editing to cards. When I click on a card's title, it should turn into a text input with the current title. When I click on the description, it should turn into a textarea. Save on blur or Enter, cancel on Escape. Don't allow saving an empty title.
```

### Prompt: Card priority levels

```
Add a priority field to cards with three levels: Low, Medium, and High. Add a priority selector to the add-card form with Medium as the default. Display priority on each card as a colored left border — green for Low, orange for Medium, red for High.
```

### Prompt: Search and filter

```
Add a search bar above the board. As I type, filter cards across all columns to only show cards whose title or description contains the search text (case-insensitive). Show the total number of matching cards next to the search input. When the search is cleared, show all cards again.
```

### Prompt: Due dates with overdue highlighting

```
Add an optional due date field to cards. Add a date picker to the add-card form. Display the due date on each card in a relative format like "Due in 3 days" or "Due yesterday". If a card is past its due date, add a red-tinted background to the card.
```

### Prompt: WIP limit

```
Add a WIP (work-in-progress) limit of 5 to the "In Progress" column. Display the limit in the column header like "In Progress (2/5)". When the limit is reached, show the count in red and disable the "Move to" dropdown option for "In Progress" on cards in other columns. Still allow moving cards OUT of In Progress.
```

---

## Step 5: Create a Skill (Block 6 hands-on)

Attendees create a reusable `.prompt.md` file, then use it.

### Step 5a: Create the skill

```
Create a file called .github/prompts/add-feature-field.prompt.md with this content:

---
description: "Add a new field to Kanban cards with form input, display, and persistence"
---

Add a new field called "{{fieldName}}" to the Card interface with type {{fieldType}}.

Update the following:
1. Add the field to the Card type in types.ts
2. Add an appropriate input to AddCardForm (use a sensible default value)
3. Display the field on the Card component in a visually appropriate way
4. Ensure it persists through localStorage (no migration needed — new cards will have it, old cards can use the default)

Keep the implementation minimal and consistent with the existing code style.
```

### Step 5b: Use the skill

Now use the skill by typing `/` in the chat input, selecting the `add-feature-field` skill, and filling in the variables:

> fieldName: `assignee`
> fieldType: `string`

Or try:

> fieldName: `category`
> fieldType: `"Bug" | "Feature" | "Task"`

---

## Step 6: Wire Up an MCP Server (Block 6 hands-on)

### Prompt: Add Context7 MCP for React docs

```
Create a .vscode/mcp.json file with the Context7 MCP server configured:

{
  "servers": {
    "context7": {
      "command": "npx",
      "args": ["-y", "@upstash/context7-mcp@latest"]
    }
  }
}
```

Then start a new conversation and try:

```
Using the context7 tool, look up the React docs for useEffect cleanup functions. Then review my useLocalStorage hook and tell me if I'm handling cleanup correctly.
```

---

## Step 7: Vision — Redesign from a Screenshot (Block 6 hands-on)

### Prompt: Paste a Trello screenshot

Paste a screenshot of a Trello board into the chat, then type:

```
Redesign my Kanban board to match the look and feel of this screenshot. Match the card styling, column headers, background colors, and overall layout. Keep all the existing functionality working.
```

### Prompt: Paste a hand-drawn mockup

If you don't have a Trello screenshot, sketch a quick design on paper, take a photo, paste it in:

```
Redesign my board based on this sketch. Interpret the layout and colors as best you can. Keep all existing functionality.
```

---

## Step 8: Create a Custom Agent (Block 6 hands-on)

### Prompt: Create a UI reviewer agent

```
Create a .github/agents/ui-reviewer.agent.md file with this content:

---
description: "Reviews UI components for visual quality, consistency, and UX issues"
tools: ["read_file", "list_dir"]
---

You are a UI/UX reviewer. When asked to review a component:

1. Read the component's TSX and CSS files
2. Check for visual consistency (spacing, colors, typography)
3. Check for UX issues (missing hover states, unclear affordances, poor contrast)
4. Check for responsive issues
5. Check for accessibility basics (semantic HTML, alt text, logical focus order)

Provide feedback as a numbered list with severity (🔴 Critical, 🟡 Suggestion, 🟢 Nice to have).
Do not make changes — only review and report.
```

Then switch to the `ui-reviewer` agent and type:

```
Review the Card component
```

---

## Step 9: Add a Hook (Block 6 hands-on — stretch goal)

### Prompt: Auto-format on file edit

```
Create a .vscode/copilot-hooks.json file that automatically runs Prettier on any TypeScript or CSS file after Copilot edits it. Use this format:

{
  "hooks": {
    "postFileEdit": {
      "command": "npx prettier --write ${filePath}",
      "pattern": "**/*.{ts,tsx,css}"
    }
  }
}
```

> **Facilitator note:** This requires Prettier to be installed. Tell attendees to run `npm install -D prettier` first, or skip if they haven't used Prettier before.

---

## Step 10: Request Code Review (Block 6 hands-on)

### Prompt: Local code review

After making several changes, trigger Copilot's code review:

```
Review all the changes I've made to this project. Focus on:
- TypeScript type safety issues
- React anti-patterns (missing keys, stale closures, unnecessary re-renders)
- CSS consistency
- Any bugs you can spot
```

Or for a focused review:

```
Review the Card component and its CSS for accessibility issues and suggest improvements.
```

---

## Step 11: CLI Features (Block 5 demo / Block 6 practice)

### Rubber duck: Debug a problem

If you hit a bug during the workshop:

```
gh copilot
```

Then describe your problem conversationally:

> "My cards aren't persisting after refresh. The useLocalStorage hook looks correct but the data isn't there when I reload. What could be going wrong?"

### Explain a command

```
gh copilot explain "npx vite --host 0.0.0.0 --port 3000"
```

### Suggest a command

```
gh copilot suggest "kill whatever process is using port 5173"
```

---

## Bonus: Freestyle Challenges

For attendees who blaze through everything:

### Prompt: Drag-and-drop

```
Add drag-and-drop to the Kanban board using the HTML5 Drag and Drop API (no libraries). I should be able to drag a card from one column and drop it into another column. Show a visual drop indicator when dragging over a valid drop target. Keep the existing "Move to" dropdown as a fallback.
```

### Prompt: Dark mode

```
Add a dark mode toggle to the app header. Use a CSS class on the body element and CSS custom properties for all colors. The toggle should persist its state in localStorage. Default to the user's system preference using prefers-color-scheme.
```

### Prompt: Multiple boards

```
Add support for multiple boards. Add a board selector above the Kanban board with a dropdown showing all board names and a "New Board" button. Each board has its own set of columns and cards. Store all boards in localStorage under the key "kanban-boards". The default board is called "My Board".
```

### Prompt: Export/import

```
Add an "Export" button in the header that downloads the current board as a JSON file named "kanban-board-YYYY-MM-DD.json". Add an "Import" button that lets me upload a JSON file to replace the current board. Validate that the imported JSON matches the Board type before applying it.
```
