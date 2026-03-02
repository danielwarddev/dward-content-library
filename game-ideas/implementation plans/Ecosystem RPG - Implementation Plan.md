# Ecosystem RPG - Implementation Plan

## Project Metadata

| Field                  | Value                                                    |
| ---------------------- | -------------------------------------------------------- |
| **Engine**             | Godot 4.x with C#                                        |
| **Experience Level**   | Advanced beginner Godot, expert C#, new to AI/simulation |
| **Time Budget**        | 2-5 hours/week                                           |
| **Scope**              | Prototype - Plant System + Population Dynamics           |
| **Art Approach**       | Placeholder (cubes, simple shapes)                       |
| **Starting Point**     | Fresh project                                            |
| **Estimated Duration** | 16-22 weeks                                              |

## Focus Areas

**Priority (This Plan):**

-   Plant system (trampling, harvesting, spreading, regrowth)
-   Population dynamics (herbivore creatures that eat plants, breed, die)
-   First-person exploration to observe the systems

**Deferred (Future Features):**

-   Predator/prey AI and hunting behavior
-   Combat system
-   Magic system
-   Faction/NPC interactions
-   Corruption mechanic
-   Base building
-   Narrative/story elements
-   Day/night cycle
-   Crafting system

---

## Phase 0: Learning Prerequisites (Weeks 1-2)

_Get comfortable with the foundational concepts before building._

### Step 0.1: Godot 3D Refresher

-   [ ] **Task:** Create a test scene with a CharacterBody3D, terrain (CSGBox or simple mesh), and basic WASD + mouse look movement
-   [ ] Review Godot's 3D coordinate system (Y-up) and node hierarchy
-   [ ] Practice with `@export` variables and the inspector
-   **Time:** ~2-3 hours
-   **Done when:** You can walk around a 3D space smoothly with mouse-look camera

### Step 0.2: State Machine Fundamentals

-   [ ] **Task:** Read/watch a tutorial on simple state machines in Godot (enemy AI tutorials work well)
-   [ ] Build a trivial example: a cube that switches between "Idle" (stationary) and "Wander" (moves randomly) states
-   [ ] Use an enum for states and a `switch` statement in `_Process`
-   **Time:** ~2-3 hours
-   **Done when:** You have a working state machine switching between 2 states on a timer

### Step 0.3: Simulation Concepts on Paper

-   [ ] **Task:** Create a simple spreadsheet modeling plant growth
    -   Columns: Turn #, Plant Count, Growth Rate, Max Capacity
    -   Formula: `NewPlants = min(Plants * GrowthRate, MaxCapacity)`
    -   Run 20 turns, observe S-curve growth to carrying capacity
-   [ ] Add a "Harvesting" column that removes plants each turn, see how it affects equilibrium
-   **Time:** ~1-2 hours
-   **Done when:** You understand carrying capacity, growth rates, and equilibrium on paper

### Step 0.4: Agent-Based Thinking

-   [ ] **Task:** Sketch (on paper or digitally) how you'd represent:
    -   A single plant tile (position, growth stage, health)
    -   A single creature (position, hunger, state)
    -   How they interact (creature enters tile → eats plant → hunger decreases)
-   **Time:** ~1 hour
-   **Done when:** You have a mental model of agents with properties and interactions

---

### 🏁 Milestone Checkpoint: Learning Complete

-   [ ] Comfortable with Godot 3D movement
-   [ ] Understand state machine pattern
-   [ ] Grasp simulation concepts (carrying capacity, growth, equilibrium)
-   [ ] Have a mental model for agent-based systems

---

## Phase 1: Project Foundation (Weeks 3-4)

_Set up the project structure and get a player walking around._

### Step 1.1: Project Setup

-   [ ] **Task:** Create new Godot project with C# enabled
-   [ ] Set up folder structure:
    ```
    /Scenes
      /Player
      /World
      /Creatures
      /Plants
      /UI
    /Scripts
      /Player
      /Simulation
      /Creatures
      /Plants
      /Core
    /Resources
    ```
-   [ ] Configure `.gitignore` for Godot + C#
-   [ ] Create initial `Main.tscn` scene
-   **Time:** ~30-45 minutes
-   **Done when:** Project opens, compiles C#, folders exist

### Step 1.2: First-Person Controller

-   [ ] **Task:** Create `Player.tscn` with CharacterBody3D
    -   Add CollisionShape3D (capsule)
    -   Add Camera3D as child at eye height (~1.6 units)
-   [ ] Create `PlayerController.cs`:
    -   WASD movement with configurable speed
    -   Mouse look (capture mouse, rotate camera)
    -   Basic gravity and ground detection
-   [ ] Add input actions in Project Settings (move_forward, move_back, etc.)
-   **Time:** ~2-3 hours
-   **Done when:** Smooth first-person movement with mouse look, no jitter

### Step 1.3: Test Environment

-   [ ] **Task:** Create `TestWorld.tscn`:
    -   Large flat ground plane (CSGBox or MeshInstance3D with PlaneMesh)
    -   Basic DirectionalLight for visibility
    -   WorldEnvironment with simple sky
-   [ ] Add colored CSGBox "landmarks" for orientation
-   [ ] Instance Player scene
-   **Time:** ~1-2 hours
-   **Done when:** You can walk around a lit environment with reference points

### Step 1.4: Debug Overlay Foundation

-   [ ] **Task:** Create a simple debug UI (CanvasLayer + Labels)
    -   Display FPS
    -   Display player position
    -   Toggle visibility with F3
-   [ ] This will be essential for observing simulation values later
-   **Time:** ~1 hour
-   **Done when:** F3 toggles a debug overlay showing FPS and position

---

### 🏁 Milestone Checkpoint: Foundation Complete

-   [ ] Project structure organized
-   [ ] First-person controller working smoothly
-   [ ] Test environment to walk around
-   [ ] Debug overlay for development

---

## Phase 2: Plant System Core (Weeks 5-8)

_The heart of your prototype—plants that grow, spread, and respond to the player._

### Step 2.1: Plant Data Model

-   [ ] **Task:** Create `PlantData.cs` (C# class, not Node):
    ```csharp
    public class PlantData
    {
        public Vector2I GridPosition;
        public float Health; // 0-100
        public float GrowthStage; // 0-1 (seedling to mature)
        public float TimeSinceLastUpdate;
    }
    ```
-   [ ] Create `PlantConfig` resource (or static class) with tunable values:
    -   GrowthRate, MaxHealth, SpreadChance, SpreadRadius
-   **Time:** ~1 hour
-   **Done when:** Data structures defined and compile

### Step 2.2: Grid-Based Plant Manager

-   [ ] **Task:** Create `PlantManager.cs` (Node attached to world):
    -   Dictionary<Vector2I, PlantData> to track all plants
    -   Grid cell size (e.g., 1 unit = 1 cell)
    -   Method: `AddPlant(Vector2I position)`
    -   Method: `RemovePlant(Vector2I position)`
    -   Method: `GetPlantAt(Vector2I position)`
-   [ ] Helper: `WorldToGrid(Vector3 worldPos)` conversion
-   **Time:** ~1-2 hours
-   **Done when:** Can add/remove plants in code, dictionary works

### Step 2.3: Plant Visualization (Placeholder)

-   [ ] **Task:** Create `PlantVisual.tscn`:
    -   Simple CSGCylinder (thin, green) or CSGBox
    -   Scale Y based on GrowthStage (small when young, tall when mature)
    -   Color shade based on Health (bright green = healthy, brown = dying)
-   [ ] `PlantManager` spawns/updates visuals when plants change
-   [ ] Use object pooling or spawn/despawn as needed
-   **Time:** ~2-3 hours
-   **Done when:** Plants appear as colored shapes, size reflects growth

### Step 2.4: Plant Growth Simulation

-   [ ] **Task:** In `PlantManager._Process` (or on a timer):
    -   Loop through all plants
    -   Increase GrowthStage over time (configurable rate)
    -   Mature plants regenerate Health slowly
    -   Update visuals to reflect changes
-   [ ] Use delta time properly for frame-independent growth
-   [ ] Add growth to debug overlay (total plants, average health)
-   **Time:** ~2-3 hours
-   **Done when:** Plants visibly grow from small to large over ~30-60 seconds

### Step 2.5: Plant Spreading

-   [ ] **Task:** Mature plants (GrowthStage == 1) have a chance to spread:
    -   Each update tick, roll SpreadChance (e.g., 5% per tick)
    -   If success, pick random adjacent grid cell
    -   If cell is empty, spawn new seedling
-   [ ] Implement carrying capacity: don't spread if local density too high
    -   Count plants within SpreadRadius, cap at MaxLocalDensity
-   **Time:** ~2-3 hours
-   **Done when:** Starting with 1 plant, watch it spread to fill an area, then stop at capacity

### Step 2.6: Player Trampling

-   [ ] **Task:** Detect when player walks over plant grid cells:
    -   In PlayerController, emit signal or call PlantManager when moving
    -   `PlantManager.TrampleAt(Vector3 worldPos)`
    -   Reduce Health of plant at that cell
-   [ ] Plants with Health <= 0 die and are removed
-   [ ] Visual feedback: health-based color already shows damage
-   **Time:** ~2-3 hours
-   **Done when:** Walking through plants damages/kills them, visible paths form

### Step 2.7: Player Harvesting (Interaction)

-   [ ] **Task:** Add interaction system:
    -   Raycast from camera center (short range, ~2 units)
    -   If ray hits plant, show "Press E to harvest" (simple Label)
    -   On E press, remove plant, (optionally) add to inventory counter
-   [ ] Harvested plants don't spread (they're gone)
-   [ ] Add harvest count to debug overlay
-   **Time:** ~2-3 hours
-   **Done when:** Can look at plants and harvest them with E, count increases

### Step 2.8: Plant System Tuning & Testing

-   [ ] **Task:** Create a test scenario:
    -   Spawn 10 plants in a cluster
    -   Observe: Do they spread? Do they hit carrying capacity?
    -   Walk through: Do paths form? Do trampled areas recover?
-   [ ] Tune values until behavior feels good:
    -   Growth not too fast or slow
    -   Spreading creates natural-looking clusters
    -   Trampling is impactful but not instant death
-   [ ] Document your tuned values
-   **Time:** ~2 hours
-   **Done when:** Plant system feels alive and responsive

---

### 🏁 Milestone Checkpoint: Plant System Complete

-   [ ] Plants grow from seedling to mature
-   [ ] Plants spread to adjacent cells up to carrying capacity
-   [ ] Player trampling damages/kills plants
-   [ ] Player can harvest plants
-   [ ] Paths form where player walks frequently
-   [ ] System is tuned and feels good

---

## Phase 3: Creature Population Basics (Weeks 9-12)

_Add simple herbivore creatures that depend on plants._

### Step 3.1: Creature Data Model

-   [ ] **Task:** Create `CreatureData.cs`:

    ```csharp
    public class CreatureData
    {
        public Vector3 Position;
        public float Hunger; // 0-100 (0 = starving, 100 = full)
        public float Age;
        public CreatureState State;
    }

    public enum CreatureState { Idle, Wandering, Eating, Dead }
    ```

-   [ ] Create `CreatureConfig` with tunable values:
    -   MoveSpeed, HungerDecayRate, EatRate, BreedingThreshold
-   **Time:** ~1 hour
-   **Done when:** Data structures compile

### Step 3.2: Creature Scene & Basic AI

-   [ ] **Task:** Create `Creature.tscn`:
    -   CharacterBody3D (smaller than player)
    -   CollisionShape3D (sphere or capsule)
    -   CSGSphere or CSGBox for visual (colored to distinguish from plants)
    -   Attach `CreatureController.cs`
-   [ ] Implement basic state machine:
    -   **Idle:** Stand still for random duration, then switch to Wandering
    -   **Wandering:** Pick random direction, walk for random duration, then Idle
-   [ ] Keep creatures grounded (simple gravity + floor detection)
-   **Time:** ~3-4 hours
-   **Done when:** Creatures wander around aimlessly without falling through floor

### Step 3.3: Creature Manager

-   [ ] **Task:** Create `CreatureManager.cs`:
    -   List<Creature> to track all creatures
    -   Method: `SpawnCreature(Vector3 position)`
    -   Method: `RemoveCreature(Creature c)`
    -   Population count for debug overlay
-   [ ] Spawn 5-10 test creatures on scene load
-   **Time:** ~1-2 hours
-   **Done when:** Creatures spawn and are tracked, count shows in debug

### Step 3.4: Hunger System

-   [ ] **Task:** In `CreatureController._Process`:
    -   Decrease Hunger over time (HungerDecayRate \* delta)
    -   If Hunger <= 0, creature dies (change state to Dead, queue_free after delay or immediately)
-   [ ] Visual feedback: creature color shifts from green (full) to red (starving)
-   [ ] Add average hunger to debug overlay
-   **Time:** ~2 hours
-   **Done when:** Creatures slowly starve and die if they don't eat

### Step 3.5: Eating Behavior

-   [ ] **Task:** Add Eating state to creature AI:
    -   When Wandering, check for plant at current grid position
    -   If plant exists and Hunger < 80, switch to Eating state
    -   While Eating: decrease plant Health, increase Hunger
    -   When plant dies or Hunger full, return to Idle
-   [ ] Creature needs reference to PlantManager (inject or find in tree)
-   **Time:** ~3-4 hours
-   **Done when:** Creatures seek out plants (even if just finding them while wandering) and eat them

### Step 3.6: Simple Plant-Seeking

-   [ ] **Task:** Improve Wandering to prefer areas with plants:
    -   When picking wander direction, sample a few random directions
    -   Prefer direction with more plants (check grid cells ahead)
    -   Not perfect pathfinding—just a bias
-   [ ] This creates emergent grazing behavior
-   **Time:** ~2-3 hours
-   **Done when:** Creatures tend to move toward plant-dense areas

### Step 3.7: Breeding System

-   [ ] **Task:** Add breeding logic:
    -   Creatures with Hunger > BreedingThreshold can breed
    -   Check if another creature is nearby (simple distance check)
    -   If both eligible, spawn new creature between them
    -   Add cooldown to prevent instant population explosion
-   [ ] Limit max population (performance and gameplay balance)
-   **Time:** ~2-3 hours
-   **Done when:** Well-fed creatures produce offspring, population can grow

### Step 3.8: Population Dynamics Integration

-   [ ] **Task:** Connect the systems and observe:
    -   Plants grow → Creatures eat → Creatures breed → More creatures eat more → Plant scarcity → Starvation → Population drops → Plants recover → Cycle
-   [ ] Create test scenario:
    -   Dense plant area + 5 creatures
    -   Observe: population rises, plants deplete, creatures starve, plants regrow
-   [ ] Tune values for visible ~2-3 minute cycles
-   **Time:** ~3-4 hours
-   **Done when:** Observable boom/bust population cycles emerge naturally

---

### 🏁 Milestone Checkpoint: Population Dynamics Working

-   [ ] Creatures wander and have basic AI states
-   [ ] Hunger system causes starvation deaths
-   [ ] Creatures eat plants to survive
-   [ ] Creatures breed when well-fed
-   [ ] Boom/bust cycles visible over time
-   [ ] Debug overlay shows population and plant stats

---

## Phase 4: Player Impact & Feedback (Weeks 13-16)

_Make the player's actions visibly affect the ecosystem._

### Step 4.1: Player-Caused Extinction Scenario

-   [ ] **Task:** Test and tune:
    -   If player harvests all plants in an area, creatures should starve
    -   If player tramples constantly, area becomes barren
-   [ ] Ensure the cause-effect is visible and understandable
-   **Time:** ~2 hours
-   **Done when:** Player can intentionally cause local creature extinction

### Step 4.2: Population Tracking UI

-   [ ] **Task:** Create simple UI panel (toggle with Tab):
    -   Graph or number showing creature population over time
    -   Graph or number showing total plant count over time
    -   Simple Line2D or just text history
-   [ ] Update every few seconds, keep last ~20 data points
-   **Time:** ~3-4 hours
-   **Done when:** Player can see population trends on a graph/chart

### Step 4.3: Area Health Indicator

-   [ ] **Task:** Divide world into regions (4x4 or 8x8 grid chunks)
    -   Calculate "health" per region: plant density + creature count
    -   Visualize on minimap or overlay (green = healthy, red = depleted)
-   [ ] Simple colored squares on a corner minimap
-   **Time:** ~2-3 hours
-   **Done when:** Player can see which areas are thriving or struggling

### Step 4.4: Ecosystem Journal/Log

-   [ ] **Task:** Create simple event log:
    -   "A creature starved in the eastern region"
    -   "Plant population recovered in the northern meadow"
    -   "Creature population reached new high: 15"
-   [ ] Display as scrolling text or simple notification
-   [ ] Helps player understand what's happening
-   **Time:** ~2-3 hours
-   **Done when:** Notable ecosystem events are logged and visible

### Step 4.5: Expanded Test World

-   [ ] **Task:** Create larger terrain:
    -   ~50x50 or 100x100 unit area
    -   Multiple starting plant clusters
    -   Multiple creature spawn points
-   [ ] Vary initial conditions (dense area, sparse area)
-   [ ] Add simple landmarks for navigation
-   **Time:** ~2-3 hours
-   **Done when:** More interesting world to explore with varied ecosystem states

### Step 4.6: Performance Optimization Pass

-   [ ] **Task:** Profile the simulation:
    -   How many plants/creatures before FPS drops?
    -   Are there obvious bottlenecks?
-   [ ] Optimizations to consider:
    -   Update plants in batches (not all every frame)
    -   Use timer for simulation ticks (0.5s) instead of every frame
    -   Spatial hashing for creature-creature and creature-plant lookups
-   **Time:** ~3-4 hours
-   **Done when:** Stable 60 FPS with target population (e.g., 500 plants, 50 creatures)

### Step 4.7: Tuning & Polish Pass

-   [ ] **Task:** Playtest the complete loop:
    -   Walk around, observe ecosystem
    -   Harvest plants, watch consequences
    -   Create trampled paths, see recovery
    -   Watch creatures thrive and struggle
-   [ ] Tune all values for satisfying pacing
-   [ ] Fix any bugs or edge cases
-   **Time:** ~2-3 hours
-   **Done when:** The prototype feels cohesive and demonstrates the core concept

---

### 🏁 Milestone Checkpoint: Prototype Complete

-   [ ] Plant system with growth, spreading, trampling, harvesting
-   [ ] Creature population with hunger, eating, breeding, death
-   [ ] Visible boom/bust cycles
-   [ ] Player impact is clear and consequential
-   [ ] UI shows population trends and ecosystem health
-   [ ] Performance is acceptable
-   [ ] Core concept is demonstrated

---

## Final Milestone Checklist

At the end of this implementation plan, you should have:

-   [ ] First-person character walking through a 3D world
-   [ ] Plants that grow, spread, and compete for space
-   [ ] Plants that respond to player trampling and harvesting
-   [ ] Herbivore creatures that eat plants to survive
-   [ ] Creatures that breed when well-fed and die when starving
-   [ ] Emergent population cycles (boom → bust → recovery)
-   [ ] Clear cause-and-effect from player actions
-   [ ] UI showing ecosystem state and trends
-   [ ] Stable performance with reasonable entity counts
-   [ ] Foundation for adding predators, combat, and more systems

---

## Tips for Staying on Track

### Weekly Rhythm

1. **Start of week:** Review where you left off, pick 1-2 steps to complete
2. **During session:** Focus on one step at a time, commit working code
3. **End of session:** Note what works, what's broken, next steps

### When Stuck

-   **Simplify:** Can you prove the concept with cubes before adding complexity?
-   **Isolate:** Build a test scene for just the feature you're debugging
-   **Paper first:** Sketch the logic before coding
-   **Take breaks:** Walk away, the solution often comes later

### Avoid Scope Creep

-   ❌ Don't add predators until herbivores work
-   ❌ Don't add combat until population dynamics work
-   ❌ Don't add multiple biomes until one biome works
-   ✅ Each phase builds on the previous one

### Commit Often

-   Commit after each step is "Done when" complete
-   Use descriptive commit messages ("Add plant spreading logic")
-   You can always roll back if something breaks

---

## Resources

### Godot 4 + C#

-   [Godot C# Documentation](https://docs.godotengine.org/en/stable/tutorials/scripting/c_sharp/index.html)
-   [CharacterBody3D Tutorial](https://docs.godotengine.org/en/stable/tutorials/physics/using_character_body_2d.html) (concepts apply to 3D)
-   [First Person Controller Tutorial](https://docs.godotengine.org/en/stable/tutorials/3d/first_person.html)

### Simulation & AI

-   [Introduction to Agent-Based Modeling](https://www.jasss.org/20/4/2.html) (academic but accessible)
-   [Lotka-Volterra Equations](https://en.wikipedia.org/wiki/Lotka%E2%80%93Volterra_equations) (predator-prey math, useful for future phases)
-   [Boids Algorithm](https://www.red3d.com/crag/boids/) (flocking behavior, useful for creature groups)

### Performance

-   [Godot Performance Optimization](https://docs.godotengine.org/en/stable/tutorials/performance/index.html)
-   Spatial partitioning concepts (grid-based lookups, quadtrees)

---

## Future Features (Post-Prototype)

After validating the core concept, consider adding:

### Phase A: Predator/Prey

-   Add predator creature type
-   Predators hunt herbivores
-   Three-level food chain: plants → herbivores → predators
-   Classic Lotka-Volterra dynamics

### Phase B: Combat

-   Player can fight creatures
-   Creature deaths affect population
-   Combat has ecosystem consequences

### Phase C: Environmental Variety

-   Multiple plant species with different properties
-   Different creature species with niches
-   Biome differentiation

### Phase D: Advanced Simulation

-   Day/night cycle affecting behavior
-   Seasonal changes
-   Weather effects on growth

### Phase E: Narrative & Goals

-   Corruption mechanic as threat
-   Factions and NPCs
-   Quest objectives tied to ecosystem state

---

_Document Version: 1.0_
_Created: January 3, 2026_
_Based on: Ecosystem RPG - Expanded Design Document_
