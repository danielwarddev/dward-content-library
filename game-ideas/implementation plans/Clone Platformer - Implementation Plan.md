# Clone Platformer - Bite-Sized Implementation Steps

> **Engine:** Godot 4.x with C#  
> **Time Budget:** 2-5 hours/week  
> **Focus:** Movement & Traversal (no combat)  
> **Art:** Placeholder shapes

---

## Phase 1: Foundation (Week 1)

### Step 1.1: Project Setup

-   [ ] Create new Godot 4 project with C# support
-   [ ] Set up folder structure: `Scenes/`, `Scripts/`, `Resources/`
-   [ ] Create a test scene with a simple tilemap floor
-   [ ] Verify C# scripts compile and run

**Done when:** You can run the project and see a floor.

---

### Step 1.2: Player Node Structure

-   [ ] Create `Player.tscn` scene
-   [ ] Root: `CharacterBody2D`
-   [ ] Add `CollisionShape2D` (rectangle)
-   [ ] Add `Sprite2D` (use a colored rectangle texture or `ColorRect` for now)
-   [ ] Attach a new C# script: `Player.cs`

**Done when:** Player node exists and appears in the test scene.

---

### Step 1.3: Basic Horizontal Movement

-   [ ] In `Player.cs`, implement `_PhysicsProcess`
-   [ ] Read horizontal input (`ui_left`, `ui_right` or custom)
-   [ ] Set `Velocity.X` based on input and a `MoveSpeed` constant
-   [ ] Call `MoveAndSlide()`

**Done when:** Player moves left/right smoothly.

---

### Step 1.4: Gravity & Jumping

-   [ ] Add gravity to `Velocity.Y` each frame
-   [ ] Detect `IsOnFloor()` for jump eligibility
-   [ ] On jump input, set `Velocity.Y` to negative jump force
-   [ ] Tune values until it feels decent (not perfect yet)

**Done when:** Player falls, lands, and can jump.

---

## Phase 2: Core Clone Mechanic (Weeks 2-3)

### Step 2.1: Clone Scene Setup

-   [ ] Create `Clone.tscn` scene
-   [ ] Root: `CharacterBody2D` (or `StaticBody2D` for basic version)
-   [ ] Add `CollisionShape2D` and `Sprite2D` (different color from player)
-   [ ] Create `Clone.cs` script (empty for now)

**Done when:** Clone scene exists and can be instanced.

---

### Step 2.2: Spawning a Clone

-   [ ] Add clone input action in Project Settings (e.g., `clone`)
-   [ ] In `Player.cs`, detect clone button press
-   [ ] Instance `Clone.tscn` at player's position
-   [ ] Add clone to the scene tree (parent it to the level, not player)
-   [ ] Store a reference to the active clone

**Done when:** Pressing the clone button spawns a clone where you stand.

---

### Step 2.3: One Clone Limit

-   [ ] Before spawning, check if a clone already exists
-   [ ] If yes, destroy the old clone first (`QueueFree()`)
-   [ ] Then spawn the new one

**Done when:** Only one clone can exist at a time.

---

### Step 2.4: Clone Swapping (Basic)

-   [ ] Detect clone button when a clone already exists
-   [ ] Swap `GlobalPosition` between player and clone
-   [ ] Add a small visual feedback (optional: screen shake or particle)

**Done when:** Pressing clone button near an existing clone swaps positions.

---

### Step 2.5: Spawn vs Swap Decision

-   [ ] Define a "swap radius" (e.g., 150 pixels)
-   [ ] If clone exists AND player is within radius → swap
-   [ ] If clone exists AND player is far → destroy old, spawn new
-   [ ] If no clone exists → spawn new

**Done when:** Clone button intelligently swaps or spawns based on distance.

---

## Phase 3: Movement Feel (Week 3-4)

### Step 3.1: Coyote Time

-   [ ] Add a timer variable for coyote time (e.g., 0.1 seconds)
-   [ ] When leaving ground, start the timer
-   [ ] Allow jumping while timer > 0
-   [ ] Reset timer when landing

**Done when:** You can jump slightly after walking off a ledge.

---

### Step 3.2: Jump Buffering

-   [ ] Add a timer for jump buffer (e.g., 0.1 seconds)
-   [ ] When jump pressed in air, start the timer
-   [ ] When landing, if timer > 0, execute jump
-   [ ] Reset timer after jump executes

**Done when:** Pressing jump just before landing still works.

---

### Step 3.3: Variable Jump Height

-   [ ] When jump button released early, reduce upward velocity
-   [ ] Only apply if currently moving upward
-   [ ] Multiply `Velocity.Y` by a dampening factor (e.g., 0.5)

**Done when:** Tap = short hop, hold = full jump.

---

### Step 3.4: Tuning Pass

-   [ ] Create exported variables for all movement values
-   [ ] Test and tweak: `MoveSpeed`, `JumpForce`, `Gravity`, `CoyoteTime`, `JumpBuffer`
-   [ ] Get it feeling responsive (not floaty, not stiff)

**Done when:** Movement feels good to you.

---

## Phase 4: Clone Throwing (Weeks 4-5)

### Step 4.1: Directional Clone Spawn

-   [ ] When spawning clone while holding a direction, note that direction
-   [ ] Offset clone spawn position slightly in that direction
-   [ ] (Prep work for actual throwing)

**Done when:** Holding right + clone spawns clone slightly to the right.

---

### Step 4.2: Clone Gets Velocity

-   [ ] Change `Clone` to use `CharacterBody2D` with its own `_PhysicsProcess`
-   [ ] Add `Velocity` property to Clone
-   [ ] When spawning, pass a throw velocity based on direction
-   [ ] Clone moves in that direction, affected by gravity

**Done when:** Clone flies in the direction you throw it.

---

### Step 4.3: Clone Stops on Collision

-   [ ] In Clone's `_PhysicsProcess`, call `MoveAndSlide()`
-   [ ] When clone hits a wall or floor, zero out its velocity
-   [ ] Clone becomes stationary

**Done when:** Thrown clone lands and stops.

---

### Step 4.4: Player Momentum on Throw

-   [ ] When throwing a clone, apply opposite momentum to player
-   [ ] Scale based on throw strength
-   [ ] This creates the "recoil" movement tech

**Done when:** Throwing clone right pushes player left.

---

## Phase 5: Test Rooms (Weeks 5-6)

### Step 5.1: Test Room - Basic Swap

-   [ ] Create a room with a gap too wide to jump
-   [ ] Player must: spawn clone on other side somehow, then swap
-   [ ] Solution: throw clone across, swap to it

**Done when:** Room is completable only using clone mechanics.

---

### Step 5.2: Test Room - Vertical Throw

-   [ ] Create a room with a high platform
-   [ ] Player must: throw clone upward, swap to reach it

**Done when:** Room teaches vertical clone throwing.

---

### Step 5.3: Test Room - Chain Gaps

-   [ ] Create a room with multiple gaps in sequence
-   [ ] Requires spawn/swap/spawn/swap rhythm

**Done when:** Room tests chaining the mechanic.

---

### Step 5.4: Playtest & Iterate

-   [ ] Play through all rooms multiple times
-   [ ] Note what feels bad or confusing
-   [ ] Adjust values, room layouts, or mechanics as needed
-   [ ] (Optional) Have someone else try it

**Done when:** Rooms feel fair and the mechanic clicks.

---

## Phase 6: Polish Basics (Week 6+)

### Step 6.1: Input Buffering for Clone

-   [ ] Buffer clone button presses (similar to jump buffer)
-   [ ] Prevents inputs from being "eaten"

---

### Step 6.2: Visual Feedback

-   [ ] Add particles or flash on clone spawn
-   [ ] Add particles or screen effect on swap
-   [ ] Make it feel satisfying

---

### Step 6.3: Sound Effects

-   [ ] Add placeholder SFX for: jump, land, clone spawn, clone swap
-   [ ] Use free sounds (freesound.org, Kenney.nl)

---

### Step 6.4: Camera

-   [ ] Add `Camera2D` as child of player
-   [ ] Enable smoothing
-   [ ] Set limits to room boundaries

---

## Milestone Checklist

After completing all steps, you should have:

-   [x] Player with responsive movement (run, jump, coyote time, buffering)
-   [x] Clone spawning at player position
-   [x] Clone swapping (teleport to clone)
-   [x] Clone throwing with momentum
-   [x] 3 test rooms demonstrating the mechanic
-   [x] Basic juice (particles, sounds, camera)

**This is your prototype.** If it feels fun, continue to the full game. If not, revisit the core mechanic.

---

## Tips

-   **Commit often:** Git commit after each step works
-   **Test constantly:** Run the game after every change
-   **Don't polish early:** Placeholder art is fine until mechanics are locked
-   **Take notes:** Write down what feels wrong for later fixing
-   **Time-box:** If stuck for 30+ min, move on and come back later

---

## Next Steps (Post-Prototype)

If prototype succeeds, see the full design doc for:

-   Additional clone types (Momentum, Mirror, Combat)
-   Enemy design
-   Boss fights
-   Full level progression
-   Art and audio polish
