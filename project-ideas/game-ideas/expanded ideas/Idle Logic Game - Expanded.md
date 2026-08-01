# Idle Logic Game - Expanded Design Document

## Executive Summary

**Working Title:** _Signal Flow_ (placeholder)

**Core Hook:** An idle/incremental game dressed in the satisfying visual language of logic circuits and IFTTT automation—but without the puzzle-solving pressure. Players build increasingly complex networks of "signal nodes" that generate resources passively. The joy comes from watching your abstract machine hum along, unlocking new node types, and optimizing your setup for exponential growth. Think "Zachtronics aesthetic" meets "Cookie Clicker progression."

**Target Audience:**

-   Idle/incremental game fans who want something visually fresh
-   Players who like the _look_ of programming/automation games but find them stressful
-   Casual gamers who enjoy progression without time pressure
-   Age 16-45, plays during downtime/background

**Elevator Pitch:** "What if IFTTT was a clicker game? Watch your logic circuits generate numbers go up."

---

## Market Analysis

### Comparable Products

| Game                     | What It Does Well                              | Gap/Opportunity                            |
| ------------------------ | ---------------------------------------------- | ------------------------------------------ |
| **Cookie Clicker**       | Addictive progression, prestige systems        | Visually minimal, no spatial reasoning     |
| **Universal Paperclips** | Narrative-driven progression, automation feel  | Text-heavy, no visual machine building     |
| **Factorio**             | Satisfying automation, visual factory building | Active gameplay, not idle; high complexity |
| **Opus Magnum**          | Beautiful machine visualization                | Puzzle game, not idle; solutions required  |
| **Shapez**               | Relaxing factory building                      | Still requires active problem-solving      |
| **Idle Slayer**          | Addictive idle progression                     | Generic fantasy theme, no logic aesthetic  |
| **NGU Idle**             | Deep systems, long progression                 | Overwhelming UI, ugly                      |
| **Spaceplan**            | Clean design, satisfying clicks                | Short, not replayable                      |

### Market Gap Identified

No idle game currently offers:

1. Zachtronics-style visual appeal (circuits, signals, logic nodes)
2. True idle gameplay (no puzzles, just progression)
3. Spatial network building as the upgrade mechanism
4. Abstract-but-themed aesthetic
5. Casual-friendly with optional depth

### Recent Successes in Adjacent Space

-   **Antimatter Dimensions** (ongoing): Deep idle with mathematical theming
-   **Bitburner** (2021): Programming-themed incremental (but requires actual coding)
-   **Cell to Singularity** (2018): Science-themed idle, broad appeal

---

## Core Mechanics/Features

### 1. Core Loop

```
Watch Signals → Earn Resources → Unlock New Nodes → Build Network → Watch Faster → Repeat
```

**Primary Engagement:**

-   Early game: Active clicking speeds things up
-   Mid game: Network generates passively; check in to upgrade
-   Late game: Complex networks, prestiging, deep optimization

**Session Types:**

-   Active: 15-30 min sessions, building and optimizing
-   Passive: Check in every few hours to collect and upgrade
-   Offline: Progress continues (at reduced rate)

### 2. Signal System (Core Visual Metaphor)

Players build a network of **nodes** connected by **wires**. Signals flow through the network, generating resources.

#### Signal Types (Unlocked Progressively)

| Signal      | Visual                 | Base Generation          | Unlock Condition |
| ----------- | ---------------------- | ------------------------ | ---------------- |
| **Pulse**   | Simple blip            | 1 Energy/sec             | Start            |
| **Data**    | Binary stream          | 10 Energy/sec            | 50 total Energy  |
| **Power**   | Thick glow             | Multiplies other signals | 500 Energy       |
| **Logic**   | Branching paths        | Enables conditions       | 2,000 Energy     |
| **Quantum** | Flickering uncertainty | Rare burst yields        | 50,000 Energy    |

#### Visual Design

The network should look like:

-   Stylized circuit boards with glowing traces
-   Signals visibly traveling along wires
-   Node activation with satisfying visual feedback (lights, pulses, effects)
-   Abstract but recognizable logic gate shapes

**Art Direction:** Think neon-on-dark, minimalist-but-lively. Signals should feel like electricity flowing.

### 3. Node Types

Nodes are the buildings of this idle game. They take inputs, transform them, and produce outputs.

#### Generator Nodes (Produce Resources)

| Node            | Cost           | Effect                         | Upgrades                |
| --------------- | -------------- | ------------------------------ | ----------------------- |
| **Emitter**     | Free (starter) | Generates 1 Pulse/sec          | Output rate, auto-click |
| **Amplifier**   | 100 Energy     | Multiplies incoming signal x2  | Higher multiplier       |
| **Harvester**   | 500 Energy     | Converts Pulse to Energy       | Conversion rate         |
| **Core**        | 5,000 Energy   | Passive Energy generation      | Generation rate         |
| **Quantum Tap** | 100,000 Energy | Small chance of massive output | Proc chance             |

#### Logic Nodes (Modify Flow)

| Node           | Cost         | Effect                            | Why Fun           |
| -------------- | ------------ | --------------------------------- | ----------------- |
| **Splitter**   | 200 Energy   | One input → multiple outputs      | Parallelism       |
| **Merger**     | 200 Energy   | Multiple inputs → combined output | Consolidation     |
| **Delay**      | 500 Energy   | Holds signal, releases in burst   | Burst timing      |
| **AND Gate**   | 1,000 Energy | Only outputs if all inputs active | Synergy building  |
| **Threshold**  | 2,000 Energy | Only outputs if input exceeds X   | Gating strategies |
| **Alternator** | 3,000 Energy | Switches between outputs          | Pattern variety   |

#### Special Nodes (Late-Game)

| Node                   | Cost              | Effect                                  |
| ---------------------- | ----------------- | --------------------------------------- |
| **Prestige Converter** | 1M Energy         | Converts Energy to Prestige currency    |
| **Overclocker**        | Prestige currency | Globally speeds all nodes               |
| **Recursion Loop**     | Prestige currency | Output feeds back into input (careful!) |
| **Void Gate**          | Rare drop         | Mystery effects, discovered through use |

### 4. Network Building

The "gameplay" is placing nodes and connecting them with wires.

**Building Interface:**

-   Grid-based placement (or freeform with snap-to)
-   Click to place nodes
-   Drag to connect wires
-   Right-click to remove
-   Signals visibly flow along connections

**No Puzzle Element:**

-   Any valid connection works
-   No "correct" layouts
-   Optimization is optional
-   Can't "fail"

**Optimization Depth (Optional):**

-   Shorter wire paths = faster signals
-   Efficient layouts = less visual clutter
-   Synergy chains = multiplier bonuses
-   Min-maxers can optimize; casuals can just build

### 5. Resource Economy

| Resource            | Generation                      | Spent On                          |
| ------------------- | ------------------------------- | --------------------------------- |
| **Energy**          | Primary resource from all nodes | Node purchases, upgrades, unlocks |
| **Data**            | From Data-type signals          | Tech tree upgrades                |
| **Fragments**       | Rare drops, milestones          | Cosmetics, special nodes          |
| **Prestige Points** | From prestiging                 | Permanent multipliers             |

**Scaling:**

-   Exponential costs (standard idle economy)
-   Soft caps that prestige resets
-   Deep progression (weeks to "finish")

### 6. Progression Systems

#### Tech Tree

Spend Data to unlock permanent improvements:

| Branch         | Examples                               |
| -------------- | -------------------------------------- |
| **Efficiency** | +10% Energy generation, -5% node costs |
| **Complexity** | Unlock advanced node types             |
| **Automation** | Auto-upgrade nodes, smart routing      |
| **Aesthetics** | New visual themes, wire colors         |
| **Secrets**    | Hidden nodes, lore fragments           |

#### Milestones

Achievements that grant permanent bonuses:

| Milestone     | Requirement                       | Reward                    |
| ------------- | --------------------------------- | ------------------------- |
| _First Spark_ | Generate 100 Energy               | +1 starting Emitter       |
| _Networker_   | Place 50 nodes                    | Unlock Splitter           |
| _Power Surge_ | Generate 1M Energy in one session | +10% global multiplier    |
| _Architect_   | Build 200-node network            | Cosmetic: Blueprint theme |
| _Singularity_ | Reach prestige 10                 | ???                       |

#### Prestige System

**"Reset to go faster" mechanic:**

1. Reach threshold (e.g., 1M lifetime Energy)
2. Choose to Prestige (reset Energy, Data, network)
3. Gain Prestige Points based on progress
4. Spend PP on permanent bonuses
5. Start over, but stronger

**Prestige Upgrades:**

-   Starting Energy bonus
-   Unlock new node types
-   Global speed multiplier
-   Offline progress rate
-   Node discount

### 7. Idle & Offline Systems

| System                 | Description                                                 |
| ---------------------- | ----------------------------------------------------------- |
| **Passive Generation** | Network runs while app is open but not interacted with      |
| **Offline Progress**   | When app is closed, time passes at reduced rate (25-50%)    |
| **Catch-Up Burst**     | Returning after long absence grants bonus collection        |
| **Active Bonuses**     | Clicking, building, or watching gives temporary speed boost |

**No Energy/Stamina Gates:**

-   No "wait or pay" mechanics
-   Premium is cosmetic only
-   Respect player time

### 8. Visual & Audio

**Visual Identity:**

-   Dark background (near-black or deep blue)
-   Neon-colored signals (cyan, magenta, gold, green)
-   Glowing wires with signal travel animation
-   Nodes with satisfying activation pulses
-   Particle effects on generation
-   Zoom levels (see whole network or focus on section)

**Themes (Unlockable):**

-   Classic Circuit (default)
-   Synthwave (pink/purple, retro)
-   Nature (organic veins, green/brown)
-   Minimal (white on black, stark)
-   Corrupted (glitchy, red)

**Audio:**

-   Ambient electronic hum
-   Soft blips when signals fire
-   Satisfying "click" on node placement
-   Milestone fanfares
-   Optional: music that reacts to network activity

---

## Prototype MVP

### Minimum Viable Prototype Scope

**Included:**

-   Grid-based canvas for node placement
-   5 node types (Emitter, Amplifier, Harvester, Splitter, Merger)
-   Wire connections with visible signal flow
-   Energy as single resource
-   10-15 upgrades for nodes
-   5 milestones
-   Basic prestige (reset for multiplier)
-   Offline progress (simple)
-   Core visual style (dark + neon)

**Excluded from MVP:**

-   Multiple signal types
-   Tech tree
-   Cosmetic themes
-   Deep prestige options
-   Audio (or placeholder only)
-   Mobile optimization

### Development Milestones

| Milestone                   | Description                                | Est. Time |
| --------------------------- | ------------------------------------------ | --------- |
| **M1: Grid & Nodes**        | Place nodes on grid, basic visuals         | 1-2 weeks |
| **M2: Wires & Signals**     | Connect nodes, signals animate along wires | 2 weeks   |
| **M3: Resource Generation** | Energy flows, numbers go up                | 1 week    |
| **M4: Node Variety**        | Add 5 node types with distinct behaviors   | 2 weeks   |
| **M5: Upgrades**            | Spend Energy to improve nodes              | 1 week    |
| **M6: Milestones**          | Achievements with rewards                  | 1 week    |
| **M7: Prestige**            | Reset mechanic with permanent bonus        | 1-2 weeks |
| **M8: Offline Progress**    | Calculate gains while away                 | 1 week    |
| **M9: Polish Pass**         | Visual juice, UI, balance                  | 2-3 weeks |

**Total MVP Estimate:** 12-16 weeks (solo, part-time)

### Success Criteria

| Metric                       | Target                                    |
| ---------------------------- | ----------------------------------------- |
| Session length               | 10-30 min active sessions feel good       |
| Return motivation            | Players want to check in after closing    |
| "Numbers go up" satisfaction | Testers enjoy watching generation         |
| Network building fun         | Testers place nodes even when not optimal |
| Prestige pull                | Testers willing to reset for progression  |
| Aesthetic reaction           | "This looks cool" from testers            |

---

## Full Vision

If the prototype validates, the full game could include:

### Content Expansion

-   **50+ Node Types** with unique behaviors
-   **5 Signal Types** with distinct mechanics
-   **Deep Tech Tree** with branching paths
-   **100+ Milestones** for long-term goals
-   **10+ Prestige Tiers** with unique unlocks each
-   **Secret/Hidden Nodes** for explorers
-   **Lore System** revealed through progression

### Systems Expansion

-   **Blueprints:** Save and load network designs
-   **Challenges:** Limited-node or time challenges for bonuses
-   **Sandbox Mode:** Infinite resources, experiment freely
-   **Network Sharing:** Share builds with community
-   **Daily Bonuses:** Login rewards without FOMO
-   **Events:** Seasonal themes with limited cosmetics

### Platform Expansion

-   **Mobile Port:** Touch-friendly UI, portrait mode
-   **Steam Version:** Achievements, cloud saves
-   **Web Version:** Play in browser

### Monetization (Ethical)

| Item                | Type                          | Price Point |
| ------------------- | ----------------------------- | ----------- |
| Cosmetic themes     | Permanent                     | $1-3 each   |
| Node skins          | Permanent                     | $1-2 each   |
| Supporter pack      | Permanent bonuses + cosmetics | $5-10       |
| Remove ads (if any) | Permanent                     | $3-5        |

**NOT Included:**

-   Pay-to-skip timers
-   Lootboxes
-   Pay-to-win

---

## Risks & Mitigations

| Risk                          | Likelihood | Impact    | Mitigation                                           |
| ----------------------------- | ---------- | --------- | ---------------------------------------------------- |
| **"Too simple"**              | Medium     | Medium    | Add optional optimization depth, prestige complexity |
| **Progression too fast/slow** | High       | High      | Extensive balancing spreadsheets, playtesting        |
| **Visually boring**           | Medium     | High      | Invest in signal animations, juice, themes           |
| **Idle balance wrong**        | Medium     | Medium    | Study successful idle games' offline rates           |
| **No "one more turn" hook**   | Medium     | High      | Strong milestone spacing, teaser unlocks             |
| **Scope creep**               | Medium     | Medium    | Strict MVP focus, cut aggressively                   |
| **Mobile port complexity**    | Low (MVP)  | Low (MVP) | PC first, mobile later if validates                  |

---

## Feasibility Assessment

### Technical Considerations (Godot + C#)

| System               | Complexity | Notes                        |
| -------------------- | ---------- | ---------------------------- |
| Grid/Node Placement  | Low        | Standard 2D, well-documented |
| Wire Drawing         | Low-Medium | Line2D or custom shader      |
| Signal Animation     | Low-Medium | Tweens along paths           |
| Resource Calculation | Low        | Basic math, runs on timer    |
| Save/Load            | Low        | Serialize grid state         |
| Offline Calculation  | Low-Medium | Calculate delta on return    |
| Performance          | Low        | 2D, limited entities         |
| UI                   | Medium     | Many panels, but standard    |

**Godot Advantages:**

-   GDScript or C# both work well
-   2D rendering is fast and simple
-   Great for iterative UI work
-   Easy export to PC and web

### Art Requirements

| Asset            | Quantity | Approach                                |
| ---------------- | -------- | --------------------------------------- |
| Node sprites     | 20-30    | Simple geometric, can self-create       |
| Wire shader      | 1        | Glowing line, shader tutorial available |
| Particle effects | 10-15    | Built into Godot                        |
| UI elements      | Standard | Theme + controls                        |
| Backgrounds      | 5-10     | Gradient or subtle pattern              |

**Self-Producible:** Yes, with geometric/abstract style

### Realistic Timeline (Solo, Part-Time ~20hr/week)

| Phase                    | Duration        |
| ------------------------ | --------------- |
| Pre-production           | 2-3 weeks       |
| MVP Development          | 12-16 weeks     |
| MVP Testing/Polish       | 3-4 weeks       |
| **MVP Total**            | **~4-6 months** |
| Full Game (if validated) | +6-12 months    |

**Note:** This is the most feasible of the three concepts for a solo developer.

---

## Open Questions

1. **Narrative Layer:** Should there be any story/lore, or pure abstract progression?

2. **Puzzle Mode Option:** Would an optional "challenge" mode with constraints add value, or distract from the idle appeal?

3. **Social Features:** Leaderboards for Energy generated? Network sharing?

4. **Web vs. Desktop:** Launch on web first for accessibility, or desktop for monetization?

5. **Audio Priority:** How important is sound for the "satisfying" feel?

6. **Tutorial Depth:** How much explanation does the logic aesthetic need?

7. **Node Limit:** Should there be a max network size, or unlimited with performance scaling?

8. **Active vs. Idle Balance:** What percentage of progress should require active play?

9. **Prestige Pacing:** How long before first prestige is available? (1 hour? 1 day?)

10. **Seasonal Content:** Worth doing limited-time events, or keep it evergreen?

---

## Comparable Game Analysis: Why They Work

### Cookie Clicker

-   **Hook:** Simple premise, exponential growth
-   **Retention:** Prestige, golden cookies, achievements
-   **Lesson:** Numbers going up IS the fun; don't overthink

### Antimatter Dimensions

-   **Hook:** Mathematical theming, deep systems
-   **Retention:** Many reset tiers, automation unlocks
-   **Lesson:** Hardcore players want DEEP progression

### Opus Magnum

-   **Hook:** Beautiful machine visualization
-   **Retention:** Puzzle solving satisfaction
-   **Lesson:** Visual satisfaction of working machines is powerful

### NGU Idle

-   **Hook:** Parody humor, ridiculous depth
-   **Retention:** Always something new unlocking
-   **Lesson:** Pacing of unlocks is critical

---

## Design Pillars

1. **Satisfying Visuals:** Signals flowing should feel good to watch
2. **Zero Pressure:** No fail states, no time limits, no puzzles
3. **Meaningful Progression:** Unlocks change gameplay, not just numbers
4. **Respect Player Time:** Offline progress works, no predatory mechanics
5. **Optional Depth:** Casuals can enjoy; optimizers can min-max

---

## Next Steps

1. **Paper Prototype:** Spreadsheet economy model; verify progression pacing
2. **Visual Test:** Create one animated signal wire in Godot
3. **Core Loop Prototype:** Place nodes, generate Energy, buy upgrades
4. **Balance Pass:** Test first hour of progression
5. **Juice Pass:** Add particles, sounds, screen shake to generation

---

_Document Version: 1.0_
_Created: January 3, 2026_
