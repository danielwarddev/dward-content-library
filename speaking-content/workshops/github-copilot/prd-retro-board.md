# Product Requirements Document: Sprint Retro Board

## 1. Project Overview

**Sprint Retro Board** is a single-page web application for running sprint retrospectives. Teams use it to collect feedback across three categories, vote on the most important items, and identify action items — all in a visual sticky-note board layout.

This is a **frontend-only** application with no backend, authentication, or real-time collaboration. All data persists in the browser's `localStorage`. Think of it as a simplified, single-user version of EasyRetro / FunRetro.

**Target users:** Software development teams running sprint retrospectives in a co-located or screen-shared setting.

**Context:** This project is a workshop exercise. Attendees build it in ~45 minutes with AI coding assistance. The MVP should be completable in ~20 minutes; extension features exist for attendees who finish early.

---

## 2. Tech Stack

| Layer        | Technology                     |
| ------------ | ------------------------------ |
| Build tool   | Vite                           |
| Framework    | React 18+                      |
| Language     | TypeScript (strict mode)       |
| Styling      | Plain CSS (no Tailwind, no UI library) |
| Persistence  | `localStorage`                 |
| Package mgr  | npm                            |

**No additional runtime dependencies.** Do not add any UI component libraries, CSS frameworks, or state management libraries. Use React's built-in `useState` and `useEffect` hooks. Generate UUIDs with `crypto.randomUUID()`.

---

## 3. MVP Features

These are the **must-have** features for a complete core experience.

### 3.1 Three-Column Board Layout

The board displays exactly three columns, always visible side by side horizontally:

| Column             | Theme Color | Purpose                              |
| ------------------ | ----------- | ------------------------------------ |
| What Went Well     | Green       | Positive observations from the sprint |
| What Didn't Go Well | Red/Pink   | Pain points and problems              |
| Action Items       | Blue        | Concrete next steps to improve        |

Each column has a colored header matching its theme. The columns fill the available viewport width equally.

### 3.2 Add a Sticky Note

Each column has an **add-note form** at the top, consisting of:

- A text input field (placeholder: "Add a note...")
- A submit button (labeled "Add" or a "+" icon)

**Behavior:**

- Pressing the submit button or pressing `Enter` in the text input creates a new sticky note in that column.
- The text input clears after submission.
- Empty or whitespace-only submissions are ignored (do not create a note).
- New notes appear at the top of the column's note list (before sorting is applied).

### 3.3 Sticky Note Cards

Each note renders as a styled card with a sticky-note aesthetic (see Section 5 for visual details). Each card displays:

- The note's text content
- A vote count badge (e.g., "▲ 3")
- A delete button (an "×" in the top-right corner of the card)

### 3.4 Delete a Sticky Note

- Each sticky note has a visible delete button ("×") in its top-right corner.
- Clicking the delete button immediately removes the note from the column. No confirmation dialog is needed for individual note deletion.

### 3.5 Vote on Sticky Notes

- Each sticky note displays an upvote button with the current vote count.
- Clicking the upvote button increments the vote count by 1.
- There is no vote limit — users can upvote the same note multiple times.
- The vote button and count should be visually distinct (e.g., a "▲" arrow with a number).

### 3.6 Sort Notes by Vote Count

- Notes within each column are **always displayed sorted by vote count** in descending order (highest votes first).
- Notes with equal vote counts maintain their relative insertion order (stable sort).

### 3.7 localStorage Persistence

- The entire board state (all columns and notes) is saved to `localStorage` on every change (add, delete, vote).
- On page load, the app reads from `localStorage` and restores the previous board state.
- Use a single `localStorage` key: `"retro-board-data"`.
- Store the data as a JSON-serialized `RetroBoard` object (see Section 6).

### 3.8 New Retro Button

- The app header contains a **"New Retro"** button.
- Clicking it shows a browser `confirm()` dialog: `"Start a new retro? This will clear all current notes."`
- If confirmed, all notes are removed from all columns and `localStorage` is cleared.
- If cancelled, nothing happens.

### 3.9 Visual Design: Sticky-Note Aesthetic

See Section 5 for full UI/UX details. The key visual requirement is that note cards look and feel like physical sticky notes on a board.

---

## 4. Extension Features

These are **optional** features for attendees who finish the MVP early. They are listed in rough order of complexity (easiest first). Each is independent — implement any subset in any order.

### 4.1 Edit Note Text Inline

- Double-clicking a sticky note's text makes it editable (turns into a text input or textarea in place).
- Pressing `Enter` or clicking outside the input saves the edit.
- Pressing `Escape` cancels the edit and reverts to the original text.

### 4.2 Dark Mode Toggle

- A toggle button in the header switches between light and dark themes.
- Dark mode uses a dark background (#1a1a2e or similar) with adjusted card and text colors.
- The theme preference persists in `localStorage` (key: `"retro-board-theme"`).

### 4.3 Export Retro as Markdown

- An "Export" button in the header generates a Markdown string of the current board state.
- Format:
  ```
  # Sprint Retro

  ## What Went Well
  - Note text (3 votes)
  - Another note (1 vote)

  ## What Didn't Go Well
  - Note text (5 votes)

  ## Action Items
  - Note text (2 votes)
  ```
- Trigger a file download of the Markdown as `retro-export.md`.

### 4.4 Export Retro as JSON

- A "Export JSON" button (or a dropdown from the Export button) downloads the raw `RetroBoard` data as a formatted JSON file (`retro-export.json`).

### 4.5 Drag and Drop Notes Between Columns

- Users can drag a sticky note from one column and drop it into another column.
- Use the HTML5 Drag and Drop API (no external library).
- The note retains its text and vote count when moved.

### 4.6 Timer for Retro Phases

- A timer component in the header with preset phase durations:
  - Brainstorm: 5 minutes
  - Vote: 3 minutes
  - Discuss: 5 minutes
- Start/pause/reset controls.
- Visual and/or audio alert when time expires (e.g., flash the timer red, play a beep).

### 4.7 Custom Column Names

- Column headers are editable. Clicking a column title turns it into a text input.
- Custom names persist in `localStorage` as part of the board data.
- The "New Retro" button resets column names to defaults.

### 4.8 Emoji Reactions on Notes

- Each note shows a small reaction bar below the text.
- Users can click to add emoji reactions: 👍 👎 😂 🔥 💡
- Each reaction type shows its count. Clicking again increments the count.

### 4.9 Group Similar Notes

- A "Group" button on each note allows selecting two or more notes to merge into a group.
- Grouped notes display as a stack with a combined vote count and a list of individual note texts.

### 4.10 Multiple Retro History

- Instead of clearing data on "New Retro," archive the current retro with a timestamp.
- A "History" panel or dropdown lists past retros by date.
- Clicking a past retro loads it in read-only mode.
- Store history in `localStorage` (key: `"retro-board-history"`).

---

## 5. UI/UX Description

### 5.1 Overall Layout

```
┌──────────────────────────────────────────────────────────┐
│  Header: "Sprint Retro Board"    [New Retro]             │
├──────────────────┬──────────────────┬────────────────────┤
│  What Went Well  │ What Didn't Go   │  Action Items      │
│  (green)         │ Well (red/pink)  │  (blue)            │
│                  │                  │                    │
│ ┌──────────────┐ │ ┌──────────────┐ │ ┌──────────────┐  │
│ │ [Add a note] │ │ │ [Add a note] │ │ │ [Add a note] │  │
│ │ [Add]        │ │ │ [Add]        │ │ │ [Add]        │  │
│ └──────────────┘ │ └──────────────┘ │ └──────────────┘  │
│                  │                  │                    │
│ ┌──────────────┐ │ ┌──────────────┐ │ ┌──────────────┐  │
│ │ Note text  × │ │ │ Note text  × │ │ │ Note text  × │  │
│ │ ▲ 5          │ │ │ ▲ 2          │ │ │ ▲ 0          │  │
│ └──────────────┘ │ └──────────────┘ │ └──────────────┘  │
│                  │                  │                    │
│ ┌──────────────┐ │                  │                    │
│ │ Note text  × │ │                  │                    │
│ │ ▲ 3          │ │                  │                    │
│ └──────────────┘ │                  │                    │
└──────────────────┴──────────────────┴────────────────────┘
```

- **Header:** Full width, dark or neutral background. Contains the app title on the left and the "New Retro" button on the right.
- **Board:** Fills the remaining viewport height below the header. Three columns with equal width, arranged horizontally using CSS flexbox or grid.
- **Columns:** Each column has a colored header bar, an add-note form, and a scrollable list of sticky note cards below it. Columns scroll independently if content overflows.

### 5.2 Sticky Note Visual Style

Each sticky note card must look like a physical sticky note pinned to a board:

- **Background color:** A soft, muted version of the column's theme color:
  - What Went Well: `#c8f7c5` (light green)
  - What Didn't Go Well: `#f7c5c5` (light pink/red)
  - Action Items: `#c5d5f7` (light blue)
- **Slight random rotation:** Each card is rotated between −2° and +2° using a CSS `transform: rotate()`. Use a deterministic rotation derived from the note's ID (e.g., hash the ID to a number in the range) so the rotation is consistent across renders.
- **Box shadow:** `2px 4px 8px rgba(0, 0, 0, 0.15)` — a soft shadow to create depth.
- **Border radius:** `2px` — sticky notes have almost-square corners.
- **Font:** Use `'Patrick Hand', 'Segoe Print', 'Comic Sans MS', cursive` as the font stack for note text to evoke a handwritten feel. Load 'Patrick Hand' from Google Fonts via a `<link>` tag in `index.html`.
- **Padding:** `16px` inside each card.
- **Margin:** `8px 0` between cards.
- **Width:** Cards fill the column width minus padding.
- **Delete button (×):** Positioned absolutely in the top-right corner of the card. Subtle gray by default, turns red on hover.
- **Vote area:** Bottom-left of the card. The upvote button ("▲") and vote count are displayed inline. The upvote button uses `cursor: pointer` and slightly enlarges on hover.

### 5.3 Color Palette

| Element                  | Color     |
| ------------------------ | --------- |
| Page background          | `#f5f0e8` (warm beige, like a corkboard) |
| Header background        | `#2c3e50` (dark blue-gray) |
| Header text              | `#ffffff` |
| Column header (Well)     | `#27ae60` |
| Column header (Didn't)   | `#e74c3c` |
| Column header (Actions)  | `#2980b9` |
| Note bg (Well)           | `#c8f7c5` |
| Note bg (Didn't)         | `#f7c5c5` |
| Note bg (Actions)        | `#c5d5f7` |
| Note text                | `#2c3e50` |
| Vote count               | `#555555` |
| Delete button            | `#999999` (hover: `#e74c3c`) |

### 5.4 Responsive Behavior

- On viewports under 768px wide, columns should stack vertically instead of horizontally.
- The app should remain usable on tablet-sized screens. Full mobile optimization is not required.

---

## 6. Data Model

Define the following TypeScript types in a shared `types.ts` file:

```typescript
interface Note {
  id: string;          // crypto.randomUUID()
  text: string;        // The note content
  votes: number;       // Upvote count, starts at 0
  createdAt: string;   // ISO 8601 timestamp
}

interface Column {
  id: string;          // "went-well" | "didnt-go-well" | "action-items"
  title: string;       // "What Went Well" | "What Didn't Go Well" | "Action Items"
  notes: Note[];       // Array of notes in this column
}

interface RetroBoard {
  columns: Column[];   // Always exactly 3 columns
}
```

### Default Board State

When no data exists in `localStorage`, initialize the board with:

```typescript
const defaultBoard: RetroBoard = {
  columns: [
    { id: "went-well", title: "What Went Well", notes: [] },
    { id: "didnt-go-well", title: "What Didn't Go Well", notes: [] },
    { id: "action-items", title: "Action Items", notes: [] },
  ],
};
```

---

## 7. Component Structure

```
App
├── Header
│   ├── App title ("Sprint Retro Board")
│   └── NewRetroButton
├── RetroBoard
│   └── Column (×3)
│       ├── ColumnHeader (colored title bar)
│       ├── AddNoteForm (text input + submit button)
│       └── StickyNote (×N, sorted by votes desc)
│           ├── Note text
│           ├── DeleteButton (×)
│           └── VoteButton (▲ + count)
```

### Component Responsibilities

| Component      | Responsibility |
| -------------- | -------------- |
| `App`          | Top-level layout. Holds board state in `useState`. Loads from and saves to `localStorage`. Passes state and handlers down as props. |
| `Header`       | Renders app title and the "New Retro" button. |
| `RetroBoard`   | Renders the three `Column` components in a horizontal flex/grid container. |
| `Column`       | Renders its column header, the `AddNoteForm`, and the sorted list of `StickyNote` components. Receives its `Column` data and callbacks as props. |
| `AddNoteForm`  | Manages its own input state. Calls an `onAddNote(columnId, text)` callback on submit. |
| `StickyNote`   | Renders a single note card. Calls `onDelete(noteId, columnId)` and `onVote(noteId, columnId)` callbacks. Applies sticky-note styling including rotation. |

### State Management

- All board state lives in `App` as a single `RetroBoard` object in `useState`.
- `App` defines handler functions (`addNote`, `deleteNote`, `voteNote`, `newRetro`) and passes them down as props.
- A `useEffect` in `App` saves the board state to `localStorage` whenever it changes.
- A lazy initializer on `useState` loads the board from `localStorage` on first render.

---

## 8. Suggested File Structure

```
retro-board/
├── index.html
├── package.json
├── tsconfig.json
├── tsconfig.app.json
├── tsconfig.node.json
├── vite.config.ts
├── public/
│   └── (empty or favicon)
└── src/
    ├── main.tsx              # ReactDOM.createRoot, renders <App />
    ├── App.tsx               # Top-level component, state management
    ├── App.css               # Global styles (body, page background, fonts)
    ├── types.ts              # Note, Column, RetroBoard interfaces
    ├── components/
    │   ├── Header.tsx
    │   ├── Header.css
    │   ├── RetroBoard.tsx
    │   ├── RetroBoard.css
    │   ├── Column.tsx
    │   ├── Column.css
    │   ├── AddNoteForm.tsx
    │   ├── AddNoteForm.css
    │   ├── StickyNote.tsx
    │   └── StickyNote.css
    └── utils/
        └── storage.ts        # loadBoard() and saveBoard() helpers
```

### `storage.ts` Spec

```typescript
const STORAGE_KEY = "retro-board-data";

function loadBoard(): RetroBoard | null {
  // Read from localStorage, parse JSON, return RetroBoard or null if missing/invalid
}

function saveBoard(board: RetroBoard): void {
  // Serialize board to JSON and write to localStorage
}
```

---

## 9. Acceptance Criteria

The MVP is complete when all of the following are true:

1. **Board renders:** The app displays three columns side by side with the correct titles and header colors.
2. **Add notes:** Typing text into a column's input and pressing Enter (or clicking Add) creates a new sticky note in that column. The input clears after submission. Empty submissions are rejected.
3. **Notes display:** Each note shows its text, a vote count (starting at 0), and a delete button.
4. **Delete notes:** Clicking the × button on a note removes it from the board.
5. **Vote on notes:** Clicking the upvote button on a note increments its vote count by 1.
6. **Sort by votes:** Notes within each column are displayed in descending order of vote count.
7. **Persistence:** Refreshing the browser preserves all notes and vote counts. (Test: add notes, refresh, verify notes still appear.)
8. **New Retro:** Clicking "New Retro" shows a confirmation dialog. Confirming clears all notes. Cancelling preserves the board.
9. **Sticky-note styling:** Note cards have column-appropriate background colors, slight rotation, drop shadows, and a handwritten-style font.
10. **Responsive columns:** On narrow viewports (<768px), columns stack vertically.

---

## 10. Out of Scope

The following are **explicitly not part of this project**:

- **Backend / server** — No API, no server, no database. Frontend only.
- **Real-time collaboration** — No WebSocket, no shared state between browsers.
- **Authentication / user accounts** — No login, no user identity.
- **Database** — No SQL, no NoSQL, no IndexedDB. Only `localStorage`.
- **Automated tests** — No unit tests, no integration tests, no E2E tests.
- **CI/CD** — No build pipeline, no deployment configuration.
- **Accessibility audit** — Basic semantic HTML is sufficient. No ARIA-heavy implementation required.
- **Animations / transitions** — Simple CSS hover effects are fine. No animation libraries.
- **State management libraries** — No Redux, Zustand, Jotai, etc.
- **CSS frameworks** — No Tailwind, Bootstrap, Material UI, or similar.
- **Multi-user features** — No author names, no user identification on notes.
- **Routing** — Single page, no React Router.
