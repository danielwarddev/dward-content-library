# Product Requirements Document: Kanban Board

## 1. Project Overview

A single-page Kanban board web application for managing tasks across workflow stages. Users can create, move, and delete cards organized into columns representing task status.

- **Purpose**: Workshop demo project — attendees build this in ~45 minutes with GitHub Copilot assistance.
- **Target users**: Workshop attendees following along after a live demo.
- **Deployment**: Local development only (`npm run dev`). No production build or deployment required.
- **Persistence**: Browser `localStorage`. No backend, no database, no network requests.

---

## 2. Tech Stack

| Layer        | Technology                  |
| ------------ | --------------------------- |
| Build tool   | Vite (latest)               |
| Framework    | React 18+ with hooks        |
| Language     | TypeScript (strict mode)    |
| Styling      | Plain CSS (no Tailwind, no UI library, no CSS-in-JS) |
| State        | React `useState` + `useEffect` for localStorage sync |
| IDs          | `crypto.randomUUID()`       |

**No additional dependencies beyond what `npm create vite@latest` provides with the `react-ts` template.**

---

## 3. MVP Features

These features are required for a complete MVP.

### 3.1 Board Layout

- The board displays exactly three columns in a horizontal row: **"To Do"**, **"In Progress"**, **"Done"**.
- Columns are fixed — users cannot add, remove, rename, or reorder columns in MVP.
- The board has a header/title area at the top displaying the text **"Kanban Board"**.

### 3.2 Column Display

- Each column has a **header** showing the column name and the current card count in parentheses, e.g., `To Do (3)`.
- Each column header has a distinct background color:
  - To Do: `#4a90d9` (blue)
  - In Progress: `#e6a817` (amber)
  - Done: `#2ecc71` (green)
- Column header text is white (`#ffffff`).
- Cards stack vertically inside each column, most recently added card at the **bottom**.
- If a column has no cards, display the text "No cards yet" in muted/gray text.

### 3.3 Add Card

- Each column has an **"+ Add Card"** button at the bottom of the card list.
- Clicking "**+ Add Card**" reveals an inline form **within that column** (replaces the button temporarily). The form contains:
  - A **Title** text input (required, max 100 characters). Placeholder text: `"Card title"`.
  - A **Description** textarea (optional, max 500 characters). Placeholder text: `"Description (optional)"`.
  - A **"Add"** button that submits the form.
  - A **"Cancel"** button that hides the form and re-shows the "+ Add Card" button.
- Pressing **Enter** in the title input submits the form (same as clicking "Add").
- Pressing **Escape** in any field cancels the form (same as clicking "Cancel").
- On submit:
  - If title is empty or whitespace-only, do **not** create the card. Show no error — just keep the form open.
  - Otherwise, create a new card in that column, clear the form, and hide it (re-show the "+ Add Card" button).
- After adding a card, the column should scroll to show the new card if the column is scrollable.

### 3.4 Card Display

- Each card renders as a rounded-corner (`8px`) white card with a subtle box shadow.
- Card content:
  - **Title**: displayed in bold. If longer than 60 characters, truncate with ellipsis (`…`).
  - **Description**: displayed below the title in normal weight, muted color. If longer than 120 characters, truncate with ellipsis.
  - If description is empty, do not render the description element at all.
- Card actions (displayed at the bottom of each card):
  - A **"Move to"** dropdown (`<select>`) listing the other two columns (not the current column). Selecting a value immediately moves the card to that column.
  - A **"Delete"** button (styled in red/danger color).

### 3.5 Move Card

- Each card has a `<select>` dropdown labeled with the placeholder option `"Move to…"`.
- The dropdown options are the names of the other two columns (excluding the card's current column).
- When the user selects a column from the dropdown, the card immediately moves to the **bottom** of the target column.
- After moving, the dropdown resets to the placeholder option.

### 3.6 Delete Card

- Clicking the "Delete" button on a card triggers a browser-native `window.confirm()` dialog: `"Delete card \"<card title>\"?"`.
- If the user confirms, the card is removed from its column.
- If the user cancels, nothing happens.

### 3.7 Data Persistence

- The entire board state (all columns and cards) is stored in `localStorage` under the key `"kanban-board"`.
- State is saved to `localStorage` on **every change** (add, move, delete).
- On app load:
  - If `localStorage` has a valid saved state, load it.
  - If `localStorage` is empty or the data is invalid/corrupt, initialize with the three default empty columns.
- Use `JSON.stringify()` / `JSON.parse()` for serialization.

---

## 4. Extension Features

These are optional stretch goals for attendees who finish the MVP early. They are listed in roughly increasing difficulty.

1. **Edit card inline** — Click a card's title or description to toggle into edit mode with input fields. Save on blur or Enter, cancel on Escape.
2. **Card priority** — Each card has a priority level: Low, Medium, High. Display as a colored left border or badge (Low = green, Medium = orange, High = red). Add a priority selector to the add-card form. Default priority: Medium.
3. **Search/filter cards** — Add a search input above the board. As the user types, only cards whose title or description contains the search text are visible. Show match count.
4. **Card labels/tags** — Add up to 3 color-coded labels per card (e.g., "Bug", "Feature", "Urgent"). Display as small colored pills on the card.
5. **Due dates** — Add an optional due date to cards. Display the date on the card. If the due date is in the past, highlight the card with a red border or background tint.
6. **Drag-and-drop** — Enable moving cards between columns by dragging. Use the HTML5 Drag and Drop API (no library). Show a visual drop indicator when dragging over a column.
7. **Column reordering** — Allow dragging columns to rearrange their horizontal order.
8. **Multiple boards** — Add a board selector/switcher above the board. Users can create new boards with custom names and switch between them. Each board has its own set of columns and cards. Persist all boards in localStorage.

---

## 5. UI/UX Description

### Overall Layout

```
┌──────────────────────────────────────────────────────────┐
│                      Kanban Board                        │  ← App header
├──────────────────────────────────────────────────────────┤
│ ┌─────────────┐ ┌─────────────┐ ┌─────────────┐         │
│ │  To Do (2)  │ │In Progress 1│ │   Done (0)  │         │
│ ├─────────────┤ ├─────────────┤ ├─────────────┤         │
│ │ ┌─────────┐ │ │ ┌─────────┐ │ │             │         │
│ │ │ Card 1  │ │ │ │ Card 3  │ │ │ No cards yet│         │
│ │ └─────────┘ │ │ └─────────┘ │ │             │         │
│ │ ┌─────────┐ │ │             │ │             │         │
│ │ │ Card 2  │ │ │             │ │             │         │
│ │ └─────────┘ │ │             │ │             │         │
│ │             │ │             │ │             │         │
│ │ [+ Add Card]│ │ [+ Add Card]│ │ [+ Add Card]│         │
│ └─────────────┘ └─────────────┘ └─────────────┘         │
└──────────────────────────────────────────────────────────┘
```

### Sizing and Spacing

- **App background**: `#f5f5f5` (light gray).
- **App header**: centered text, `24px` font size, `16px` vertical padding.
- **Board container**: horizontal flexbox with `16px` gap. Centered on the page with `16px` padding on all sides.
- **Column**: `flex: 1 1 0`, `min-width: 280px`, `max-width: 400px`. Background: `#e8e8e8`. Border-radius: `8px`. Column has `8px` internal padding.
- **Column header**: `12px` padding, border-radius `8px 8px 0 0`, bold white text, the background color specified in §3.2.
- **Card**: white background, `12px` padding, `8px` border-radius, `8px` margin-bottom between cards, box-shadow: `0 1px 3px rgba(0, 0, 0, 0.12)`.
- **Card actions row**: flexbox row with space-between alignment, `8px` top margin, small font size.

### Responsive Behavior

- On viewports narrower than `768px`, columns stack vertically (change flex-direction to column).
- No other responsive behavior is required.

### Interactions

| Action | Trigger | Result |
| --- | --- | --- |
| Open add-card form | Click "+ Add Card" button in a column | Form appears inline at bottom of column, replacing the button |
| Submit new card | Click "Add" or press Enter in title input | Card created at bottom of column; form closes |
| Cancel add card | Click "Cancel" or press Escape | Form closes, "+ Add Card" button re-appears |
| Move card | Select target column from dropdown on card | Card moves to bottom of target column; dropdown resets |
| Delete card | Click "Delete" on card → confirm dialog | Card removed from column |

---

## 6. Data Model

```typescript
interface Card {
  id: string;           // crypto.randomUUID()
  title: string;        // 1–100 characters
  description: string;  // 0–500 characters (empty string if none)
  createdAt: string;    // ISO 8601 timestamp from new Date().toISOString()
}

interface Column {
  id: string;           // crypto.randomUUID()
  title: string;        // "To Do" | "In Progress" | "Done"
  color: string;        // hex color for the column header
  cards: Card[];        // ordered list; index 0 = top of column
}

type Board = Column[];  // exactly 3 columns for MVP
```

### Default Board State

```typescript
const DEFAULT_BOARD: Board = [
  { id: crypto.randomUUID(), title: "To Do",        color: "#4a90d9", cards: [] },
  { id: crypto.randomUUID(), title: "In Progress",  color: "#e6a817", cards: [] },
  { id: crypto.randomUUID(), title: "Done",          color: "#2ecc71", cards: [] },
];
```

### localStorage Schema

- **Key**: `"kanban-board"`
- **Value**: `JSON.stringify(board)` where `board` is of type `Board`

---

## 7. Component Structure

```
App
├── Header                    // Renders "Kanban Board" title
└── Board                     // Manages board state, localStorage sync
    ├── Column                // Renders column header, card list, add-card button/form
    │   ├── Card              // Renders a single card with title, description, actions
    │   └── AddCardForm       // Inline form for creating a new card
    ├── Column
    │   ├── Card
    │   └── AddCardForm
    └── Column
        ├── Card
        └── AddCardForm
```

### Component Responsibilities

| Component | Props | State | Notes |
| --- | --- | --- | --- |
| `App` | — | — | Renders Header and Board |
| `Header` | — | — | Static heading |
| `Board` | — | `board: Board` | Owns all board state. Provides `addCard`, `moveCard`, `deleteCard` functions as props to Column. Syncs state to localStorage via `useEffect`. |
| `Column` | `column: Column`, `otherColumns: {id: string, title: string}[]`, `onAddCard`, `onMoveCard`, `onDeleteCard` | `isAddingCard: boolean` | Renders column header with count, card list, and add-card form toggle. |
| `Card` | `card: Card`, `otherColumns: {id: string, title: string}[]`, `onMove`, `onDelete` | — | Renders card content and action controls. |
| `AddCardForm` | `onSubmit: (title: string, description: string) => void`, `onCancel: () => void` | `title: string`, `description: string` | Controlled form with title input, description textarea, Add/Cancel buttons. |

---

## 8. File Structure

```
kanban-board/
├── index.html
├── package.json
├── tsconfig.json
├── tsconfig.app.json
├── tsconfig.node.json
├── vite.config.ts
├── public/
└── src/
    ├── main.tsx              // ReactDOM.createRoot, renders <App />
    ├── App.tsx               // Top-level component
    ├── App.css               // Global and app-level styles
    ├── types.ts              // Card, Column, Board type definitions
    ├── constants.ts          // DEFAULT_BOARD, STORAGE_KEY
    ├── hooks/
    │   └── useLocalStorage.ts  // Custom hook for localStorage-backed state
    ├── components/
    │   ├── Header.tsx
    │   ├── Header.css
    │   ├── Board.tsx
    │   ├── Board.css
    │   ├── Column.tsx
    │   ├── Column.css
    │   ├── Card.tsx
    │   ├── Card.css
    │   ├── AddCardForm.tsx
    │   └── AddCardForm.css
    └── index.css             // CSS reset and base styles (from Vite template)
```

### `useLocalStorage` Hook

```typescript
function useLocalStorage<T>(key: string, initialValue: T): [T, (value: T | ((prev: T) => T)) => void]
```

- On mount: reads `key` from `localStorage`, parses JSON, returns parsed value or `initialValue` if missing/invalid.
- On state change: writes the new value to `localStorage` as JSON.
- Wraps `useState` + `useEffect`.

---

## 9. Acceptance Criteria

Each criterion must pass for the MVP to be considered complete.

1. **App loads** — Running `npm run dev` starts the app with no console errors. The board renders three empty columns.
2. **Columns display correctly** — Each column shows its title, a card count of `(0)`, and a color-coded header matching the specified colors.
3. **Add a card with title only** — Click "+ Add Card" on "To Do", type a title, click "Add". Card appears in "To Do". Count updates to `(1)`.
4. **Add a card with title and description** — Add a card with both fields filled. Both title and description display on the card.
5. **Cannot add empty card** — Open the add-card form, leave title blank, click "Add". No card is created. Form stays open.
6. **Cancel add card** — Open the add-card form, click "Cancel". Form disappears, "+ Add Card" button returns.
7. **Move card** — Create a card in "To Do". Use the dropdown to move it to "In Progress". Card disappears from "To Do" and appears in "In Progress". Counts update.
8. **Delete card with confirm** — Click "Delete" on a card. Confirm dialog appears. Click OK. Card is removed. Count updates.
9. **Delete card with cancel** — Click "Delete" on a card. Confirm dialog appears. Click Cancel. Card remains.
10. **Text truncation** — Add a card with a title longer than 60 characters. Title truncates with ellipsis on the card.
11. **Persistence** — Add several cards, move one, delete one. Refresh the page (`F5`). The board state matches what was there before refresh.
12. **Empty column message** — A column with no cards displays "No cards yet".
13. **Responsive layout** — At viewport width below `768px`, columns stack vertically.
14. **Keyboard shortcuts** — Pressing Enter in the title input submits the form. Pressing Escape in any form field cancels.

---

## 10. Out of Scope

The following are explicitly **not** part of this project:

- Backend / API / database
- User authentication or accounts
- Automated tests (unit, integration, or E2E)
- Drag-and-drop (MVP — listed as extension feature)
- Column add/remove/rename/reorder (MVP)
- Card editing after creation (MVP)
- Animations or transitions
- Dark mode
- Accessibility beyond semantic HTML (no ARIA audit required)
- Production build optimization
- Deployment / hosting
- Any npm packages beyond what `create vite` provides with the `react-ts` template
- CI/CD
- Linting or formatting configuration beyond Vite defaults
