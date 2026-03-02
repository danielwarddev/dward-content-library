# Runebound Gauntlet - Implementation Plan

## Project Metadata

| Field                    | Value                                                                |
| ------------------------ | -------------------------------------------------------------------- |
| **Engine**               | Godot 4.x with C#                                                    |
| **Developer Experience** | Advanced beginner Godot, expert C#                                   |
| **Time Budget**          | 2-5 hours/week                                                       |
| **Scope**                | MVP/Prototype - Core Skilling Loop                                   |
| **Art Approach**         | Placeholder art initially                                            |
| **Estimated Duration**   | 12-16 weeks                                                          |
| **Focus Areas**          | Gathering, Skills, Inventory, Relics, Tasks                          |
| **Deferred Features**    | Combat, Multiple Biomes, Audio/Polish, Save System, Meta-Progression |

---

## Phase 0: Learning & Setup (Week 1)

Foundation work before diving into game-specific features.

### 0.1 - Project Setup

-   [ ] Create new Godot 4.x project with C# support enabled
-   [ ] Set up folder structure: `Scenes/`, `Scripts/`, `Resources/`, `Assets/`
-   [ ] Configure `.gitignore` for Godot + C# (ignore `.godot/`, `*.mono/`, etc.)
-   [ ] Initial commit to version control

**Time:** ~30-45 minutes  
**Done when:** Project opens in Godot, C# scripts compile, Git repo initialized

### 0.2 - Tilemap Refresher

-   [ ] Create a test scene with a `TileMapLayer` node
-   [ ] Import or create a simple placeholder tileset (grass, dirt, rock, water - 16x16 or 32x32)
-   [ ] Paint a small test map manually (20x20 tiles)
-   [ ] Experiment with multiple tilemap layers (ground, resources, obstacles)

**Time:** ~1-2 hours  
**Done when:** You have a painted test map with at least 2 layers and understand layer ordering

### 0.3 - Basic Player Movement

-   [ ] Create a `Player` scene with `CharacterBody2D`, `Sprite2D`, `CollisionShape2D`
-   [ ] Add placeholder sprite (colored rectangle or simple icon)
-   [ ] Implement 8-directional movement with `MoveAndSlide()`
-   [ ] Set up input actions in Project Settings (move_up, move_down, move_left, move_right)
-   [ ] Add camera that follows player (`Camera2D` as child)

**Time:** ~1-2 hours  
**Done when:** Player moves smoothly in 8 directions, camera follows, collides with obstacles

---

## ✅ Milestone Checkpoint: Foundation Complete

-   [ ] Project structure in place
-   [ ] Tilemap basics understood
-   [ ] Player moves around a static test world
-   [ ] Ready to build game systems

---

## Phase 1: Resource Nodes & Gathering (Weeks 2-4)

Build the core "click on thing, get stuff" loop.

### 1.1 - Resource Node Base Class

-   [ ] Create `ResourceNode.cs` base class extending `Area2D` or `StaticBody2D`
-   [ ] Add properties: `ResourceType`, `Tier`, `YieldAmount`, `GatherTime`, `Depleted`
-   [ ] Add placeholder sprite and collision shape
-   [ ] Implement `OnInteract()` method stub

**Time:** ~45-60 minutes  
**Done when:** Base class exists with properties, can be placed in scene

### 1.2 - Specific Resource Types

-   [ ] Create `OreNode` extending `ResourceNode` (for Mining)
-   [ ] Create `TreeNode` extending `ResourceNode` (for Woodcutting)
-   [ ] Create `FishingSpot` extending `ResourceNode` (for Fishing)
-   [ ] Give each type distinct placeholder visuals (different colored shapes)

**Time:** ~1 hour  
**Done when:** Three resource node types exist with unique visuals

### 1.3 - Interaction System

-   [ ] Create `InteractionManager.cs` singleton/autoload
-   [ ] Detect when player is near interactable objects (Area2D signals or raycast)
-   [ ] Show interaction prompt UI ("Press E to Mine")
-   [ ] Handle interaction input and route to appropriate node

**Time:** ~1.5-2 hours  
**Done when:** Walking near a node shows prompt, pressing interact key triggers `OnInteract()`

### 1.4 - Gathering Action with Progress

-   [ ] Implement gathering as a timed action (progress bar fills)
-   [ ] Create simple `GatheringProgressBar` UI element
-   [ ] Player cannot move while gathering (or movement cancels)
-   [ ] On completion, call method to give resource to player
-   [ ] Node becomes "depleted" visually (alpha change or sprite swap)

**Time:** ~2-3 hours  
**Done when:** Player holds interact, progress bar fills, node depletes on completion

### 1.5 - Resource Respawning

-   [ ] Add `RespawnTime` property to `ResourceNode`
-   [ ] Start respawn timer when depleted
-   [ ] Restore node to harvestable state after timer
-   [ ] Visual feedback for respawning (semi-transparent or different sprite)

**Time:** ~45-60 minutes  
**Done when:** Depleted nodes respawn after configured time

---

## ✅ Milestone Checkpoint: Gathering Works

-   [ ] Three resource node types in the world
-   [ ] Player can walk up, hold interact, see progress bar
-   [ ] Resources deplete and respawn
-   [ ] Core "gather stuff" feel is present

---

## Phase 2: Inventory System (Weeks 4-6)

Store and display gathered resources.

### 2.1 - Item Data Structure

-   [ ] Create `ItemData.cs` resource class (`Resource` in Godot)
-   [ ] Properties: `Id`, `Name`, `Icon`, `StackSize`, `Category`, `Tier`
-   [ ] Create enum for `ItemCategory` (RawMaterial, ProcessedMaterial, Tool, Consumable)
-   [ ] Create a few test item definitions as `.tres` files

**Time:** ~1 hour  
**Done when:** Item data resources can be created and saved in the editor

### 2.2 - Inventory Data Model

-   [ ] Create `Inventory.cs` class (not a Node, pure C# class)
-   [ ] Implement slot-based storage (array of `InventorySlot` with `ItemData` + `Quantity`)
-   [ ] Methods: `AddItem()`, `RemoveItem()`, `HasItem()`, `GetQuantity()`
-   [ ] Handle stacking logic (respect `StackSize`)
-   [ ] Emit signals/events when inventory changes

**Time:** ~1.5-2 hours  
**Done when:** Inventory class can add/remove items, respects stacking, signals on change

### 2.3 - Player Inventory Integration

-   [ ] Add `Inventory` instance to Player
-   [ ] Connect gathering completion to `AddItem()` call
-   [ ] Debug output to console showing items gained

**Time:** ~30-45 minutes  
**Done when:** Gathering a node adds item to player inventory (visible in console)

### 2.4 - Inventory UI Panel

-   [ ] Create `InventoryUI` scene (Control node hierarchy)
-   [ ] Grid of `InventorySlot` UI elements (TextureRect + Label for quantity)
-   [ ] Toggle visibility with Tab key (or I key)
-   [ ] Connect to inventory data, update when inventory changes

**Time:** ~2-3 hours  
**Done when:** Pressing Tab opens inventory, shows items with icons and quantities

### 2.5 - UI Polish Pass

-   [ ] Add slot highlighting on hover
-   [ ] Tooltip showing item name on hover
-   [ ] Visual feedback when item is added (slot flash or animation)
-   [ ] Clean up layout and sizing

**Time:** ~1-2 hours  
**Done when:** Inventory feels responsive and readable

---

## ✅ Milestone Checkpoint: Inventory Complete

-   [ ] Items have data definitions
-   [ ] Gathering adds items to inventory
-   [ ] UI displays inventory contents
-   [ ] Player can see their collected resources

---

## Phase 3: Skills & XP System (Weeks 6-8)

Make gathering level up skills.

### 3.1 - Skill Data Structure

-   [ ] Create `SkillData.cs` with properties: `Id`, `Name`, `CurrentXP`, `Level`
-   [ ] Implement XP-to-level curve (e.g., `level = floor(sqrt(xp / 100))` or lookup table)
-   [ ] Method: `AddXP(amount)` that handles leveling
-   [ ] Signal/event when level changes

**Time:** ~1 hour  
**Done when:** Skill class can gain XP and level up correctly

### 3.2 - Player Skills Collection

-   [ ] Create `PlayerSkills.cs` component/class
-   [ ] Initialize skills: Mining, Woodcutting, Fishing, Smithing, Cooking
-   [ ] Methods to get skill by type, add XP to specific skill
-   [ ] Attach to Player node

**Time:** ~45-60 minutes  
**Done when:** Player has all five skills initialized at level 1

### 3.3 - XP from Gathering

-   [ ] Add `XPReward` and `RequiredSkill` properties to `ResourceNode`
-   [ ] On gather completion, grant XP to appropriate skill
-   [ ] Show floating XP text at gather location ("+15 Mining XP")

**Time:** ~1-1.5 hours  
**Done when:** Gathering ore grants Mining XP, trees grant Woodcutting XP, etc.

### 3.4 - Skill Requirements

-   [ ] Add `RequiredLevel` property to `ResourceNode`
-   [ ] Check player skill level before allowing gather
-   [ ] Show "Requires Mining 15" message if too low
-   [ ] Tier resources: Tier 1 (level 1), Tier 2 (level 10), Tier 3 (level 20)

**Time:** ~1 hour  
**Done when:** Higher-tier nodes require higher skill levels to gather

### 3.5 - Skills UI Panel

-   [ ] Create `SkillsUI` scene showing all skills
-   [ ] Display: Skill name, current level, XP progress bar to next level
-   [ ] Toggle with different key than inventory (K key?)
-   [ ] Update in real-time as XP is gained

**Time:** ~1.5-2 hours  
**Done when:** Skills panel shows levels and XP progress, updates on XP gain

### 3.6 - Skill Level Benefits

-   [ ] Implement gathering speed bonus from skill level (+2% per level)
-   [ ] Implement yield bonus at level milestones (level 10: +1 yield, etc.)
-   [ ] Show current bonuses in skill tooltip

**Time:** ~1 hour  
**Done when:** Higher skill levels make gathering faster and more rewarding

---

## ✅ Milestone Checkpoint: Skills Working

-   [ ] Five skills track XP and levels
-   [ ] Gathering grants XP
-   [ ] Higher tiers require higher levels
-   [ ] Level benefits are noticeable
-   [ ] UI shows skill progress

---

## Phase 4: Processing Stations (Weeks 8-10)

Transform raw resources into processed goods.

### 4.1 - Recipe Data Structure

-   [ ] Create `RecipeData.cs` resource class
-   [ ] Properties: `Inputs` (list of ItemData + quantity), `Outputs`, `ProcessingTime`, `RequiredSkill`, `RequiredLevel`
-   [ ] Create test recipes: Ore → Bar, Logs → Planks, Raw Fish → Cooked Fish

**Time:** ~1 hour  
**Done when:** Recipe resources can be created in editor with inputs/outputs

### 4.2 - Processing Station Base

-   [ ] Create `ProcessingStation.cs` extending `Area2D`
-   [ ] Properties: `StationType`, `AvailableRecipes`
-   [ ] On interact, open processing UI

**Time:** ~45-60 minutes  
**Done when:** Interacting with a furnace/anvil opens a dedicated UI

### 4.3 - Processing UI

-   [ ] Create `ProcessingUI` scene
-   [ ] Show available recipes for this station
-   [ ] Display required inputs, outputs, and player's current quantities
-   [ ] "Craft" button enabled only when player has required items

**Time:** ~2-3 hours  
**Done when:** UI shows recipes, indicates which are craftable based on inventory

### 4.4 - Crafting Execution

-   [ ] On craft button press, check inventory for inputs
-   [ ] Remove input items from inventory
-   [ ] Start processing timer with progress bar
-   [ ] On completion, add output items to inventory
-   [ ] Grant XP to appropriate processing skill

**Time:** ~1.5-2 hours  
**Done when:** Full craft flow works: select recipe → wait → receive output + XP

### 4.5 - Multiple Station Types

-   [ ] Create `Furnace` station (Smithing recipes: ore → bars)
-   [ ] Create `Anvil` station (Smithing recipes: bars → equipment)
-   [ ] Create `CookingFire` station (Cooking recipes: raw → cooked food)
-   [ ] Place stations in test world

**Time:** ~1 hour  
**Done when:** Three station types exist with appropriate recipes

---

## ✅ Milestone Checkpoint: Processing Complete

-   [ ] Raw resources can be processed into refined goods
-   [ ] Smithing and Cooking skills gain XP from processing
-   [ ] Recipe UI is functional
-   [ ] Resource → Process → Better Resource loop works

---

## Phase 5: Relic System Foundation (Weeks 10-12)

Introduce build-defining modifiers.

### 5.1 - Relic Data Structure

-   [ ] Create `RelicData.cs` resource class
-   [ ] Properties: `Id`, `Name`, `Description`, `Tier` (Minor/Major/Legendary), `Icon`
-   [ ] Create enum `RelicEffectType` for different modifier categories
-   [ ] Design 5-8 starter relics on paper first

**Time:** ~1 hour  
**Done when:** Relic data structure defined, initial relics documented

### 5.2 - Modifier System Architecture

-   [ ] Create `StatModifier.cs` with `ModifierType`, `Value`, `Source`
-   [ ] Create `PlayerStats.cs` to aggregate base stats + modifiers
-   [ ] Implement `AddModifier()` / `RemoveModifier()` methods
-   [ ] Calculate final stats: `GetGatheringSpeed()`, `GetXPMultiplier()`, etc.

**Time:** ~2-3 hours  
**Done when:** Stat system can apply and remove modifiers, calculate final values

### 5.3 - Implement First Relics

-   [ ] **Prospector's Instinct:** +25% Mining speed
-   [ ] **Lumberjack's Fury:** +25% Woodcutting speed
-   [ ] **Scholar's Focus:** +20% XP gain (all skills)
-   [ ] **Efficient Artisan:** -25% processing time
-   [ ] **Bountiful Harvest:** +1 yield from all gathering

**Time:** ~2 hours  
**Done when:** Five relics implemented and affect gameplay when active

### 5.4 - Relic Selection UI

-   [ ] Create `RelicSelectionUI` scene
-   [ ] Display 3 random relics as cards with name, description, tier
-   [ ] Player clicks to select one
-   [ ] Selected relic applies to player immediately

**Time:** ~2 hours  
**Done when:** UI presents 3 choices, selection adds relic effects to player

### 5.5 - Relic Activation Points

-   [ ] Create `Shrine` interactable that triggers relic selection
-   [ ] Place 2-3 shrines in test world
-   [ ] Track which relics player has acquired this run
-   [ ] Show active relics in a small UI element (icons near health bar area)

**Time:** ~1.5 hours  
**Done when:** Player can find shrines, choose relics, see active relics on HUD

### 5.6 - Relic Synergy Testing

-   [ ] Add 3 more relics that interact with existing ones:
    -   **Chain Harvest:** 15% chance gathering triggers adjacent node
    -   **Echo of Action:** 10% chance any action repeats free
    -   **Polymath:** -20% XP per skill, but all skills train together
-   [ ] Test combinations for interesting synergies

**Time:** ~2 hours  
**Done when:** 8 total relics, some with synergy potential, all working correctly

---

## ✅ Milestone Checkpoint: Relics Working

-   [ ] 8 relics with varied effects
-   [ ] Modifier system affects gathering, XP, processing
-   [ ] Shrines offer relic choices
-   [ ] Active relics visible on HUD
-   [ ] Build variety is emerging

---

## Phase 6: Task System (Weeks 12-14)

Give players directed goals.

### 6.1 - Task Data Structure

-   [ ] Create `TaskData.cs` resource class
-   [ ] Properties: `Id`, `Name`, `Description`, `Requirements` (list), `Rewards`
-   [ ] Requirement types: GatherItem, ReachSkillLevel, ProcessItem
-   [ ] Reward types: Items, XP, RelicUnlockPoint

**Time:** ~1 hour  
**Done when:** Task data can express "Mine 20 Iron Ore for +50 Mining XP"

### 6.2 - Task Tracking System

-   [ ] Create `TaskManager.cs` singleton
-   [ ] Track active tasks and their progress
-   [ ] Listen to relevant events (item gathered, skill leveled, item processed)
-   [ ] Update task progress when conditions are met

**Time:** ~2 hours  
**Done when:** System tracks progress toward task goals automatically

### 6.3 - Task Completion & Rewards

-   [ ] Detect when task requirements are fully met
-   [ ] Grant rewards to player (items, XP)
-   [ ] Mark task as complete
-   [ ] Trigger UI notification ("Task Complete!")

**Time:** ~1 hour  
**Done when:** Completing a task grants rewards and shows feedback

### 6.4 - Task UI Panel

-   [ ] Create `TasksUI` scene with list of active tasks
-   [ ] Show task name, description, progress (e.g., "12/20 Iron Ore")
-   [ ] Highlight completed tasks
-   [ ] Toggle with J key

**Time:** ~2 hours  
**Done when:** Tasks panel shows active tasks with live progress updates

### 6.5 - Initial Task Set

-   [ ] Create 10-15 tasks spanning different skills:
    -   Gathering tasks: "Mine 20 Copper Ore", "Chop 15 Oak Logs"
    -   Processing tasks: "Smelt 10 Iron Bars", "Cook 5 Salmon"
    -   Level tasks: "Reach Mining Level 10"
    -   Combined: "Smith an Iron Sword"
-   [ ] Assign appropriate rewards to each

**Time:** ~1.5 hours  
**Done when:** 10-15 tasks exist and are completable

### 6.6 - Task Progression

-   [ ] Some tasks unlock after others complete
-   [ ] Implement task prerequisites in `TaskData`
-   [ ] On task complete, check for newly available tasks
-   [ ] Add newly available tasks to active list

**Time:** ~1 hour  
**Done when:** Completing early tasks unlocks harder/later tasks

---

## ✅ Milestone Checkpoint: Tasks Complete

-   [ ] 10-15 tasks with varied goals
-   [ ] Progress tracks automatically
-   [ ] Rewards granted on completion
-   [ ] Task chains provide progression
-   [ ] Players have directed goals

---

## Phase 7: Static World & Integration (Weeks 14-16)

Create a cohesive test world and tie systems together.

### 7.1 - Design Test World Layout

-   [ ] Sketch world on paper: player start, resource zones, stations, shrines
-   [ ] Plan resource distribution (low-tier near start, higher-tier further out)
-   [ ] Place 2-3 shrines at meaningful locations
-   [ ] Include "gated" areas requiring skill levels to access (optional)

**Time:** ~1 hour  
**Done when:** World layout is planned and documented

### 7.2 - Build World in Tilemap

-   [ ] Create 50x50 (or larger) world with varied terrain
-   [ ] Paint ground layer (grass, dirt, paths)
-   [ ] Add obstacle layer (trees, rocks, water for collision)
-   [ ] Add decoration layer (bushes, flowers for visual interest)

**Time:** ~2-3 hours  
**Done when:** World looks complete with multiple terrain types

### 7.3 - Populate with Interactables

-   [ ] Place resource nodes throughout world (tiered by distance/area)
-   [ ] Place processing stations in logical locations (furnace near ore, etc.)
-   [ ] Place shrines at exploration rewards
-   [ ] Balance density: enough to gather, not overwhelming

**Time:** ~1.5-2 hours  
**Done when:** World is populated with all interactable elements

### 7.4 - Run Flow: Start & End

-   [ ] Create title screen with "Start Run" button
-   [ ] Initialize player with empty inventory, level 1 skills, no relics
-   [ ] Create "Run Complete" trigger (complete X tasks or reach goal area)
-   [ ] Show run summary screen (tasks completed, skills gained, relics acquired)

**Time:** ~2-3 hours  
**Done when:** Full run flow from title → play → end screen works

### 7.5 - HUD Integration

-   [ ] Combine all HUD elements: active relics, minimap (optional), quick stats
-   [ ] Add resource gathering feedback (floating numbers)
-   [ ] Add level-up celebration effect (visual flash, sound placeholder)
-   [ ] Ensure UI doesn't overlap or obstruct gameplay

**Time:** ~1.5-2 hours  
**Done when:** HUD is clean, informative, and non-intrusive

### 7.6 - Playtest & Balance Pass

-   [ ] Play through a full "run" (30-45 minutes)
-   [ ] Note pain points: pacing, XP curves, gather times
-   [ ] Adjust values in resource files
-   [ ] Repeat until core loop feels satisfying

**Time:** ~2-3 hours  
**Done when:** One full run feels engaging with reasonable progression

---

## ✅ FINAL MILESTONE: MVP Complete

-   [ ] Player can start a run from title screen
-   [ ] World has resources, stations, and shrines
-   [ ] Five skills level up through gameplay
-   [ ] 8 relics offer build variety
-   [ ] 10-15 tasks provide direction
-   [ ] Run ends with summary screen
-   [ ] Core loop is fun and functional

---

## Future Features (Post-MVP)

These were intentionally deferred. Tackle them after validating the core loop:

### Combat System

-   [ ] Enemy types and AI
-   [ ] Combat stats (Health, Damage, Defense)
-   [ ] Real-time combat with attacks and dodging
-   [ ] Combat skills (Melee, Ranged, Magic)
-   [ ] Equipment that affects combat stats
-   [ ] Dungeons and bosses

### Procedural World Generation

-   [ ] Noise-based terrain generation
-   [ ] Biome system with unique resources per biome
-   [ ] Procedural placement of nodes, stations, shrines
-   [ ] World modifiers ("Ore-Rich", "Eternal Night")
-   [ ] Seed-based generation for shareable runs

### Multiple Biomes

-   [ ] Forest (MVP biome)
-   [ ] Desert, Tundra, Swamp, Volcanic, Crystal Caves
-   [ ] Biome-specific resources and recipes
-   [ ] Visual variety per biome

### Meta-Progression

-   [ ] Renown currency earned from runs
-   [ ] Unlock new classes, traits, relics between runs
-   [ ] Persistent unlocks that expand run options
-   [ ] Difficulty modes unlocked through play

### Save System

-   [ ] Save/load meta-progression
-   [ ] Optional mid-run saving
-   [ ] Run history tracking

### Audio & Polish

-   [ ] Sound effects for gathering, crafting, leveling
-   [ ] Ambient music per area
-   [ ] UI sounds and feedback
-   [ ] Visual juice (particles, screen shake, animations)

### Additional Systems

-   [ ] Classes with unique starting bonuses
-   [ ] Traits (positive/negative) for run customization
-   [ ] NPC trading/shops
-   [ ] Equipment system beyond tools

---

## Tips for Staying on Track

### Time Management

-   **Session Goal:** Have one clear goal per session (e.g., "Get gathering progress bar working")
-   **Timebox:** If stuck for 30+ minutes, step back, take notes, try next session
-   **Commit Often:** Small, working commits keep momentum and provide rollback points

### Scope Discipline

-   **"Good Enough":** Placeholder art and minimal UI are fine—focus on feel
-   **Cut Ruthlessly:** If a feature isn't in MVP scope, resist adding it
-   **Vertical Slice:** Better to have one polished skill than five half-working ones

### Testing Approach

-   **Play Early:** Test each feature as you build it, not just at the end
-   **Note Problems:** Keep a running list of issues to fix later
-   **Fresh Eyes:** Return after a break to spot obvious problems

### Motivation

-   **Visible Progress:** The todo checkboxes in this document are progress
-   **Share Updates:** Screenshot your progress, even rough—external accountability helps
-   **Remember Why:** This is the OSRS Leagues experience in roguelike form. That's cool!

---

## Resources

### Godot 4 + C#

-   [Godot 4 C# Documentation](https://docs.godotengine.org/en/stable/tutorials/scripting/c_sharp/index.html)
-   [Godot 4 C# API Differences](https://docs.godotengine.org/en/stable/tutorials/scripting/c_sharp/c_sharp_differences.html)
-   [GDQuest Godot Tutorials](https://www.gdquest.com/)

### Tilemaps

-   [Godot TileMap Tutorial](https://docs.godotengine.org/en/stable/tutorials/2d/using_tilemaps.html)
-   [TileMapLayer (Godot 4.3+)](https://docs.godotengine.org/en/stable/classes/class_tilemaplayer.html)

### Inventory Systems

-   [Inventory System Tutorial (GDQuest)](https://www.gdquest.com/tutorial/godot/2d/inventory-system/)

### Roguelike Design

-   [Roguebasin Articles](http://www.roguebasin.com/)
-   [OSRS Wiki - Leagues](https://oldschool.runescape.wiki/w/Leagues)

### Placeholder Assets

-   [Kenney Assets (Free)](https://kenney.nl/assets)
-   [OpenGameArt](https://opengameart.org/)
-   [Itch.io Free Assets](https://itch.io/game-assets/free)

---

## Estimated Timeline Summary

| Phase   | Focus               | Weeks | Running Total |
| ------- | ------------------- | ----- | ------------- |
| Phase 0 | Setup & Learning    | 1     | Week 1        |
| Phase 1 | Resource Gathering  | 2-3   | Weeks 2-4     |
| Phase 2 | Inventory System    | 2     | Weeks 4-6     |
| Phase 3 | Skills & XP         | 2     | Weeks 6-8     |
| Phase 4 | Processing Stations | 2     | Weeks 8-10    |
| Phase 5 | Relic System        | 2     | Weeks 10-12   |
| Phase 6 | Task System         | 2     | Weeks 12-14   |
| Phase 7 | World & Integration | 2     | Weeks 14-16   |

**Total: ~16 weeks at 2-5 hours/week**

---

_Document Version: 1.0_  
_Created: January 3, 2026_  
_Based on: Roguelike OSRS Leagues - Expanded Design Document_
