# Physics-Based Platformer - Expanded Design Document

> **Last Updated:** January 2026  
> **Status:** Concept Expansion  
> **Working Title:** _Whiplash_ (placeholder)

---

## Executive Summary

**Core Hook:** A 2D action platformer where your weapon—a bladed whip—is controlled by real physics. Every swing has weight, every hit has impact. Slice through robotic enemies with the precision of Mega Man Zero and the tactile satisfaction of a physics toy.

**Target Audience:**

-   Action platformer fans (Mega Man Zero, Dead Cells, Katana Zero)
-   Players who enjoy skill-based combat with high ceilings (Devil May Cry, Sekiro)
-   Fans of physics-based games who want more action (Getting Over It, but aggressive)
-   Speedrunners and combo enthusiasts

**Elevator Pitch:** "Your weapon has weight. Your enemies have weak points. Make every swing count."

---

## Market Analysis

### Comparable Products

| Game               | Strengths                                        | Weaknesses                           | Gap We Fill                               |
| ------------------ | ------------------------------------------------ | ------------------------------------ | ----------------------------------------- |
| **Mega Man Zero**  | Incredible feel, ranking system, slicing enemies | Fixed attack patterns, dated         | Physics-based attacks with same precision |
| **Dead Cells**     | Fluid combat, roguelike replayability            | Weapons feel similar, less precision | Unique physics weapon feel                |
| **Katana Zero**    | Stylish, time-slow, instant kills                | Short, linear weapon                 | Whip range + physics depth                |
| **Fury Unleashed** | Comic style, combo system                        | Less precision, more chaos           | Precise hits matter more                  |
| **Blasphemous**    | Gorgeous art, weighty combat                     | Slow, methodical                     | Fast but impactful                        |

### Physics-Based Games Comparison

| Game                | Physics Feel             | Combat? | What We Learn                 |
| ------------------- | ------------------------ | ------- | ----------------------------- |
| **Getting Over It** | Core gameplay IS physics | No      | Weight and frustration/reward |
| **Starblade**       | Whip-like weapon         | Yes     | Inspiration for whip feel     |
| **Umihara Kawase**  | Grappling physics        | No      | Rope/swing physics            |
| **Flail Rider**     | Flail weapon physics     | Yes     | Momentum-based combat         |

### Market Gap Identified

1. **Physics weapons in precision games:** Most physics games are ragdoll comedy; precision combat with physics is rare
2. **High-res pixel art action:** The Mega Man Zero aesthetic is beloved but underserved
3. **Whip as primary weapon:** Castlevania moved away from whips; there's nostalgia to tap
4. **Feel over complexity:** Many action games add mechanics; we focus on one perfect weapon

---

## Core Mechanics

### The Bladed Whip

The central mechanic is a whip-like weapon that follows realistic physics:

| Property      | Description                                        |
| ------------- | -------------------------------------------------- |
| **Segments**  | Whip made of connected rigid body segments (10-15) |
| **Blade**     | Tip segment deals damage on collision              |
| **Momentum**  | Damage scales with velocity at impact              |
| **Gravity**   | Whip is affected by gravity when extended          |
| **Collision** | Whip interacts with environment and enemies        |

### Control Scheme

**Primary Actions:**

| Input                  | Action              | Notes                          |
| ---------------------- | ------------------- | ------------------------------ |
| **Attack Button**      | Thrust whip forward | Fast extension, blade leads    |
| **Hold + Release**     | Charged thrust      | Longer range, more power       |
| **Attack + Direction** | Directional attack  | Aim up, down, diagonal         |
| **Pull Back**          | Retract whip        | Snap back, can hit on return   |
| **Spin Input**         | Circular swing      | Full 360° rotation, continuous |

**Movement:**

| Input               | Action                                 |
| ------------------- | -------------------------------------- |
| **Move**            | Run left/right                         |
| **Jump**            | Standard jump                          |
| **Dash**            | Quick invincible dash (short cooldown) |
| **Wall Slide/Jump** | Wall interaction                       |

### Attack Types

| Attack              | Execution                | Use Case                         |
| ------------------- | ------------------------ | -------------------------------- |
| **Quick Thrust**    | Tap attack               | Fast poke, low commitment        |
| **Power Thrust**    | Hold + release           | High damage, breaks guards       |
| **Rising Slash**    | Attack + Up              | Anti-air, launcher               |
| **Plunging Strike** | Attack + Down (air)      | Dive attack, bounces off enemies |
| **Spin Attack**     | Rotate stick + attack    | Area control, crowd clear        |
| **Whip Catch**      | Extend + hold near ledge | Grapple to ledges                |
| **Return Slash**    | Time pull-back           | Hit enemies behind you           |

### Physics Feel: Fast and Snappy with Impact

The whip should feel:

-   **Extension:** Extremely fast, almost instant to reach full length
-   **Idle:** Hangs naturally with subtle sway
-   **Hit Reaction:** HARD pause frames on contact (3-5 frames), screen shake, particle burst
-   **Pull Back:** Snap retraction with satisfying audio cue
-   **Spin:** Smooth, continuous, builds visual intensity

**Impact System:**

| Impact Type  | Frames Frozen | Screen Shake | Effect                     |
| ------------ | ------------- | ------------ | -------------------------- |
| Light hit    | 2-3 frames    | Minimal      | Small sparks               |
| Heavy hit    | 4-6 frames    | Medium       | Large sparks, enemy recoil |
| Critical hit | 6-8 frames    | Heavy        | Slow-mo, massive particles |
| Enemy slice  | 8-10 frames   | Heavy        | Bisection animation        |

### Enemy Slice System (Mega Man Zero Inspired)

Enemies have **cut points** that determine how they're sliced:

| Cut Point  | Result           | Example                             |
| ---------- | ---------------- | ----------------------------------- |
| Horizontal | Top/bottom split | Robot sliced at waist               |
| Vertical   | Left/right split | Robot sliced down middle            |
| Diagonal   | Angled split     | Dynamic slash effect                |
| Limb       | Part removed     | Arm falls off, enemy weakened       |
| Head       | Instant kill     | Decapitation (robots, so it's fine) |

**Hit Detection:**

-   Blade velocity + angle determines cut direction
-   Higher velocity = cleaner cut animation
-   Low velocity = enemies flinch but survive

### Enemy Design

| Enemy Type   | Behavior           | Weak Point             |
| ------------ | ------------------ | ---------------------- |
| **Drone**    | Floats, shoots     | Anywhere (fragile)     |
| **Walker**   | Patrols, melee     | Head, joints           |
| **Shielder** | Blocks front       | Back, overhead         |
| **Charger**  | Rushes player      | Must be hit mid-charge |
| **Turret**   | Stationary, aims   | Core (armored sides)   |
| **Flyer**    | Aerial, dive bombs | Wings, then body       |
| **Heavy**    | Slow, armored      | Exposed joints only    |

### Scoring/Ranking System (Optional for Full Version)

| Rank  | Requirements                           |
| ----- | -------------------------------------- |
| **S** | No damage, fast time, all slices clean |
| **A** | Minor damage, good time                |
| **B** | Some hits taken, average time          |
| **C** | Struggled, slow time                   |
| **D** | Just survived                          |

---

## Visual & Audio Design

### Art Direction

**Style:** High-resolution pixel art inspired by Mega Man Zero/ZX series

| Element           | Description                                       |
| ----------------- | ------------------------------------------------- |
| **Resolution**    | 320x180 base, scaled up                           |
| **Color Palette** | Vibrant sci-fi (neon accents, dark backgrounds)   |
| **Animation**     | Fluid, high frame count for player (12-24 fps)    |
| **Backgrounds**   | Parallax layers, detailed but not distracting     |
| **Effects**       | Generous particles, motion trails, impact flashes |

### Character Design

-   **Protagonist:** Sleek android/cyborg with visible whip attachment point
-   **Enemies:** Distinct silhouettes, clear weak point indicators
-   **Bosses:** Large, multi-phase, memorable designs

### Audio Design

| Sound            | Feel                          |
| ---------------- | ----------------------------- |
| **Whip extend**  | Sharp _crack_ or _whoosh_     |
| **Whip retract** | Metallic _clink_ chain sound  |
| **Hit (light)**  | Quick metallic impact         |
| **Hit (heavy)**  | Meaty thud + reverb           |
| **Slice**        | Satisfying _shink_            |
| **Enemy death**  | Explosion + mechanical sparks |
| **Dash**         | Whoosh + subtle time-stretch  |

### Impact Feedback Layers

Every hit should have:

1. **Visual:** Particles, flash, slow-mo
2. **Audio:** Layered impact sound
3. **Haptic:** Controller rumble (if supported)
4. **Animation:** Enemy recoil, player follow-through
5. **Screen:** Shake, chromatic aberration pulse

---

## Prototype / MVP Scope

### MVP Goal

Validate that physics-based whip combat feels satisfying and that the impact system delivers the "weight" players crave.

### MVP Features

| Feature                          | Priority    | Notes                      |
| -------------------------------- | ----------- | -------------------------- |
| Physics whip system              | Must Have   | Core of the game           |
| Basic movement (run, jump, dash) | Must Have   | Platformer fundamentals    |
| Thrust attack                    | Must Have   | Primary attack             |
| Pull-back attack                 | Must Have   | Secondary attack           |
| Spin attack                      | Should Have | Crowd control option       |
| 3 enemy types                    | Must Have   | Drone, Walker, Shielder    |
| Hit pause/impact system          | Must Have   | Key to "weight" feel       |
| 1-2 test levels                  | Must Have   | Linear, combat-focused     |
| Slice system (basic)             | Should Have | Horizontal/vertical cuts   |
| Placeholder art                  | Acceptable  | Focus on feel over visuals |

### MVP Excludes

-   Story/cutscenes
-   Bosses
-   Ranking system
-   Multiple environments
-   Grapple mechanics
-   RPG elements/upgrades
-   High-res art (use simpler sprites)

### Success Criteria

| Metric                            | Target                  |
| --------------------------------- | ----------------------- |
| "Whip feels good" rating          | 8/10+ average           |
| Impact moments feel impactful     | 90%+ agree              |
| Combat is readable/understandable | 85%+ agree              |
| Players experiment with attacks   | Observed in playtesting |
| "I want to play more"             | 70%+ say yes            |

### MVP Timeline Estimate

| Phase              | Duration        | Tasks                           |
| ------------------ | --------------- | ------------------------------- |
| Physics Prototype  | 3-4 weeks       | Whip system, basic movement     |
| Combat System      | 3-4 weeks       | Attacks, enemies, hit detection |
| Impact Polish      | 2-3 weeks       | Pause frames, effects, audio    |
| Level Building     | 2 weeks         | 1-2 test levels                 |
| Playtest & Iterate | 2 weeks         | Tune feel based on feedback     |
| **Total**          | **12-15 weeks** |                                 |

---

## Full Vision

### If Prototype Succeeds...

**Campaign Structure:**

-   8-10 stages with distinct themes
-   8-10 bosses with multi-phase fights
-   Unlockable difficulty modes
-   Time attack / score attack modes

**Stage Themes:**

| Stage          | Environment        | Unique Elements               |
| -------------- | ------------------ | ----------------------------- |
| **City Ruins** | Urban decay        | Collapsing platforms, traffic |
| **Factory**    | Industrial         | Conveyor belts, crushers      |
| **Sky Tower**  | Vertical climb     | Wind, floating platforms      |
| **Laboratory** | Clean/sterile      | Lasers, test chambers         |
| **Cyberspace** | Abstract digital   | Glitch hazards, teleporters   |
| **Warzone**    | Military           | Missiles, tanks, chaos        |
| **Core**       | Organic/mechanical | Final area, all mechanics     |

**Advanced Whip Techniques:**

| Technique         | Unlock   | Use                             |
| ----------------- | -------- | ------------------------------- |
| **Grapple Swing** | Stage 2  | Hook ledges, swing across gaps  |
| **Whip Parry**    | Stage 3  | Deflect projectiles with timing |
| **Charged Spin**  | Stage 4  | Massive AoE, costs meter        |
| **Whip Plant**    | Stage 5  | Anchor whip, swing around it    |
| **Dual Whip**     | Postgame | Two whips, advanced combos      |

**Boss Design Philosophy:**

-   Each boss tests mastery of mechanics learned
-   Multi-phase with distinct attack patterns
-   Clear tells, learnable patterns
-   Weak points that reward precision

**Ranking & Replayability:**

-   S/A/B/C/D ranks per stage
-   Online leaderboards for time/score
-   Achievements for stylish play
-   Unlockable cosmetics (whip skins, colors)

---

## Risks & Mitigations

| Risk                         | Likelihood | Impact   | Mitigation                                                  |
| ---------------------------- | ---------- | -------- | ----------------------------------------------------------- |
| Physics feels janky          | High       | Critical | Tune constants extensively; fake physics if needed          |
| Hit detection unreliable     | Medium     | High     | Use generous hitboxes; visual feedback clarifies            |
| Too hard to control          | Medium     | High     | Provide aim assist options; practice modes                  |
| Not enough depth             | Medium     | Medium   | Add techniques progressively; skill ceiling through mastery |
| Art requirements too high    | Medium     | Medium   | Start with placeholder; commission key art later            |
| Performance issues (physics) | Low        | Medium   | Limit whip segments; optimize collision checks              |
| Unfavorably compared to MMZ  | Medium     | Low      | Lean into physics uniqueness; don't copy directly           |

### The "Feel" Risk

The biggest risk is that physics-based combat feels unresponsive or floaty. Mitigations:

1. **Fast extension:** Whip reaches full length in 2-3 frames
2. **Aim assist:** Slight magnetism toward enemies
3. **Forgiving hitboxes:** Blade hitbox slightly larger than visual
4. **Cancel options:** Can always dash to cancel recovery
5. **Predictable physics:** Minimal randomness in whip behavior
6. **Pause frames:** Make hits FEEL heavy even if physics is light

---

## Feasibility Assessment

### Technical Requirements (Godot/C#)

| System                      | Complexity | Notes                            |
| --------------------------- | ---------- | -------------------------------- |
| 2D Platformer movement      | Low        | CharacterBody2D, standard        |
| Physics whip (rigid bodies) | High       | Chain of RigidBody2D with joints |
| Hit detection               | Medium     | Area2D on blade segment          |
| Velocity-based damage       | Low        | Calculate on collision           |
| Pause frame system          | Low        | Engine.time_scale manipulation   |
| Screen shake                | Low        | Common effect, well-documented   |
| Parallax backgrounds        | Low        | Built-in Godot support           |
| Enemy AI                    | Medium     | State machines, pathfinding      |

### Physics Whip Implementation Options

| Approach                    | Pros           | Cons                                 |
| --------------------------- | -------------- | ------------------------------------ |
| **Full RigidBody chain**    | Most realistic | Performance concerns, harder to tune |
| **Verlet integration**      | Fast, stable   | Custom implementation needed         |
| **Hybrid (fake + real)**    | Best of both   | Complexity in switching              |
| **Fully animated + hitbox** | Simplest       | Loses physics uniqueness             |

**Recommendation:** Start with RigidBody chain, simplify if performance issues arise. Consider Verlet integration as backup.

### Art Requirements

| Asset Type        | Quantity (MVP) | Quantity (Full) |
| ----------------- | -------------- | --------------- |
| Player animations | 15-20          | 30-40           |
| Enemy sprites     | 3-5 types      | 10-15 types     |
| Environment tiles | 50-100         | 200-300         |
| Effects/particles | 10-15          | 30-50           |
| Boss sprites      | 0              | 8-10            |
| UI elements       | 10             | 20-30           |

**Art Approach:**

-   MVP: Programmer art or simple pixel art
-   Validation: If feel is right, invest in high-res pixel art
-   Estimated cost: $2000-5000 for full game art assets (commissioned)

### Solo Dev Reality Check

| Factor                   | Assessment                               |
| ------------------------ | ---------------------------------------- |
| Technical skill required | High—physics tuning is tricky            |
| Art requirements         | High—but can defer with placeholder      |
| Design complexity        | Medium—one weapon, master it             |
| Time investment          | 3-4 months for MVP                       |
| Burnout risk             | Medium—physics tuning can be frustrating |

**Recommendation:** This is technically ambitious but feasible. The physics system will require iteration. Be prepared to simplify if needed—the feel matters more than simulation accuracy.

---

## Open Questions

1. **How many whip segments?** More = more realistic, but harder to tune. Start with 8-12, adjust based on feel.

2. **Should blade velocity affect damage linearly or with thresholds?** Linear is intuitive; thresholds create "proper hit" moments.

3. **Grapple from the start or unlockable?** Adds traversal depth but may overwhelm early. Consider introducing in stage 2-3.

4. **How punishing should misses be?** Full recovery animation? Cancel with dash? Affects aggression balance.

5. **Health system?** HP bar, 3 hits, or one-hit with slow-mo saves (like Katana Zero)?

6. **Should enemies telegraph weak points?** Glowing spots vs. learning through experimentation?

7. **Narrative justification for whip?** Built-in weapon, ancient artifact, experimental tech?

8. **Difficulty options?** Easy mode with aim assist and slower enemies? Hardcore mode with one-hit deaths?

---

## References & Inspiration

### Games

-   **Mega Man Zero series** - Art style, slicing, ranking system
-   **Katana Zero** - Impact feel, slow-mo, stylish action
-   **Dead Cells** - Fluid combat, weapon variety baseline
-   **Umihara Kawase** - Physics rope traversal
-   **Blasphemous** - Dark pixel art, weighty combat
-   **Devil May Cry** - Combo depth, style meter

### Physics References

-   **Verlet integration tutorials** - For custom rope physics
-   **Godot RigidBody2D joints** - For chain physics
-   **Game Feel by Steve Swink** - Impact and feedback design

### Visual References

-   **Mega Man Zero/ZX Official Complete Works** - Art style bible
-   **Hyper Light Drifter** - Pixel art effects
-   **Blazing Chrome** - Modern retro action aesthetic

---

_Document generated for solo developer consideration. Physics system is the high-risk, high-reward core—prototype early and often._
