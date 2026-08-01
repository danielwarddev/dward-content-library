# Stealth Puzzle Bomber - Expanded Design Document

> **Last Updated:** January 2026  
> **Status:** Concept Expansion

---

## Executive Summary

**Core Hook:** A top-down stealth puzzle game where you infiltrate buildings, plant bombs, and escape—but the rules change on the way out. Guards are now alert, patrol routes shift, and time is ticking. It's Hotline Miami meets The Spy Who Loved Me, wrapped in a comedic spy thriller package.

**Target Audience:**

-   Fans of puzzle games with action elements (Hitman GO, Heat Signature)
-   Players who enjoy stealth games but want tighter, replayable levels (Hotline Miami, Monaco)
-   Speedrunners looking for tight mechanical mastery
-   Comedy game enthusiasts (Untitled Goose Game, Jazzpunk)

**Elevator Pitch:** "Plant the bomb. Get out alive. Try not to knock over the plant on your way out."

---

## Market Analysis

### Comparable Products

| Game               | Strengths                                       | Weaknesses                             | Gap We Fill                               |
| ------------------ | ----------------------------------------------- | -------------------------------------- | ----------------------------------------- |
| **Hotline Miami**  | Tight controls, brutal action, instant restarts | Combat-focused, no stealth requirement | Non-lethal stealth with similar tension   |
| **Heat Signature** | Great infiltration fantasy, procedural          | Can feel samey, less puzzle-like       | Hand-crafted puzzles with clear solutions |
| **Monaco**         | Excellent co-op stealth, heist theme            | Chaotic, less precise                  | Solo-focused precision puzzles            |
| **Serial Cleaner** | Stealth + comedy, 70s aesthetic                 | Simpler mechanics                      | Two-phase gameplay twist                  |
| **Hitman GO**      | Puzzle-stealth hybrid, elegant design           | Turn-based, mobile-first               | Real-time with puzzle sensibilities       |

### Market Gaps Identified

1. **Two-Phase Stealth:** No game meaningfully changes the rules between infiltration and exfiltration
2. **Comedy Spy Games:** The spy genre is dominated by serious entries—room for parody
3. **Bite-Sized Stealth:** Most stealth games are long; short replayable levels are underserved
4. **Non-Lethal Focus:** Forcing non-lethal creates unique puzzle constraints

### Success Indicators

-   **Hotline Miami** sold 5M+ copies with tight level design and instant restarts
-   **Untitled Goose Game** proved comedy stealth has mainstream appeal
-   Puzzle games with clear "par times" drive replayability and streaming content

---

## Core Mechanics

### The Two-Phase Structure

Every level has two distinct phases:

**Phase 1: Infiltration**

-   Enter the building undetected
-   Navigate patrol routes, security cameras, laser grids
-   Reach the bomb plant location
-   Plant the bomb (brief animation/minigame)

**Phase 2: Exfiltration**

-   Bomb planted triggers alert state
-   Guards change patrol routes (more aggressive, checking hiding spots)
-   New obstacles may activate (lockdowns, searchlights)
-   Some paths may close, others may open
-   Timer pressure (bomb will explode, you need to be OUT)

### Movement & Detection

| Mechanic        | Description                                          |
| --------------- | ---------------------------------------------------- |
| **Walk**        | Silent movement, guards won't hear                   |
| **Run**         | Faster but creates noise radius                      |
| **Hide**        | Duck into cover spots (lockers, bushes, under desks) |
| **Peek**        | See around corners without exposing yourself         |
| **Distraction** | Throw coins, make phones ring, knock on walls        |

### Guard AI Behavior

**Normal State (Phase 1):**

-   Predictable patrol routes
-   Fixed vision cones
-   Investigate noises briefly, then return

**Alert State (Phase 2):**

-   Patrols become semi-random
-   Vision cones wider and longer
-   Guards check hiding spots occasionally
-   Some guards become stationary blockers

### Gadgets (Unlockable/Collectible)

| Gadget                  | Use                                        | Comedy Potential               |
| ----------------------- | ------------------------------------------ | ------------------------------ |
| **Banana Peel**         | Guards slip and are stunned                | Classic slapstick              |
| **Fake Mustache**       | Brief disguise, walks past one guard       | Obviously fake                 |
| **Whoopee Cushion**     | Noise distraction                          | Guards investigate embarrassed |
| **Invisible Ink Spray** | Temporarily blind cameras                  | "Why is the lens wet?"         |
| **Inflatable Decoy**    | Guards investigate, then realize it's fake | Deflates sadly                 |
| **Rocket Shoes**        | Emergency dash, very loud                  | "Was that a fart noise?"       |

### Level Elements

-   **Guards:** Various types (patrol, stationary, sleepy, paranoid)
-   **Cameras:** Fixed, rotating, or tracking
-   **Laser Grids:** Must be disabled or timed
-   **Locked Doors:** Require keycards, hacking, or alternate routes
-   **Civilians:** Don't trigger alarms but will scream if startled
-   **Environmental Hazards:** Squeaky floors, loose tiles, barking dogs

---

## Comedy & Tone

### Spy Thriller Parody

The game takes place in a world of bumbling secret agents and incompetent villains:

-   **The Agency:** Your employer is clearly underfunded—gadgets are homemade, briefings are on sticky notes
-   **The Villains:** Evil corporations with ridiculous schemes (cornering the market on rubber ducks, etc.)
-   **The Agent:** Competent at stealth, terrible at small talk (dialogue options are all awkward)

### Comedy Moments

-   Guards have idle dialogue that's absurd ("You think the boss actually likes rubber ducks, or is it a tax thing?")
-   Failed stealth has funny death/capture animations
-   Victory screens show the explosion with ridiculous property damage totals
-   Newspaper headlines after missions parody spy movie tropes

### Visual Comedy (Hotline Miami / Early GTA Style)

-   Top-down perspective with chunky pixel art
-   Exaggerated character animations
-   Environmental details that reward exploration (silly posters, easter eggs)
-   Neon-soaked urban environments with 80s/90s aesthetic

---

## Prototype / MVP Scope

### MVP Goal

Validate that the two-phase infiltration/exfiltration loop is fun and that level design can support meaningful phase transitions.

### MVP Features

| Feature                          | Priority    | Notes                   |
| -------------------------------- | ----------- | ----------------------- |
| Basic movement (walk, run, hide) | Must Have   | Core feel must be right |
| Guard patrol AI (normal state)   | Must Have   | Simple state machine    |
| Guard alert AI (phase 2)         | Must Have   | Key differentiator      |
| Vision cone system               | Must Have   | Clear visual feedback   |
| 3 hand-crafted levels            | Must Have   | Intro, medium, hard     |
| Bomb plant mechanic              | Must Have   | Simple interaction      |
| Timer for exfiltration           | Must Have   | Creates tension         |
| 1-2 basic gadgets                | Should Have | Coin toss, banana peel  |
| Instant restart                  | Must Have   | Critical for feel       |
| Basic sound design               | Should Have | Footsteps, alerts       |

### MVP Excludes

-   Level editor
-   Multiple gadget unlocks
-   Story/cutscenes
-   Leaderboards
-   Multiple environments (just one tileset)

### Success Criteria

| Metric                                          | Target        |
| ----------------------------------------------- | ------------- |
| Playtesters find phase 2 meaningfully different | 80%+ agree    |
| Average level completion time                   | 1-3 minutes   |
| Playtesters want to retry for better time       | 70%+ do       |
| "Fun" rating                                    | 7/10+ average |
| Core loop understood without tutorial           | 90%+          |

### MVP Timeline Estimate

| Phase          | Duration      | Tasks                         |
| -------------- | ------------- | ----------------------------- |
| Core Systems   | 3-4 weeks     | Movement, detection, guard AI |
| Level Building | 2-3 weeks     | Design 3 levels, iterate      |
| Polish & Test  | 2 weeks       | Sound, effects, playtesting   |
| **Total**      | **7-9 weeks** |                               |

---

## Full Vision

### If Prototype Succeeds...

**Campaign Mode:**

-   30-50 hand-crafted levels across 5 environments (office, warehouse, mansion, lab, casino)
-   Light story with recurring villain and agency characters
-   Unlockable gadgets tied to level completion/par times
-   Optional objectives (no detection, speed, collect intel)

**Environment Variety:**

| Environment          | Unique Elements                            |
| -------------------- | ------------------------------------------ |
| **Corporate Office** | Cubicles, water coolers, nosy coworkers    |
| **Warehouse**        | Forklifts, crates, guard dogs              |
| **Villain Mansion**  | Butlers, secret passages, chandeliers      |
| **Secret Lab**       | Scientists, hazmat suits, test subjects    |
| **Casino**           | Crowds, slot machines, security everywhere |

**Advanced Gadgets:**

-   Grappling hook (limited vertical movement)
-   EMP device (disables electronics briefly)
-   Sleeping gas (area denial)
-   Hologram projector (advanced decoy)

**Level Editor (Way Later):**

-   Simple tile-based editor
-   Share levels via Steam Workshop
-   Community challenges and leaderboards

**Speedrun Support:**

-   In-game timer with milliseconds
-   Ghost replays
-   Par times for each level
-   Global leaderboards

---

## Risks & Mitigations

| Risk                         | Likelihood | Impact | Mitigation                                                                                   |
| ---------------------------- | ---------- | ------ | -------------------------------------------------------------------------------------------- |
| Phase 2 feels repetitive     | Medium     | High   | Vary phase 2 changes per level; some add guards, some change routes, some add timer pressure |
| Guard AI too predictable     | Medium     | Medium | Add slight randomization in phase 2; "paranoid" guard type                                   |
| Waiting for guards is boring | High       | High   | Design levels with minimal waiting; always have alternate paths; keep patrols short          |
| Comedy doesn't land          | Medium     | Medium | Playtest humor early; lean into visual comedy which transcends language                      |
| Scope creep on gadgets       | Medium     | Medium | MVP with 2 gadgets max; add more only if core loop is solid                                  |
| Level design is hard         | Medium     | High   | Study Hotline Miami level design; prototype on paper first; iterate heavily                  |

---

## Feasibility Assessment

### Technical Requirements (Godot/C#)

| System              | Complexity | Notes                            |
| ------------------- | ---------- | -------------------------------- |
| Top-down movement   | Low        | Standard 2D character controller |
| Vision cone system  | Medium     | Raycasting or polygon collision  |
| Guard state machine | Medium     | Finite state machine pattern     |
| Pathfinding         | Medium     | Built-in AStar or Navigation2D   |
| Tilemap system      | Low        | Godot's built-in TileMap         |
| Audio system        | Low        | Basic sound triggers             |

### Art Requirements

| Asset Type        | Quantity (MVP) | Notes                           |
| ----------------- | -------------- | ------------------------------- |
| Character sprites | 3-4            | Player, 2 guard types, civilian |
| Environment tiles | 50-100         | One tileset for MVP             |
| UI elements       | 10-15          | Menus, HUD, timer               |
| Gadget icons      | 2-4            | Simple icons                    |
| Animations        | 20-30          | Walk, run, hide, alert states   |

**Art Approach:**

-   Hotline Miami / early GTA style is achievable with solid pixel art fundamentals
-   Consider purchasing asset packs for MVP, custom art for full release
-   Estimated cost for commissioned pixel art: $500-1500 for MVP assets

### Solo Dev Reality Check

| Factor                   | Assessment                              |
| ------------------------ | --------------------------------------- |
| Technical skill required | Moderate—within advanced beginner scope |
| Art requirements         | Moderate—can use assets initially       |
| Design complexity        | Moderate—level design is the hard part  |
| Time investment          | 2-3 months for MVP                      |
| Burnout risk             | Low—small scope, clear milestones       |

---

## Open Questions

1. **How long should the timer be in Phase 2?** Fixed per level? Starts when bomb is planted? Visible or hidden?

2. **Should there be a "perfect stealth" bonus?** Some players love ghost runs, others find them frustrating.

3. **What happens on detection?** Instant fail? Chase sequence? "You have 3 seconds to hide"?

4. **Checkpoint system?** Instant restart is core, but should longer levels have mid-level checkpoints?

5. **Difficulty modes?** Easier guard vision, more time, vs. hardcore one-hit detection?

6. **Multiplayer potential?** Co-op could be interesting (one plants, one distracts) but may be out of scope.

7. **What's the bomb actually for?** Story justification—are we blowing up evil rubber duck factories?

---

## References & Inspiration

-   **Hotline Miami** - Aesthetic, instant restarts, tight level design
-   **Heat Signature** - Infiltration fantasy, gadget variety
-   **Monaco** - Top-down stealth, heist theme
-   **Untitled Goose Game** - Comedy stealth, physical comedy
-   **Jazzpunk** - Spy parody, absurdist humor
-   **The Spy Who Loved Me / Austin Powers** - Comedy spy tone
-   **Mark of the Ninja** - Two-phase level design (getting in vs. getting out)

---

_Document generated for solo developer consideration. Scope is intentionally tight for MVP validation._
