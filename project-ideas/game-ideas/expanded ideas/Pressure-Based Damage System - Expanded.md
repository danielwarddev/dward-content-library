# Pressure-Based Damage System

## Executive Summary

**Core Hook**: A 2D action game where damage isn't just about hitting enemies—it's about *how* you hit them. Attacks deal more damage based on the physical force behind them: momentum, weight, positioning, and environmental factors all multiply your impact. A perfectly timed downward strike from a ledge devastates; a desperate backward swing while retreating barely scratches.

**Target Audience**: Players who enjoy skill-expressive combat systems with emergent depth—fans of games like Dead Cells, Hollow Knight, and Dark Souls who appreciate when mastery is rewarded through mechanics rather than just stats.

**Genre**: 2D action platformer with gritty, weighty combat  
**Art Style**: Pixel art or stylized 2D with impactful visual feedback  
**Tone**: Gritty, serious, grounded fantasy or dark sci-fi

---

## Market Analysis

### What's Succeeding

| Game | Relevant Mechanic | Why It Works |
|------|-------------------|--------------|
| **Hollow Knight** | Nail arts with wind-up | Charging attacks feel impactful; positioning matters |
| **Dead Cells** | DPS meta, speed scaling | Fast, responsive; damage tied to build synergy |
| **Blasphemous** | Weighty, deliberate combat | Every swing feels heavy and meaningful |
| **Rain World** | Physics-based movement | Momentum and weight create emergent gameplay |
| **Hyper Light Drifter** | Dash-centric combat | Positioning is core to damage and survival |
| **Celeste** | Momentum preservation | Players intuitively understand physics-feel |

### Comparable Products

- **Platformers with physics combat** are rare—most use hitbox/hurtbox + flat damage
- **Fighting games** have frame data and combo damage scaling, but not physics-based
- **Physics sandboxes** (Totally Accurate Battle Simulator, Human Fall Flat) use physics for comedy, not precision combat

### Identified Gap

**No 2D action game makes physics-based damage the core differentiator.** Players understand that a running punch hurts more than a standing jab, but games rarely model this. There's an opportunity to create intuitive, skill-expressive combat where spatial reasoning and momentum management directly translate to damage output.

---

## Core Mechanics

### 1. Pressure Calculation System

Damage is calculated using a **Pressure Formula** that considers multiple factors:

```
Final Damage = Base Damage × Momentum Multiplier × Position Multiplier × Weight Multiplier × Environmental Multiplier
```

#### Momentum Multiplier (0.5x – 2.5x)

| State | Multiplier | Example |
|-------|------------|---------|
| Stationary | 1.0x | Standing still, basic attack |
| Walking toward target | 1.2x | Advancing strike |
| Running toward target | 1.5x | Charging attack |
| Falling | 1.3x – 2.0x | Based on fall distance |
| Dashing | 1.8x | Dash-attack commitment |
| Moving away | 0.5x – 0.8x | Retreating swing (penalized) |
| Lunging (special) | 2.0x – 2.5x | Full commitment wind-up attacks |

**Design Intent**: Reward aggression and commitment. Running away while swinging should feel weak. Charging in should feel powerful but risky.

#### Position Multiplier (0.8x – 2.0x)

| Position | Multiplier | Rationale |
|----------|------------|-----------|
| Striking downward (above target) | 1.5x – 2.0x | Gravity assists; high ground advantage |
| Striking upward (below target) | 0.8x – 1.0x | Fighting gravity |
| Flanking/behind | 1.3x | Undefended angle |
| Cornered target | 1.2x | Nowhere to absorb impact |
| Airborne target (juggle) | 1.4x | Can't brace for impact |

**Design Intent**: Positioning should be a constant consideration. Taking the high ground matters. Cornering enemies is rewarded.

#### Weight Multiplier (Weapon Dependent)

| Weapon Class | Base Speed | Weight Factor | Sweet Spot |
|--------------|------------|---------------|------------|
| Daggers | Very Fast | 0.8x base, high momentum scaling | Best with dashes/combos |
| Swords | Medium | 1.0x base, balanced scaling | Versatile |
| Hammers | Slow | 1.5x base, massive momentum scaling | Devastating with height/charge |
| Fists | Fast | 0.6x base, combo multiplier | Reward sustained aggression |
| Polearms | Medium-Slow | 1.2x base, tip damage bonus | Range + sweet spot |

**Design Intent**: Weapon choice changes *how* you want to apply pressure. Daggers want constant movement; hammers want big setup moments.

#### Environmental Multiplier

| Factor | Multiplier | Example |
|--------|------------|---------|
| Slamming into wall | +0.3x | Enemy pinned against surface |
| Knocking off ledge | Fall damage bonus | Gravity does the work |
| Explosive barrels | +1.0x | Environmental hazard |
| Slippery surface | Variable | Sliding attacks, loss of control |
| Narrow corridor | +0.2x | No room to disperse force |

### 2. Visual Feedback System

**Critical for player understanding.** The pressure system must be *felt* and *seen*:

| Element | Implementation |
|---------|----------------|
| **Impact particles** | Scale with final damage—bigger hits = bigger sparks/blood |
| **Screen shake** | Intensity proportional to damage dealt |
| **Slowdown frames** | Hitstop duration increases with pressure |
| **Sound design** | Layered impact sounds: weak = thud, strong = CRUNCH |
| **Damage numbers** | Color-coded: white (normal), yellow (1.5x+), red (2.0x+) |
| **Trailing effects** | Weapon trails lengthen with momentum |
| **Enemy reactions** | Stagger distance/duration based on pressure |

### 3. Enemy Pressure (The Other Direction)

Enemies also use pressure. A charging enemy hits harder. This creates:

- **Risk/reward for aggression**: You want momentum, but so do they
- **Interception gameplay**: Stopping a charging enemy mid-run reduces their damage
- **Clash mechanics**: Two charging combatants meeting could have special interactions

### 4. Defensive Pressure Interactions

| Defensive Action | Pressure Interaction |
|------------------|----------------------|
| **Block** | High-pressure attacks cause guard break/stamina drain |
| **Parry** | Reflects pressure back—high-pressure parries stun longer |
| **Dodge** | Preserves your momentum for counter-attack |
| **Counter-charge** | Clash mechanic—higher pressure wins |

---

## Prototype MVP

### Minimal Scope (2-4 weeks)

**One room. One weapon. One enemy type. Pressure system working.**

#### Must Have
- [ ] Player movement: walk, run, jump, dash
- [ ] Basic attack with visible wind-up
- [ ] Momentum tracking (velocity → multiplier)
- [ ] Position tracking (height difference → multiplier)
- [ ] Visual damage numbers showing final calculation
- [ ] One enemy that walks toward player and attacks
- [ ] Debug UI showing pressure calculation in real-time

#### Nice to Have (if time permits)
- [ ] Simple combo system (2-3 hit chain)
- [ ] One additional weapon type (different weight class)
- [ ] Basic environmental collision (wall slam)

### Success Criteria

| Metric | Target | How to Measure |
|--------|--------|----------------|
| **Feel** | Attacks feel meaningfully different based on approach | Playtest feedback |
| **Clarity** | Players understand why some hits hurt more | Ask testers to explain the system |
| **Skill Expression** | Good players consistently deal more damage | Compare damage output between skill levels |
| **Fun** | Players *want* to set up big hits | Observe if players cheese or engage |

### Prototype Test Questions
1. Does the pressure difference feel significant enough to matter?
2. Is the system intuitive or confusing?
3. Do players naturally start optimizing for pressure?
4. Is the visual feedback sufficient to communicate multipliers?
5. Does it feel good, or does it feel like doing math?

---

## Full Vision

### If Prototype Succeeds

#### Campaign Structure
- **Interconnected levels** with varied terrain for pressure exploitation
- **Boss fights** designed around pressure mechanics (e.g., a boss that's invulnerable unless you have enough momentum)
- **Metroidvania elements**: Unlocking abilities that enable new pressure strategies

#### Expanded Weapon Arsenal

| Weapon | Unique Pressure Mechanic |
|--------|--------------------------|
| Whip | Sweet spot at tip—maximum damage at max range |
| Throwing axe | Inherits your momentum at release |
| Grappling mace | Pull enemies before impact |
| Pile bunker | Massive wind-up, devastating point-blank pressure |
| Shield | Bash uses your block's absorbed pressure |

#### Advanced Systems
- **Pressure combos**: Chaining attacks that build cumulative momentum
- **Pressure abilities**: Special moves that store/release pressure (e.g., "Momentum Burst"—freeze your current pressure for 3 seconds)
- **Enemy pressure tells**: Learn enemy charge patterns, exploit openings
- **Pressure puzzles**: Environmental puzzles requiring specific force application

#### Progression
- **Unlockable weapons** with different pressure profiles
- **Pressure talents**: Passive modifiers (+10% momentum from dashing, etc.)
- **Runes/equipment**: Customize pressure formula weights

---

## Risks & Mitigations

| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
| **System feels like math, not combat** | Medium | High | Invest heavily in feel/juice; hide numbers behind intuitive feedback |
| **Too complex to understand** | Medium | High | Start with only momentum; add layers gradually; excellent tutorials |
| **Encourages degenerate strategies** | Medium | Medium | Playtest for cheese; add variety to optimal play |
| **Performance issues (physics calculations)** | Low | Medium | Simplified physics; cache calculations; profile early |
| **Balancing nightmare** | High | Medium | Multiplicative systems are volatile—test extensively; have override values |
| **Doesn't feel different enough** | Medium | High | If pressure swing is 0.5x–2.5x, difference is 5x—should be noticeable |

### Biggest Risk

**The system could feel invisible.** If players don't *notice* the pressure difference, they'll just mash attack like any other game. Mitigation: Make low-pressure attacks feel *unsatisfyingly weak* and high-pressure attacks feel *devastatingly powerful*. The contrast must be visceral.

---

## Feasibility Assessment

### Timeline (Solo Dev, Godot/C#)

| Phase | Duration | Deliverables |
|-------|----------|--------------|
| **Prototype** | 3-4 weeks | Core pressure system, one weapon, one enemy |
| **Validation** | 1-2 weeks | Playtesting, iteration, kill/continue decision |
| **Vertical Slice** | 6-8 weeks | One polished level, 3 weapons, 3 enemies, boss |
| **Full MVP** | 4-6 months | 3-5 levels, 6+ weapons, full enemy variety, story beats |
| **Polish & Release** | 2-3 months | Bug fixes, balancing, achievements, Steam integration |

### Technical Considerations

| System | Complexity | Notes |
|--------|------------|-------|
| Velocity tracking | Low | Godot's CharacterBody2D handles this |
| Multiplier calculation | Low | Simple math, run on hit |
| Position comparison | Low | Compare Y positions, dot products for angles |
| Visual feedback | Medium | Particles, screenshake—Godot has good support |
| Enemy AI | Medium | State machines, need pressure-aware behavior |
| Balancing tools | Medium | Build debug UI early for tweaking values |

### Asset Requirements

| Asset Type | Approach |
|------------|----------|
| **Player sprites** | Commission or asset pack; 8-directional, multiple weapons |
| **Enemy sprites** | Start with 1-2 types; expand post-validation |
| **Tilesets** | Asset packs for prototype; custom for release |
| **Sound effects** | Layered impact sounds critical; consider professional SFX pack |
| **Music** | Atmospheric, gritty; commission or royalty-free |

---

## Open Questions

1. **How granular should the UI be?** Should players see the exact multipliers, or just the final number with color coding?

2. **Should pressure affect things beyond damage?** Stagger duration, knockback distance, status effect application?

3. **What's the optimal pressure range?** Current proposal is 0.25x–5.0x (20x difference). Is that too extreme or not enough?

4. **How do ranged attacks work?** Does the projectile inherit momentum? Does distance matter?

5. **What about PvP potential?** The system could be fascinating in player-vs-player. Worth considering in design?

6. **Narrative framing?** What world/story makes "pressure" thematically resonant? A world where physics are literally weaponized?

7. **Accessibility considerations?** For players who struggle with precision, should there be assists that help maintain pressure?

---

## Summary

The Pressure-Based Damage System offers a unique combat feel that rewards skill, positioning, and commitment. By making every attack's damage dependent on *how* you deliver it, not just *what* you're swinging, combat becomes a constant optimization puzzle wrapped in visceral action.

The prototype is technically simple but requires excellent game feel to validate. If the pressure difference doesn't *feel* meaningful, the concept fails. Investment in visual/audio feedback is not optional—it's the core of the pitch.

**Verdict**: High skill ceiling, unique hook, feasible scope. Worth prototyping.
