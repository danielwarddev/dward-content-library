# Idle Logic Game (Signal Flow) - Implementation Plan

## Game Concept

**Working Title:** Signal Flow

An idle/incremental game dressed in the visual language of logic circuits and automation. Players build networks of "signal nodes" connected by glowing wires—signals flow through the network, generating resources passively. No puzzles, no fail states—just the satisfaction of watching your abstract machine hum along, unlocking new node types, and optimizing for exponential growth.

**Core Hook:** "What if IFTTT was a clicker game? Watch your logic circuits generate numbers go up."

**Visual Style:** Neon-on-dark circuit board aesthetic. Signals visibly travel along wires, nodes pulse when they fire, and the whole network feels alive with electricity.

**Core Loop:** Watch Signals → Earn Energy → Unlock New Nodes → Build Network → Watch Faster → Repeat

---

## Project Metadata

| Field                  | Value                                  |
| ---------------------- | -------------------------------------- |
| **Engine**             | Godot 4.x with C#                      |
| **Experience Level**   | Advanced beginner (Godot), Expert (C#) |
| **Time Budget**        | 2-5 hours/week                         |
| **Scope**              | MVP/Prototype                          |
| **Art Approach**       | Placeholder (Godot primitives)         |
| **Priority Focus**     | Grid/node placement, Resource economy  |
| **Estimated Duration** | 14-18 weeks                            |

## Deferred for Later

-   [ ] Audio/sound effects
-   [ ] Offline progress calculation
-   [ ] Prestige system
-   [ ] Save/load system
-   [ ] Advanced node types (beyond 5 core types)
-   [ ] Multiple signal types
-   [ ] Tech tree
-   [ ] Milestones/achievements

---

## Phase 0: Project Setup & Godot C# Refresher (Week 1)

Quick setup and warm-up to ensure smooth development.

### 0.1 Create Fresh Godot 4 C# Project

-   [ ] Create new Godot 4.x project with C# support
-   [ ] Set up folder structure: `Scenes/`, `Scripts/`, `Resources/`, `Autoload/`
-   [ ] Configure project settings: 1920x1080 resolution, 2D renderer
-   [ ] Verify C# builds correctly (create test script, attach, run)

**Time:** ~30 min  
**Done when:** Project runs, C# script prints to console

### 0.2 Set Up Basic Scene Structure

-   [ ] Create `Main.tscn` as primary scene
-   [ ] Add a `CanvasLayer` for UI (will use later)
-   [ ] Add a `Node2D` named "GameWorld" for the grid/network
-   [ ] Create a simple `Camera2D` with zoom controls (mouse wheel)

**Time:** ~30-45 min  
**Done when:** Can pan/zoom an empty scene with mouse

### 0.3 Review Key Godot 2D Concepts (Optional Refresher)

-   [ ] Quick review: Node2D, Control, Signals, Input handling
-   [ ] Quick review: Line2D for wire drawing
-   [ ] Quick review: Tweens for animations

**Time:** ~30 min  
**Done when:** Feel confident with core 2D systems

---

## ✅ Milestone Checkpoint: Project Foundation

-   [ ] Project builds and runs
-   [ ] Camera can pan and zoom
-   [ ] Folder structure is organized
-   [ ] Ready to build game systems

---

## Phase 1: Grid System & Node Placement (Weeks 2-4)

The spatial canvas where players build their networks.

### 1.1 Create Grid Data Structure

-   [ ] Create `GridManager.cs` as an Autoload/singleton
-   [ ] Define grid dimensions (e.g., 20x15 cells, 64px cell size)
-   [ ] Store placed nodes in a `Dictionary<Vector2I, BaseNode>`
-   [ ] Add methods: `CanPlaceAt(pos)`, `PlaceNode(pos, node)`, `RemoveNode(pos)`

**Time:** ~45-60 min  
**Done when:** Can programmatically add/remove nodes from grid dictionary

### 1.2 Visualize Grid (Debug/Placeholder)

-   [ ] Draw grid lines using `_Draw()` override or `Line2D` nodes
-   [ ] Use subtle color (dark gray on dark background)
-   [ ] Grid should be visible but not distracting
-   [ ] Add toggle to show/hide grid (debug purposes)

**Time:** ~30-45 min  
**Done when:** Can see grid lines in the game world

### 1.3 Create Base Node Class

-   [ ] Create `BaseNode.cs` extending `Node2D`
-   [ ] Properties: `GridPosition`, `NodeType`, `InputConnections`, `OutputConnections`
-   [ ] Virtual methods: `OnSignalReceived()`, `ProcessTick()`, `GetOutputValue()`
-   [ ] Create placeholder visual (colored `ColorRect` or `Polygon2D`)

**Time:** ~60 min  
**Done when:** BaseNode class exists with core interface defined

### 1.4 Implement Node Placement Input

-   [ ] Detect mouse click on grid
-   [ ] Convert screen position → grid position (snap to grid)
-   [ ] On left-click: place node at position (if empty)
-   [ ] On right-click: remove node at position (if occupied)
-   [ ] Show ghost/preview of node before placing

**Time:** ~60-90 min  
**Done when:** Can click to place and right-click to remove nodes on grid

### 1.5 Create First Node Type: Emitter

-   [ ] Create `EmitterNode.cs` extending `BaseNode`
-   [ ] Visual: Simple circle or square with distinct color (cyan)
-   [ ] Behavior: Generates 1 Pulse per tick (logic comes in Phase 3)
-   [ ] Place via clicking (hardcoded as default for now)

**Time:** ~45 min  
**Done when:** Emitter nodes appear on grid when clicked

### 1.6 Add Node Selection UI

-   [ ] Create simple UI panel (bottom or side of screen)
-   [ ] Show available node types as buttons
-   [ ] Clicking button selects that node type for placement
-   [ ] Highlight currently selected node type

**Time:** ~60 min  
**Done when:** Can switch between node types and place different ones

---

## ✅ Milestone Checkpoint: Node Placement Works

-   [ ] Grid is visible and functional
-   [ ] Can place nodes by clicking
-   [ ] Can remove nodes by right-clicking
-   [ ] Node selection UI works
-   [ ] At least 1 node type (Emitter) is placeable

---

## Phase 2: Wire Connections & Signal Visualization (Weeks 5-7)

Connect nodes and watch signals flow.

### 2.1 Design Connection Data Model

-   [ ] Each node has input slots and output slots
-   [ ] Connection: `{ FromNode, FromSlot, ToNode, ToSlot }`
-   [ ] Store connections in `GridManager` or dedicated `ConnectionManager`
-   [ ] Validate connections (output → input only)

**Time:** ~45 min  
**Done when:** Connection data structure defined and validated

### 2.2 Implement Wire Drawing

-   [ ] Use `Line2D` for each connection
-   [ ] Wire goes from output position of node A to input position of node B
-   [ ] Style: 2-4px width, glowing color (use `Line2D` with glow material or modulate)
-   [ ] Wires update position if nodes move (not needed for grid-locked nodes)

**Time:** ~60 min  
**Done when:** Wires draw between connected nodes

### 2.3 Implement Connection Input (Drag to Connect)

-   [ ] Click and hold on node output slot
-   [ ] Drag to another node's input slot
-   [ ] Release to create connection (or cancel if invalid)
-   [ ] Show preview wire while dragging
-   [ ] Right-click on wire to delete connection

**Time:** ~90 min  
**Done when:** Can drag-connect nodes and delete wires

### 2.4 Add Visual Node Slots

-   [ ] Show input slots on left side of node (small circles)
-   [ ] Show output slots on right side of node (small circles)
-   [ ] Different node types have different slot configurations
-   [ ] Slots highlight when hovering during connection

**Time:** ~60 min  
**Done when:** Slots are visible and interactive

### 2.5 Animate Signals Along Wires

-   [ ] Create small "signal" sprite (dot or pulse)
-   [ ] When signal is sent, animate dot from output to input
-   [ ] Use `Tween` for smooth movement along wire path
-   [ ] Signal visual matches signal type (color/size)

**Time:** ~60-90 min  
**Done when:** Signals visibly travel along wires when nodes fire

### 2.6 Add Signal Glow/Pulse Effect

-   [ ] Wire "lights up" briefly when signal passes
-   [ ] Node pulses when it receives/sends signal
-   [ ] Use modulate or shader for glow effect
-   [ ] Keep effects subtle but satisfying

**Time:** ~45 min  
**Done when:** Network feels alive with visual feedback

---

## ✅ Milestone Checkpoint: Visual Network

-   [ ] Nodes can be connected with wires
-   [ ] Wires draw correctly between nodes
-   [ ] Signals animate along wires
-   [ ] Visual feedback when nodes activate
-   [ ] Connections can be deleted

---

## Phase 3: Resource Economy & Game Loop (Weeks 8-10)

Numbers go up! Core idle game loop.

### 3.1 Create Resource Manager

-   [ ] Create `ResourceManager.cs` as Autoload/singleton
-   [ ] Track `Energy` (primary resource) as `double` (for big numbers)
-   [ ] Methods: `AddEnergy(amount)`, `SpendEnergy(amount)`, `CanAfford(amount)`
-   [ ] Emit signal when Energy changes (for UI updates)

**Time:** ~30-45 min  
**Done when:** Resource manager tracks Energy, emits change signals

### 3.2 Create Game Tick System

-   [ ] Create `GameManager.cs` to control game loop
-   [ ] Run tick every X seconds (e.g., 1 second, configurable)
-   [ ] On each tick, all nodes process in order
-   [ ] Tick rate can be upgraded later

**Time:** ~45 min  
**Done when:** Game ticks reliably, nodes process each tick

### 3.3 Implement Emitter Generation Logic

-   [ ] On each tick, Emitter generates 1 "Pulse" signal
-   [ ] Pulse travels to connected nodes
-   [ ] If no connection, Pulse converts to 1 Energy directly

**Time:** ~30-45 min  
**Done when:** Emitters generate Energy each tick

### 3.4 Create Harvester Node

-   [ ] Create `HarvesterNode.cs` extending `BaseNode`
-   [ ] Visual: Different color (green), square shape
-   [ ] Behavior: Receives Pulse, converts to Energy (1 Pulse → 10 Energy)
-   [ ] Add to node selection UI

**Time:** ~45 min  
**Done when:** Emitter → Harvester chain generates more Energy than Emitter alone

### 3.5 Create Amplifier Node

-   [ ] Create `AmplifierNode.cs` extending `BaseNode`
-   [ ] Visual: Triangle or diamond shape (yellow/orange)
-   [ ] Behavior: Receives signal, outputs multiplied signal (x2)
-   [ ] Chain: Emitter → Amplifier → Harvester = 20 Energy

**Time:** ~45 min  
**Done when:** Amplifiers multiply signal value correctly

### 3.6 Create Splitter Node

-   [ ] Create `SplitterNode.cs` extending `BaseNode`
-   [ ] Visual: Branching shape (magenta)
-   [ ] Behavior: 1 input, 2+ outputs (sends signal to all)
-   [ ] Enables parallel processing

**Time:** ~45 min  
**Done when:** Splitter sends signal to multiple connected nodes

### 3.7 Create Merger Node

-   [ ] Create `MergerNode.cs` extending `BaseNode`
-   [ ] Visual: Converging shape (blue)
-   [ ] Behavior: Multiple inputs, 1 output (combines signals)
-   [ ] Outputs sum of all inputs

**Time:** ~45 min  
**Done when:** Merger combines multiple input signals

### 3.8 Create Energy Display UI

-   [ ] Add UI label showing current Energy
-   [ ] Format large numbers (1,000 → 1K, 1,000,000 → 1M)
-   [ ] Animate number changes (count up effect)
-   [ ] Position prominently (top of screen)

**Time:** ~45-60 min  
**Done when:** Energy displays clearly and updates in real-time

---

## ✅ Milestone Checkpoint: Core Loop Works

-   [ ] 5 node types functional (Emitter, Harvester, Amplifier, Splitter, Merger)
-   [ ] Signals flow through network each tick
-   [ ] Energy generates and accumulates
-   [ ] UI shows current Energy
-   [ ] Building networks feels meaningful

---

## Phase 4: Upgrades & Progression (Weeks 11-13)

Spend Energy to improve nodes.

### 4.1 Design Upgrade Data Structure

-   [ ] Each node type has upgrade tiers (Level 1, 2, 3...)
-   [ ] Each level: cost, new stats (output multiplier, speed, etc.)
-   [ ] Create `NodeUpgradeData.cs` resource or static data

**Time:** ~45 min  
**Done when:** Upgrade data structure defined for all 5 node types

### 4.2 Add Node Level Property

-   [ ] Add `Level` property to `BaseNode`
-   [ ] Node stats scale with level (e.g., Emitter Level 2 = 2 Pulse/tick)
-   [ ] Visual indicator of node level (border color, size, number)

**Time:** ~30-45 min  
**Done when:** Nodes have levels that affect their output

### 4.3 Create Node Upgrade UI

-   [ ] Click on placed node to select it
-   [ ] Show info panel: node type, level, current stats, upgrade cost
-   [ ] "Upgrade" button (disabled if can't afford)
-   [ ] Show preview of next level stats

**Time:** ~60-90 min  
**Done when:** Can click nodes and see upgrade options

### 4.4 Implement Upgrade Purchase

-   [ ] Clicking upgrade button spends Energy
-   [ ] Node level increases, stats update
-   [ ] Visual feedback (flash, particle)
-   [ ] UI updates to show new level

**Time:** ~45 min  
**Done when:** Can upgrade nodes by spending Energy

### 4.5 Add Node Purchase Costs

-   [ ] Nodes beyond the first Emitter cost Energy to place
-   [ ] Cost scales with how many of that type you own
-   [ ] Show cost in node selection UI
-   [ ] Gray out nodes you can't afford

**Time:** ~45-60 min  
**Done when:** Must spend Energy to place new nodes (except first Emitter)

### 4.6 Balance First Hour of Progression

-   [ ] Create spreadsheet of costs vs. generation rates
-   [ ] Test first 60 minutes of play
-   [ ] Adjust values until progression feels good
-   [ ] Document final values

**Time:** ~60-90 min (ongoing)  
**Done when:** First hour feels engaging with clear progression

---

## ✅ Milestone Checkpoint: Progression Loop

-   [ ] Nodes can be upgraded
-   [ ] Upgrades cost Energy and improve output
-   [ ] New nodes cost Energy
-   [ ] Progression feels rewarding
-   [ ] Balance is playable for first hour

---

## Phase 5: Visual Polish & Juice (Weeks 14-16)

Make it feel good.

### 5.1 Improve Node Visuals

-   [ ] Distinct shapes for each node type
-   [ ] Glowing outlines or borders
-   [ ] Subtle idle animation (pulse, breathe)
-   [ ] Clear differentiation between types

**Time:** ~60 min  
**Done when:** Nodes look distinct and polished (still placeholder, but refined)

### 5.2 Improve Wire Visuals

-   [ ] Add glow shader to wires
-   [ ] Wires pulse when active
-   [ ] Color-code by signal type (future-proofing)
-   [ ] Smooth curves instead of straight lines (optional)

**Time:** ~60 min  
**Done when:** Wires look like glowing circuit traces

### 5.3 Add Particle Effects

-   [ ] Particles when node fires
-   [ ] Particles when signal reaches destination
-   [ ] Particles when upgrading
-   [ ] Particles when placing new node

**Time:** ~45-60 min  
**Done when:** Key actions have particle feedback

### 5.4 Improve UI Polish

-   [ ] Consistent color theme (dark + neon)
-   [ ] Hover effects on buttons
-   [ ] Transition animations for panels
-   [ ] Tooltips for node types

**Time:** ~60 min  
**Done when:** UI feels cohesive and responsive

### 5.5 Add Visual Themes (Basic)

-   [ ] Create base theme (cyan/magenta on dark)
-   [ ] Implement theme as resource (colors, wire style)
-   [ ] Allow switching themes (future cosmetic system)

**Time:** ~45 min  
**Done when:** Theme system exists, one theme implemented

### 5.6 Screen Shake & Camera Juice

-   [ ] Subtle screen shake on big milestones
-   [ ] Smooth camera follow when panning
-   [ ] Zoom in/out feels smooth

**Time:** ~30 min  
**Done when:** Camera feels polished

---

## ✅ Milestone Checkpoint: Juicy MVP

-   [ ] Visuals are satisfying to watch
-   [ ] Network feels alive and active
-   [ ] UI is polished and responsive
-   [ ] "Numbers go up" feels rewarding
-   [ ] Ready for external testing

---

## Phase 6: Playtest & Iterate (Weeks 17-18)

Validate with real players.

### 6.1 Create Playtest Build

-   [ ] Export build for Windows
-   [ ] Include basic instructions (text file or in-game)
-   [ ] Test export runs correctly

**Time:** ~30 min  
**Done when:** Playable build ready to share

### 6.2 Gather Feedback

-   [ ] Share with 3-5 testers
-   [ ] Observe play sessions if possible
-   [ ] Collect feedback (form or conversation)
-   [ ] Note common issues

**Time:** ~60-120 min (spread over time)  
**Done when:** Have actionable feedback from testers

### 6.3 Iterate on Feedback

-   [ ] Fix critical bugs
-   [ ] Adjust balance based on feedback
-   [ ] Improve UX pain points
-   [ ] Polish based on "this was confusing" feedback

**Time:** ~120+ min  
**Done when:** Major feedback addressed

### 6.4 Final MVP Polish

-   [ ] Bug fixes
-   [ ] Performance check
-   [ ] Final balance pass
-   [ ] Version 0.1.0 tagged

**Time:** ~60 min  
**Done when:** MVP complete and stable

---

## ✅ Final Milestone: MVP Complete

-   [ ] Core loop is fun and satisfying
-   [ ] 5 node types with distinct behaviors
-   [ ] Upgrade system works
-   [ ] Visuals are polished (placeholder but refined)
-   [ ] Tested with external players
-   [ ] Ready for post-MVP expansion

---

## Tips for Staying on Track

1. **Timebox ruthlessly** - If a step takes >2 hours, stop and simplify
2. **Playtest weekly** - Play your own game for 10 min each session
3. **Commit small** - Git commit after each completed step
4. **Skip perfectionism** - Placeholder is fine; iterate later
5. **Balance can wait** - Get mechanics working first, numbers second
6. **One feature at a time** - Don't parallel-work unrelated systems
7. **Celebrate milestones** - Take a break when you hit a checkpoint

---

## Resources

### Godot 4 + C# Documentation

-   [Godot C# Basics](https://docs.godotengine.org/en/stable/tutorials/scripting/c_sharp/c_sharp_basics.html)
-   [Godot 2D Tutorial](https://docs.godotengine.org/en/stable/getting_started/first_2d_game/index.html)
-   [Line2D Documentation](https://docs.godotengine.org/en/stable/classes/class_line2d.html)
-   [Tween Documentation](https://docs.godotengine.org/en/stable/classes/class_tween.html)
-   [Signals in C#](https://docs.godotengine.org/en/stable/tutorials/scripting/c_sharp/c_sharp_signals.html)

### Idle Game Design

-   [The Math of Idle Games](https://blog.kongregate.com/the-math-of-idle-games-part-i/)
-   [Clicker Game Design Patterns](https://www.gamedeveloper.com/design/the-clicker-game-design-pattern)

### Visual Inspiration

-   [Opus Magnum](https://store.steampowered.com/app/558990/Opus_Magnum/) - Machine visualization
-   [SHENZHEN I/O](https://store.steampowered.com/app/504210/SHENZHEN_IO/) - Circuit aesthetic
-   [Shapez](https://store.steampowered.com/app/1318690/shapez/) - Factory idle

---

## Next Steps (Post-MVP)

Once MVP is validated, consider adding in priority order:

1. **Save/Load System** - Persist progress between sessions
2. **Offline Progress** - Calculate gains while away
3. **Prestige System** - Reset for permanent multipliers
4. **More Node Types** - Logic gates, special nodes
5. **Multiple Signal Types** - Data, Power, Quantum
6. **Milestones/Achievements** - Long-term goals
7. **Audio** - Ambient sounds, blips, clicks
8. **Tech Tree** - Permanent upgrades with Data currency
9. **Themes/Cosmetics** - Visual customization
10. **Mobile Port** - Touch-friendly UI

---

_Document Version: 1.0_  
_Created: January 4, 2026_  
_Based on: Idle Logic Game - Expanded Design Document_
