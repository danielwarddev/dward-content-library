# Echo Run - Implementation Plan

> **Engine:** Godot 4.x with C#  
> **Experience:** Advanced beginner with Godot, expert with C#  
> **Time Budget:** 2-5 hours/week  
> **Scope:** Prototype (Pure Puzzle Focus)  
> **Art:** Placeholder / Kenney assets  
> **Estimated Duration:** 6-8 weeks  
> **Target:** 5-10 puzzle levels with single Echo mechanic

---

## Focus Areas

-   ✅ Player movement (walk, jump, interact, crouch)
-   ✅ Single Echo recording/playback system
-   ✅ Core puzzle elements (pressure plates, doors, platforms, levers)
-   ✅ Level completion and reset systems
-   ✅ 5-10 pure puzzle levels

## Excluded (Future Features)

-   ❌ Action/hazard sections (spikes, enemies, crushers)
-   ❌ Multiple Echoes
-   ❌ Par times / medal system
-   ❌ Narrative elements
-   ❌ Audio beyond basic SFX
-   ❌ Advanced abilities (double jump, dash, wall slide, etc.)

---

## Phase 0: Project Setup (Week 1)

_Brief setup - you know how to do this._

### 0.1 Create Godot Project

-   [ ] Create new Godot 4 project with C# support
-   [ ] Set up folder structure (`Scenes/`, `Scripts/`, `Assets/`, `Levels/`)
-   [ ] Configure fixed timestep in Project Settings (critical for determinism)
-   [ ] Import Kenney platformer asset pack

**Time:** ~30-60 min  
**Done when:** Project opens, C# compiles, assets visible in FileSystem

---

## Phase 1: Player Movement (Weeks 1-2)

_Foundation for everything else. Get this feeling good before moving on._

### 1.1 Basic Player Scene

-   [ ] Create `Player.tscn` with CharacterBody2D
-   [ ] Add collision shape and placeholder sprite
-   [ ] Create `Player.cs` script with basic structure

**Time:** ~30 min  
**Done when:** Player node exists with visible sprite and collision

---

### 1.2 Horizontal Movement

-   [ ] Implement left/right input detection
-   [ ] Apply horizontal velocity with acceleration/deceleration
-   [ ] Tune movement speed to feel responsive

**Time:** ~45-60 min  
**Done when:** Player moves left/right smoothly, stops when no input

---

### 1.3 Jump Mechanics

-   [ ] Implement jump with ground detection
-   [ ] Add gravity and fall speed
-   [ ] Implement coyote time (small grace period after leaving platform)
-   [ ] Add jump buffering (register jump input slightly before landing)

**Time:** ~1-2 hours  
**Done when:** Jumping feels crisp, can land on platforms reliably

---

### 1.4 Crouch

-   [ ] Implement crouch input (hold to crouch)
-   [ ] Reduce collision height while crouching
-   [ ] Prevent standing if obstacle above
-   [ ] Optional: slower movement while crouching

**Time:** ~45-60 min  
**Done when:** Can crouch under low obstacles, collision resizes properly

---

### 1.5 Interact System

-   [ ] Create `IInteractable` interface
-   [ ] Add interact input (e.g., E key)
-   [ ] Detect interactable objects in range (Area2D)
-   [ ] Call interact method on detected objects

**Time:** ~45-60 min  
**Done when:** Player can trigger interaction on objects in range

---

### 📍 Milestone Checkpoint: Movement Complete

-   [ ] Player moves, jumps, crouches, and interacts
-   [ ] Movement feels good in a test scene with platforms
-   [ ] All inputs responsive and predictable

---

## Phase 2: Recording System (Weeks 2-3)

_The core innovation. This MUST be input-based, not position-based._

### 2.1 Input Frame Structure

-   [ ] Create `InputFrame` struct/class to store:
    -   Frame number (int)
    -   Horizontal input (float)
    -   Jump pressed (bool)
    -   Crouch held (bool)
    -   Interact pressed (bool)
-   [ ] Ensure struct is serializable for future save/load

**Time:** ~30 min  
**Done when:** InputFrame struct compiles with all needed fields

---

### 2.2 Recording Manager Singleton

-   [ ] Create `RecordingManager.cs` as autoload singleton
-   [ ] Add `CurrentRecording` (List<InputFrame>)
-   [ ] Add `IsRecording` state flag
-   [ ] Add frame counter that increments in `_PhysicsProcess`

**Time:** ~30-45 min  
**Done when:** Singleton accessible, frame counter works

---

### 2.3 Input Capture

-   [ ] In Player's `_PhysicsProcess`, capture inputs each frame
-   [ ] When recording, send InputFrame to RecordingManager
-   [ ] Store frames in CurrentRecording list

**Time:** ~45-60 min  
**Done when:** Can start recording, frames accumulate in list

---

### 2.4 Recording Start/Stop

-   [ ] Add keybind to start recording (e.g., R)
-   [ ] Add keybind to stop recording (e.g., R again, or separate key)
-   [ ] On stop, save CurrentRecording to `SavedEcho`
-   [ ] Reset player to start position when recording stops

**Time:** ~45-60 min  
**Done when:** Can record a sequence, player resets after

---

### 2.5 Visual Recording Indicator

-   [ ] Add simple UI showing "RECORDING" when active
-   [ ] Show frame count or timer
-   [ ] Different color/icon when not recording

**Time:** ~30 min  
**Done when:** Clear visual feedback for recording state

---

### 📍 Milestone Checkpoint: Recording Works

-   [ ] Can start/stop recording
-   [ ] Input frames stored correctly
-   [ ] Player resets to start after recording

---

## Phase 3: Echo Playback (Weeks 3-4)

_Make the ghost appear and replay your actions._

### 3.1 Echo Scene

-   [ ] Create `Echo.tscn` duplicating Player structure
-   [ ] Add ghost shader/material (semi-transparent blue tint)
-   [ ] Create `Echo.cs` script (similar to Player but input-driven externally)

**Time:** ~45-60 min  
**Done when:** Echo scene exists with distinct ghost appearance

---

### 3.2 Playback System

-   [ ] Add `PlayEcho()` method to RecordingManager
-   [ ] Spawn Echo at start position
-   [ ] Each `_PhysicsProcess`, feed next InputFrame to Echo
-   [ ] Echo applies inputs exactly like Player would

**Time:** ~1-2 hours  
**Done when:** Echo replays recorded movement perfectly

---

### 3.3 Echo Collision Rules

-   [ ] Echo collides with world (platforms, walls)
-   [ ] Echo passes through Player (no collision between them)
-   [ ] Echo can trigger puzzle elements (pressure plates, etc.)

**Time:** ~30-45 min  
**Done when:** Echo interacts with world, ignores player collision

---

### 3.4 Simultaneous Control

-   [ ] After recording stops, spawn Echo AND reset Player
-   [ ] Both run simultaneously - Echo replays, Player has new inputs
-   [ ] Both exist in the level at the same time

**Time:** ~45-60 min  
**Done when:** Can control Player while Echo replays beside you

---

### 3.5 Playback End Handling

-   [ ] When Echo runs out of frames, it stops (idles in place)
-   [ ] Optional: Echo fades slightly when "done"
-   [ ] Echo remains in final position until level reset

**Time:** ~30 min  
**Done when:** Echo gracefully finishes playback

---

### 📍 Milestone Checkpoint: Echo System Complete

-   [ ] Can record, then watch Echo replay while controlling Player
-   [ ] Echo visually distinct (ghost effect)
-   [ ] Echo interacts with world properly

---

## Phase 4: Puzzle Elements (Weeks 4-5)

_Build the interactive pieces that make puzzles possible._

### 4.1 Pressure Plate

-   [ ] Create `PressurePlate.tscn` with Area2D
-   [ ] Detect when Player OR Echo stands on it
-   [ ] Emit signal when activated/deactivated
-   [ ] Visual feedback (pressed down sprite)

**Time:** ~45-60 min  
**Done when:** Plate detects both Player and Echo, shows state

---

### 4.2 Door (Linked to Triggers)

-   [ ] Create `Door.tscn` with collision
-   [ ] Add `Open()` / `Close()` methods
-   [ ] Connect to pressure plate signals
-   [ ] Animate open/close (simple tween or sprite swap)

**Time:** ~45-60 min  
**Done when:** Door opens when plate pressed, closes when released

---

### 4.3 Timed Door

-   [ ] Extend Door to support timed mode
-   [ ] Opens when triggered, closes after N seconds
-   [ ] Visual countdown indicator (optional but helpful)

**Time:** ~30-45 min  
**Done when:** Door opens briefly then auto-closes

---

### 4.4 Lever (Toggle Switch)

-   [ ] Create `Lever.tscn` as IInteractable
-   [ ] Toggle state when interacted
-   [ ] Emit signal with current state
-   [ ] Stays in position (doesn't reset like pressure plate)

**Time:** ~30-45 min  
**Done when:** Player/Echo can flip lever, it stays flipped

---

### 4.5 Moving Platform

-   [ ] Create `MovingPlatform.tscn` with AnimatableBody2D
-   [ ] Define waypoints (path or simple A-B)
-   [ ] Smooth movement between points
-   [ ] Player/Echo ride platform correctly

**Time:** ~1-2 hours  
**Done when:** Platform moves on path, carries player smoothly

---

### 4.6 Goal Zone

-   [ ] Create `GoalZone.tscn` with Area2D
-   [ ] Detect when Player enters
-   [ ] Emit level complete signal
-   [ ] Visual indicator (flag, glow, etc.)

**Time:** ~30 min  
**Done when:** Entering goal triggers completion

---

### 📍 Milestone Checkpoint: Puzzle Elements Complete

-   [ ] Pressure plates work with Player and Echo
-   [ ] Doors respond to triggers
-   [ ] Levers toggle state
-   [ ] Moving platforms carry entities
-   [ ] Goal zone detects completion

---

## Phase 5: Level Infrastructure (Week 5-6)

_The systems that tie levels together._

### 5.1 Level Reset

-   [ ] Add reset keybind (e.g., Backspace)
-   [ ] Reset Player to spawn point
-   [ ] Clear all Echoes
-   [ ] Reset all puzzle elements to default state

**Time:** ~45-60 min  
**Done when:** Can fully reset level state instantly

---

### 5.2 Re-Record Option

-   [ ] Add keybind to clear Echo and start fresh recording
-   [ ] Preserve option to keep existing Echo and add another (for future multi-Echo)
-   [ ] Clear UI feedback on current state

**Time:** ~30-45 min  
**Done when:** Can discard recording and try again

---

### 5.3 Level Completion Detection

-   [ ] Detect Player in goal zone
-   [ ] For single-Echo levels: just Player reaching goal is enough
-   [ ] Show completion UI (simple "Level Complete" text)
-   [ ] Option to proceed to next level or replay

**Time:** ~45-60 min  
**Done when:** Completing goal shows success, can proceed

---

### 5.4 Level Transition

-   [ ] Create simple level select or linear progression
-   [ ] Load next level scene on completion
-   [ ] Track which levels are completed (basic save)

**Time:** ~45-60 min  
**Done when:** Can progress through multiple levels

---

### 5.5 Basic UI

-   [ ] Recording state indicator
-   [ ] Reset button (or show keybind)
-   [ ] Level name/number display
-   [ ] Pause menu with restart/quit options

**Time:** ~1 hour  
**Done when:** Essential UI elements visible and functional

---

### 📍 Milestone Checkpoint: Infrastructure Complete

-   [ ] Can reset levels cleanly
-   [ ] Can complete levels and progress
-   [ ] Basic UI shows game state

---

## Phase 6: Level Design (Weeks 6-8)

_Create 5-10 levels that teach and test the mechanic._

### 6.1 Level 1: Movement Tutorial

-   [ ] Simple platforms, no puzzles
-   [ ] Teach walk, jump, reach goal
-   [ ] No Echo required

**Time:** ~30-45 min  
**Done when:** Player learns basic movement

---

### 6.2 Level 2: First Recording

-   [ ] Pressure plate blocks door
-   [ ] Must record standing on plate
-   [ ] Walk through door during playback
-   [ ] Minimal complexity

**Time:** ~45-60 min  
**Done when:** Player understands record → playback loop

---

### 6.3 Level 3: Timing Introduction

-   [ ] Timed door puzzle
-   [ ] Echo must trigger, player must move quickly
-   [ ] Introduces timing element

**Time:** ~45-60 min  
**Done when:** Player understands timing coordination

---

### 6.4 Level 4: Lever Puzzle

-   [ ] Lever opens path for player
-   [ ] Echo pulls lever, stays there
-   [ ] Introduces permanent toggle concept

**Time:** ~45-60 min  
**Done when:** Player understands lever vs pressure plate

---

### 6.5 Level 5: Moving Platform

-   [ ] Platform only moves when plate pressed
-   [ ] Echo holds plate, player rides platform
-   [ ] Tests sustained activation

**Time:** ~45-60 min  
**Done when:** Player coordinates Echo timing with platform

---

### 6.6 Level 6-7: Combination Puzzles

-   [ ] Combine 2+ elements
-   [ ] Require more planning
-   [ ] Increase spatial complexity

**Time:** ~1-2 hours total  
**Done when:** Puzzles feel challenging but fair

---

### 6.7 Level 8-10: Advanced Puzzles (Optional)

-   [ ] Multi-step solutions
-   [ ] Longer recordings
-   [ ] Test mastery of all mechanics

**Time:** ~1-2 hours total  
**Done when:** Satisfying difficulty curve complete

---

### 6.8 Playtest and Iterate

-   [ ] Play through all levels start to finish
-   [ ] Note friction points
-   [ ] Adjust timing, distances, visual clarity
-   [ ] Get 1-2 external playtesters if possible

**Time:** ~2-3 hours  
**Done when:** Levels flow smoothly, puzzles are clear

---

## 📍 Final Milestone: Prototype Complete

-   [ ] Player movement feels good
-   [ ] Recording/playback is deterministic and reliable
-   [ ] 5-10 puzzle levels with clear progression
-   [ ] All puzzle elements functional
-   [ ] Can reset, complete, and progress through levels
-   [ ] Basic UI communicates game state
-   [ ] Placeholder art is consistent
-   [ ] No major bugs

---

## Tips for Staying on Track

### Weekly Goals

-   **Week 1:** Project setup + basic movement
-   **Week 2:** Complete movement + start recording system
-   **Week 3:** Recording system complete
-   **Week 4:** Echo playback working
-   **Week 5:** Puzzle elements
-   **Week 6:** Level infrastructure + first 3 levels
-   **Week 7-8:** Remaining levels + polish + playtesting

### Common Pitfalls to Avoid

1. **Scope creep** — Resist adding hazards, abilities, or multi-Echo until prototype validates the core
2. **Premature polish** — Placeholder art is fine; focus on feel and mechanics
3. **Over-engineering** — Start simple, refactor later if needed
4. **Skipping playtesting** — Fresh eyes catch what you miss
5. **Position-based recording** — ALWAYS use input-based recording for determinism

### Debug Tools to Build Early

-   Frame-by-frame step mode for debugging playback
-   Visual display of recorded input frames
-   Spawn Echo without recording (for testing puzzles)
-   Skip to any level (for iteration)

---

## Resources

### Godot Documentation

-   [CharacterBody2D](https://docs.godotengine.org/en/stable/classes/class_characterbody2d.html)
-   [Using CharacterBody2D](https://docs.godotengine.org/en/stable/tutorials/physics/using_character_body_2d.html)
-   [Singletons (Autoload)](https://docs.godotengine.org/en/stable/tutorials/scripting/singletons_autoload.html)
-   [C# Basics](https://docs.godotengine.org/en/stable/tutorials/scripting/c_sharp/c_sharp_basics.html)
-   [Shaders](https://docs.godotengine.org/en/stable/tutorials/shaders/shader_reference/shading_language.html)

### Asset Packs

-   [Kenney Platformer Pack](https://kenney.nl/assets/platformer-pack-redux)
-   [Kenney Input Prompts](https://kenney.nl/assets/input-prompts)
-   [Kenney UI Pack](https://kenney.nl/assets/ui-pack)

### Reference Games to Study

-   **Cursor\*10** (web) — Simplest recording mechanic
-   **The Swapper** — Clone puzzles, atmosphere
-   **Super Time Force** — Ghost chaos (what NOT to do for puzzles)

---

## Next Steps (Post-Prototype)

After validating the prototype, consider:

1. **Add hazards** — Spikes, enemies, crushers for action sections
2. **Multi-Echo system** — Allow 2-3 Echoes for complex puzzles
3. **Additional abilities** — Double jump, dash, wall slide
4. **Par times / medals** — Encourage optimization
5. **Narrative layer** — Portal-style environmental storytelling
6. **Audio polish** — Full SFX and music
7. **Art upgrade** — Commission or create final pixel art
8. **More levels** — Expand to 25+ for MVP

---

_Good luck! Record, replay, repeat._ 🎮
