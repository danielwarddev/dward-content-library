# Workshop Demo Activities Per App

**Generated:** April 11, 2026
**Context:** Ideas for what to do with each of the three candidate demo apps during the workshop. The app is pre-built and working. Activities fall into three categories: exploring/explaining the codebase, adding a feature, and changing the design. Each activity is mapped to the Copilot feature it showcases.

---

## Memory Match Game

### Exploring / Explaining the Codebase

| Activity | Copilot Feature | How It Works |
|---|---|---|
| "Explain this game state machine" | Chat (Ask) | Select the game logic hook/component, ask Copilot to explain the state transitions (idle → playing → matched → won) |
| "What happens when I click a card?" | Chat (Ask) | Trace the click handler through flip logic, match checking, and mismatch delay — good for showing Copilot following cross-component data flow |
| "How does the shuffle algorithm work?" | CLI (`gh copilot explain`) | Pipe the shuffle function to the CLI and have it explain the Fisher-Yates algo. Good CLI demo moment. |
| "Find all the places game state resets" | Agent mode | Ask agent to find every code path that resets the board — shows how agent searches across files |
| "Review this codebase for bugs" | Code review (local) | Trigger Copilot code review on the project — might catch edge cases like double-clicking the same card |

### Adding a Feature

| Feature | Copilot Feature | Why It's Good |
|---|---|---|
| **Difficulty selector** (4x4, 6x6) | Agent mode | Simple but touches grid rendering, card generation, and state — shows agent coordinating multi-file changes |
| **Move counter + best score** | Chat → Edit | Ask chat how to implement it, then have agent add it. Best score uses localStorage — quick win. |
| **Card flip animation** (CSS 3D transform) | Vision | Show Copilot a GIF or screenshot of a card flip animation, ask "make my cards flip like this" |
| **Sound effects toggle** | Skill (`.prompt.md`) | Create a "add-audio-feature" skill that describes the pattern for adding toggle-able sound effects to any component |
| **Two-player turn mode** | Agent mode (autopilot) | Bigger feature — let autopilot mode run and narrate as it adds turn tracking, separate scores, turn indicator |
| **Confetti on win** | Chat one-shot | "Add a confetti animation when the player wins" — satisfying quick demo, probably uses canvas-confetti or CSS |

### Changing the Design

| Change | Copilot Feature | Why It's Good |
|---|---|---|
| **Dark mode toggle** | Agent mode | Touches every component's styles — shows agent doing a sweeping style change across the project |
| **Switch card theme** (emojis → colors → images) | Instructions | Add to `copilot-instructions.md`: "Card themes are configurable via a ThemeContext. When adding new themes, follow the existing pattern." Then prompt for a new theme. |
| **Redesign from a mockup** | Vision | Paste a screenshot of a polished memory game UI into chat: "Make my app look like this" |
| **Mobile-responsive layout** | Agent mode | "Make the game board responsive — 2 columns on mobile, 4 on desktop" — shows agent editing CSS across components |
| **Neumorphic / glassmorphism style** | Chat | "Restyle the cards with a glassmorphism aesthetic" — visual wow factor, purely CSS |

---

## Kanban Board

### Exploring / Explaining the Codebase

| Activity | Copilot Feature | How It Works |
|---|---|---|
| "Walk me through the data model" | Chat (Ask) | Select the TypeScript types, ask Copilot to explain the Board → Column → Card relationship |
| "How does moving a card between columns work?" | Chat (Ask) | Trace the move handler — shows Copilot explaining state update logic across components |
| "How is localStorage sync working?" | CLI (`gh copilot explain`) | Pipe the useLocalStorage hook to CLI — good for explaining custom hooks |
| "What would break if I deleted this component?" | Agent mode | Ask agent to analyze the dependency chain of a component — shows codebase understanding |
| "Review for accessibility issues" | Code review (local) | Trigger code review with an a11y focus — might catch missing ARIA labels, keyboard navigation gaps |

### Adding a Feature

| Feature | Copilot Feature | Why It's Good |
|---|---|---|
| **Drag-and-drop** | Agent mode (autopilot) | The marquee upgrade — let autopilot add HTML5 drag-and-drop or a library. Narrate as it works through the complexity. Most impressive demo. |
| **Card labels/tags** | Agent mode | Adds a data model change, UI chips, and filtering — multi-file coordination |
| **Due dates with overdue highlighting** | Skill (`.prompt.md`) | Create a "add-date-field" skill: "When adding a date field to a data model, include: the type change, a date picker input, relative time display, and conditional styling for overdue." Reusable pattern. |
| **Search/filter across columns** | Chat → Edit | Ask chat for the approach, then agent implements it — shows the ask-then-build workflow |
| **Inline card editing** | Agent mode | Click a card title to edit it in place — touches event handling, conditional rendering, and state |
| **WIP limit per column** | Chat one-shot | "Add a WIP limit of 3 to the In Progress column — show a warning when exceeded" — quick, practical |

### Changing the Design

| Change | Copilot Feature | Why It's Good |
|---|---|---|
| **Sticky-note aesthetic** | Vision | Show a photo of a physical Kanban board with Post-it notes: "Make the cards look like this" |
| **Dark mode** | Agent mode | Classic cross-cutting style change |
| **Column color customization** | Instructions | Add instruction: "Column colors are defined in a COLUMN_THEMES constant. When changing colors, update only the theme constant, never inline styles." Then prompt: "Make the columns use a pastel color scheme." |
| **Compact vs. expanded card view toggle** | Agent mode | Add a toggle between showing just title vs. title + description + metadata — shows conditional rendering |
| **Redesign from a Trello screenshot** | Vision | Paste a Trello board screenshot: "Make my board look like this" — great vision demo |

---

## Retro Board

### Exploring / Explaining the Codebase

| Activity | Copilot Feature | How It Works |
|---|---|---|
| "How does the voting system work?" | Chat (Ask) | Explain the vote handler, sort-by-votes logic, and how state updates propagate to the UI |
| "Why are the sticky notes rotated differently?" | Chat (Ask) | Explain the deterministic rotation from note ID — clever implementation detail worth highlighting |
| "Explain the localStorage pattern" | CLI (`gh copilot explain`) | Pipe the storage utility to CLI — consistent with the Kanban demo if you use that too |
| "What's the component hierarchy?" | Agent mode | "Draw me an ASCII diagram of the component tree and props flow" — shows agent analyzing the architecture |
| "Review for XSS vulnerabilities" | Code review (local) | User-input text rendered to DOM — good security-focused code review demo |

### Adding a Feature

| Feature | Copilot Feature | Why It's Good |
|---|---|---|
| **Timer for retro phases** | Agent mode | Add a configurable countdown timer (5 min brainstorm, 5 min vote) — touches new component, state management, and UI |
| **Export as Markdown** | Chat one-shot | "Export the retro board as Markdown with columns as headers and notes as bullet points sorted by votes" — quick, practical, satisfying output |
| **Emoji reactions** (beyond upvote) | Skill (`.prompt.md`) | Create a "reaction-system" skill that describes: the data model extension, emoji picker component, and display pattern. Apply the skill to add 👍👎🔥🤔 reactions. |
| **Group/cluster similar notes** | Agent mode (autopilot) | Select multiple notes → merge into a group with a summary title. More complex feature, good autopilot demo. |
| **Custom column names** | Agent mode | Edit column headers inline — similar to Kanban inline editing but simpler scope |
| **Anonymous mode toggle** | Chat → Edit | Ask "how would I add an anonymous mode?" then have agent implement it — shows planning before building |

### Changing the Design

| Change | Copilot Feature | Why It's Good |
|---|---|---|
| **Real sticky-note look** | Vision | Paste a photo of actual Post-it notes on a whiteboard: "Make the notes look like this" — most natural vision demo of all three apps |
| **Dark mode with neon sticky notes** | Agent mode | Dark background + bright colored notes — visually striking and fun |
| **Redesign from EasyRetro screenshot** | Vision | Paste a screenshot of a polished retro tool: "Match this design" |
| **Switch font to handwriting style** | Instructions | Add instruction: "This app uses a handwriting font aesthetic. All text should use the Patrick Hand font family. Never use system fonts." Then prompt for a layout change and verify it respects the instruction. |
| **Add a board title/header area** | Agent mode | "Add a header with the retro title, date, and a team name field" — simple but makes it feel more complete |

---

## Cross-App Feature Ideas (Work with Any of the Three)

These activities showcase Copilot features regardless of which app you pick:

| Activity | Copilot Feature | Description |
|---|---|---|
| **Create copilot-instructions.md** | Custom instructions | Add project-specific guidelines: coding style, preferred patterns, naming conventions. Then show how subsequent prompts follow the rules. |
| **Create a `.prompt.md` skill** | Skills | Build a reusable prompt template for a common pattern (e.g., "add a new React component with tests and styles") |
| **Create an `.agent.md` custom agent** | Custom agents | Create a "designer" agent focused on CSS/UI changes, or a "reviewer" agent that checks code quality |
| **Wire up an MCP server** | MCP | Add Context7 for up-to-date React docs, or Playwright MCP for E2E testing the running app |
| **Paste a UI mockup** | Vision | Works with any app — screenshot a polished version of the same type of app and ask Copilot to match it |
| **Add a hook for auto-formatting** | Hooks | Set up a hook that runs Prettier after every file edit — practical across all three apps |
| **Debug with rubber duck** | CLI (`gh copilot`) | Hit a bug during development, use `gh copilot` to reason through it in the terminal |
| **Request code review** | Code review (local) | Trigger Copilot review after making changes — works with any codebase |
| **"Explain this" on unfamiliar code** | CLI (`gh copilot explain`) | Works on any file — good for attendees exploring each other's code too |

---

## Which App Best Showcases Which Feature?

| Copilot Feature | Best App | Why |
|---|---|---|
| **Vision** | Retro Board | Real-world sticky note photos are the most natural "make it look like this" prompt |
| **Agent mode (big feature)** | Kanban Board | Drag-and-drop is a complex multi-file change that shows agent at its best |
| **Autopilot mode** | Memory Match | Scaffolding the game from scratch in autopilot is the most visually dramatic |
| **Skills** | Retro Board | Emoji reaction system is a clean, reusable pattern to templatize |
| **Custom instructions** | Kanban Board | More structured codebase benefits most from style/pattern enforcement |
| **MCP** | All equal | MCP demos (Context7, Playwright) work the same regardless of app |
| **Hooks** | All equal | Auto-format/lint works identically everywhere |
| **CLI rubber duck** | Memory Match | Game logic bugs (double-flip, match detection) are fun to debug conversationally |
| **Code review** | Retro Board | User-input rendering makes security review most interesting |

---

## Notes

- The "exploring the codebase" activities work best at the START of the workshop, right after showing the working app — they double as onboarding attendees to the code.
- "Adding a feature" activities map well to the hands-on lab time.
- "Changing the design" activities are great for the Part 2 challenge menu — they're visual, self-contained, and showcase vision/instructions.
- For the live demo (Block 3), you'd pick ONE feature addition + ONE design change. Save the rest for attendees to choose from.
