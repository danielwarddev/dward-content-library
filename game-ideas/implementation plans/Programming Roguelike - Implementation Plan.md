# Programming Roguelike - Implementation Plan

> **Target:** MVP Prototype (3 waves, node editor, basic combat)  
> **Time Budget:** 2-5 hours/week  
> **Engine:** Godot 4.x with C#  
> **Estimated Duration:** 10-14 weeks

---

## Phase 0: Godot Foundations (Week 1-2)

These steps teach you Godot basics before diving into the game. Skip any you're already comfortable with.

### 0.1 - Project Setup

-   [ ] Create new Godot 4 project with C# support
-   [ ] Verify C# builds work (create a Node with a simple script, print to console)
-   [ ] Set up your preferred IDE (VS Code or Rider) with Godot C# extensions
-   **Time:** ~1 hour

### 0.2 - Input & Movement

-   [ ] Set up input actions in Project Settings (WASD + arrow keys)
-   [ ] Create a CharacterBody2D that moves with input
-   [ ] Add a Camera2D that follows the player
-   **Time:** ~1-2 hours

### 0.3 - Signals & Scenes

-   [ ] Learn Godot's signal system (C# events equivalent)
-   [ ] Create an enemy scene, instantiate it from code
-   [ ] Connect a signal between two nodes
-   **Time:** ~1-2 hours

---

## Phase 1: Core Player & Arena (Week 3-4)

### 1.1 - Arena Setup

-   [ ] Create main game scene with a bounded play area
-   [ ] Add simple ColorRect or placeholder sprites for boundaries
-   [ ] Prevent player from leaving the arena
-   **Time:** ~1 hour

### 1.2 - Player Character

-   [ ] Create Player scene (CharacterBody2D + CollisionShape2D + Sprite2D)
-   [ ] Implement 8-directional movement
-   [ ] Add player stats: HP, speed (as exported variables)
-   [ ] Create simple placeholder art (colored circle/square)
-   **Time:** ~2 hours

### 1.3 - Basic HUD

-   [ ] Create a CanvasLayer for UI
-   [ ] Add HP bar (ProgressBar or TextureProgressBar)
-   [ ] Display current wave number
-   **Time:** ~1-2 hours

---

## Phase 2: Enemies & Damage (Week 4-5)

### 2.1 - Basic Enemy

-   [ ] Create Enemy scene (CharacterBody2D that follows player)
-   [ ] Add HP and damage stats
-   [ ] Simple placeholder art (different colored shape)
-   **Time:** ~1 hour

### 2.2 - Collision & Damage

-   [ ] Set up collision layers (Player, Enemy, Projectile)
-   [ ] Implement player taking damage from enemy contact
-   [ ] Add brief invincibility frames after taking damage
-   [ ] Visual feedback (flash red, knockback)
-   **Time:** ~2 hours

### 2.3 - Enemy Death

-   [ ] Enemies can be killed (placeholder: click to damage for now)
-   [ ] Death signal/event emitted
-   [ ] Simple death effect (scale down + fade, or particles)
-   [ ] Enemy drops XP pickup
-   **Time:** ~1-2 hours

### 2.4 - XP & Pickups

-   [ ] Create XP orb scene (Area2D)
-   [ ] XP orbs drift toward player when close
-   [ ] Track player XP, level up at thresholds
-   [ ] Level up triggers event (will open editor later)
-   **Time:** ~1-2 hours

---

## Phase 3: Basic Projectiles (Week 5-6)

### 3.1 - Projectile System

-   [ ] Create Projectile scene (Area2D + Sprite2D + CollisionShape2D)
-   [ ] Projectile moves in a direction, damages enemies on contact
-   [ ] Projectile despawns after distance/time or hitting enemy
-   **Time:** ~1-2 hours

### 3.2 - Default Auto-Attack

-   [ ] Player auto-fires a projectile every X seconds (timer)
-   [ ] Projectile targets nearest enemy
-   [ ] This is your baseline attack (before logic system)
-   **Time:** ~1 hour

### 3.3 - Object Pooling (Optional but Recommended)

-   [ ] Create a simple object pool for projectiles
-   [ ] Reuse projectiles instead of instantiating/freeing constantly
-   [ ] Helps performance for bullet-heavy gameplay
-   **Time:** ~1-2 hours

---

## Phase 4: Wave System (Week 6-7)

### 4.1 - Wave Manager

-   [ ] Create WaveManager autoload/singleton
-   [ ] Define wave data structure (enemy count, spawn rate, duration)
-   [ ] Implement basic wave: spawn X enemies over Y seconds
-   **Time:** ~2 hours

### 4.2 - Wave Transitions

-   [ ] Detect when wave ends (timer or all enemies dead)
-   [ ] Emit signal for wave complete
-   [ ] Pause game/spawning between waves
-   **Time:** ~1 hour

### 4.3 - Three Test Waves

-   [ ] Wave 1: 10 slow chasers
-   [ ] Wave 2: 15 chasers, slightly faster
-   [ ] Wave 3: 20 chasers, mixed speeds
-   [ ] Test the full 3-wave loop
-   **Time:** ~1 hour

---

## Phase 5: Node Editor Foundation (Week 7-9)

This is the core unique feature. Take your time here.

### 5.1 - GraphEdit Basics

-   [ ] Create a new scene with GraphEdit node
-   [ ] Learn GraphEdit in C#: adding nodes, getting connections
-   [ ] Create a simple test: add 2 GraphNodes, connect them, print connection data
-   **Time:** ~2-3 hours

### 5.2 - Custom GraphNode Scenes

-   [ ] Create base LogicNode class extending GraphNode
-   [ ] Create TriggerNode, ConditionNode, ActionNode subclasses
-   [ ] Different colors/styles for each type
-   [ ] Each node has input/output slots configured correctly
-   **Time:** ~2-3 hours

### 5.3 - Node Palette

-   [ ] Create UI panel showing available nodes
-   [ ] Click/drag to add node to graph
-   [ ] Start with just 3 nodes: "On Kill" (trigger), "Fire Projectile" (action), "Enemy Count > X" (condition)
-   **Time:** ~2 hours

### 5.4 - Connection Validation

-   [ ] Only allow valid connections (Trigger → Condition or Action, Condition → Action)
-   [ ] Reject invalid connections with visual feedback
-   [ ] Store connections in a data structure
-   **Time:** ~2 hours

### 5.5 - Editor UI Integration

-   [ ] Show node editor when wave ends
-   [ ] "Confirm" button to close editor and resume game
-   [ ] Editor pauses game while open
-   **Time:** ~1-2 hours

---

## Phase 6: Logic Execution (Week 9-11)

### 6.1 - Chain Data Structure

-   [ ] Define LogicChain class: Trigger + optional Condition + Action
-   [ ] Parse GraphEdit connections into LogicChain objects
-   [ ] Store active chains in a list
-   **Time:** ~2 hours

### 6.2 - Trigger System

-   [ ] Create TriggerManager that listens for game events
-   [ ] Implement "On Kill" trigger (fires when enemy dies)
-   [ ] Implement "Every X Seconds" trigger (timer-based)
-   [ ] When trigger fires, evaluate its chain
-   **Time:** ~2-3 hours

### 6.3 - Condition Evaluation

-   [ ] Implement condition checking (returns true/false)
-   [ ] "Enemy Count > X": count enemies in scene
-   [ ] "HP Above X%": check player HP
-   [ ] Chain only executes action if condition passes (or no condition)
-   **Time:** ~1-2 hours

### 6.4 - Action Execution

-   [ ] Implement "Fire Projectile" action (spawn projectile toward nearest enemy)
-   [ ] Implement "AoE Burst" action (damage all enemies in radius)
-   [ ] Implement "Spawn Shield" action (brief invincibility)
-   [ ] Actions have cooldowns to prevent spam
-   **Time:** ~2-3 hours

### 6.5 - First Playable Chain

-   [ ] Connect everything: build "On Kill → Fire Projectile" chain in editor
-   [ ] Verify it executes correctly during gameplay
-   [ ] Celebrate! 🎉
-   **Time:** ~1-2 hours

---

## Phase 7: MVP Polish (Week 11-14)

### 7.1 - Remaining Prototype Nodes

Add remaining nodes from the MVP spec:

**Triggers:**

-   [ ] On Hit (player takes damage)
-   [ ] HP Below 50%
-   [ ] On Wave Start

**Conditions:**

-   [ ] Random 50% (coin flip)

**Actions:**

-   [ ] Speed Boost (temporary)
-   [ ] Spawn Drone (orbiting attacker)
-   **Time:** ~3-4 hours total

### 7.2 - Node Upgrade Offerings

-   [ ] After each wave, offer 1-2 new nodes to add
-   [ ] Randomize from available pool
-   [ ] Player picks one (or skips)
-   **Time:** ~2 hours

### 7.3 - Visual Feedback

-   [ ] Show active chains during combat (small icons or log)
-   [ ] Flash/highlight when a chain triggers
-   [ ] Damage numbers on enemies
-   **Time:** ~2 hours

### 7.4 - Game Over & Restart

-   [ ] Detect player death
-   [ ] Show simple game over screen
-   [ ] Restart button
-   [ ] Detect victory (wave 3 complete)
-   **Time:** ~1-2 hours

### 7.5 - Placeholder Art Pass

-   [ ] Consistent color scheme (neon/cyberpunk)
-   [ ] Glow effects on projectiles (Godot's CanvasItem materials)
-   [ ] Simple particle effects (death, damage, pickup)
-   **Time:** ~2-3 hours

### 7.6 - Basic Audio

-   [ ] Find free SFX (Freesound, OpenGameArt)
-   [ ] Add sounds: shoot, enemy death, player hit, level up, UI click
-   [ ] Optional: simple background music loop
-   **Time:** ~1-2 hours

---

## Milestone Checklist

### End of Phase 4 - "Playable Loop"

-   [ ] Player moves and survives 3 waves
-   [ ] Enemies spawn and chase
-   [ ] Basic auto-attack kills enemies
-   [ ] XP collection works

### End of Phase 6 - "Core Feature Complete"

-   [ ] Node editor opens between waves
-   [ ] Can create at least one logic chain
-   [ ] Chain executes correctly during gameplay
-   [ ] The game's unique hook is functional

### End of Phase 7 - "MVP Prototype"

-   [ ] All 13 prototype nodes implemented
-   [ ] Full 3-wave playable experience
-   [ ] Win/lose conditions
-   [ ] Ready for playtesting

---

## Tips for Success

1. **One task per session**: With 2-5 hours/week, focus on completing ONE checkbox per session.

2. **Test constantly**: Run the game after every small change. Godot's hot reload helps.

3. **Commit often**: Use git. Commit after each checkbox.

4. **Placeholder first**: Don't get distracted by art. Colored shapes are fine until Phase 7.

5. **Reference projects**: Search GitHub for "Godot bullet heaven" or "Godot survivors clone" for patterns.

6. **Ask for help**: The Godot Discord C# channel is active and helpful.

---

## Resources

-   [Godot C# Documentation](https://docs.godotengine.org/en/stable/tutorials/scripting/c_sharp/index.html)
-   [GraphEdit Class Reference](https://docs.godotengine.org/en/stable/classes/class_graphedit.html)
-   [GraphNode Class Reference](https://docs.godotengine.org/en/stable/classes/class_graphnode.html)
-   [Godot C# Signals](https://docs.godotengine.org/en/stable/tutorials/scripting/c_sharp/c_sharp_signals.html)

---

_Good luck! Check off tasks as you complete them._
