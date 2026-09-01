# Product Requirements Document: Memory Match Card Game

## 1. Project Overview

**Memory Match** is a single-page card-matching game where players flip cards to find matching pairs. It is the hands-on demo project for a 3-hour GitHub Copilot workshop. Attendees will build this app from scratch in approximately 45 minutes using AI-assisted coding, after watching a live demo.

**Target users:** Workshop attendees with intermediate JavaScript/TypeScript and React experience.

**Goals:**

- Fully buildable MVP in ~20 minutes with AI assistance
- Clean, self-contained codebase with zero backend dependencies
- Extension points for attendees who finish the MVP early
- Fun, visually satisfying gameplay that demonstrates real app architecture

---

## 2. Tech Stack

| Layer        | Technology                        |
| ------------ | --------------------------------- |
| Build tool   | Vite (latest stable)              |
| Framework    | React 18+ with functional components and hooks |
| Language     | TypeScript (strict mode)          |
| Styling      | Plain CSS (one or more `.css` files) |
| Persistence  | `localStorage` (high scores, settings) |
| Package mgr  | npm                               |

**Constraints:**

- No CSS framework (no Tailwind, Bootstrap, Material UI, etc.)
- No UI component library
- No backend, API calls, or database
- No testing libraries (out of scope for the workshop)
- Minimal npm dependencies — only what Vite + React scaffolding provides

---

## 3. MVP Features

These features are **required** for the core game to function.

### 3.1 Game Board

- Display a grid of face-down cards.
- Default grid size: 4×4 (16 cards = 8 unique pairs).
- Each card shows a uniform back face when face-down.
- Cards are laid out in a CSS Grid with equal-sized cells.

### 3.2 Card Content

- Each pair is represented by a unique emoji from this default set (8 emojis for 4×4):
  ```
  🐶 🐱 🐸 🦊 🐵 🦁 🐼 🐨
  ```
- On game start, duplicate each emoji to create pairs, then shuffle the full array using the Fisher-Yates algorithm.

### 3.3 Card Flip Mechanic

- Clicking a face-down card flips it face-up, revealing its emoji.
- A maximum of **two** cards may be face-up (unmatched) at any time.
- While two unmatched cards are face-up, **ignore** additional card clicks.
- Clicking an already face-up or matched card does **nothing**.

### 3.4 Match Detection

- After the second card is flipped, compare the two revealed cards:
  - **Match:** Both cards stay face-up permanently. Apply a visual indicator (e.g., green border, slight scale-up, or reduced opacity) so they are visually distinct from unmatched face-up cards.
  - **Mismatch:** After a **1-second delay**, both cards flip back to face-down.

### 3.5 Move Counter

- Display a move counter above or below the board.
- A "move" is defined as **flipping the second card** (i.e., completing one guess attempt).
- The counter starts at `0` and increments by `1` per move.

### 3.6 Timer

- Display an elapsed-time timer (format: `MM:SS`) alongside the move counter.
- The timer **starts on the first card click** of a new game.
- The timer **stops** when all pairs are matched (win state).
- The timer does **not** run before the first click.

### 3.7 Win State

- When all pairs are matched, display a results summary overlay/modal with:
  - "You Win!" heading
  - Total time elapsed (MM:SS)
  - Total moves
  - A "Play Again" button that starts a new game

### 3.8 New Game / Restart

- A "New Game" button is always visible in the header/stats area.
- Clicking it:
  1. Resets the move counter to `0`
  2. Resets and stops the timer
  3. Shuffles and deals a new set of cards
  4. Dismisses the win modal if it is showing

---

## 4. Extension Features

These are **optional** enhancements for attendees who finish the MVP early. They are listed in suggested order of complexity (easiest first).

### 4.1 Flip Animation (CSS)

- Apply a CSS 3D card-flip animation when a card transitions between face-down and face-up.
- Use `transform: rotateY(180deg)` with `perspective` and `backface-visibility: hidden`.
- Animation duration: ~400ms ease-in-out.

### 4.2 Difficulty Selector

- Add a dropdown or button group above the board with options: **Easy (4×4)**, **Hard (6×6)**.
- 4×4 = 8 pairs (16 cards). 6×6 = 18 pairs (36 cards).
- Changing difficulty starts a new game immediately.
- Extended emoji set for 6×6:
  ```
  🐶 🐱 🐸 🦊 🐵 🦁 🐼 🐨 🦄 🐙 🐝 🐢 🦋 🐬 🦉 🐞 🦀 🐳
  ```

### 4.3 Card Themes

- Add a theme selector (dropdown or button group) with at least two themes:
  - **Animals** (default emoji set above)
  - **Food:** `🍕 🍔 🌮 🍣 🍩 🍪 🧁 🍉 🍇 🥑 🌽 🍓 🥐 🍿 🧀 🍫 🍋 🥝`
- Changing theme starts a new game.

### 4.4 High Score Leaderboard

- After a win, prompt the player to enter their name (default: "Player").
- Save top 10 scores to `localStorage` under the key `memoryMatchHighScores`.
- Score ranking: fewer moves is better; ties broken by faster time.
- Display a "High Scores" view accessible from a button in the header.
- Each entry shows: rank, name, moves, time, grid size, date.

### 4.5 Sound Effects Toggle

- Add a mute/unmute button (🔊 / 🔇) in the header.
- Play short sound effects for: card flip, match found, mismatch, game win.
- Use the Web Audio API or short inline `Audio` objects with base64-encoded clips or simple oscillator tones.
- Default state: muted (to avoid surprising workshop attendees).

### 4.6 Two-Player Mode

- Add a "2 Player" toggle in the header.
- Display whose turn it is: "Player 1's Turn" / "Player 2's Turn".
- Each player scores a point for each matched pair they find.
- On a match, the same player goes again; on a mismatch, turn switches.
- On game win, show both players' scores and declare a winner (or tie).

---

## 5. UI/UX Description

### 5.1 Layout

```
┌──────────────────────────────────────────┐
│  🃏 Memory Match          [New Game]     │  ← Header
├──────────────────────────────────────────┤
│  Moves: 0    Time: 00:00                 │  ← Stats Bar
├──────────────────────────────────────────┤
│                                          │
│   ┌────┐ ┌────┐ ┌────┐ ┌────┐           │
│   │ ?? │ │ ?? │ │ ?? │ │ ?? │           │
│   └────┘ └────┘ └────┘ └────┘           │
│   ┌────┐ ┌────┐ ┌────┐ ┌────┐           │  ← Game Board
│   │ ?? │ │ ?? │ │ 🐶 │ │ ?? │           │    (4x4 grid)
│   └────┘ └────┘ └────┘ └────┘           │
│   ┌────┐ ┌────┐ ┌────┐ ┌────┐           │
│   │ ?? │ │ ?? │ │ ?? │ │ ?? │           │
│   └────┘ └────┘ └────┘ └────┘           │
│   ┌────┐ ┌────┐ ┌────┐ ┌────┐           │
│   │ ?? │ │ ?? │ │ ?? │ │ ?? │           │
│   └────┘ └────┘ └────┘ └────┘           │
│                                          │
└──────────────────────────────────────────┘
```

### 5.2 Visual States

#### Card States

| State     | Appearance                                                                                     |
| --------- | ---------------------------------------------------------------------------------------------- |
| Face-down | Solid colored background (e.g., `#4a90d9`), no emoji visible, `cursor: pointer`                |
| Face-up   | White background, emoji centered and large (~2rem), slightly raised shadow                      |
| Matched   | White background with green border (`#4caf50`), emoji visible, `cursor: default`, slight opacity reduction (0.8) |

#### Game States

| State       | What the user sees                                                                     |
| ----------- | -------------------------------------------------------------------------------------- |
| **Start**   | All 16 cards face-down. Moves: 0. Time: 00:00 (not ticking). New Game button visible.  |
| **Playing** | Mix of face-down, face-up, and matched cards. Timer running. Move count updating.       |
| **Checking**| Two unmatched cards face-up. 1-second pause. Clicks disabled.                           |
| **Win**     | All cards matched (green borders). Timer stopped. Results modal overlays the board.      |

#### Results Modal

```
┌─────────────────────────────┐
│                             │
│       🎉 You Win! 🎉       │
│                             │
│     Time:   01:23           │
│     Moves:  14              │
│                             │
│     [ Play Again ]          │
│                             │
└─────────────────────────────┘
```

- Centered overlay with semi-transparent dark backdrop (`rgba(0,0,0,0.5)`).
- Modal has white background, rounded corners, box shadow.
- "Play Again" is a styled button that resets the game and closes the modal.

### 5.3 Responsive Design

- The board should be centered and scale reasonably on screens from 375px to 1440px wide.
- Cards should maintain a 1:1 aspect ratio.
- Use `max-width` on the board container (e.g., `500px` for 4×4) and let cards fill via CSS Grid `1fr` columns.

---

## 6. Data Model

Define these TypeScript types in a `src/types.ts` file.

```typescript
export interface Card {
  id: string;          // Unique identifier (e.g., "card-0", "card-1", ...)
  emoji: string;       // The emoji symbol (e.g., "🐶")
  isFlipped: boolean;  // Currently face-up (either temporarily or matched)
  isMatched: boolean;  // Permanently matched
}

export interface GameState {
  cards: Card[];
  flippedCards: string[];   // IDs of currently flipped (unmatched) cards (0, 1, or 2)
  moves: number;
  timer: number;            // Elapsed seconds
  isRunning: boolean;       // Whether the timer is actively ticking
  isWon: boolean;
  gridSize: number;         // 4 for 4x4, 6 for 6x6
}

// Extension: High Scores
export interface HighScore {
  name: string;
  moves: number;
  time: number;       // Elapsed seconds
  gridSize: number;
  date: string;       // ISO 8601 date string
}

// Extension: Settings
export interface Settings {
  gridSize: number;
  theme: string;          // "animals" | "food"
  soundEnabled: boolean;
}
```

### localStorage Keys

| Key                      | Value Type    | Description                    |
| ------------------------ | ------------- | ------------------------------ |
| `memoryMatchHighScores`  | `HighScore[]` | Top 10 scores, JSON-serialized |
| `memoryMatchSettings`    | `Settings`    | User preferences               |

---

## 7. Component Structure

```
App
├── Header
│   ├── Game title ("🃏 Memory Match")
│   └── NewGameButton
├── StatsBar
│   ├── MoveCounter
│   └── Timer
├── GameBoard
│   └── Card (×16 for 4×4)
└── ResultsModal (conditionally rendered when isWon === true)
```

### Component Responsibilities

| Component        | Responsibility                                                                                  |
| ---------------- | ----------------------------------------------------------------------------------------------- |
| `App`            | Holds game state (via `useState` / `useReducer`). Passes state and handlers down as props.       |
| `Header`         | Displays game title and New Game button. Triggers `onNewGame` callback.                          |
| `StatsBar`       | Displays current move count and formatted timer. Pure display component.                         |
| `GameBoard`      | Renders the CSS Grid of Card components. Passes `onCardClick` handler to each card.              |
| `Card`           | Renders a single card. Shows back face or emoji based on `isFlipped`/`isMatched`. Calls `onCardClick(id)` on click. |
| `ResultsModal`   | Overlay displayed on win. Shows time, moves, and Play Again button.                              |

### State Management

- Use `useState` hooks in `App` for simplicity (no Redux, no Context needed for MVP).
- Core handler: `handleCardClick(cardId: string)` in `App` — this is the main game logic entry point.
- Timer: use `useEffect` with `setInterval` (1-second tick) that runs only when `isRunning` is `true`. Clean up the interval on unmount and when the game is won.

---

## 8. Suggested File Structure

```
memory-match/
├── index.html
├── package.json
├── tsconfig.json
├── vite.config.ts
├── public/
│   └── favicon.ico
└── src/
    ├── main.tsx              # ReactDOM.createRoot entry point
    ├── App.tsx               # Root component, game state, game logic
    ├── App.css               # Global styles, CSS variables, layout
    ├── types.ts              # TypeScript interfaces (Card, GameState, etc.)
    ├── utils.ts              # Shuffle function, emoji sets, timer formatting
    ├── components/
    │   ├── Header.tsx        # Title + New Game button
    │   ├── Header.css
    │   ├── StatsBar.tsx      # Move counter + timer display
    │   ├── StatsBar.css
    │   ├── GameBoard.tsx     # Grid container for cards
    │   ├── GameBoard.css
    │   ├── Card.tsx          # Single card component
    │   ├── Card.css
    │   ├── ResultsModal.tsx  # Win screen overlay
    │   └── ResultsModal.css
    └── hooks/                # (Extension) Custom hooks if needed
        └── useTimer.ts       # (Extension) Extract timer logic
```

---

## 9. Acceptance Criteria

The MVP is complete when **all** of the following are true:

| #  | Criterion                                                                                         | How to verify                                                            |
| -- | ------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------ |
| 1  | `npm run dev` starts the app with no console errors.                                               | Run dev server, open browser, check DevTools console.                    |
| 2  | A 4×4 grid of 16 face-down cards is displayed on load.                                             | Visual inspection.                                                       |
| 3  | Clicking a face-down card flips it face-up, showing an emoji.                                      | Click any card, verify emoji appears.                                    |
| 4  | Clicking a second card completes a move and increments the move counter by 1.                      | Click two cards, verify counter reads `1`.                               |
| 5  | Two matching cards stay face-up with a visible "matched" indicator.                                 | Find and click a matching pair, verify they stay up with green border.   |
| 6  | Two non-matching cards flip back face-down after ~1 second.                                         | Click two non-matching cards, wait, verify they flip back.               |
| 7  | While two unmatched cards are shown (during the 1-second delay), clicking other cards has no effect.| Rapidly click during the delay, verify no extra cards flip.              |
| 8  | Clicking an already face-up or matched card has no effect.                                          | Click a face-up card, verify nothing changes.                            |
| 9  | The timer starts (from 00:00) on the very first card click and ticks every second.                  | Click first card, observe timer starts counting.                         |
| 10 | The timer stops when all pairs are matched.                                                         | Win the game, verify timer freezes.                                      |
| 11 | On winning, a modal displays "You Win!", the final time, and total moves.                           | Win the game, verify modal content.                                      |
| 12 | The "Play Again" button in the modal resets the game (new shuffle, timer reset, counter reset).     | Click Play Again, verify fresh board.                                    |
| 13 | The "New Game" button in the header resets the game at any point during play.                        | Click New Game mid-game, verify fresh board.                             |
| 14 | Cards are shuffled randomly each game (board layout differs between games).                          | Start two new games, compare card positions.                             |
| 15 | The layout is reasonably centered and usable at 1024px and 375px viewport widths.                   | Resize browser, verify no overflow or broken layout.                     |

---

## 10. Out of Scope

The following are **explicitly excluded** from this project:

- **Backend / API** — no server, no database, no network requests
- **Authentication** — no user accounts or login
- **Automated testing** — no unit tests, integration tests, or E2E tests
- **CI/CD** — no build pipeline or deployment configuration
- **Accessibility (a11y)** — nice to have but not required for the workshop MVP
- **Internationalization (i18n)** — English only
- **PWA features** — no service worker, no offline support
- **CSS preprocessors** — no Sass, Less, or CSS-in-JS
- **State management libraries** — no Redux, Zustand, Jotai, etc.
- **Routing** — single page, no React Router
- **Animation libraries** — CSS only (no Framer Motion, React Spring, etc.)
- **Image assets** — emojis only, no external image files
- **Mobile touch gestures** — standard click/tap is sufficient
