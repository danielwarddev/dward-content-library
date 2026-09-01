# Workshop Demo Project Ideas

**Generated:** April 9, 2026
**Updated:** April 9, 2026 — Pivoted to full-stack (React via Vite + Express/Fastify backend) projects with a visible frontend.
**Context:** Brainstorming demo projects for the 3-hour GitHub Copilot workshop. The project is demoed live first, then attendees build it themselves in ~20-30 min. Stack is React (Vite) + Express/Fastify, all TypeScript. Should be completable and showcase Copilot's strengths (Agent mode scaffolding, prompting, instructions, edit/agent workflows).

---

## Evaluation Criteria

A good workshop demo project should:

- **Be completable in 20-30 min** with Copilot assistance
- **Show off Agent mode** — scaffolding, multi-file creation, terminal commands (`npm create vite`, `npm install`, etc.)
- **Have a visible frontend** — something you can see in the browser, not just terminal output
- **Full-stack** — React (Vite) frontend + Express/Fastify backend, all TypeScript
- **Have obvious extension points** — attendees who finish early can keep going
- **Not require external accounts/APIs** — no sign-ups, no API keys, no databases to install
- **Be universally relatable** — domain everyone understands without explanation

---

## The Ideas

### 1. Bookmark Manager

React frontend with a card grid of saved bookmarks (URL, title, tags). Express API stores bookmarks in an in-memory array (or JSON file). Add, delete, filter by tag.

- **Why it works:** Immediately relatable, simple CRUD, looks good fast. Agent mode scaffolds both Vite and Express projects in one shot. Tag filtering shows React state management naturally.
- **Copilot showcase:** Agent scaffolds full-stack → prompt to add tag filtering → Edit mode to improve card layout/styling.
- **Extension points:** Favicon fetching, drag-to-reorder, import/export JSON, dark mode toggle.

### 2. URL Shortener with Dashboard

Express API with `POST /shorten` and `GET /:code` (redirect). React frontend with a form to create short URLs and a dashboard table showing all links with click counts. In-memory storage.

- **Why it works:** Classic demo everyone instantly understands. The frontend gives it a "real app" feel vs. just curling an API. Click tracking adds a data visualization opportunity.
- **Copilot showcase:** Agent builds API + React UI in one pass → prompt to add click count tracking → Edit mode to add a copy-to-clipboard button.
- **Extension points:** QR code generation, expiration dates, bar chart of top links.

### 3. Quiz Game

Express API serves trivia questions from a hardcoded JSON dataset. React frontend presents questions one at a time with multiple-choice buttons, tracks score, and shows results at the end.

- **Why it works:** Interactive and fun — the audience sees something engaging in the browser. Multi-component (API + frontend + game state) is perfect for Agent mode. Everyone gets a different experience depending on how they customize their questions.
- **Copilot showcase:** Agent scaffolds API + game UI → prompt to add a timer per question → Edit mode to add a results summary with correct/incorrect breakdown.
- **Extension points:** Categories/difficulty, leaderboard, animations on correct/wrong answer.

### 4. Expense Tracker

React form for logging expenses (amount, category, date, note). Express API for CRUD operations. Dashboard shows a list of expenses, total by category, and a simple summary. In-memory or JSON file storage.

- **Why it works:** Real-world utility, clear data model, natural filtering/aggregation on the frontend. Agent mode handles the API + React forms + summary view. Good for showing iterative prompting ("now group by category and show totals").
- **Copilot showcase:** Agent builds CRUD API + React forms → prompt for category summary view → Edit mode to add a pie chart with a simple `<canvas>` or CSS-only bar chart.
- **Extension points:** CSV export, date range filtering, budget warnings, persistent storage.

### 5. Pomodoro Timer with Session Log

React-based Pomodoro timer (25/5 min cycles) with start/pause/reset controls. Express API logs completed sessions. Dashboard view shows today's sessions and a weekly summary table.

- **Why it works:** Visually interesting (live countdown in the browser), simple state logic, and the API integration adds realistic full-stack flavor. Attendees leave with something they might actually use.
- **Copilot showcase:** Agent scaffolds timer UI + API → prompt to add session logging → Edit mode to add the weekly summary view.
- **Extension points:** Browser notifications, configurable durations, streak tracking, sound effects.

### 6. Weather Dashboard (Static Data)

Express API serves fake weather data for ~10 cities (hardcoded JSON — no external API needed). React frontend shows a searchable city list, current conditions card, and a 5-day forecast grid.

- **Why it works:** Visually rich output (weather icons, temperature cards, forecast grid). No API keys needed since data is mocked. Great for demonstrating how Agent mode generates both realistic seed data and styled UI components.
- **Copilot showcase:** Agent builds mock API + React dashboard → prompt to add a search/filter → Edit mode to add weather icons and improve card styling.
- **Extension points:** Toggle °F/°C, "favorites" list, responsive layout, animated transitions.

### 7. Kanban Board

React drag-and-drop board with columns (To Do, In Progress, Done). Express API manages cards (title, description, status). Move cards between columns, add/delete cards.

- **Why it works:** Extremely visual and interactive. Everyone knows what a Kanban board is. The drag-and-drop aspect is impressive when Copilot generates it. Multi-component state makes full-stack coordination shine.
- **Copilot showcase:** Agent scaffolds board UI + API → prompt to add drag-and-drop (HTML5 drag API or a library) → Edit mode to add card editing.
- **Extension points:** Card colors/labels, column reordering, persistence, due dates.
- **Risk:** Drag-and-drop can be finicky. Have a fallback plan where cards move via buttons instead.

### 8. Recipe Finder

Express API serves a hardcoded collection of ~15 recipes (title, ingredients, instructions, tags). React frontend with a search bar, ingredient filter, and recipe detail view. Click a recipe card to see full instructions.

- **Why it works:** Relatable domain, nice card-based UI, demonstrates list → detail navigation pattern. Agent mode creates the data, API, and two views. Good for showing how Copilot handles component composition.
- **Copilot showcase:** Agent builds API + recipe list + detail view → prompt to add "filter by ingredient" → Edit mode to improve recipe card layout.
- **Extension points:** Favorites, serving size adjuster, print-friendly view, recipe categories.

### 9. GitHub Profile Viewer

React form takes a GitHub username. Express backend proxies the public GitHub API (`/users/:username` and `/users/:username/repos`) to avoid CORS issues. Frontend displays avatar, bio, and a repo list sorted by stars.

- **Why it works:** Personalized — everyone types in their own username and sees their data. Real API data is always more compelling than fake data. The proxy pattern teaches a legitimate full-stack concept.
- **Copilot showcase:** Agent builds Express proxy + React UI → prompt to add repo sorting/filtering → Edit mode to add a "top languages" summary.
- **Extension points:** Contribution graph mockup, compare two users, repo search.
- **Risk:** GitHub API rate limits (60 req/hr unauthenticated). Fine for a workshop room if you're not all hammering it simultaneously.

### 10. Markdown Note-Taking App

React editor with a textarea on the left and rendered Markdown preview on the right (split pane). Express API saves/loads notes by title. Note list sidebar for navigation.

- **Why it works:** Developers *love* Markdown. Side-by-side preview is visually impressive and immediately functional. Agent mode generates the editor, renderer (using `marked` or similar), and API in one pass. Great for showing instructions ("use marked for Markdown rendering, highlight.js for code blocks").
- **Copilot showcase:** Agent scaffolds editor + preview + API → prompt to add a note list sidebar → Edit mode to add syntax highlighting in code blocks.
- **Extension points:** Auto-save, keyboard shortcuts, export as HTML, tag/search notes.

### 11. Habit Tracker

React grid/calendar view for tracking daily habits (checkboxes). Express API stores habit definitions and completion data. Dashboard shows streaks and completion percentages.

- **Why it works:** Clean visual design, fun to interact with, and the streak/stats logic is interesting. Agent mode builds the grid, API, and stats calculation. Good for showing Copilot generating date logic (which developers notoriously hate writing manually).
- **Copilot showcase:** Agent scaffolds habit grid + API → prompt to add streak calculation → Edit mode to add a stats summary card.
- **Extension points:** Weekly/monthly views, habit categories, motivational messages, data export.

### 12. Movie Watchlist

Express API with hardcoded movie seed data (or user-added entries): title, year, genre, rating, watched/unwatched. React frontend with a filterable list, add/edit form, and watched vs. unwatched tabs.

- **Why it works:** Universally relatable domain. CRUD + filtering + tabs covers the key UI patterns. Agent mode generates seed data, API, and multiple UI components. The "mark as watched" toggle is satisfying to demo.
- **Copilot showcase:** Agent builds API + list/form UI → prompt to add genre filtering → Edit mode to add star rating display.
- **Extension points:** Sort by rating/year, search, responsive grid vs. list toggle, movie poster placeholder images.

---

## Quick Comparison

| #  | Project                  | Visual Wow | Completability | Shows Agent Well | No External Deps |
|----|--------------------------|:----------:|:--------------:|:----------------:|:-----------------:|
| 1  | Bookmark Manager         | ⭐⭐⭐     | ⭐⭐⭐⭐⭐         | ⭐⭐⭐⭐           | ✅                |
| 2  | URL Shortener + Dashboard| ⭐⭐⭐     | ⭐⭐⭐⭐          | ⭐⭐⭐⭐           | ✅                |
| 3  | Quiz Game                | ⭐⭐⭐⭐   | ⭐⭐⭐⭐          | ⭐⭐⭐⭐⭐          | ✅                |
| 4  | Expense Tracker          | ⭐⭐⭐     | ⭐⭐⭐⭐          | ⭐⭐⭐⭐           | ✅                |
| 5  | Pomodoro Timer           | ⭐⭐⭐⭐   | ⭐⭐⭐⭐          | ⭐⭐⭐             | ✅                |
| 6  | Weather Dashboard        | ⭐⭐⭐⭐⭐  | ⭐⭐⭐           | ⭐⭐⭐⭐           | ✅                |
| 7  | Kanban Board             | ⭐⭐⭐⭐⭐  | ⭐⭐⭐           | ⭐⭐⭐⭐⭐          | ✅                |
| 8  | Recipe Finder            | ⭐⭐⭐⭐   | ⭐⭐⭐⭐          | ⭐⭐⭐⭐           | ✅                |
| 9  | GitHub Profile Viewer    | ⭐⭐⭐⭐   | ⭐⭐⭐⭐          | ⭐⭐⭐⭐           | ⚠️ Rate limits    |
| 10 | Markdown Note App        | ⭐⭐⭐⭐⭐  | ⭐⭐⭐           | ⭐⭐⭐⭐⭐          | ✅                |
| 11 | Habit Tracker            | ⭐⭐⭐⭐   | ⭐⭐⭐           | ⭐⭐⭐⭐           | ✅                |
| 12 | Movie Watchlist          | ⭐⭐⭐     | ⭐⭐⭐⭐⭐         | ⭐⭐⭐⭐           | ✅                |

---

## My Top 3 Recommendations

1. **#3 Quiz Game** — Best balance of visual wow, completability, and Agent showcase. The interactive gameplay is engaging to demo live, everyone immediately "gets it," and it naturally uses both frontend state and API calls. Easy to customize with your own questions.

2. **#10 Markdown Note App** — Developer audience will love this. The split-pane editor/preview is visually impressive and Copilot generating the Markdown rendering pipeline is a great Agent mode moment. Slightly more ambitious but the core is very achievable.

3. **#12 Movie Watchlist** — Safest choice. Straightforward CRUD that's easy to complete in the time window, relatable domain, and the filtering/tabs demonstrate enough React patterns to be interesting. Low risk of anyone getting stuck.

**Honorable mention:** **#7 Kanban Board** has the highest wow factor but drag-and-drop adds risk. Great if you test it beforehand and have a button-based fallback.

---

## Notes

- All projects use React (Vite) + Express, all TypeScript, no database.
- For the live demo, you'd `npm create vite@latest` the frontend and scaffold the Express server with Agent mode in ~10 min, then attendees replicate and extend.
- Consider having a starter monorepo template with `client/` and `server/` directories, both with `package.json` and `tsconfig.json` pre-configured, so attendees don't burn time on Vite/Express setup.
- Seed data (quiz questions, recipes, movies, etc.) is important — Agent mode generating realistic seed data is itself a good demo moment.
