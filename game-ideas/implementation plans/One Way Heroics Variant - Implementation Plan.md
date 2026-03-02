# Pathmaker - Implementation Plan

> **Engine:** Godot 4.x with C#  
> **Time Budget:** 2-5 hours/week  
> **Focus Areas:** Chunk choice system, basic combat, Darkness pressure  
> **Estimated Duration:** 12-16 weeks  
> **Scope:** MVP/Prototype  
> **Art Approach:** Asset packs (Kenney, itch.io)

---

## Overview

This plan builds a prototype of "Pathmaker"—a roguelike where you choose map chunks as you flee the advancing Darkness. The core innovation is the **chunk choice system**: every time you reach the edge of your current area, you pick from 3 options that shape your journey.

**MVP Goal:** Validate that choosing map chunks feels meaningfully different from random generation.

---

## Phase 0: Godot Refresher & Project Setup (Week 1)

Quick refresher on Godot systems you'll use heavily. Skip any you're already comfortable with.

### 0.1 Project Setup

-   [ ] Create new Godot 4.x project with C# support
-   [ ] Set up folder structure: `Scenes/`, `Scripts/`, `Resources/`, `Art/`, `UI/`
-   [ ] Configure project settings: 2D, 320x180 base resolution, stretch mode "canvas_items"
-   [ ] Download and import Kenney asset pack(s) (e.g., "1-Bit Pack", "Roguelike/RPG Pack")

**Time:** ~30-45 min  
**Done when:** Project runs, assets imported, folders organized

### 0.2 TileMapLayer Refresher

-   [ ] Create a test scene with TileMapLayer
-   [ ] Set up a simple TileSet from Kenney assets
-   [ ] Paint a small test area (ground, walls, obstacles)
-   [ ] Understand terrain vs. decoration layers

**Time:** ~45-60 min  
**Done when:** Can paint a simple room with collision tiles

### 0.3 CharacterBody2D Refresher

-   [ ] Create a player scene with CharacterBody2D
-   [ ] Add sprite from asset pack, CollisionShape2D
-   [ ] Implement 8-direction movement with `MoveAndSlide()`
-   [ ] Test collision with tilemap walls

**Time:** ~45-60 min  
**Done when:** Player moves smoothly and collides with walls

### 0.4 Scene Instancing Refresher

-   [ ] Create a simple "enemy" scene (just a sprite + collision)
-   [ ] Instance it into your test scene via code
-   [ ] Practice `GetTree().ChangeSceneToFile()` and `AddChild()`

**Time:** ~30-45 min  
**Done when:** Can spawn scenes dynamically and switch scenes

---

## Milestone: Foundation Ready ✓

-   [ ] Project configured with C#
-   [ ] Asset pack imported
-   [ ] Basic player movement working
-   [ ] Comfortable with TileMapLayer, CharacterBody2D, scene instancing

---

## Phase 1: The Darkness (Weeks 2-3)

The Darkness is the core pressure mechanic. Get this working early—it defines the game's feel.

### 1.1 Darkness Visual Effect

-   [ ] Create a Darkness scene: a large ColorRect or Sprite2D (dark purple/black)
-   [ ] Position it on the left side of the screen, extending off-screen left
-   [ ] Add subtle particle effect on the leading edge (optional, can defer)

**Time:** ~30-45 min  
**Done when:** Dark wall visible on left side of screen

### 1.2 Darkness Movement

-   [ ] Add script to move Darkness rightward at constant speed
-   [ ] Expose `darknessSpeed` variable for tuning
-   [ ] Test: Darkness slowly advances across screen

**Time:** ~30-45 min  
**Done when:** Darkness advances at configurable speed

### 1.3 Darkness Collision & Death

-   [ ] Add Area2D to Darkness leading edge
-   [ ] Connect signal to detect player entering
-   [ ] On contact: trigger death (for now, just reload scene)
-   [ ] Add screen shake or flash on death (simple feedback)

**Time:** ~45-60 min  
**Done when:** Touching Darkness kills player and restarts

### 1.4 Camera Following Player

-   [ ] Add Camera2D as child of player
-   [ ] Set up camera limits (can't scroll left past Darkness)
-   [ ] Camera follows player but Darkness is always visible threat

**Time:** ~30-45 min  
**Done when:** Camera follows player, Darkness visible as threat approaching from left

### 1.5 Basic Test Level

-   [ ] Create a long horizontal test level (use TileMapLayer)
-   [ ] Player starts on left, must run right
-   [ ] Darkness chases—can you outrun it?
-   [ ] Tune speed so it's tense but not impossible

**Time:** ~1 hour  
**Done when:** Playable "run from Darkness" prototype, feels tense

---

## Milestone: Core Pressure Working ✓

-   [ ] Darkness advances relentlessly
-   [ ] Player can outrun it (barely)
-   [ ] Death on contact, restart
-   [ ] The tension is palpable

---

## Phase 2: Chunk System Foundation (Weeks 4-6)

This is the core innovation. Take your time here.

### 2.1 Chunk Scene Template

-   [ ] Create a base "Chunk" scene structure:
    -   Root Node2D named "Chunk"
    -   TileMapLayer for terrain
    -   Marker2D for "EntryPoint" (left side)
    -   Marker2D for "ExitPoint" (right side)
    -   Node2D container for "SpawnPoints"
-   [ ] Create a ChunkData Resource class (C#) with: `chunkName`, `difficulty`, `chunkType`

**Time:** ~1 hour  
**Done when:** Chunk template scene exists with entry/exit markers

### 2.2 Create First Chunk Variants

-   [ ] Create "Plains" chunk (Easy): open area, few obstacles, ~10 tiles wide
-   [ ] Create "Forest" chunk (Easy): trees as obstacles, some cover
-   [ ] Create "GoblinCamp" chunk (Medium): obstacles, designated enemy spawn points
-   [ ] Each chunk uses the template structure

**Time:** ~1.5-2 hours  
**Done when:** 3 distinct chunk scenes exist

### 2.3 Chunk Manager Singleton

-   [ ] Create ChunkManager autoload (singleton)
-   [ ] Store references to all chunk scene paths
-   [ ] Method: `GetRandomChunks(count)` returns N random chunk paths
-   [ ] Method: `GetChunksByDifficulty(difficulty)` filters by difficulty

**Time:** ~1 hour  
**Done when:** ChunkManager can provide random chunk options

### 2.4 Chunk Spawning System

-   [ ] Create "World" scene as main game scene
-   [ ] On start, spawn first chunk at origin
-   [ ] Track current chunk and its exit position
-   [ ] Method: `SpawnNextChunk(chunkPath)` places chunk at current exit

**Time:** ~1-1.5 hours  
**Done when:** Can spawn chunks end-to-end programmatically

### 2.5 Chunk Transition Detection

-   [ ] Add Area2D trigger at each chunk's exit point
-   [ ] When player enters exit area, emit signal "PlayerReachedExit"
-   [ ] World scene listens for this signal

**Time:** ~45-60 min  
**Done when:** Game detects when player reaches chunk exit

### 2.6 Old Chunk Cleanup

-   [ ] Track spawned chunks in a list
-   [ ] When Darkness fully consumes a chunk, queue_free() it
-   [ ] Check Darkness position vs. chunk boundaries

**Time:** ~45-60 min  
**Done when:** Old chunks are cleaned up, memory stays stable

---

## Milestone: Chunks Connect ✓

-   [ ] Multiple chunks spawn in sequence
-   [ ] Player can run through connected chunks
-   [ ] Old chunks get cleaned up
-   [ ] Darkness still chases through all chunks

---

## Phase 3: Chunk Choice UI (Weeks 7-8)

The moment of decision. This is where the game becomes unique.

### 3.1 Choice UI Layout

-   [ ] Create ChunkChoiceUI scene (CanvasLayer + Control nodes)
-   [ ] Layout: 3 panels side by side showing chunk options
-   [ ] Each panel shows: chunk name, difficulty indicator, icon (placeholder)
-   [ ] Keyboard navigation (1, 2, 3 keys) and click support

**Time:** ~1-1.5 hours  
**Done when:** UI displays 3 chunk options

### 3.2 Choice UI Data Binding

-   [ ] Create ChunkOption class: name, difficulty, scenePath, preview info
-   [ ] UI accepts array of 3 ChunkOptions and displays them
-   [ ] Difficulty shown as color or stars (Easy=green, Medium=yellow, Hard=red)

**Time:** ~1 hour  
**Done when:** UI dynamically shows chunk data

### 3.3 Trigger Choice on Exit

-   [ ] When player reaches exit, pause game (or slow Darkness significantly)
-   [ ] Show ChunkChoiceUI with 3 random options
-   [ ] Player selects one, UI emits "ChunkChosen" signal with selected chunk

**Time:** ~1 hour  
**Done when:** Reaching exit shows choice UI

### 3.4 Auto-Select Timer

-   [ ] Add countdown timer to choice UI (10-15 seconds)
-   [ ] Visual countdown bar
-   [ ] On timeout, auto-select easiest option
-   [ ] Maintains tension even during choice

**Time:** ~45-60 min  
**Done when:** Choice times out and auto-selects

### 3.5 Connect Choice to Spawning

-   [ ] On "ChunkChosen" signal, spawn the selected chunk
-   [ ] Dismiss UI, resume game
-   [ ] Player continues into new chunk

**Time:** ~45-60 min  
**Done when:** Full loop works: run → reach exit → choose → new chunk spawns → continue

---

## Milestone: Core Loop Complete ✓

-   [ ] Run from Darkness
-   [ ] Reach exit, choose from 3 chunks
-   [ ] Selected chunk spawns
-   [ ] Repeat until death or victory
-   [ ] **Playtest this heavily!** Does choosing feel meaningful?

---

## Phase 4: Basic Combat (Weeks 9-10)

Keep combat simple. Focus on it feeling responsive, not deep.

### 4.1 Warrior Player Setup

-   [ ] Add attack animation frames (or use single sprite + effects)
-   [ ] Create melee attack hitbox (Area2D, disabled by default)
-   [ ] Attack input (Spacebar): enable hitbox briefly, play animation
-   [ ] Cooldown between attacks (~0.5s)

**Time:** ~1-1.5 hours  
**Done when:** Player can swing attack with cooldown

### 4.2 Enemy Base Class

-   [ ] Create base Enemy scene: CharacterBody2D, sprite, collision, health
-   [ ] Enemy takes damage when hit by player attack hitbox
-   [ ] On death: play effect, drop nothing (loot comes later), queue_free()
-   [ ] Simple health bar above enemy (optional for MVP)

**Time:** ~1-1.5 hours  
**Done when:** Enemies can be killed

### 4.3 Basic Enemy AI

-   [ ] Simple patrol: move left/right between points
-   [ ] Detection: if player within range, move toward player
-   [ ] Attack: if adjacent to player, deal damage on timer
-   [ ] Keep it simple—no pathfinding

**Time:** ~1-1.5 hours  
**Done when:** Enemies patrol and chase/attack player

### 4.4 Player Health & Damage

-   [ ] Add health to player (e.g., 100 HP)
-   [ ] Player takes damage from enemy attacks
-   [ ] Simple UI: health bar in corner
-   [ ] On death: same as Darkness death (restart)

**Time:** ~1 hour  
**Done when:** Player can die to enemies

### 4.5 Enemy Spawning in Chunks

-   [ ] Use SpawnPoints in chunk template
-   [ ] ChunkManager populates spawn points based on chunk difficulty
-   [ ] Easy chunks: 0-2 enemies, Medium: 2-4, Hard: 3-6
-   [ ] Spawn from enemy pool randomly

**Time:** ~1 hour  
**Done when:** Chunks spawn appropriate enemies

### 4.6 Create Enemy Variants

-   [ ] Goblin: low HP, medium speed, melee
-   [ ] Slime: low HP, slow, melee
-   [ ] Archer: medium HP, stationary, ranged (simple projectile)
-   [ ] Assign enemy types to chunk types (Goblins in camps, etc.)

**Time:** ~1.5-2 hours  
**Done when:** 3 enemy types with distinct behaviors

---

## Milestone: Combat Functional ✓

-   [ ] Player can attack and kill enemies
-   [ ] Enemies fight back
-   [ ] Chunks spawn enemies based on difficulty
-   [ ] Combat feels responsive (not deep, just responsive)

---

## Phase 5: Loot & Risk/Reward (Weeks 11-12)

Make harder chunks worth the risk.

### 5.1 Item Data Structure

-   [ ] Create Item Resource: name, type (weapon/consumable), stats
-   [ ] Create a few test items:
    -   Sword (weapon): +5 attack
    -   Health Potion (consumable): restore 30 HP
    -   Shield (armor): +3 defense

**Time:** ~45-60 min  
**Done when:** Item resources defined

### 5.2 Simple Inventory

-   [ ] Player has inventory array (limit 6-8 slots)
-   [ ] Can equip 1 weapon, 1 armor
-   [ ] Consumables used from inventory
-   [ ] Basic inventory UI (grid of icons)

**Time:** ~1.5-2 hours  
**Done when:** Can pick up, view, use/equip items

### 5.3 Loot Drops

-   [ ] Enemies drop items on death (% chance)
-   [ ] Loot spawns as pickup node, player walks over to collect
-   [ ] Drop quality based on enemy type/difficulty

**Time:** ~1 hour  
**Done when:** Killing enemies can drop loot

### 5.4 Loot Chests in Chunks

-   [ ] Create Chest scene: sprite, interaction Area2D
-   [ ] Player presses E near chest to open
-   [ ] Chest gives random item based on chunk difficulty
-   [ ] Place chests in harder chunks

**Time:** ~1 hour  
**Done when:** Chests can be opened for loot

### 5.5 Chunk Completion Bonus

-   [ ] Track when player exits a chunk
-   [ ] If chunk was Medium+, grant bonus gold/item
-   [ ] Display brief popup: "Chunk Complete! +50 gold"

**Time:** ~45-60 min  
**Done when:** Harder chunks give completion rewards

### 5.6 Risk/Reward Tuning Pass

-   [ ] Playtest: Is Hard worth it? Is Easy too safe?
-   [ ] Adjust enemy counts, loot quality, completion bonuses
-   [ ] Goal: player should sometimes want each difficulty

**Time:** ~1-2 hours (iterative)  
**Done when:** All difficulty levels feel like valid choices

---

## Milestone: Risk/Reward Loop ✓

-   [ ] Harder chunks have more/tougher enemies
-   [ ] Harder chunks have better loot
-   [ ] Completing hard chunks grants bonuses
-   [ ] Player genuinely weighs risk vs. reward

---

## Phase 6: Win Condition & Polish (Weeks 13-14)

### 6.1 Run Length & Victory

-   [ ] Track chunks completed count
-   [ ] After N chunks (e.g., 10-15), spawn "Sanctuary" chunk
-   [ ] Reaching Sanctuary = victory
-   [ ] Show simple victory screen with stats

**Time:** ~1 hour  
**Done when:** Game has a win condition

### 6.2 Remaining Chunk Types

-   [ ] Create "Village" chunk (Safe): no enemies, shop placeholder (just healing)
-   [ ] Create "Ruins" chunk (Hard): many enemies, best loot
-   [ ] Create "Shrine" chunk (Variable): random buff or debuff
-   [ ] Total: 6 chunk types as planned

**Time:** ~2-3 hours  
**Done when:** 6 distinct chunk types playable

### 6.3 Chunk Choice Variety

-   [ ] Ensure choice options are distinct (not 3 of same type)
-   [ ] Guarantee at least one "easier" option always available
-   [ ] Weight harder chunks less common early, more common late

**Time:** ~1 hour  
**Done when:** Choices feel varied and fair

### 6.4 Visual Polish

-   [ ] Consistent art from asset pack across all chunks
-   [ ] Player/enemy sprites have idle animations
-   [ ] Attack effects (slash, hit flash)
-   [ ] Darkness edge particles

**Time:** ~2-3 hours  
**Done when:** Game looks cohesive

### 6.5 Game Feel Polish

-   [ ] Screen shake on hit
-   [ ] Brief hitstop on attacks
-   [ ] Damage numbers (optional)
-   [ ] Smooth camera (add slight drag)

**Time:** ~1-2 hours  
**Done when:** Combat feels impactful

### 6.6 Basic Difficulty Scaling

-   [ ] Darkness speeds up slightly as run progresses
-   [ ] Enemy HP/damage scales with chunk count
-   [ ] Loot quality scales to match

**Time:** ~1 hour  
**Done when:** Late game is harder than early game

---

## Milestone: MVP Complete ✓

-   [ ] Complete run from start to Sanctuary possible
-   [ ] 6 chunk types with distinct identities
-   [ ] Risk/reward choices feel meaningful
-   [ ] Combat is functional and responsive
-   [ ] Game looks and feels cohesive

---

## Final MVP Checklist

### Core Systems

-   [ ] Darkness advances and kills player
-   [ ] Chunk choice system with 3 options
-   [ ] Chunks spawn connected, old ones cleaned up
-   [ ] Choice UI with timer and preview info

### Combat

-   [ ] Warrior class with melee attack
-   [ ] 3 enemy types
-   [ ] Player and enemy health/damage
-   [ ] Enemies spawn based on chunk difficulty

### Progression

-   [ ] Items drop from enemies and chests
-   [ ] Simple inventory and equipment
-   [ ] Harder chunks = better rewards
-   [ ] Win condition (reach Sanctuary)

### Content

-   [ ] 6 chunk types: Plains, Forest, Village, Goblin Camp, Ruins, Shrine
-   [ ] Difficulty variety in chunk options
-   [ ] Cohesive visual style from asset pack

---

## Tips for Staying on Track

1. **Playtest the core loop early (end of Phase 3)**  
   If choosing chunks doesn't feel meaningful, iterate before adding combat.

2. **Resist feature creep**  
   The document has amazing ideas (quests, resource chains, meta-progression). Save them for post-MVP.

3. **Timebox polish**  
   It's easy to spend forever on "feel." Set a time limit and move on.

4. **One class is enough**  
   Warrior only. Adding classes multiplies content needs.

5. **Playtest with fresh eyes**  
   Have someone else try it. Watch them, don't explain.

6. **Commit often**  
   Use git. Commit after each step. You'll thank yourself.

---

## Resources

### Godot 4 / C#

-   [Godot 4 C# Documentation](https://docs.godotengine.org/en/stable/tutorials/scripting/c_sharp/index.html)
-   [CharacterBody2D Tutorial](https://docs.godotengine.org/en/stable/tutorials/physics/using_character_body_2d.html)
-   [TileMap/TileSet Guide](https://docs.godotengine.org/en/stable/tutorials/2d/using_tilemaps.html)
-   [Signals in C#](https://docs.godotengine.org/en/stable/tutorials/scripting/c_sharp/c_sharp_signals.html)

### Art Assets

-   [Kenney Assets](https://kenney.nl/assets) (free, CC0)
-   [itch.io Game Assets](https://itch.io/game-assets/free/tag-pixel-art)

### Design Reference

-   [One Way Heroics](https://store.steampowered.com/app/266210/One_Way_Heroics/) (play it if you haven't!)
-   [Slay the Spire Map System](https://slay-the-spire.fandom.com/wiki/Map) (path choice reference)

---

## Future Features (Post-MVP)

These are explicitly deferred. Only consider after MVP is validated:

### Additional Classes

-   Ranger (ranged, mobile)
-   Mage (high damage, fragile)
-   Rogue (fast, burst damage)
-   Merchant (economy focused)

### Combat Depth

-   Abilities beyond basic attack
-   Detailed enemy AI with pathfinding
-   Boss encounters

### Meta Systems

-   Meta-progression (unlock classes, items, chunks)
-   Save/load system
-   Quest chains ("clear the goblin camp ahead")
-   Resource chains (ore → blacksmith)
-   Multiple exits per chunk

### Polish

-   Full audio (music, SFX)
-   Narrative framing (why is Darkness chasing?)
-   Multiple endings
-   Daily/weekly challenge seeds

---

## Estimated Timeline Summary

| Phase     | Focus                  | Weeks        | Hours (@ 3.5 hrs/wk avg) |
| --------- | ---------------------- | ------------ | ------------------------ |
| 0         | Setup & Refresher      | 1            | 3-4                      |
| 1         | The Darkness           | 2            | 5-7                      |
| 2         | Chunk System           | 3            | 8-10                     |
| 3         | Chunk Choice UI        | 2            | 5-7                      |
| 4         | Basic Combat           | 2            | 7-10                     |
| 5         | Loot & Risk/Reward     | 2            | 6-8                      |
| 6         | Win Condition & Polish | 2            | 8-12                     |
| **Total** |                        | **14 weeks** | **42-58 hours**          |

---

_Good luck, Pathmaker. The Darkness waits for no one._ 🌑➡️
