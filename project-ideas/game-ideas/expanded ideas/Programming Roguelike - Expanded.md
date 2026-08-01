# Programming Roguelike - Expanded Design Document

> **Genre:** Bullet Heaven / Auto-Battler / Programming Hybrid  
> **Art Style:** Flexible (Cyberpunk or Techno-Wizard recommended)  
> **Engine:** Godot  
> **Scope:** Medium (Solo Dev Feasible)  
> **Prototype Timeline:** 3-5 weeks  
> **Last Updated:** January 2026

---

## Table of Contents

1. [Executive Summary](#executive-summary)
2. [Market Analysis](#market-analysis)
3. [Core Gameplay Loop](#core-gameplay-loop)
4. [The Programming Layer](#the-programming-layer)
5. [Node System Design](#node-system-design)
6. [Combat & Wave Structure](#combat--wave-structure)
7. [Progression Systems](#progression-systems)
8. [Setting & Aesthetic](#setting--aesthetic)
9. [Prototype MVP](#prototype-mvp)
10. [Full Game Vision](#full-game-vision)
11. [UX Challenges & Solutions](#ux-challenges--solutions)
12. [Risks & Mitigations](#risks--mitigations)
13. [Solo Dev Feasibility](#solo-dev-feasibility)
14. [Open Questions](#open-questions)

---

## Executive Summary

A **bullet heaven** game (Vampire Survivors/Brotato style) where between waves, you program your character's behavior using a **visual node editor**. Instead of passively picking upgrades, you actively construct logic chains: "When I kill an enemy → spawn a projectile toward the nearest enemy." The game plays itself during waves; you play the _meta-game_ of optimizing your automation.

**The Hook:** What if Vampire Survivors let you _program_ your build instead of just picking random upgrades?

**Why This Works:**

-   Vampire Survivors proved "auto-battler + roguelike" is a massive market
-   Programming games (_Zachtronics_, _Factorio_) have dedicated, passionate audiences
-   The intersection is almost untapped
-   "Automate your build" is more accessible than "write code"

**Target Audience:** Players who enjoy _Vampire Survivors_, _Brotato_, _20 Minutes Till Dawn_, and _Factorio_/_Shapez_/_while True: learn()_—people who like optimization and emergent systems.

---

## Market Analysis

### Bullet Heaven Successes (2022-2025)

| Game                     | Why It Works                                   | Lesson for Us                            |
| ------------------------ | ---------------------------------------------- | ---------------------------------------- |
| **Vampire Survivors**    | Simplicity, dopamine loop, build variety       | Minimal input, maximum satisfaction      |
| **Brotato**              | More active, build diversity, weird characters | Active movement matters; variety is king |
| **20 Minutes Till Dawn** | Aiming + shooting, synergies, polish           | "Active" bullet heaven has appeal        |
| **Halls of Torment**     | ARPG depth, meaningful items, darker tone      | More complexity can work if layered      |
| **Soulstone Survivors**  | Spell combos, build crafting                   | Deep synergies create replayability      |
| **Holocure**             | Fan engagement, character diversity            | Unique characters carry content          |

### Programming Game Successes

| Game                    | Why It Works                          | Lesson for Us                       |
| ----------------------- | ------------------------------------- | ----------------------------------- |
| **Factorio/Shapez**     | Optimization loop, scale satisfaction | Building systems is inherently fun  |
| **Zachtronics games**   | Puzzle satisfaction, "ah-ha" moments  | Programming as puzzle, not chore    |
| **while True: learn()** | Accessible, visual, low barrier       | Visual programming > text coding    |
| **Gladiabots**          | AI programming, combat application    | "Program your fighter" works        |
| **Bitburner**           | Idle + coding, persistent progression | Programming as progression mechanic |
| **Automachef**          | Puzzle-based, clear goals             | Constraints drive creativity        |

### The Market Gap

| Existing Game     | What It Does                 | What It's Missing                        |
| ----------------- | ---------------------------- | ---------------------------------------- |
| Vampire Survivors | Pick upgrades, watch chaos   | No customization of _how_ abilities work |
| Brotato           | Pick weapons, active dodging | Still just "pick from 3 options"         |
| Gladiabots        | Program AI fighters          | Not a bullet heaven; no real-time action |
| Zachtronics       | Deep programming puzzles     | Not action-based; niche audience         |

**Our Niche:** Bullet heaven action + programming customization. Best of both worlds.

---

## Core Gameplay Loop

### The Two Phases

```
┌─────────────────────────────────────────────────────────────┐
│                      WAVE PHASE (60-90 sec)                 │
│  • Real-time action                                         │
│  • You control movement only (WASD/stick)                   │
│  • Your programmed logic handles attacks automatically      │
│  • Survive, collect XP/currency                             │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                    PROGRAMMING PHASE (no timer)             │
│  • Wave paused                                              │
│  • Open node editor                                         │
│  • Add/modify/remove logic chains                           │
│  • Choose new nodes from upgrade pool                       │
│  • Confirm and resume                                       │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
                      [Next Wave]
```

### Player Agency During Waves

You control:

-   **Movement** (WASD / left stick)
-   **Dash/dodge** (if unlocked)
-   That's it

Your logic nodes control:

-   When attacks fire
-   What attacks fire
-   What targets they hit
-   What effects trigger on events

**Why limit player control?**

1. Lets you focus on observing your "program" in action
2. Creates separation between "playing" and "programming"
3. Reduces decision fatigue during action
4. Makes good programming feel rewarding ("It works!")

### Session Structure

```
Run Start
├── Choose starting character/loadout
├── Get 3 starting nodes
└── Enter Wave 1

Waves 1-5 (Early Game)
├── Short waves (45-60 sec)
├── Weak enemies
├── 1 upgrade choice per wave
└── Learning your nodes

Wave 5: Elite
├── Tougher enemy with unique pattern
└── Bonus node reward

Waves 6-10 (Mid Game)
├── Longer waves (60-90 sec)
├── More enemy variety
├── Node synergies emerging
└── 1-2 upgrades per wave

Wave 10: Boss
├── Major health pool
├── Unique mechanics
└── Rare node reward + shop

Waves 11-20 (Late Game)
├── High density, high speed
├── Your build is online
└── Testing your optimization

Wave 20: Final Boss
└── Win condition

Run End
├── Score tally
├── Meta-progression unlocks
└── Return to menu
```

---

## The Programming Layer

### What Is a "Program"?

Your program is a set of **logic chains**. Each chain follows this structure:

```
[TRIGGER] ──► [CONDITION (optional)] ──► [ACTION]
```

**Example chains:**

```
[On Kill] ──► [Fire Projectile: Nearest Enemy]
[Every 2 Seconds] ──► [Enemy Count > 5] ──► [AoE Burst]
[On Dash] ──► [Spawn Shield: 1 Second]
[HP Below 50%] ──► [Activate Heal Drone]
```

### Why Visual Nodes?

| Approach         | Pros                          | Cons                       |
| ---------------- | ----------------------------- | -------------------------- |
| Text coding      | Maximum flexibility           | Intimidating, error-prone  |
| Dropdown menus   | Simple                        | Boring, limited expression |
| **Visual nodes** | Intuitive, tactile, game-like | More dev work for editor   |
| Card-based       | Familiar (Slay the Spire)     | Less "programming" feel    |

**Visual nodes** hit the sweet spot: they _feel_ like programming without the syntax barrier. Godot's `GraphEdit` makes this relatively easy to implement.

### The Node Editor

**Layout:**

```
┌─────────────────────────────────────────────────────────────┐
│  [TRIGGERS]          [CONDITIONS]         [ACTIONS]         │
│  ┌─────────┐         ┌───────────┐        ┌──────────┐      │
│  │ On Kill │────────►│ HP > 50%  │───────►│ Fireball │      │
│  └─────────┘         └───────────┘        └──────────┘      │
│                                                             │
│  ┌─────────┐                              ┌──────────┐      │
│  │ Every 3s│─────────────────────────────►│ Shield   │      │
│  └─────────┘                              └──────────┘      │
│                                                             │
│  [Available Nodes]    [Node Inventory]    [Confirm]         │
└─────────────────────────────────────────────────────────────┘
```

**Interactions:**

-   Drag nodes from inventory to canvas
-   Connect nodes by dragging from output to input
-   Right-click to delete/configure
-   Hover for tooltips explaining each node
-   "Confirm" to save and resume wave

---

## Node System Design

### Node Categories

#### Triggers (When does something happen?)

| Node                | Fires When...                          |
| ------------------- | -------------------------------------- |
| **On Kill**         | You kill an enemy                      |
| **On Hit**          | You take damage                        |
| **On Dash**         | You use dash ability                   |
| **Every X Seconds** | Timer (configurable: 1s, 2s, 3s, etc.) |
| **HP Below X%**     | Health drops to threshold              |
| **HP Above X%**     | Health rises above threshold           |
| **On Wave Start**   | New wave begins                        |
| **On Pickup**       | Collect XP/currency                    |
| **Random X%**       | X% chance each frame/tick              |
| **Enemy in Range**  | Enemy enters radius                    |
| **Kill Streak X**   | Kill X enemies without taking damage   |

#### Conditions (Should it actually happen?)

| Node                  | Passes If...                  |
| --------------------- | ----------------------------- |
| **HP > X%**           | Health above threshold        |
| **HP < X%**           | Health below threshold        |
| **Enemy Count > X**   | More than X enemies on screen |
| **Enemy Count < X**   | Fewer than X enemies          |
| **Cooldown Ready**    | Ability off cooldown          |
| **Random X%**         | X% chance to pass             |
| **Has Buff**          | You have specific buff        |
| **Nearest Enemy < X** | Closest enemy within range    |
| **Wave > X**          | Current wave number above X   |

#### Actions (What happens?)

| Node                | Effect                                                                |
| ------------------- | --------------------------------------------------------------------- |
| **Fire Projectile** | Shoot toward target (configurable: nearest, random, cursor direction) |
| **AoE Burst**       | Damage all enemies in radius                                          |
| **Spawn Drone**     | Create orbiting drone that fires                                      |
| **Activate Shield** | Temporary damage immunity/reduction                                   |
| **Dash**            | Quick movement in direction                                           |
| **Heal**            | Restore HP                                                            |
| **Speed Boost**     | Temporary movement speed increase                                     |
| **Magnet Pulse**    | Pull XP/pickups toward you                                            |
| **Spawn Trap**      | Place damaging zone                                                   |
| **Chain Lightning** | Bouncing damage between enemies                                       |
| **Freeze Enemies**  | Slow/stop nearby enemies                                              |
| **Spawn Clone**     | Create temporary attacking clone                                      |

### Node Upgrades

Nodes can be upgraded (via pickups or shop):

| Base Node       | Upgrade Path                                          |
| --------------- | ----------------------------------------------------- |
| Fire Projectile | → Faster projectile → Piercing → Exploding            |
| AoE Burst       | → Larger radius → More damage → Shorter cooldown      |
| On Kill         | → Also triggers on assist → Triggers twice            |
| Every 3 Seconds | → Every 2 Seconds → Every 1 Second                    |
| Spawn Drone     | → +1 Drone → Drones fire faster → Drones orbit faster |

### Node Synergies

The magic happens when nodes combine:

| Combo                                                   | Effect                      | Emergent Behavior        |
| ------------------------------------------------------- | --------------------------- | ------------------------ |
| On Kill → Fire Projectile                               | Kill = more projectiles     | Chain reaction kills     |
| On Hit → Spawn Shield                                   | Getting hit = protection    | Defensive build          |
| Every 1s → Spawn Drone + On Kill → Destroy Oldest Drone | Constant drone cycling      | Drone swarm with refresh |
| HP Below 25% → AoE Burst + Speed Boost                  | Crisis = explosion + escape | Glass cannon comebacks   |
| Kill Streak 5 → Fire Projectile x3                      | Reward aggression           | Snowball momentum        |

### Chain Limits

To prevent infinite loops and balance:

-   Max **5 chains** active at once (expandable via upgrades)
-   Max **3 nodes per chain** (Trigger → Condition → Action)
-   Some actions have **cooldowns** (can't spam infinitely)
-   Some combinations **conflict** (can't have two of same action type)

---

## Combat & Wave Structure

### Enemy Types

| Enemy           | Behavior                      | Counter Strategy              |
| --------------- | ----------------------------- | ----------------------------- |
| **Swarm**       | Weak, appears in groups       | AoE actions, chain effects    |
| **Chaser**      | Follows player, moderate HP   | Kiting, single-target damage  |
| **Shooter**     | Stationary, fires projectiles | Positioning, shields          |
| **Tank**        | Slow, high HP                 | Sustained damage, drones      |
| **Exploder**    | Dies and creates AoE          | Keep distance, ranged attacks |
| **Splitter**    | Dies into 2 smaller enemies   | Prepare for second wave       |
| **Healer**      | Heals nearby enemies          | Priority targeting            |
| **Speed Demon** | Fast, erratic movement        | Prediction, AoE               |

### Wave Composition

| Wave Range | Enemy Mix                    | Density      | Special      |
| ---------- | ---------------------------- | ------------ | ------------ |
| 1-3        | Swarm only                   | Light        | Tutorial     |
| 4-5        | Swarm + Chaser               | Light-Medium | —            |
| 5 (Elite)  | Elite Chaser (high HP, fast) | —            | Bonus reward |
| 6-9        | Mix of basic types           | Medium       | —            |
| 10 (Boss)  | Boss + Swarm adds            | —            | Shop unlock  |
| 11-15      | All types, faster spawns     | Heavy        | —            |
| 16-19      | Dense, overlapping waves     | Very Heavy   | —            |
| 20 (Final) | Final Boss + all types       | —            | Victory      |

### Boss Design

Bosses should test your _program_, not your reflexes:

| Boss                  | Mechanic                          | Node Counter                    |
| --------------------- | --------------------------------- | ------------------------------- |
| **The Swarm Queen**   | Spawns endless small enemies      | AoE chains, kill triggers       |
| **The Charging Bull** | Charges in straight lines         | Dash triggers, speed boosts     |
| **The Shield Bearer** | Invulnerable except from behind   | Drones, multi-directional fire  |
| **The Cloner**        | Creates copies of itself          | Damage over time, chain effects |
| **The Nullifier**     | Disables random nodes temporarily | Redundant chains, adaptability  |

---

## Progression Systems

### In-Run Progression

| Progression Type  | How Obtained           | Effect                          |
| ----------------- | ---------------------- | ------------------------------- |
| **New Nodes**     | Level up, wave rewards | Expand your programming options |
| **Node Upgrades** | Level up, shops        | Make existing nodes stronger    |
| **Chain Slots**   | Rare rewards           | Allow more simultaneous chains  |
| **Base Stats**    | XP thresholds          | More HP, speed, damage          |

### Meta-Progression (Across Runs)

| Unlock Type         | How Unlocked              | Effect                      |
| ------------------- | ------------------------- | --------------------------- |
| **New Node Types**  | Achievements, boss kills  | More programming options    |
| **New Characters**  | Complete runs, challenges | Different starting loadouts |
| **Passive Bonuses** | Spend currency            | Permanent stat boosts       |
| **Starting Nodes**  | Unlock progression        | Better early-game options   |
| **Challenge Modes** | Beat the game             | Modifiers for harder runs   |

### Character Differences

If multiple characters exist, they differ in:

-   **Starting nodes** (3-4 pre-selected)
-   **Locked chain slots** (some start with more/fewer)
-   **Passive ability** (unique modifier)
-   **Stat distribution** (HP vs speed vs damage)

---

## Setting & Aesthetic

### Option 1: Cyberpunk Hacker (Recommended)

**Premise:** You're a rogue AI virus infiltrating a corporate mainframe. Enemies are security programs. Nodes are malware modules.

| Element | Cyberpunk Version                    |
| ------- | ------------------------------------ |
| Player  | Glowing geometric shape, neon trails |
| Enemies | Security bots, firewalls, trackers   |
| Nodes   | "Malware," "exploits," "payloads"    |
| Setting | Circuit-board arenas, data streams   |
| UI      | Terminal aesthetic, monospace fonts  |

**Why it works:**

-   Programming = hacking is intuitive
-   Neon aesthetics are popular and achievable
-   Strong visual language for "code" and "bugs"
-   Enemies as "security" is clear

**Art approach:** Geometric shapes, glow effects, particle systems. Achievable with shaders and minimal sprite work.

---

### Option 2: Techno-Wizard

**Premise:** You're a wizard whose spells are literally code. Enemies are corrupted magical creatures. Nodes are spell components.

| Element | Techno-Wizard Version                      |
| ------- | ------------------------------------------ |
| Player  | Robed figure with glowing runes            |
| Enemies | Golems, elementals, corrupted spirits      |
| Nodes   | "Glyphs," "sigils," "bindings"             |
| Setting | Arcane laboratories, magical circuits      |
| UI      | Ancient tome aesthetic with modern touches |

**Why it works:**

-   "Magic as programming" is a fun concept
-   Fantasy is more accessible than pure cyberpunk
-   Unique visual identity (tech + magic blend)
-   Nodes as "runes" feels tactile

**Art approach:** Pixel art with magical effects, rune symbols, particle magic.

---

### Option 3: Factory Bot

**Premise:** You're a malfunctioning factory robot. Enemies are quality control bots. Nodes are factory parts you bolt onto yourself.

| Element | Factory Version                   |
| ------- | --------------------------------- |
| Player  | Modular robot                     |
| Enemies | QC drones, crushers, scanners     |
| Nodes   | "Attachments," "mods," "firmware" |
| Setting | Factory floors, conveyor belts    |
| UI      | Industrial, warning signs, metal  |

**Why it works:**

-   Appeals to _Factorio_ audience directly
-   "Building yourself" is satisfying
-   Industrial aesthetic is underused
-   Clear modular theming

---

### Recommendation

**For prototype:** Cyberpunk (easiest with shaders/particles)  
**For full game:** Either Cyberpunk or Techno-Wizard based on art skills and market testing

---

## Prototype MVP

### Goal

Prove two things:

1. **The node editor is usable** (not annoying or confusing)
2. **Programming your build is fun** (not just "pick the best nodes")

### Scope

| Feature                            | Included | Excluded          |
| ---------------------------------- | -------- | ----------------- |
| Player movement                    | ✅       |                   |
| Basic shooting (auto-fire default) | ✅       |                   |
| Node editor (drag-and-drop)        | ✅       |                   |
| 5 trigger nodes                    | ✅       |                   |
| 3 condition nodes                  | ✅       |                   |
| 5 action nodes                     | ✅       |                   |
| 3 waves                            | ✅       |                   |
| 2 enemy types                      | ✅       |                   |
| Wave transition with editing phase | ✅       |                   |
| Placeholder art (shapes/colors)    | ✅       |                   |
| Meta-progression                   |          | ❌                |
| Multiple characters                |          | ❌                |
| Bosses                             |          | ❌                |
| Polish/juice                       |          | ❌                |
| Audio                              |          | ❌ (basic SFX ok) |

### Prototype Nodes

**Triggers:**

1. On Kill
2. Every 2 Seconds
3. On Hit
4. HP Below 50%
5. On Wave Start

**Conditions:**

1. Enemy Count > 3
2. HP Above 50%
3. Random 50%

**Actions:**

1. Fire Projectile
2. AoE Burst
3. Spawn Shield
4. Speed Boost
5. Spawn Drone

### Success Criteria

The prototype succeeds if:

1. **Players understand the editor within 1 minute**
2. **Players create at least 2 different chains**
3. **Players say "oh cool, that worked!"** when their logic executes
4. **Players want to try different combinations**
5. **No one says "why don't I just pick upgrades normally?"**

### Godot Implementation Notes

#### Node Editor

-   Use `GraphEdit` + `GraphNode` (built-in Godot nodes)
-   Each node type is a scene inheriting `GraphNode`
-   Connections stored in a Dictionary: `{trigger: {condition: action}}`
-   Validate connections (only trigger → condition or trigger → action)

#### Logic Execution

-   Each trigger has a signal or poll condition
-   When trigger fires, check conditions, then execute actions
-   Use a central `LogicController` that iterates through active chains

#### Waves

-   `Timer` for wave duration
-   Spawn enemies via `spawn_points` array
-   Between waves: pause physics, show editor, resume on confirm

---

## Full Game Vision

### Content Scope

| Content Type    | Amount        |
| --------------- | ------------- |
| Trigger nodes   | 15-20         |
| Condition nodes | 10-15         |
| Action nodes    | 20-25         |
| Node upgrades   | 3-5 per node  |
| Characters      | 4-6           |
| Enemy types     | 12-15         |
| Bosses          | 5-6           |
| Waves per run   | 20-25         |
| Run length      | 20-30 minutes |
| Unlock time     | 15-25 hours   |

### Optional Features

| Feature                                | Value Add | Effort |
| -------------------------------------- | --------- | ------ |
| Build sharing (export codes)           | High      | Low    |
| Daily seeded runs                      | High      | Low    |
| Endless mode                           | Medium    | Low    |
| Challenge modifiers                    | Medium    | Low    |
| "Showcase" mode (watch optimal builds) | Medium    | Medium |

---

## UX Challenges & Solutions

### Challenge: "Programming is Intimidating"

**Solutions:**

-   Call it "automation" or "build crafting," not "programming"
-   Start with pre-built chains as examples
-   Offer templates: "Aggressive," "Defensive," "Balanced"
-   Tooltips explain everything in plain language
-   No text syntax—everything is visual

### Challenge: "Node Editor is Clunky"

**Solutions:**

-   Keep the editor minimal (no zoom, no complex layouts)
-   Big click targets for mobile-friendliness
-   Undo button always available
-   "Reset to last wave" option
-   Keyboard shortcuts for power users

### Challenge: "Optimal Builds Are Found Quickly"

**Solutions:**

-   Randomize node offerings each run (like Slay the Spire cards)
-   Synergy bonuses encourage experimentation
-   Enemy variety punishes one-dimensional builds
-   New nodes unlocked over time keep meta shifting

### Challenge: "Too Much Downtime Between Waves"

**Solutions:**

-   Keep editing phase optional (can skip if happy with build)
-   Quick-pick upgrade option (skip editor entirely)
-   Show preview of next wave to encourage quick edits
-   Timer optional for challenge modes

### Challenge: "Logic Conflicts or Infinite Loops"

**Solutions:**

-   Global cooldown on all actions (0.1s minimum)
-   Max one action per trigger per frame
-   Clear error messages: "This chain can't connect"
-   Sanity limits on spawnable entities

---

## Risks & Mitigations

| Risk                         | Likelihood | Impact   | Mitigation                                              |
| ---------------------------- | ---------- | -------- | ------------------------------------------------------- |
| Node editor is annoying      | High       | Critical | Iterate on UX endlessly; test with non-programmers      |
| "Programming" scares casuals | High       | High     | Marketing as "automate your build"; no code terminology |
| Balance nightmare            | High       | Medium   | Embrace chaos (Vampire Survivors is unbalanced too)     |
| Complexity creep             | Medium     | High     | Start with 13 nodes, add slowly                         |
| Performance (many entities)  | Medium     | Medium   | Object pooling, spatial partitioning                    |
| Feels like homework          | Medium     | High     | Juice the feedback; make chains feel powerful           |
| Slay the Spire comparisons   | Low        | Medium   | Focus on action + programming combo; own the niche      |

---

## Solo Dev Feasibility

### Why This Is Achievable

| Factor              | Assessment                                 |
| ------------------- | ------------------------------------------ |
| **Core mechanic**   | Godot's GraphEdit does heavy lifting       |
| **Art style**       | Geometric/neon is shader-friendly          |
| **Content scaling** | Nodes are data-driven; easy to add more    |
| **Scope**           | 20-minute runs with 15 node types is tight |
| **Reference games** | Vampire Survivors was made by one person   |

### Recommended Timeline

| Phase              | Duration        | Focus                       |
| ------------------ | --------------- | --------------------------- |
| Prototype          | 3-5 weeks       | Node editor + basic loop    |
| Playtest & iterate | 2-3 weeks       | UX refinement               |
| Content pass       | 2-3 months      | All nodes, enemies, bosses  |
| Polish & meta      | 1-2 months      | Progression, juice, balance |
| **Total**          | **6-12 months** |                             |

### Key Technical Risks

| Risk                          | Mitigation                         |
| ----------------------------- | ---------------------------------- |
| GraphEdit too limited         | Build custom node editor if needed |
| Performance with many bullets | Object pooling, ECS-like patterns  |
| Save/load logic graphs        | Serialize to JSON, test thoroughly |

---

## Open Questions

### Core Gameplay

-   Should there be a "default" auto-attack, or only programmed actions?
-   How many chains are too many? 5? 10?
-   Should nodes have cooldowns, or fire every time trigger hits?

### Node Design

-   Should some nodes be "rare" (hard to find)?
-   Can nodes be sold/discarded, or are they permanent?
-   Should there be "cursed" nodes with downsides?

### Presentation

-   How do we visualize active chains during combat?
-   Should there be a "logic cam" that highlights what triggered?
-   How do we make the editor feel like part of the game, not a chore?

### Progression

-   How much meta-progression is right? (Risk: trivializing early game)
-   Should characters have locked nodes, or all nodes for everyone?
-   Is there a "win" condition, or infinite scaling?

### Business

-   Is this a $5 game or $15 game?
-   Is mobile viable? (Touch-based node editing?)
-   Demo: first 5 waves, or limited node set?

---

## Competitor Differentiation

| Competitor           | What They Do                 | How We're Different                         |
| -------------------- | ---------------------------- | ------------------------------------------- |
| Vampire Survivors    | Pick upgrades from 3 options | You BUILD your logic, not pick from presets |
| Brotato              | Same, with active aiming     | Same differentiation; we're passive aiming  |
| Gladiabots           | Program AI robots            | We're real-time action, not turn-based      |
| Slay the Spire       | Deckbuilding decisions       | We're bullet heaven, not card battles       |
| 20 Minutes Till Dawn | Active shooting              | We're automation-focused                    |

**Our unique value:** The only bullet heaven where you program your playstyle.

---

## References & Inspiration

### Games to Play

-   _Vampire Survivors_ (genre foundation)
-   _Brotato_ (variety and pacing)
-   _Gladiabots_ (programming combat AI)
-   _while True: learn()_ (accessible visual programming)
-   _Shapez_ (optimization satisfaction)
-   _Soulstone Survivors_ (deeper synergies)

### Godot Resources

-   GraphEdit documentation
-   Object pooling tutorials
-   Bullet hell patterns (GitHub repos)

### Design Talks

-   "Vampire Survivors Postmortem" (poncle, GDC if available)
-   "Designing Emergent Systems" (various)
-   "Making Automation Fun" (Factorio devs)

---

## Quick Reference: Core Loop

```
┌─────────────────────────────┐
│         START RUN           │
│  Select character/loadout   │
│  Get 3 starting nodes       │
└─────────────┬───────────────┘
              │
              ▼
┌─────────────────────────────┐
│        WAVE PHASE           │
│  Move with WASD             │
│  Logic executes auto        │◄───────┐
│  Survive 60-90 seconds      │        │
└─────────────┬───────────────┘        │
              │                        │
              ▼                        │
┌─────────────────────────────┐        │
│     PROGRAMMING PHASE       │        │
│  Open node editor           │        │
│  Add/modify chains          │        │
│  Choose new nodes           │        │
│  Confirm to continue        │        │
└─────────────┬───────────────┘        │
              │                        │
              ▼                        │
         Next Wave ────────────────────┘
              │
              ▼ (after final boss)
┌─────────────────────────────┐
│          RUN END            │
│  Score, unlocks, meta       │
│  Return to menu             │
└─────────────────────────────┘
```

---

_End of Document_
