# Stealth Puzzle Bomber - Implementation Plan

> **Engine:** Godot 4.x with C#  
> **Experience:** Advanced beginner with Godot (first top-down 2D), expert with C#  
> **Time Budget:** 2-5 hours/week  
> **Scope:** MVP/Prototype  
> **Art:** Placeholder shapes + Kenney assets  
> **Estimated Duration:** 10-14 weeks  
> **Last Updated:** January 2026

---

## Focus Areas

**Priority (This Plan):**

1. Player movement & feel (walk, run, hide, peek)
2. Core game loop (infiltrate → plant bomb → escape → win/fail)

**Deferred (Noted for Later):**

-   Gadgets (banana peel, coins, distractions)
-   Sound/audio system
-   Multiple guard types
-   Civilians
-   Cameras and laser grids
-   Comedy/polish elements
-   Menu system / UI polish

---

## Phase 0: Godot 2D Foundations (Week 1-2)

_Since this is your first top-down 2D game in Godot, spend time getting comfortable with the core systems._

### 0.1 - Project Setup & Editor Familiarity

-   [ ] Create new Godot 4.x project with C# support
-   [ ] Explore the editor: Scene dock, Inspector, FileSystem, Node tree
-   [ ] Set up project settings: 2D render mode, pixel art texture filtering (Nearest)
-   [ ] Create folder structure: `Scenes/`, `Scripts/`, `Assets/`, `Resources/`

**Time:** ~1 hour  
**Done when:** Project opens, C# scripts compile, folders organized

---

### 0.2 - CharacterBody2D Basics

-   [ ] Create a simple scene with a `CharacterBody2D` + `CollisionShape2D` + `Sprite2D`
-   [ ] Write a basic C# script that moves the character with WASD/arrow keys
-   [ ] Understand `MoveAndSlide()` and velocity-based movement
-   [ ] Experiment with `_PhysicsProcess` vs `_Process`

**Time:** ~1-2 hours  
**Done when:** A colored rectangle moves smoothly with keyboard input

---

### 0.3 - TileMap & Collision Layers

-   [ ] Create a `TileMapLayer` node and import a simple Kenney tileset (or placeholder)
-   [ ] Paint a small test room with walls
-   [ ] Set up collision layers: Player (layer 1), Walls (layer 2), Guards (layer 3)
-   [ ] Verify player collides with walls but can walk on floor

**Time:** ~1-2 hours  
**Done when:** Player cannot walk through walls, stays inside the room

---

### 0.4 - Area2D & Signals

-   [ ] Create an `Area2D` node with a `CollisionShape2D` (represents a "trigger zone")
-   [ ] Connect the `body_entered` signal to a C# method
-   [ ] Print a message when the player enters the zone
-   [ ] Understand the difference between `Area2D` (triggers) and `CharacterBody2D` (physics)

**Time:** ~1 hour  
**Done when:** Console prints "Player entered zone" when walking into the area

---

### ✅ Phase 0 Milestone

-   [ ] Comfortable navigating Godot editor
-   [ ] Can create CharacterBody2D with C# movement
-   [ ] Understand TileMap basics and collision layers
-   [ ] Understand Area2D signals for trigger zones

---

## Phase 1: Player Movement & Feel (Weeks 3-5)

_The core of a stealth game is how movement feels. Get this right before adding complexity._

### 1.1 - Basic Top-Down Movement

-   [ ] Create `Player.tscn` scene with `CharacterBody2D` root
-   [ ] Add `CollisionShape2D` (capsule or circle) and `Sprite2D` (placeholder square)
-   [ ] Create `Player.cs` script with 8-directional movement
-   [ ] Implement walk speed constant (~100-150 pixels/sec)
-   [ ] Add smooth rotation or instant facing direction

**Time:** ~1 hour  
**Done when:** Player moves in 8 directions at consistent speed

---

### 1.2 - Walk vs Run Toggle

-   [ ] Add run speed constant (~250-300 pixels/sec)
-   [ ] Implement hold-to-run input (Shift key)
-   [ ] Create `PlayerState` enum: `Walking`, `Running`, `Hiding`, `Peeking`
-   [ ] Visual indicator for run state (sprite color change or scale pulse)

**Time:** ~1-2 hours  
**Done when:** Holding Shift makes player visibly faster, state changes correctly

---

### 1.3 - Hide Mechanic (Cover Spots)

-   [ ] Create `HideSpot.tscn` scene with `Area2D` + visual placeholder
-   [ ] When player enters hide spot and presses interact key (E), snap to hidden position
-   [ ] Player cannot move while hiding (state = `Hiding`)
-   [ ] Press E again or move input to exit hiding
-   [ ] Visual change when hidden (fade alpha, shrink, or overlay)

**Time:** ~2 hours  
**Done when:** Player can enter/exit hiding spots, clearly visible state change

---

### 1.4 - Peek Mechanic (Corner Peeking)

-   [ ] Create `PeekSpot.tscn` at corners/doorways
-   [ ] When player is adjacent and presses peek key (Q), camera shifts to show around corner
-   [ ] Player is stationary while peeking
-   [ ] Release Q to return camera to normal

**Time:** ~2 hours  
**Done when:** Camera smoothly shifts to reveal hidden areas, returns on release

---

### 1.5 - Camera Follow

-   [ ] Add `Camera2D` as child of Player (or separate with follow logic)
-   [ ] Set appropriate zoom for top-down view (experiment: 1.5x - 3x)
-   [ ] Add slight smoothing for camera follow (`position_smoothing_enabled`)
-   [ ] Camera respects room boundaries (optional: clamp to level bounds)

**Time:** ~1 hour  
**Done when:** Camera follows player smoothly, zoom feels right for gameplay

---

### 1.6 - Test Level Layout

-   [ ] Create `TestLevel.tscn` with TileMap
-   [ ] Design a small test room: entrance, some walls, 2-3 hide spots, 1-2 peek corners
-   [ ] Place a "bomb plant location" marker (just a colored area for now)
-   [ ] Place an "exit zone" marker

**Time:** ~1-2 hours  
**Done when:** Playable test area with all movement mechanics usable

---

### ✅ Phase 1 Milestone

-   [ ] Player moves with walk/run toggle
-   [ ] Hide spots work (enter/exit)
-   [ ] Peek spots work (camera shift)
-   [ ] Camera follows player appropriately
-   [ ] Test level allows exercising all mechanics

---

## Phase 2: Basic Guard AI (Weeks 6-8)

_Simple guard with patrol and vision cone—enough to test stealth feel._

### 2.1 - Guard Scene Setup

-   [ ] Create `Guard.tscn` with `CharacterBody2D` + collision + sprite (different color than player)
-   [ ] Create `Guard.cs` script with state enum: `Patrolling`, `Alerted`, `Searching`
-   [ ] Guard faces movement direction (rotation or flip sprite)

**Time:** ~1 hour  
**Done when:** Guard exists in scene, has basic structure

---

### 2.2 - Patrol Path System

-   [ ] Create `PatrolPath.tscn` using `Path2D` + `PathFollow2D` or array of `Marker2D` waypoints
-   [ ] Guard walks between waypoints at steady pace
-   [ ] Guard pauses briefly at each waypoint (0.5-1 sec)
-   [ ] Guard loops patrol or ping-pongs back

**Time:** ~2 hours  
**Done when:** Guard walks a defined path repeatedly

---

### 2.3 - Vision Cone (Detection Zone)

-   [ ] Add `Area2D` child to Guard with `CollisionPolygon2D` shaped as cone
-   [ ] Vision cone rotates with guard's facing direction
-   [ ] Detect when Player enters vision cone (`body_entered` signal)
-   [ ] Vision cone visual: semi-transparent polygon (green = safe, yellow = alert)

**Time:** ~2 hours  
**Done when:** Vision cone visible, detects player entry

---

### 2.4 - Line-of-Sight Raycast

-   [ ] When player is in vision cone area, cast ray from guard to player
-   [ ] If ray hits wall before player, player is NOT detected (occluded)
-   [ ] If ray reaches player, start detection
-   [ ] Use `RayCast2D` or `PhysicsDirectSpaceState2D.IntersectRay()`

**Time:** ~2 hours  
**Done when:** Hiding behind walls blocks detection even if in cone area

---

### 2.5 - Detection & Grace Period

-   [ ] Implement detection meter (0-100%)
-   [ ] Meter fills while player is visible (~2 seconds to full)
-   [ ] Meter drains when player breaks line of sight
-   [ ] At 100%, guard becomes `Alerted`
-   [ ] Visual feedback: vision cone changes color as meter fills

**Time:** ~2 hours  
**Done when:** Player has ~2 seconds to break line of sight before full alert

---

### 2.6 - Alert State (Basic)

-   [ ] When alerted, guard stops patrolling
-   [ ] Guard moves toward player's last known position
-   [ ] For MVP: Alert triggers level fail (restart)
-   [ ] Flash screen or show "DETECTED" message

**Time:** ~1-2 hours  
**Done when:** Getting fully detected ends the run with clear feedback

---

### ✅ Phase 2 Milestone

-   [ ] Guard patrols a path
-   [ ] Vision cone with line-of-sight blocking
-   [ ] Detection grace period (time to hide)
-   [ ] Alert state triggers fail
-   [ ] Can sneak past guard using timing and cover

---

## Phase 3: Core Game Loop (Weeks 9-11)

_Tie everything together: infiltrate, plant bomb, escape, win/lose states._

### 3.1 - Game State Manager

-   [ ] Create `GameManager.cs` autoload/singleton
-   [ ] Track game state: `Infiltration`, `Exfiltration`, `Win`, `Lose`
-   [ ] Expose signals: `PhaseChanged`, `GameOver`
-   [ ] Other nodes subscribe to state changes

**Time:** ~1-2 hours  
**Done when:** GameManager exists, state can be changed and queried

---

### 3.2 - Bomb Plant Mechanic

-   [ ] Create `BombPlantZone.tscn` with `Area2D`
-   [ ] When player enters zone and presses interact (E), start plant animation/timer
-   [ ] Hold E for 1-2 seconds to complete planting
-   [ ] On complete: spawn bomb visual, emit signal, trigger phase change

**Time:** ~1-2 hours  
**Done when:** Player can plant bomb, visual appears, phase transitions

---

### 3.3 - Phase Transition (Infiltration → Exfiltration)

-   [ ] When bomb planted, GameManager switches to `Exfiltration`
-   [ ] Guards receive signal and change behavior:
    -   Patrol routes change (for now: just speed up, or reverse direction)
    -   Vision cones widen slightly
-   [ ] Start countdown timer (60 seconds for MVP)
-   [ ] Display timer on HUD

**Time:** ~2 hours  
**Done when:** Planting bomb changes guard behavior and starts timer

---

### 3.4 - Escape Zone & Win Condition

-   [ ] Create `EscapeZone.tscn` with `Area2D`
-   [ ] Only active during `Exfiltration` phase (visual indicator: door opens/glows)
-   [ ] When player enters during exfiltration: trigger `Win` state
-   [ ] Show "ESCAPED!" message, display time taken

**Time:** ~1 hour  
**Done when:** Reaching exit after planting bomb shows victory

---

### 3.5 - Lose Conditions

-   [ ] **Detection:** Already implemented (Phase 2)
-   [ ] **Timer:** When countdown hits 0, trigger `Lose` state (explosion catches you)
-   [ ] Show "CAUGHT IN BLAST!" or "DETECTED!" message
-   [ ] Freeze gameplay briefly, then offer restart

**Time:** ~1 hour  
**Done when:** Running out of time fails the level with clear message

---

### 3.6 - Instant Restart

-   [ ] On win or lose, press R (or any key) to restart level
-   [ ] Use `GetTree().ReloadCurrentScene()` for simplicity
-   [ ] Restart should be INSTANT (no fade, no delay—critical for feel)

**Time:** ~30 minutes  
**Done when:** Pressing R immediately restarts the level

---

### 3.7 - Basic HUD

-   [ ] Create `HUD.tscn` with CanvasLayer
-   [ ] Display current phase ("INFILTRATE" / "ESCAPE!")
-   [ ] Display timer (only during exfiltration)
-   [ ] Display simple "Press R to restart" on game over
-   [ ] Placeholder styling (readable, not pretty)

**Time:** ~1-2 hours  
**Done when:** Player always knows current phase, time remaining, and how to restart

---

### ✅ Phase 3 Milestone

-   [ ] Full loop: Enter → Sneak → Plant Bomb → Escape → Win
-   [ ] Lose by detection or timer
-   [ ] Instant restart
-   [ ] HUD shows essential info
-   [ ] Phase 2 changes feel meaningfully different

---

## Phase 4: First Playable Level (Weeks 12-14)

_Build one complete level to validate the design._

### 4.1 - Level Design on Paper

-   [ ] Sketch level layout on paper/tablet before building
-   [ ] Plan infiltration path (entrance → bomb site)
-   [ ] Plan exfiltration path (may differ from infiltration)
-   [ ] Mark guard positions and patrol routes
-   [ ] Mark hide spots and peek corners
-   [ ] Estimate clear time: aim for 1-2 minutes

**Time:** ~1 hour  
**Done when:** Paper sketch complete with all elements marked

---

### 4.2 - Build Level in Godot

-   [ ] Create `Level01.tscn`
-   [ ] Build environment with TileMap based on sketch
-   [ ] Place Player spawn point
-   [ ] Place bomb plant zone
-   [ ] Place escape zone

**Time:** ~2 hours  
**Done when:** Level geometry matches sketch

---

### 4.3 - Place Guards & Patrol Paths

-   [ ] Add 2-3 guards with distinct patrol routes
-   [ ] Ensure infiltration path requires timing/hiding
-   [ ] Ensure exfiltration has different challenge (guard positions shift)
-   [ ] Test that level is beatable but requires thought

**Time:** ~2 hours  
**Done when:** Guards patrol, player can complete level with skill

---

### 4.4 - Phase 2 Behavior Tuning

-   [ ] Adjust what changes in exfiltration:
    -   Guard speed increase?
    -   Patrol route changes?
    -   New guard positions?
-   [ ] Make phase 2 feel meaningfully different from phase 1
-   [ ] Timer should feel tight but fair (adjust as needed)

**Time:** ~2 hours  
**Done when:** Exfiltration feels like a different puzzle than infiltration

---

### 4.5 - Playtest & Iterate

-   [ ] Play the level 10+ times yourself
-   [ ] Note frustration points: unfair detection? Boring waiting?
-   [ ] Adjust guard timing, hide spot placement, timer length
-   [ ] Have 1-2 friends playtest if possible
-   [ ] Iterate until level feels fun and fair

**Time:** ~2-3 hours  
**Done when:** Level is completable, fun, and fair—you enjoy replaying it

---

### ✅ Phase 4 Milestone (MVP COMPLETE)

-   [ ] One fully playable level
-   [ ] Complete game loop from start to win/lose
-   [ ] Two-phase gameplay feels distinct
-   [ ] Instant restart enables rapid iteration
-   [ ] Core stealth puzzle gameplay validated

---

## Milestone Checklist (MVP Complete)

-   [ ] Player movement: walk, run, hide, peek
-   [ ] Camera follows player smoothly
-   [ ] Guard patrols with vision cone
-   [ ] Line-of-sight detection with grace period
-   [ ] Bomb plant mechanic triggers phase change
-   [ ] Timer countdown during exfiltration
-   [ ] Guards change behavior in phase 2
-   [ ] Win condition (escape) and lose conditions (detection, timer)
-   [ ] Instant restart
-   [ ] Basic HUD with phase and timer
-   [ ] One complete, playtested level
-   [ ] Two-phase design validated as fun

---

## Tips for Staying on Track

1. **Playtest constantly.** After every session, play what you have. Fun problems surface early.

2. **Resist feature creep.** Gadgets, cameras, and comedy are tempting—but movement and guards must feel great first.

3. **Placeholder art is fine.** Colored shapes work. Don't let art block progress.

4. **Time-box sessions.** 2-3 hours is enough. Stop even if you want to continue—fresh eyes tomorrow.

5. **Paper first for levels.** Sketching is faster than building. Iterate on paper, build once.

6. **Instant restart is non-negotiable.** If restarting feels slow, the game feels slow. Prioritize this.

7. **Guard timing is everything.** Too fast = frustrating. Too slow = boring. Test relentlessly.

8. **Celebrate milestones.** Each phase completion is real progress. Take a moment to appreciate it.

---

## Resources

### Godot Documentation

-   [CharacterBody2D](https://docs.godotengine.org/en/stable/classes/class_characterbody2d.html)
-   [TileMapLayer](https://docs.godotengine.org/en/stable/classes/class_tilemaplayer.html)
-   [Area2D](https://docs.godotengine.org/en/stable/classes/class_area2d.html)
-   [Camera2D](https://docs.godotengine.org/en/stable/classes/class_camera2d.html)
-   [Path2D & PathFollow2D](https://docs.godotengine.org/en/stable/classes/class_path2d.html)
-   [RayCast2D](https://docs.godotengine.org/en/stable/classes/class_raycast2d.html)
-   [Collision Layers & Masks](https://docs.godotengine.org/en/stable/tutorials/physics/physics_introduction.html#collision-layers-and-masks)

### Tutorials

-   [Godot C# Basics](https://docs.godotengine.org/en/stable/tutorials/scripting/c_sharp/c_sharp_basics.html)
-   [Top-Down Movement Tutorial](https://docs.godotengine.org/en/stable/getting_started/first_2d_game/index.html)
-   [State Machine Pattern in Godot](https://gdscript.com/articles/godot-state-machine/)

### Assets

-   [Kenney Assets](https://kenney.nl/assets) - Free game assets, top-down packs available
-   [OpenGameArt](https://opengameart.org/) - Free sprites and tilesets

### Inspiration

-   Play **Hotline Miami** for feel reference (instant restarts, tight levels)
-   Watch **Hotline Miami level design breakdowns** on YouTube

---

## Next Steps (Post-MVP)

Once the MVP is validated and fun, consider these expansions in order:

### Near-Term Additions

1. **Second & Third Levels** - Validate level design process is repeatable
2. **Basic Sound Effects** - Footsteps, alert sounds, bomb plant audio
3. **One Gadget (Coin Toss)** - Simple distraction to add tactical depth
4. **Camera Security System** - Rotating cameras with similar detection logic

### Medium-Term Features

5. **Multiple Guard Types** - Stationary, sleepy, paranoid variants
6. **Civilians** - Don't trigger alarms but scream and alert guards
7. **Laser Grids** - Timing-based obstacles
8. **Title Screen & Level Select** - Basic menu flow

### Full Vision

9. **Gadget Unlock System** - Earn gadgets by completing levels/par times
10. **Comedy Elements** - Guard dialogue, funny death animations, newspaper headlines
11. **Multiple Environments** - Office, warehouse, mansion tilesets
12. **Speedrun Features** - Millisecond timer, ghost replays, leaderboards
13. **Level Editor** - If community demand exists

---

## Deferred Features Reference

These were explicitly excluded from MVP but are documented for future implementation:

| Feature                 | Complexity | Notes                                 |
| ----------------------- | ---------- | ------------------------------------- |
| Gadgets (banana, coins) | Medium     | Add after core loop validated         |
| Sound/Audio             | Low-Medium | Significant polish impact             |
| Multiple guard types    | Medium     | Variations on base guard              |
| Civilians               | Medium     | Similar to guards, different behavior |
| Cameras                 | Medium     | Rotating Area2D with detection        |
| Laser grids             | Low        | Timing-based Area2D obstacles         |
| Comedy/polish           | Varies     | Art, animation, dialogue              |
| Menu/UI polish          | Medium     | Title, pause, level select            |

---

_Good luck, agent. Plant the bomb. Get out alive. Try not to knock over the plant on your way out._ 🕵️💣
