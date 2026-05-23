# Recording/Rewinding Actions - Expanded Design Document

> **Last Updated:** January 2026  
> **Genre:** Puzzle-Platformer / Action  
> **Engine:** Godot 4 with C#  
> **Platform:** PC  
> **Scope:** Prototype → MVP → Potential Full Release  
> **Working Title:** _Echo Run_ (placeholder)

---

## Table of Contents

1. [Executive Summary](#executive-summary)
2. [Market Analysis](#market-analysis)
3. [Core Mechanics](#core-mechanics)
4. [Prototype MVP](#prototype-mvp)
5. [Full Vision](#full-vision)
6. [Risks & Mitigations](#risks--mitigations)
7. [Feasibility Assessment](#feasibility-assessment)
8. [Open Questions](#open-questions)

---

## Executive Summary

### The Core Hook

**You are your own co-op partner.** Record your actions, then replay them while you do something else simultaneously. Navigate levels that require two (or more) versions of yourself working together—one in the past, one in the present. Puzzles require precise coordination. Action sections demand you outrun or outmaneuver your own ghost.

### Target Audience

-   **Primary:** Fans of time-manipulation puzzle-platformers (Braid, The Swapper, Timelie)
-   **Secondary:** Speedrunners and optimization enthusiasts who enjoy replayability
-   **Tertiary:** Streamers looking for games with high "a-ha moment" content

### Unique Selling Points

| Feature                | Why It Matters                                                       |
| ---------------------- | -------------------------------------------------------------------- |
| Single-player co-op    | Creates unique problem-solving mindset                               |
| Both puzzle AND action | Hybrid appeals to broader audience                                   |
| Multiple recordings    | Exponential complexity without exponential confusion (if done right) |
| Self-competition       | Optimize runs against your own ghosts                                |
| Emergent creativity    | Players discover solutions you never intended                        |

### Core Fantasy

The fantasy is **mastery through layered planning**. You think ahead, record, then execute in parallel. When it clicks, you feel like a genius. When you mess up, you immediately see why (your ghost shows you).

---

## Market Analysis

### Comparable Products

| Game                 | Similarities                         | Differences                               | Lessons                                               |
| -------------------- | ------------------------------------ | ----------------------------------------- | ----------------------------------------------------- |
| **Braid**            | Time manipulation, puzzle-platformer | Rewind time, not recording; more cerebral | Proved time puzzles sell; but can be too obtuse       |
| **The Swapper**      | Clone mechanics, puzzle              | Clones are simultaneous, not time-shifted | Parallel selves work in 2D; atmosphere matters        |
| **Super Time Force** | Recorded ghosts, action platformer   | More chaos/comedy, many ghosts at once    | Fast-paced ghost gameplay is fun; can be overwhelming |
| **Timelie**          | Planning then executing              | Top-down, stealth, more puzzle            | Separation of planning and action works               |
| **Cursor\*10**       | Recording previous runs              | Web game, abstract, simple                | Core loop is proven even in minimal form              |
| **Baba Is You**      | Mind-bending puzzles                 | Rule-based, not time-based                | Shows puzzle games can have viral "aha" moments       |
| **The Pedestrian**   | Puzzle-platformer, unique mechanic   | Sign-based, not time-based                | Clear visual language critical for puzzle games       |
| **Portal**           | Spatial puzzles, physics-based       | Portal mechanic, not time                 | Escalating complexity with single mechanic = gold     |

### Market Gaps Identified

1. **No hybrid puzzle/action recording game exists** — Either pure puzzle (Cursor\*10) or pure action (Super Time Force)
2. **Multi-recording is underexplored** — Most games use single ghost; layering 2-3+ is rare
3. **Recording games lack narrative** — Opportunity for story integration
4. **Optimization replay value** — Few puzzle games encourage replaying for better solutions

### Audience Size Indicators

-   Braid sold 500K+ copies on Xbox alone before Steam launch
-   The Swapper sold well despite niche appearance
-   Speedrunning community creates longevity for games with time mechanics
-   "Time loop" games (Outer Wilds, Deathloop) have proven the mechanic has mass appeal

---

## Core Mechanics

### The Recording System

#### Basic Loop

1. **Start Level** — Player at start position
2. **Record** — Player performs actions (movement, button presses, abilities)
3. **Confirm Recording** — Recording ends, saved as "Echo"
4. **Replay Begins** — Echo plays back exactly as recorded
5. **Player Acts Simultaneously** — Real player does new actions while Echo runs
6. **Goal:** Coordinate to solve level (both reach goal, flip switches together, etc.)

#### Recording States

| State          | Player Status           | Echo Status            | Can Record?               |
| -------------- | ----------------------- | ---------------------- | ------------------------- |
| **Pre-Record** | Active                  | None exist             | No                        |
| **Recording**  | Active (being recorded) | None active            | Yes                       |
| **Playback**   | Active (new actions)    | Playing back           | Yes (creates nested Echo) |
| **Complete**   | At goal                 | At goal (or dismissed) | Level ends                |

### Echo Behavior

Echoes are **deterministic ghosts**. They replay exactly what was recorded.

| Aspect           | Behavior                                        |
| ---------------- | ----------------------------------------------- |
| **Movement**     | Identical to recording                          |
| **Interactions** | Can press switches, push buttons                |
| **Collision**    | Passes through player (usually), solid to world |
| **Death**        | If Echo dies during playback, level fails       |
| **Persistence**  | Lasts until end of level or dismissed           |

### Recording Depth (Single vs Multiple)

#### Single Recording Levels

-   One Echo + one active player
-   Simple coordination puzzles
-   Good for tutorials and early game

**Example Puzzle:**

1. Record: Walk to switch, stand on it
2. Playback: Walk through door that Echo opened

#### Multiple Recording Levels

-   Two or more Echoes + active player
-   Complex coordination
-   Requires planning across multiple timelines

**Example Puzzle (2 Echoes):**

1. Record Echo 1: Stand on Switch A
2. Record Echo 2: Wait 3 seconds, stand on Switch B
3. Player: Run through when both switches are held

#### Nested Recording

In some levels, you can record **during playback**, creating cascading sequences:

1. Record Echo 1: Press button, wait at door
2. Start playback, record Echo 2: Run past Echo 1 through opened door, press inner button
3. Playback both: Run to final goal that requires all three (Echo 1, Echo 2, you)

### Player Abilities

#### Base Abilities

| Ability  | Function                           | Recorded? |
| -------- | ---------------------------------- | --------- |
| Walk/Run | Horizontal movement                | Yes       |
| Jump     | Vertical movement                  | Yes       |
| Interact | Press buttons, pull levers         | Yes       |
| Crouch   | Fit through small spaces           | Yes       |
| Wait     | Stand still (important for timing) | Yes       |

#### Unlockable Abilities (Full Game)

| Ability         | Unlock Point | Function                            | Puzzle Application    |
| --------------- | ------------ | ----------------------------------- | --------------------- |
| **Double Jump** | Area 2       | Second jump mid-air                 | Vertical level design |
| **Dash**        | Area 3       | Quick horizontal burst              | Timing windows        |
| **Wall Slide**  | Area 3       | Slow descent on walls               | Extended air time     |
| **Wall Jump**   | Area 4       | Jump off walls                      | Complex traversal     |
| **Anchor**      | Area 5       | Freeze in place until input         | Precise timing        |
| **Phase**       | Area 6       | Brief invincibility through hazards | Obstacle crossing     |

### Puzzle Mechanics

#### Environmental Elements

| Element              | Behavior                      | Puzzle Use                        |
| -------------------- | ----------------------------- | --------------------------------- |
| **Pressure Plates**  | Activate when stood on        | Hold with Echo while player moves |
| **Timed Doors**      | Open briefly when triggered   | Coordinate trigger and traversal  |
| **Conveyor Belts**   | Move player/Echo in direction | Account for movement in recording |
| **Moving Platforms** | Set path/timing               | Sync with platform arrival        |
| **Light Bridges**    | Require sustained activation  | Echo maintains while player uses  |
| **Mirrors**          | Redirect beams                | Position Echo to reflect          |
| **Weight Scales**    | Balance-based                 | Multiple Echoes to achieve weight |
| **Teleporters**      | Instant position change       | Record teleported paths           |

#### Puzzle Types

| Type                   | Description                                            | Example                                  |
| ---------------------- | ------------------------------------------------------ | ---------------------------------------- |
| **Coordination**       | Two+ points must be triggered together                 | Dual pressure plates                     |
| **Timing**             | Actions must happen in sequence                        | Open door, run through before close      |
| **Positioning**        | Echoes become platforms/bridges                        | Stand in specific spots                  |
| **Chain Reaction**     | Actions enable other actions                           | Echo 1 → enables Echo 2 → enables player |
| **Optimization**       | Reach goal in minimum recordings                       | Par system for records                   |
| **Paradox Prevention** | Your recording must not conflict with your current run | Path crossing carefully                  |

### Action Mechanics

For action-focused sections/levels:

#### Hazards

| Hazard               | Behavior             | Interaction with Echoes                |
| -------------------- | -------------------- | -------------------------------------- |
| **Spikes**           | Static damage zone   | Kills Echo if touched during recording |
| **Patrolling Enemy** | Set movement pattern | Echo can distract/draw aggro           |
| **Projectile Trap**  | Fires at interval    | Must time around                       |
| **Laser Grid**       | Sweeping damage      | Crouch/jump timing                     |
| **Crusher**          | Timed crushing       | Precise movement required              |
| **Chase Entity**     | Pursues player       | Can switch targets to Echo             |

#### Action Puzzle Combinations

| Scenario            | Challenge                                                      |
| ------------------- | -------------------------------------------------------------- |
| **Distraction Run** | Record Echo to draw enemy, then sneak past                     |
| **Relay Escape**    | Record path through first hazard, then chain to next section   |
| **Mirror Dash**     | You and Echo must dodge the same obstacle from opposite sides  |
| **Sacrifice Play**  | Record Echo to die (trigger trap), making path safe for player |

### Level Structure Variants

#### Pure Puzzle

-   No time pressure
-   Reset at will
-   Focus on figuring out the solution
-   Can be complex, multi-step

#### Pure Action

-   Continuous motion
-   Hazards and timing
-   Recording as reaction, not planning
-   Fast-paced execution

#### Hybrid (Primary Design Target)

-   Sections of puzzle separated by action
-   Record during calm, execute during chaos
-   Level flow: **Puzzle → Action → Puzzle → Goal**

**Example Hybrid Level:**

1. **Puzzle Section:** Record Echo to hold door open
2. **Action Section:** Sprint through timed gauntlet while Echo holds door
3. **Puzzle Section:** Figure out which platform to stand on
4. **Action Section:** Dodge laser grid with Echo's help
5. **Goal:** Both reach endpoint

---

## Prototype MVP

### Goal

Validate that **recording yourself to solve puzzles is intuitive, fun, and creates satisfying "a-ha" moments—and that action sections feel integrated, not tacked-on.**

### Scope (4-6 Weeks)

#### Content Checklist

| Element         | Quantity                              | Notes                                                  |
| --------------- | ------------------------------------- | ------------------------------------------------------ |
| Levels          | 10-12                                 | Mix of puzzle, action, hybrid                          |
| Recording modes | Single + one multi-recording tutorial | Keep simple                                            |
| Abilities       | Base movement only                    | Walk, jump, interact                                   |
| Hazards         | 3                                     | Spikes, patrolling enemy, timed crusher                |
| Puzzle elements | 4                                     | Pressure plates, timed doors, moving platforms, levers |
| Playtime        | 30-45 min                             | Full level progression                                 |

#### Core Systems to Implement

1. **Recording system** — Input capture, storage, playback
2. **Echo rendering** — Ghost sprite following recorded path
3. **Collision handling** — Echo vs. world, player vs. world
4. **Puzzle elements** — Pressure plates, doors, levers
5. **Hazard system** — Damage, death, respawn
6. **Level completion** — Detect both player and Echo at goal
7. **Reset/retry** — Quick reset, re-record option

#### Technical MVP Requirements

| System          | Implementation Notes                                        |
| --------------- | ----------------------------------------------------------- |
| Input Recording | Store input states per frame, not positions (more accurate) |
| Playback        | Apply recorded inputs to cloned player entity               |
| Timing          | Fixed timestep critical for determinism                     |
| Echo Visual     | Semi-transparent duplicate, distinct color                  |
| Level State     | Must reset puzzle elements when re-recording                |

#### Art Requirements (Minimum)

-   Player character (idle, walk, jump, interact) — can be simple shapes
-   Echo version (same animations, ghosted/tinted)
-   1 tileset (generic tech/facility)
-   3 hazard sprites
-   4 puzzle element sprites
-   UI (recording indicator, echo counter, reset button)

#### Audio (Minimum)

-   Recording start/stop SFX
-   Echo playback ambient hum
-   Hazard SFX (spikes, crusher)
-   Level complete SFX
-   Background music (1 track, ambient tech)

### Success Criteria

| Metric                       | Target                   | How to Measure             |
| ---------------------------- | ------------------------ | -------------------------- |
| Recording feels intuitive    | < 5 min to understand    | Time to first puzzle solve |
| Puzzles are satisfying       | 80%+ solve without hints | Playtester completion rate |
| Action feels integrated      | "Not jarring"            | Qualitative feedback       |
| Players want more complexity | Request multi-recording  | Post-play interest check   |
| Replay interest              | "Would optimize runs"    | Ask about par times        |

### Prototype Risks

| Risk                         | Mitigation                                |
| ---------------------------- | ----------------------------------------- |
| Recording feels fiddly       | Polish controls, generous hitboxes        |
| Playback desyncs             | Use input-based recording, fixed timestep |
| Puzzles too easy or too hard | Extensive playtesting, adjust complexity  |
| Action sections frustrating  | Generous checkpoints, quick retry         |
| Concept doesn't click        | Strong tutorial, visual clarity           |

---

## Full Vision

### Complete Game Scope

| Element                     | Quantity                                                   |
| --------------------------- | ---------------------------------------------------------- |
| Levels                      | 50-70                                                      |
| Worlds/Areas                | 6-8 thematic zones                                         |
| Unlockable abilities        | 5-6                                                        |
| Maximum simultaneous Echoes | 3-4 (in late-game levels)                                  |
| Par times per level         | 3 tiers (Bronze, Silver, Gold)                             |
| Collectibles                | Hidden in each level                                       |
| Playtime                    | 8-12 hours (main) + 4-6 hours (optimization, collectibles) |

### World Structure

#### Linear Progression with Branches

```
[WORLD 1] → [WORLD 2] → [WORLD 3] → [WORLD 4]
     ↓           ↓           ↓
 [BONUS 1]   [BONUS 2]   [BONUS 3] → [SECRET WORLD]
```

#### World Breakdown

| World             | Theme             | New Mechanics                            | Echo Limit | Levels |
| ----------------- | ----------------- | ---------------------------------------- | ---------- | ------ |
| **1: Laboratory** | Tutorial facility | Basic recording, pressure plates         | 1          | 8      |
| **2: Factory**    | Industrial        | Moving platforms, conveyors, Double Jump | 1          | 10     |
| **3: Skyway**     | Outdoor heights   | Dash, Wall Slide, wind gusts             | 2          | 10     |
| **4: Ruins**      | Ancient tech      | Wall Jump, teleporters, mirrors          | 2          | 10     |
| **5: Core**       | Deep underground  | Anchor, gravity shifts                   | 3          | 10     |
| **6: Nexus**      | Time distortion   | Phase, all mechanics                     | 4          | 10     |
| **Bonus Worlds**  | Challenge-focused | No new mechanics, harder puzzles         | Varies     | 12-15  |
| **Secret World**  | Mastery required  | Extreme challenges                       | 4          | 5-8    |

### Narrative Integration (Optional but Recommended)

#### Story Concept

The player is a test subject in a temporal research facility. The recording ability is an experimental device. As you progress, you discover:

1. **Act 1:** You're told this is for science, the recordings are "echoes" in time
2. **Act 2:** Discover other test subjects who didn't survive—their echoes still play on loop
3. **Act 3:** The facility is trying to create a "perfect run" through reality—and you're the latest attempt
4. **Act 4:** Break free by recording a sequence that destabilizes the system

**Tone:** Can be serious (The Swapper) or darkly comedic (Portal). Recommend comedic for solo dev.

### Advanced Mechanics (Full Game)

#### Echo Interactions

| Interaction     | Description                            | Unlocked |
| --------------- | -------------------------------------- | -------- |
| **Echo Boost**  | Jump off an Echo mid-air               | World 3  |
| **Echo Carry**  | Echo can pick up and move objects      | World 4  |
| **Echo Switch** | Swap places with Echo                  | World 5  |
| **Echo Merge**  | Combine into Echo for brief super-form | World 6  |

#### Temporal Twists

| Twist                | Description                            |
| -------------------- | -------------------------------------- |
| **Reverse Playback** | Echo plays actions backward            |
| **Speed Variation**  | Echo plays at 0.5x or 2x speed         |
| **Delayed Start**    | Echo begins playback after N seconds   |
| **Conditional Echo** | Echo only activates when player does X |

#### Challenge Modes (Post-Main Game)

| Mode               | Description                           |
| ------------------ | ------------------------------------- |
| **Speedrun Mode**  | Timer, leaderboards, optimized routes |
| **Minimum Echoes** | Solve using fewest recordings         |
| **No-Death Runs**  | Entire world without dying            |
| **Echo Race**      | You vs. community ghost               |
| **Level Editor**   | Create and share custom puzzles       |

### Replayability Systems

#### Par System

Each level has:

-   **Recordings Par:** Minimum echoes expected
-   **Time Par:** Target completion time
-   **Collectible:** One hidden object per level

#### Medals

| Medal       | Requirement                                |
| ----------- | ------------------------------------------ |
| **Bronze**  | Complete level                             |
| **Silver**  | Complete under Time Par                    |
| **Gold**    | Complete under Time Par AND Recordings Par |
| **Perfect** | Gold + Collectible                         |

#### Unlockables

| Unlock               | Requirement              |
| -------------------- | ------------------------ |
| Character skins      | Medal milestones         |
| Echo skins           | Secret collectibles      |
| Developer commentary | Complete main game       |
| Secret World         | All Golds in main worlds |
| Boss Rush            | Complete Secret World    |

---

## Risks & Mitigations

### Development Risks

| Risk                                   | Likelihood | Impact   | Mitigation                                               |
| -------------------------------------- | ---------- | -------- | -------------------------------------------------------- |
| **Determinism bugs**                   | High       | Critical | Fixed timestep, input-based recording, extensive testing |
| **Level design complexity**            | High       | Medium   | Create level design templates, iterate on core puzzles   |
| **Performance with multiple Echoes**   | Medium     | Medium   | Optimize early, limit max Echoes                         |
| **Edge case exploits**                 | Medium     | Low      | Embrace creative solutions unless game-breaking          |
| **Scope creep (abilities, mechanics)** | High       | Medium   | Lock feature set after design phase                      |

### Design Risks

| Risk                            | Likelihood | Impact | Mitigation                                     |
| ------------------------------- | ---------- | ------ | ---------------------------------------------- |
| **Recording feels tedious**     | Medium     | High   | Short levels, quick retry, undo last recording |
| **Multi-Echo overwhelming**     | Medium     | High   | Gradual introduction, clear visual distinction |
| **Solutions feel prescriptive** | Medium     | Medium | Design for multiple valid approaches           |
| **Action sections frustrating** | Medium     | Medium | Generous checkpoints, tunable difficulty       |
| **Learning curve too steep**    | Medium     | Medium | Extended tutorial, hint system                 |

### Technical Risks

| Risk                             | Likelihood | Impact   | Mitigation                                          |
| -------------------------------- | ---------- | -------- | --------------------------------------------------- |
| **Playback desync**              | High       | Critical | Never use position-based replay; always input-based |
| **Save corruption**              | Low        | High     | Robust save system, auto-backup                     |
| **Performance on lower-end PCs** | Low        | Medium   | Godot is lightweight; monitor Echo count            |

### Market Risks

| Risk                         | Likelihood | Impact | Mitigation                                        |
| ---------------------------- | ---------- | ------ | ------------------------------------------------- |
| **Niche audience**           | Medium     | Medium | Hybrid action/puzzle broadens appeal              |
| **Comparison to Braid**      | Medium     | Low    | Different core mechanic (recording vs. rewinding) |
| **Streamability challenges** | Low        | Low    | "A-ha" moments are great for streams              |

---

## Feasibility Assessment

### Solo Developer Timeline

#### Prototype Phase (4-6 Weeks)

| Week | Focus                              |
| ---- | ---------------------------------- |
| 1-2  | Core recording/playback system     |
| 3    | Basic puzzle elements, 5 levels    |
| 4    | Hazard system, action levels       |
| 5-6  | Polish, playtesting, 5 more levels |

#### MVP Phase (3-5 Months)

| Month | Focus                                         |
| ----- | --------------------------------------------- |
| 1     | Expand to 25 levels, add Double Jump and Dash |
| 2     | Multi-Echo system, 10 more levels             |
| 3     | Art refinement, UI polish                     |
| 4     | Audio implementation, playtesting             |
| 5     | Bug fixing, balance pass, par times           |

#### Full Game (12-18 Months from MVP)

-   All worlds and levels
-   All abilities
-   Bonus content and secret world
-   Story integration
-   Level editor (stretch goal)
-   Polish and QA

### Resource Requirements

#### If Staying Solo

| Resource  | Approach                            | Estimated Cost |
| --------- | ----------------------------------- | -------------- |
| Art       | Pixel art, mix of original + assets | $200-600       |
| Music     | Ambient electronic, royalty-free    | $0-200         |
| SFX       | Generated + Freesound.org           | $0-100         |
| Marketing | Social media, devlogs, GIFs         | $0 (time only) |

#### If Expanding After MVP

| Resource       | Approach                          | Estimated Cost |
| -------------- | --------------------------------- | -------------- |
| Pixel Artist   | Commission full tileset per world | $2,000-5,000   |
| Composer       | Original soundtrack               | $800-2,000     |
| Level Designer | Contract for bonus levels         | $500-1,500     |
| QA             | Beta testing group                | $0-500         |

### Technical Considerations (Godot + C#)

| System           | Complexity | Notes                                     |
| ---------------- | ---------- | ----------------------------------------- |
| Input Recording  | Medium     | Dictionary of inputs per fixed frame      |
| Playback System  | Medium     | Clone player, apply inputs                |
| Determinism      | High       | Fixed timestep mandatory; avoid random    |
| Echo Rendering   | Low        | Duplicate sprite, shader for ghost effect |
| Level Management | Medium     | Reset state on re-record                  |
| Save/Load        | Medium     | Store best times, collectibles, progress  |
| Par System       | Low        | Simple tracking and UI                    |

### Godot-Specific Implementation

#### Recording System Architecture

```
RecordingManager (C# Singleton)
├── CurrentRecording (List<InputFrame>)
├── SavedEchoes (List<Recording>)
├── IsRecording (bool)
├── IsPlaying (bool)
└── Methods:
    ├── StartRecording()
    ├── StopRecording()
    ├── PlayEchoes()
    └── ResetLevel()

InputFrame (C# Struct)
├── FrameNumber (int)
├── HorizontalInput (float)
├── JumpPressed (bool)
├── InteractPressed (bool)
└── [Additional inputs as needed]
```

#### Fixed Timestep Requirement

```csharp
// In _PhysicsProcess (not _Process)
public override void _PhysicsProcess(double delta)
{
    if (isRecording)
    {
        RecordCurrentInput();
    }
    if (isPlayingEchoes)
    {
        ApplyEchoInputs();
    }
    ProcessPlayerMovement();
}
```

#### Echo Rendering

-   Use `ShaderMaterial` with transparency and color tint
-   Each Echo gets distinct tint (Echo 1: Blue, Echo 2: Green, Echo 3: Yellow)
-   Current player is always solid

---

## Open Questions

### Design Questions

1. **Should Echoes be solid or pass-through to player?** Pass-through avoids frustration but loses platform potential
2. **Can the player "ride" an Echo?** Adds depth but complexity
3. **What happens if Echo dies during playback?** Level fail? Continue without? Partial success?
4. **Should there be an undo last recording button?** Quality of life vs. design purity
5. **How many Echoes is too many?** 3-4 seems manageable; 5+ might be chaotic
6. **Should par times be visible from the start?** Encourages optimization but may stress players

### Technical Questions

1. **How to handle network instability if adding leaderboards?** Offline ghost storage?
2. **How to prevent replay manipulation?** Verification for competitive modes?
3. **Save format?** JSON vs. binary for recordings?

### Narrative Questions

1. **How much story to include?** Portal-style minimal? Braid-style hidden depth?
2. **Tone:** Serious or comedic?
3. **Should other test subjects appear as permanent Echoes?** Adds narrative weight

### Content Questions

1. **Level editor viability?** Great for longevity but significant dev time
2. **Community features?** Level sharing, ghost racing
3. **Speedrun mode considerations?** Official timer, split tracking

---

## Appendix: Level Design Templates

### Puzzle Level Template

| Phase          | Description                                   | Example Elements             |
| -------------- | --------------------------------------------- | ---------------------------- |
| **Intro**      | Show the goal, hint at solution               | Visible exit, obvious switch |
| **Setup**      | Player identifies what Echo needs to do       | Pressure plate near door     |
| **Recording**  | Player performs Echo actions                  | Stand on plate, wait         |
| **Execution**  | Player does remaining actions during playback | Run through door             |
| **Completion** | Both reach goal area                          | Dual goal pads               |

### Action Level Template

| Phase              | Description                         | Example Elements        |
| ------------------ | ----------------------------------- | ----------------------- |
| **Calm Before**    | Brief puzzle to set up Echo         | Record distraction      |
| **Action Trigger** | Start hazard section                | Begin playback          |
| **Gauntlet**       | Navigate hazards while Echo assists | Dodge, Echo draws aggro |
| **Convergence**    | You and Echo paths merge            | Same exit point         |
| **Goal**           | Complete level                      | Touch goal              |

### Hybrid Level Template

| Phase        | Description                     | Pacing     |
| ------------ | ------------------------------- | ---------- |
| **Puzzle A** | Solve first coordination puzzle | Slow       |
| **Action A** | Execute with time pressure      | Fast       |
| **Puzzle B** | More complex, builds on A       | Slow       |
| **Action B** | Climactic hazard sequence       | Fast       |
| **Goal**     | Multi-Echo goal requirement     | Resolution |

---

## Appendix: Echo Visual Reference

### Echo Appearance by State

| State               | Visual Treatment                             |
| ------------------- | -------------------------------------------- |
| Recording (active)  | Player has glowing outline, HUD indicator    |
| Echo Playing        | Semi-transparent, colored tint, trail effect |
| Echo Idle (waiting) | Faded, stationary until triggered            |
| Echo Dead           | Dissipates with particles                    |
| Echo at Goal        | Solid, success particles                     |

### Color Coding

| Echo   | Primary Color | Secondary            |
| ------ | ------------- | -------------------- |
| Echo 1 | Blue          | Light blue trail     |
| Echo 2 | Green         | Light green trail    |
| Echo 3 | Yellow        | Gold trail           |
| Echo 4 | Purple        | Violet trail         |
| Player | White/Default | No trail (or subtle) |

---

## Appendix: Difficulty Scaling Examples

### Early Game (World 1)

**Level 1-3: The Basics**

-   Single switch + single door
-   No timing pressure
-   Echo just needs to stand on switch

**Level 1-8: Introduction Complete**

-   Two switches, requires timing
-   Moving platform synchronization
-   Still single Echo

### Mid Game (World 3-4)

**Level 3-5: Dual Echo Introduction**

-   Three-switch puzzle requiring both Echoes + player
-   Moderate timing windows
-   Echo Boost introduced

**Level 4-8: Complexity Peak**

-   Teleporter chains
-   Nested recordings
-   Action sections with multiple hazard types

### Late Game (World 6)

**Level 6-5: Temporal Mastery**

-   Four Echoes
-   Reverse playback modifier
-   Phase ability required
-   Tight par times

**Level 6-10: The Gauntlet**

-   All mechanics combined
-   Minimal margin for error
-   Longest level in game
-   Secret exit for True Ending

---

_Document will be updated as development progresses._
