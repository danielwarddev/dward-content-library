# Physics-Based Platformer - Implementation Plan

> **Working Title:** _Whiplash_  
> **Engine:** Godot 4.x with C#  
> **Time Budget:** 2-5 hours/week  
> **Estimated Duration:** 10-14 weeks  
> **Scope:** MVP/Prototype  
> **Focus Areas:** Physics whip system (Verlet), basic platformer movement, attack types  
> **Deferred:** Enemies, health system, slice system, grapple, wall mechanics, scoring

---

## Success Criteria

The prototype is successful when:

-   [ ] Whip extends and retracts with satisfying "snap"
-   [ ] Whip feels weighty but responsive (not floaty or janky)
-   [ ] Player can aim attacks in 8 directions
-   [ ] Basic platformer movement feels tight
-   [ ] You enjoy just swinging the whip around

---

## Phase 0: Godot & Verlet Fundamentals (Week 1)

_Goal: Get comfortable with Godot 4 C# workflow and understand Verlet physics before building._

### 0.1 Godot 4 C# Project Setup

-   [ ] Create new Godot 4.x project with C# support
-   [ ] Verify C# scripts compile and run (create a test Node with `_Ready()` print)
-   [ ] Set up project structure: `Scenes/`, `Scripts/`, `Assets/`
-   [ ] Configure 2D pixel art settings (texture filtering: Nearest, stretch mode: canvas_items)

**Time:** ~30-45 min  
**Done when:** Test scene runs, prints to console, pixel art renders crisp

### 0.2 Godot 2D Physics Crash Course

-   [ ] Create a scene with a `CharacterBody2D` and move it with `MoveAndSlide()`
-   [ ] Understand the difference between `CharacterBody2D`, `RigidBody2D`, and `Area2D`
-   [ ] Experiment with `_Process()` vs `_PhysicsProcess()` timing

**Time:** ~1 hour  
**Done when:** You can move a rectangle around and it stops at walls

### 0.3 Verlet Integration Study

-   [ ] Read/watch a Verlet integration tutorial (see Resources)
-   [ ] Understand the core loop: position, previous position, constraints
-   [ ] Implement a simple 3-point Verlet rope in an isolated test scene
-   [ ] Verify it swings naturally under gravity

**Time:** ~1-2 hours  
**Done when:** A 3-point rope swings and settles realistically in a test scene

---

### ✅ Phase 0 Milestone

-   [ ] Godot 4 C# project compiles and runs
-   [ ] Understand CharacterBody2D movement basics
-   [ ] Simple Verlet rope prototype working

---

## Phase 1: Core Whip Physics (Weeks 2-3)

_Goal: Build the whip as a Verlet rope attached to the player. Focus on physics feel, not attacks yet._

### 1.1 Verlet Point & Constraint System

-   [ ] Create `VerletPoint` class (position, previousPosition, locked flag)
-   [ ] Create `VerletConstraint` class (pointA, pointB, targetLength)
-   [ ] Implement the Verlet integration loop in a manager script
-   [ ] Support constraint iteration (3-5 passes for stability)

**Time:** ~1-2 hours  
**Done when:** Classes exist and compile; loop runs each physics frame

### 1.2 Basic Whip Chain

-   [ ] Create 8-12 `VerletPoint` instances in a line (the whip segments)
-   [ ] Connect them with `VerletConstraint` (fixed distance between each)
-   [ ] Lock the first point (handle) to a fixed position for testing
-   [ ] Apply gravity to all unlocked points
-   [ ] Visualize with `_Draw()` or `Line2D` (simple lines connecting points)

**Time:** ~1-2 hours  
**Done when:** A chain hangs from a fixed point and swings when you move the anchor

### 1.3 Attach Whip to Player

-   [ ] Create a basic player scene (`CharacterBody2D` with placeholder sprite)
-   [ ] Lock the whip handle point to the player's hand position
-   [ ] Whip should follow the player and react to movement
-   [ ] Test: run left/right, whip trails behind naturally

**Time:** ~1 hour  
**Done when:** Whip is visually attached to player and reacts to player movement

### 1.4 Whip Rendering

-   [ ] Replace debug lines with `Line2D` node for smooth rendering
-   [ ] Set line width (2-4 pixels for retro feel)
-   [ ] Add slight taper (thicker at handle, thinner at tip)
-   [ ] Consider adding a simple blade sprite at the tip

**Time:** ~1 hour  
**Done when:** Whip looks like a whip, not debug lines

### 1.5 Tuning Whip Feel

-   [ ] Adjust segment count (try 8, 10, 12—find the sweet spot)
-   [ ] Tune segment length (shorter = stiffer, longer = floppier)
-   [ ] Tune gravity strength on whip
-   [ ] Add damping to reduce endless swinging (multiply velocity by 0.98-0.99)
-   [ ] Test: whip should feel weighty but not sluggish

**Time:** ~1-2 hours  
**Done when:** Whip feels good just watching it react to movement

---

### ✅ Phase 1 Milestone

-   [ ] Verlet whip attached to player
-   [ ] Whip reacts naturally to player movement
-   [ ] Whip rendering looks clean
-   [ ] "Just moving around feels satisfying"

---

## Phase 2: Player Movement (Weeks 4-5)

_Goal: Implement tight, responsive platformer controls. The whip should complement movement._

### 2.1 Ground Movement

-   [ ] Implement horizontal movement with acceleration/deceleration
-   [ ] Set run speed (~200-300 pixels/sec, tune to feel)
-   [ ] Add ground friction for responsive stops
-   [ ] Flip player sprite based on facing direction

**Time:** ~1 hour  
**Done when:** Running feels snappy, not floaty or slippery

### 2.2 Jumping

-   [ ] Implement jump with initial velocity
-   [ ] Apply gravity each frame (standard platformer gravity)
-   [ ] Implement variable jump height (release jump early = shorter jump)
-   [ ] Add coyote time (5-10 frames of jump grace after leaving ground)
-   [ ] Add jump buffering (queue jump if pressed slightly before landing)

**Time:** ~1-2 hours  
**Done when:** Jumping feels precise and forgiving

### 2.3 Air Control

-   [ ] Allow horizontal movement while airborne (slightly reduced acceleration)
-   [ ] Ensure landing is responsive (no slide on landing)
-   [ ] Test jump arcs—should feel like Mega Man, not Mario (less floaty)

**Time:** ~30-45 min  
**Done when:** Air control feels tight, not floaty

### 2.4 Dash Mechanic

-   [ ] Implement dash: quick burst of speed in facing direction
-   [ ] Dash should have brief invincibility frames (for future enemy interactions)
-   [ ] Add short cooldown (0.3-0.5 sec) or limited uses before landing
-   [ ] Dash should work on ground and in air
-   [ ] Visual feedback: motion blur or afterimage (simple version)

**Time:** ~1-2 hours  
**Done when:** Dash feels powerful and has clear cooldown feedback

### 2.5 Movement + Whip Integration

-   [ ] Verify whip reacts well to dashing (snaps behind, then catches up)
-   [ ] Test rapid direction changes—whip should "crack" naturally
-   [ ] Adjust whip damping if movement makes it too chaotic
-   [ ] Ensure whip doesn't clip through the player during fast movement

**Time:** ~1 hour  
**Done when:** Movement and whip feel like one cohesive system

---

### ✅ Phase 2 Milestone

-   [ ] Run, jump, dash all feel tight
-   [ ] Whip reacts naturally to all movement
-   [ ] "Movement alone is fun"

---

## Phase 3: Attack System (Weeks 6-8)

_Goal: Make the whip a weapon. Implement thrust, pull-back, and directional attacks._

### 3.1 Attack Input Handling

-   [ ] Create input actions for attack button
-   [ ] Detect attack direction from input (8 directions: cardinals + diagonals)
-   [ ] Default to facing direction if no directional input
-   [ ] Track attack state (idle, extending, holding, retracting)

**Time:** ~45 min  
**Done when:** Attack input is read and direction is calculated

### 3.2 Thrust Attack - Extension

-   [ ] On attack press, apply strong impulse to whip tip toward aim direction
-   [ ] Whip should extend rapidly (2-5 frames to reach full length)
-   [ ] Option: temporarily stiffen constraints during extension for straighter thrust
-   [ ] Test feel: should feel like a snap, not a lazy swing

**Time:** ~1-2 hours  
**Done when:** Pressing attack makes whip shoot out in aimed direction

### 3.3 Thrust Attack - Hold & Retract

-   [ ] While attack held, whip stays extended (slight sway is fine)
-   [ ] On release (or after max time), whip snaps back to player
-   [ ] Retraction should also be fast but with slight weight
-   [ ] Test: extend, hold, release—full attack cycle feels complete

**Time:** ~1 hour  
**Done when:** Full thrust attack cycle (extend → hold → retract) works

### 3.4 Directional Attacks

-   [ ] Implement all 8 aim directions
-   [ ] Up: thrust upward (anti-air)
-   [ ] Down (air): thrust downward (dive attack)
-   [ ] Diagonals: 45-degree thrusts
-   [ ] Ensure aim direction changes mid-attack if held and direction changes

**Time:** ~1 hour  
**Done when:** Can attack in all 8 directions fluidly

### 3.5 Charged Thrust (Optional Enhancement)

-   [ ] If attack button held before release, charge a power attack
-   [ ] Visual indicator: whip glows or player stance changes
-   [ ] Charged thrust has longer range and/or more force
-   [ ] Charge time: ~0.5-1 second to full charge

**Time:** ~1 hour  
**Done when:** Holding attack briefly before releasing gives a stronger thrust

### 3.6 Pull-Back Attack

-   [ ] Create secondary attack or timing-based mechanic
-   [ ] Option A: Attack button during retraction triggers "return slash"
-   [ ] Option B: Separate button for intentional pull-back strike
-   [ ] Whip tip should be dangerous during retraction
-   [ ] Test: can hit enemies behind you with the return swing

**Time:** ~1-2 hours  
**Done when:** Whip can deal damage on the way back

### 3.7 Attack Canceling & Recovery

-   [ ] Player can dash to cancel attack recovery
-   [ ] Brief recovery window after attack where movement is slowed (50-100ms)
-   [ ] Ensure attacks can't be spammed infinitely—small cooldown or recovery
-   [ ] Test: attack rhythm feels good, not button-mashy

**Time:** ~1 hour  
**Done when:** Attacking has rhythm and commitment but isn't punishing

### 3.8 Whip Blade Hitbox

-   [ ] Add `Area2D` to the whip tip (blade segment)
-   [ ] Hitbox should be active only during attack states
-   [ ] Track blade velocity for future damage calculations
-   [ ] Debug visualize hitbox to verify it follows the tip correctly

**Time:** ~1 hour  
**Done when:** Hitbox follows blade tip, activates during attacks

---

### ✅ Phase 3 Milestone

-   [ ] Thrust attack extends whip rapidly
-   [ ] Attacks aim in 8 directions
-   [ ] Pull-back attack works
-   [ ] Attack cycle has good rhythm
-   [ ] "Attacking feels impactful even without enemies"

---

## Phase 4: Impact & Juice (Weeks 9-10)

_Goal: Make hits FEEL incredible. This is where the game becomes satisfying._

### 4.1 Test Target

-   [ ] Create a simple stationary target object (static body with sprite)
-   [ ] Target should detect when blade hitbox enters
-   [ ] Log hits to console for testing
-   [ ] Place several targets in test scene at different positions

**Time:** ~30-45 min  
**Done when:** Console logs when blade hits targets

### 4.2 Hit Pause (Freeze Frames)

-   [ ] On hit, freeze the game for 3-6 frames (set `Engine.TimeScale = 0`)
-   [ ] Resume after pause duration
-   [ ] Tune pause length: light hits = 2-3 frames, heavy hits = 4-6 frames
-   [ ] Test: hits should feel "crunchy"

**Time:** ~1 hour  
**Done when:** Hitting a target causes a satisfying micro-freeze

### 4.3 Screen Shake

-   [ ] Implement screen shake system (offset camera by random small amounts)
-   [ ] Shake on hit: small shake for light hits, larger for heavy
-   [ ] Shake should decay quickly (0.1-0.2 seconds)
-   [ ] Ensure shake doesn't cause motion sickness (keep it subtle)

**Time:** ~1 hour  
**Done when:** Hits cause screen to shake appropriately

### 4.4 Hit Particles

-   [ ] Create simple particle effect for hits (sparks, impact burst)
-   [ ] Spawn particles at hit location
-   [ ] Particles should burst in direction of blade velocity
-   [ ] Use Godot's `GPUParticles2D` or simple animated sprites

**Time:** ~1-2 hours  
**Done when:** Hits spawn satisfying particle bursts

### 4.5 Hit Flash

-   [ ] Target flashes white briefly on hit
-   [ ] Implement via shader or sprite modulation
-   [ ] Flash duration: 2-4 frames

**Time:** ~30-45 min  
**Done when:** Targets flash when hit

### 4.6 Sound Effects (Placeholder)

-   [ ] Add placeholder SFX for: whip extend, whip retract, hit impact
-   [ ] Source from freesound.org or generate with sfxr/jsfxr
-   [ ] Hook up sounds to appropriate events
-   [ ] Volume balance: hits should be punchy but not jarring

**Time:** ~1 hour  
**Done when:** Whip attacks and hits make sound

### 4.7 Blade Trail Effect

-   [ ] Add motion trail behind blade during attacks
-   [ ] Use `Line2D` with gradient fade or trail renderer
-   [ ] Trail should be visible during fast movement, fade quickly when stopped

**Time:** ~1 hour  
**Done when:** Blade leaves a visible trail during swings

### 4.8 Impact Polish Pass

-   [ ] Combine all effects: pause + shake + particles + flash + sound
-   [ ] Tune timing so effects layer correctly
-   [ ] Test different attack types—ensure impact scales appropriately
-   [ ] Get feedback: does hitting things feel GOOD?

**Time:** ~1-2 hours  
**Done when:** Every hit feels satisfying and impactful

---

### ✅ Phase 4 Milestone

-   [ ] Hits cause freeze frames, screen shake, particles, flash, and sound
-   [ ] Impact feedback is layered and polished
-   [ ] "Hitting the target is the most satisfying part of the game"

---

## Phase 5: Test Level & Polish (Weeks 11-12)

_Goal: Create a simple test environment and polish the overall experience._

### 5.1 Tilemap Setup

-   [ ] Create simple tileset (platforms, walls) with placeholder art
-   [ ] Set up `TileMap` with collision
-   [ ] Build a small test level: platforms at various heights, gaps to jump

**Time:** ~1-2 hours  
**Done when:** Test level is playable with basic geometry

### 5.2 Camera System

-   [ ] Implement smooth camera follow
-   [ ] Camera should lead slightly in movement direction
-   [ ] Clamp camera to level bounds
-   [ ] Ensure screen shake integrates with camera system

**Time:** ~1 hour  
**Done when:** Camera follows player smoothly

### 5.3 Spawn Targets in Level

-   [ ] Place test targets throughout the level
-   [ ] Targets at different heights, positions, angles
-   [ ] Include some targets that require specific attack directions

**Time:** ~30 min  
**Done when:** Test level has targets to attack

### 5.4 Movement Polish

-   [ ] Final tuning pass on movement values
-   [ ] Ensure no edge cases (stuck on corners, jittering)
-   [ ] Test movement in context of level geometry

**Time:** ~1 hour  
**Done when:** Movement feels polished in level context

### 5.5 Attack Polish

-   [ ] Final tuning pass on attack timing and feel
-   [ ] Ensure attacks work well in level context (hitting targets on platforms, etc.)
-   [ ] Address any physics edge cases (whip going through walls, etc.)

**Time:** ~1-2 hours  
**Done when:** Attacks feel polished in level context

### 5.6 Debug Tools

-   [ ] Add debug toggle for: hitbox visualization, whip points, frame data
-   [ ] Add quick restart key (for testing)
-   [ ] Optional: Add simple on-screen stats (velocity, attack state)

**Time:** ~30-45 min  
**Done when:** Can toggle debug visualizations

---

### ✅ Phase 5 Milestone

-   [ ] Test level is playable
-   [ ] Camera follows smoothly
-   [ ] Movement and attacks are polished
-   [ ] "The prototype is playable and feels good"

---

## Phase 6: Prototype Complete (Weeks 13-14)

_Goal: Final polish and prepare for feedback._

### 6.1 Bug Fixing

-   [ ] Playtest and note all bugs/issues
-   [ ] Fix critical bugs (crashes, major physics issues)
-   [ ] Document known issues for later

**Time:** ~2-3 hours  
**Done when:** No critical bugs remain

### 6.2 Build & Export

-   [ ] Export playable build (Windows, or web if desired)
-   [ ] Test exported build to ensure it runs correctly
-   [ ] Create simple title screen (optional, can be just "Press Start")

**Time:** ~1 hour  
**Done when:** Distributable build exists

### 6.3 Gather Feedback

-   [ ] Share with 2-3 people for feedback
-   [ ] Observe: Do they experiment with the whip? Is it intuitive?
-   [ ] Ask: Does the whip feel good? What's confusing? What's fun?
-   [ ] Document feedback for future iterations

**Time:** ~1-2 hours  
**Done when:** Feedback collected and documented

---

### ✅ Final Prototype Milestone

-   [ ] Playable prototype with physics whip, movement, and attacks
-   [ ] Impact feedback makes hits feel satisfying
-   [ ] Test level demonstrates core mechanics
-   [ ] Feedback collected from testers
-   [ ] **"The whip feels good"**

---

## Tips for Staying on Track

1. **Timebox tuning:** Physics tuning can eat infinite hours. Set a timer (30-60 min), then move on. You can always return.

2. **Trust the Verlet:** If the whip feels weird, the fix is usually in constraints or damping, not adding complexity.

3. **Impact first, enemies later:** You don't need enemies to feel good hits. Test targets are enough for MVP.

4. **Record your progress:** Capture short GIFs/videos. Seeing improvement over time is motivating.

5. **Playtest often:** Every session, spend 5 minutes just playing. Notice what feels off.

6. **It's okay to fake it:** If something looks right but isn't "physically accurate," that's fine. Games are about feel.

7. **One thing at a time:** Don't try to add enemies while still tuning the whip. Finish phases before moving on.

---

## Resources

### Godot 4 C#

-   [Godot 4 C# Documentation](https://docs.godotengine.org/en/stable/tutorials/scripting/c_sharp/index.html)
-   [CharacterBody2D Tutorial](https://docs.godotengine.org/en/stable/tutorials/physics/using_character_body_2d.html)

### Verlet Integration

-   [Coding Math: Verlet Integration](https://www.youtube.com/watch?v=3HjO_RGIjCU) (video)
-   [Making a Verlet Physics Engine in JavaScript](https://pikuma.com/blog/verlet-integration-2d-cloth-physics-simulation) (concepts apply to C#)
-   [Thomas Jakobsen's Paper on Verlet](https://www.cs.cmu.edu/afs/cs/academic/class/15462-s13/www/lec_slides/Jakobsen.pdf) (original technique)

### Game Feel

-   [Game Feel by Steve Swink](http://www.game-feel.com/) (book, highly recommended)
-   [Juice It or Lose It](https://www.youtube.com/watch?v=Fy0aCDmgnxg) (GDC talk on impact feedback)
-   [The Art of Screenshake](https://www.youtube.com/watch?v=AJdEqssNZ-U) (Vlambeer talk)

### Sound Effects

-   [jsfxr](https://sfxr.me/) (browser-based SFX generator)
-   [Freesound.org](https://freesound.org/) (free sound effects)

### Pixel Art (for later)

-   [Lospec Palette List](https://lospec.com/palette-list) (color palettes)
-   [Aseprite](https://www.aseprite.org/) (pixel art tool)

---

## Future Features (Post-MVP)

These were explicitly deferred. Tackle after the prototype proves the core is fun:

### Movement Expansion

-   [ ] Wall slide and wall jump
-   [ ] Double jump or air dash

### Attack Expansion

-   [ ] Spin attack (360° rotation)
-   [ ] Whip grapple (hook ledges, swing)
-   [ ] Whip parry (deflect projectiles)

### Combat Depth

-   [ ] Velocity-based damage scaling
-   [ ] Enemy weak points and slice system
-   [ ] Hit combo counter

### Enemies

-   [ ] Basic enemy types (Drone, Walker, Shielder)
-   [ ] Enemy AI and attack patterns
-   [ ] Health system for player

### Progression

-   [ ] Multiple levels with unique geometry
-   [ ] Boss encounters
-   [ ] Scoring and ranking system (S/A/B/C/D)

### Polish

-   [ ] High-res pixel art (replace placeholders)
-   [ ] Full sound design and music
-   [ ] Particle polish pass
-   [ ] Accessibility options (aim assist, difficulty)

---

## Alternate Approach: RigidBody2D Whip

If Verlet integration proves too tricky or you want to experiment:

1. Create a chain of `RigidBody2D` nodes connected by `PinJoint2D`
2. Lock the first body to the player
3. Apply forces to the tip for attacks
4. Tune mass, damping, and joint parameters

**Pros:** Built-in collision, less custom code  
**Cons:** Harder to make snappy, more unpredictable

Revisit this approach if Verlet feels uncontrollable or you need environment collision.

---

_Good luck! Focus on making the whip feel incredible. Everything else can wait._
