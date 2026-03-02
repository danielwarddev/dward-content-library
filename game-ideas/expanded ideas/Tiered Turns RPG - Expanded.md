# Tiered Turns RPG System - Expanded Design Document

> **Genre:** Turn-Based RPG (Roguelike Variant Recommended)  
> **Engine:** Godot  
> **Scope:** Small-Medium (Solo Dev Feasible)  
> **Prototype Timeline:** 2-3 weeks  
> **Last Updated:** January 2026

---

## Table of Contents

1. [Executive Summary](#executive-summary)
2. [Market Analysis](#market-analysis)
3. [Core System Design](#core-system-design)
4. [The Tier Mechanic Deep Dive](#the-tier-mechanic-deep-dive)
5. [Skill Design Framework](#skill-design-framework)
6. [Class/Character Archetypes](#classcharacter-archetypes)
7. [Setting Exploration](#setting-exploration)
8. [Roguelike Integration](#roguelike-integration)
9. [Prototype MVP](#prototype-mvp)
10. [Full Game Vision](#full-game-vision)
11. [Risks & Mitigations](#risks--mitigations)
12. [Solo Dev Feasibility](#solo-dev-feasibility)
13. [Open Questions](#open-questions)

---

## Executive Summary

A turn-based RPG battle system where **the turn number determines skill power**. Each skill has multiple tiers—casting on Turn 1 gives a weaker version, while waiting until Turn 3+ unlocks powerful effects. This creates strategic tension: **act early and weak, or wait and risk taking damage for a devastating payoff**.

**The Hook:** What if turn order wasn't just about speed stats—but about building up to your ultimate moves?

**Why Roguelike?** The tier system naturally fits roguelike design:

-   Each run, you draft skills into slots
-   Relics modify tier behavior
-   Short battles with full HP resets keep pacing tight
-   Meta-progression unlocks new skills for the pool

**Target Audience:** Players who enjoy _Slay the Spire_, _Darkest Dungeon_, _Octopath Traveler_, and _Into the Breach_—people who love meaningful turn-by-turn decisions.

---

## Market Analysis

### What's Succeeding (2024-2025)

| Game                  | Why It Works                                  | Lesson for Us                          |
| --------------------- | --------------------------------------------- | -------------------------------------- |
| **Slay the Spire**    | Perfect roguelike loop, endless build variety | Draft-based progression is addictive   |
| **Balatro**           | Simple core, deep emergent combos             | One mechanic with massive depth        |
| **Octopath Traveler** | Break system adds tactical layer              | Status-based "buildup" mechanics work  |
| **Sea of Stars**      | Timing-based combat, gorgeous presentation    | Active engagement in turn-based fights |
| **Darkest Dungeon 2** | Relationship system, shorter runs             | Roguelike structure for RPG combat     |
| **Monster Train**     | Multi-floor defense, clan synergies           | Layered complexity over simple base    |
| **Into the Breach**   | Perfect information, puzzle-like combat       | Every turn is a meaningful choice      |

### Turn-Based Innovations Worth Noting

| Mechanic              | Game                        | What It Does                                         |
| --------------------- | --------------------------- | ---------------------------------------------------- |
| **Break System**      | Octopath                    | Hit weakness to "break" enemies, delaying their turn |
| **Brave/Default**     | Bravely Default             | Bank turns or spend multiple at once                 |
| **Boost Points**      | Octopath                    | Spend accumulated points to power up attacks         |
| **Overdrive Gauge**   | Chained Echoes              | Team-wide meter affects damage dealt/received        |
| **Position Matters**  | Darkest Dungeon             | Front/back row changes available skills              |
| **Time Manipulation** | I Was a Teenage Exocolonist | Play cards, outcome affected by "time" spent         |

### The Market Gap

Many turn-based RPGs treat turns as just "speed determines order." Few make **the turn number itself** a strategic resource. Our tier system creates:

-   Anticipation (building toward powerful skills)
-   Risk/reward (waiting is dangerous but rewarding)
-   Readability (turn 1 = weak, turn 5 = strong is intuitive)
-   Comeback potential (survive long enough to unleash devastation)

---

## Core System Design

### The Fundamental Loop

```
Turn 1 → Limited options, defensive play
Turn 2 → More options open up
Turn 3 → Strong skills available
Turn 4+ → Ultimate abilities, tide-turning power
```

### How Tiers Work

Each character has **skill slots** (typically 3-4). Each slot has a **tier assignment**:

```
Character: Fire Mage
├── Slot 1: Tier 1 (available Turn 1+)
├── Slot 2: Tier 2 (available Turn 2+)
├── Slot 3: Tier 3 (available Turn 3+)
└── Slot 4: Tier 1 (available Turn 1+)
```

Any skill can be placed in any slot. The **slot's tier** determines the skill's power level when cast.

### Example: Fireball

| Cast on Turn | Tier Used | Effect                                      |
| ------------ | --------- | ------------------------------------------- |
| Turn 1       | T1        | Single target, 50 damage                    |
| Turn 2       | T2        | Single target, 100 damage, burn             |
| Turn 3       | T3        | AoE (small), 150 damage, burn               |
| Turn 4       | T4        | AoE (large), 200 damage, explosion chain    |
| Turn 5       | T5        | Massive AoE, 300 damage, ignores resistance |

**Key insight:** You CAN cast T1 Fireball on Turn 5—you just choose to use a lower tier for strategic reasons (maybe you need the MP savings, or you want to save your T5 for healing).

### The Turn Counter

-   Shared across all party members (Team Turn, not individual)
-   Resets to 0 at the start of each battle
-   Advances by 1 after all party members have acted
-   Some abilities might manipulate the counter (advance, reset, freeze)

---

## The Tier Mechanic Deep Dive

### Why Tiers Create Interesting Decisions

| Situation                            | Decision                                                                |
| ------------------------------------ | ----------------------------------------------------------------------- |
| Boss telegraphs big attack on Turn 3 | Do I save my T3 heal, or use T2 heal + T3 shield?                       |
| Weak enemies in early turns          | Do I overkill with T1 skills, or let them hit me to reach T3?           |
| Low HP on Turn 2                     | Heal now (T2 = moderate heal) or gamble on surviving to T3 (full heal)? |
| One enemy left                       | End fight fast with T1, or farm turns for a harder fight ahead?         |

### Tier Availability Rules

**Option A: Unlock-Based (Simpler)**

-   T1 skills available from Turn 1 onward
-   T2 skills available from Turn 2 onward
-   Etc.
-   Once unlocked, you can use any tier up to the current turn

**Option B: Tier = Turn (Stricter)**

-   On Turn 1, you can ONLY use T1 skills
-   On Turn 2, you can use T1 or T2
-   Creates more restrictive early game

**Recommendation:** Option A for more player agency, but test both.

### Skill Slot Configurations

Different characters can have different slot layouts:

| Archetype        | Slot Layout    | Playstyle                     |
| ---------------- | -------------- | ----------------------------- |
| **Early Aggro**  | T1, T1, T2, T3 | Strong early, weaker late     |
| **Late Bloomer** | T2, T3, T4, T5 | Weak early, devastating late  |
| **Balanced**     | T1, T2, T3, T4 | Consistent power curve        |
| **Specialist**   | T1, T1, T1, T5 | Many small actions + one nuke |
| **Support**      | T1, T2, T2, T3 | Early utility, mid-tier buffs |

### Turn Manipulation Skills

These skills mess with the tier system itself:

| Skill           | Effect                                  | Strategic Use             |
| --------------- | --------------------------------------- | ------------------------- |
| **Hasten**      | Advance turn counter by 1               | Rush to high tiers        |
| **Delay**       | Reduce turn counter by 1                | Stay in comfort zone      |
| **Freeze Time** | Turn counter doesn't advance this round | Use T3 skills twice       |
| **Reset**       | Set turn counter to 0                   | Re-use powerful T1 skills |
| **Overclock**   | Next skill is cast at +1 tier           | Emergency power boost     |

---

## Skill Design Framework

### Skill Anatomy

Every skill should be designed with 3-5 tiers:

```
Skill: [Name]
├── T1: [Basic effect - always useful, never amazing]
├── T2: [Improved effect OR added utility]
├── T3: [Strong effect - most fights end here]
├── T4: [Powerful effect - boss-fight relevant]
└── T5: [Ultimate effect - rare, fight-ending]
```

### Skill Scaling Patterns

| Pattern              | T1 → T5 Progression               | Good For                     |
| -------------------- | --------------------------------- | ---------------------------- |
| **Linear Damage**    | 50 → 100 → 150 → 200 → 250        | Basic attacks                |
| **Exponential**      | 30 → 60 → 120 → 240 → 480         | Nukes                        |
| **Target Expansion** | 1 enemy → 2 → 3 → All → All x2    | AoE spells                   |
| **Effect Addition**  | Damage → +Burn → +Stun → +Execute | Debuff skills                |
| **Utility First**    | Scan → Weaken → Damage → Nuke     | Setup skills                 |
| **Inversion**        | Heal 100% → 75% → 50% → 25% → 10% | Emergency heals (use early!) |

### Sample Skill Suite: Healer

| Skill       | T1                 | T2                          | T3                       | T4                 | T5                         |
| ----------- | ------------------ | --------------------------- | ------------------------ | ------------------ | -------------------------- |
| **Heal**    | Heal 1 ally 25%    | Heal 1 ally 50%             | Heal all 25%             | Heal all 50%       | Full heal all              |
| **Cleanse** | Remove 1 debuff    | Remove all debuffs (1 ally) | Remove all debuffs (all) | Cleanse + Heal 25% | Cleanse + Immunity 2 turns |
| **Barrier** | 50 shield (1 ally) | 100 shield (1 ally)         | 50 shield (all)          | 100 shield (all)   | 200 shield + reflect       |
| **Revive**  | —                  | —                           | Revive at 25% HP         | Revive at 50% HP   | Revive at 100% HP + turn   |

### Sample Skill Suite: Damage Dealer

| Skill         | T1                | T2          | T3                 | T4                  | T5                             |
| ------------- | ----------------- | ----------- | ------------------ | ------------------- | ------------------------------ |
| **Strike**    | 80 dmg            | 160 dmg     | 240 dmg + bleed    | 320 dmg + crit      | 500 dmg + execute (<20%)       |
| **Whirlwind** | 40 dmg all        | 80 dmg all  | 120 dmg all        | 160 dmg all + stun  | 200 dmg all + knockback        |
| **Focus**     | +10% crit         | +20% crit   | +30% crit + 1 turn | +50% crit + 2 turns | Guaranteed crit next 3 attacks |
| **Execute**   | 100 dmg if HP<50% | 150 if <50% | 200 if <50%        | 300 if <30%         | Instant kill if <20%           |

### Sample Skill Suite: Support

| Skill      | T1                | T2                 | T3                         | T4                 | T5                   |
| ---------- | ----------------- | ------------------ | -------------------------- | ------------------ | -------------------- |
| **Haste**  | +1 speed (1 ally) | +2 speed           | +1 speed (all)             | +2 speed (all)     | Extra turn (1 ally)  |
| **Weaken** | -10% enemy atk    | -20%               | -10% all enemies           | -20% all           | -50% all + skip turn |
| **Scan**   | Reveal HP         | Reveal HP + skills | Reveal + 10% vuln          | Reveal + 20% vuln  | Reveal + 50% vuln    |
| **Taunt**  | Draw 1 attack     | Draw 2 attacks     | Draw all attacks + 25% def | Draw all + 50% def | Draw all + counter   |

---

## Class/Character Archetypes

### Archetype Design Philosophy

Each character should:

1. Have a clear **tier preference** (early, mid, or late)
2. Synergize with specific **skill types**
3. Offer a unique **playstyle fantasy**

### Core Archetypes

| Archetype        | Tier Preference | Slot Layout    | Fantasy                               |
| ---------------- | --------------- | -------------- | ------------------------------------- |
| **Berserker**    | Early (T1-T2)   | T1, T1, T2, T2 | Hit fast, hit hard, don't wait        |
| **Mage**         | Late (T3-T5)    | T2, T3, T4, T5 | Weak early, nukes late                |
| **Cleric**       | Mid (T2-T3)     | T1, T2, T2, T3 | Keep team alive until payoff          |
| **Rogue**        | Flexible        | T1, T2, T3, T1 | Adapt to the situation                |
| **Paladin**      | Steady          | T1, T2, T3, T4 | Balanced, reliable                    |
| **Chronomancer** | Manipulator     | T1, T3, T5, —  | Skips tiers, messes with turn counter |

### Archetype Synergies

| Combo                  | Strategy                                                        |
| ---------------------- | --------------------------------------------------------------- |
| Berserker + Cleric     | Berserker deals damage early; Cleric heals while waiting for T3 |
| Mage + Rogue           | Rogue keeps enemies busy T1-T2; Mage nukes T3+                  |
| Paladin + Chronomancer | Paladin provides steady damage; Chronomancer accelerates to T5  |

### Character Progression (Non-Roguelike)

If this isn't a roguelike:

-   Characters level up, unlocking new skills
-   Skill slots unlock over time (start with 2, end with 4-5)
-   Tier layouts can be customized via equipment or class change

---

## Setting Exploration

### Fantasy (Default)

**Flavor:** Tiers = spell incantation buildup. Longer you chant, stronger the spell.

| Element          | Fantasy Version                                                                       |
| ---------------- | ------------------------------------------------------------------------------------- |
| Classes          | Warrior, Mage, Cleric, Rogue, Paladin                                                 |
| Skills           | Spells, sword techniques, prayers                                                     |
| Tier explanation | "The ancient arts require focus. Rush, and your magic sputters. Wait, and it blazes." |
| Aesthetic        | Medieval castles, dragons, forests                                                    |

**Pros:** Instantly understandable, huge asset availability  
**Cons:** Oversaturated market, less distinctive

---

### Sci-Fi (Mech Pilots)

**Flavor:** Tiers = weapon charge / heat management. Systems need time to power up.

| Element          | Sci-Fi Version                                                                                    |
| ---------------- | ------------------------------------------------------------------------------------------------- |
| Classes          | Assault Frame, Support Unit, Sniper, Demolitions, Commander                                       |
| Skills           | Weapon systems, drone deployment, overcharge                                                      |
| Tier explanation | "All systems require charge time. Fire early for suppression. Wait for full charge to devastate." |
| Aesthetic        | Mechs, space stations, neon interfaces                                                            |

**Unique Mechanics:**

-   **Heat gauge:** Using high-tier skills builds heat; overheat = skip turn
-   **Modular loadouts:** Swap weapon systems between missions
-   **Ammunition:** Some skills have limited uses per battle

**Pros:** Distinctive, natural fit for "charging" mechanics  
**Cons:** Harder to prototype (more complex art), niche audience

---

### Modern Occult (Urban Fantasy)

**Flavor:** Tiers = ritual preparation. Quick cantrips vs. elaborate ceremonies.

| Element          | Modern Occult Version                                                                        |
| ---------------- | -------------------------------------------------------------------------------------------- |
| Classes          | Witch, Exorcist, Medium, Alchemist, Hunter                                                   |
| Skills           | Hexes, bindings, summons, potions                                                            |
| Tier explanation | "A curse whispered takes seconds. A curse properly performed takes minutes—but ruins lives." |
| Aesthetic        | City streets, occult symbols, neon + gothic                                                  |

**Unique Mechanics:**

-   **Ritual components:** Collect ingredients to unlock higher tiers
-   **Collateral damage:** High-tier spells might harm allies or environment
-   **Witness gauge:** Use too much magic publicly, attract attention

**Pros:** Trendy, visually distinctive, good for horror/comedy tones  
**Cons:** Niche, may require more narrative investment

---

### Abstract/Minimalist (Pure Roguelike)

**Flavor:** Tiers = combo multipliers. No fiction, just mechanics.

| Element          | Abstract Version                        |
| ---------------- | --------------------------------------- |
| Classes          | Shapes, colors, or pure stat archetypes |
| Skills           | "Strike Alpha," "Shield 2," "Boost X"   |
| Tier explanation | N/A—it's just the rule                  |
| Aesthetic        | Geometric shapes, clean UI, minimal     |

**Unique Mechanics:**

-   **Combo system:** Tier bonuses for chaining skills properly
-   **Pure balance:** No flavor means pure mechanical tuning
-   **Accessibility:** Easier to understand without worldbuilding

**Pros:** Fast to prototype, focuses on mechanics  
**Cons:** Less marketable, hard to differentiate

---

### Recommendation

**For prototype:** Abstract or Fantasy (fastest to mock up)  
**For full game:** Sci-Fi (Mech Pilots) offers the most natural fit for the tier/charge mechanic and stands out in the market.

---

## Roguelike Integration

### Why Roguelike Works

The tier system is **perfect** for roguelike design:

| Roguelike Element  | Tier System Synergy                            |
| ------------------ | ---------------------------------------------- |
| Draft-based builds | Choose which skills go in which tier slots     |
| Relic modifiers    | "T1 skills cost no MP," "T4+ skills hit twice" |
| Short battles      | Full HP reset means tier progression per fight |
| Risk/reward        | Push for high tiers = risk death for power     |
| Emergent combos    | Skill + relic + tier = unexpected interactions |

### Run Structure

```
Run Start
├── Choose starting character (1 of 3)
├── Draft 4 skills into tier slots
└── Enter first zone

Zone (repeat 3-4 times)
├── 3-4 combat encounters
├── 1 elite encounter
├── Skill/relic rewards between fights
├── Shop
└── Boss

Final Boss
└── Win = meta-progression unlock

Meta-Progression
├── Unlock new skills for draft pool
├── Unlock new characters
├── Unlock new relics
└── Unlock new modifiers/challenges
```

### Draft Phase

At run start (and sometimes mid-run):

1. See 3-5 skill options
2. Choose one skill
3. Assign it to a tier slot
4. Repeat until all slots filled

**Strategic depth:** A skill in T1 slot vs T5 slot plays completely differently.

### Relic Design

Relics should interact with the tier system:

| Relic            | Effect                                                      |
| ---------------- | ----------------------------------------------------------- |
| **Quick Draw**   | T1 skills deal +50% damage                                  |
| **Slow Burn**    | T4+ skills cost 50% less MP                                 |
| **Overclocker**  | Once per battle, cast a skill at +2 tiers                   |
| **Efficiency**   | If you end battle on T2 or lower, gain +1 reward            |
| **Momentum**     | Each turn, gain +5% damage (stacks)                         |
| **Glass Cannon** | All skills deal 2x damage, you take 2x damage               |
| **Tier Lock**    | Enemies can't act on turns matching your highest tier skill |

### Battle Pacing

Battles should end in **3-5 turns** typically:

-   T1-T2: Setup, chip damage, buffs
-   T3: Major damage/healing, tide turns
-   T4-T5: Fight-ending if you get there; reserved for bosses

**Boss fights:** 6-10 turns, with phases that reset or manipulate tiers.

---

## Prototype MVP

### Goal

Prove the tier mechanic creates **interesting decisions**. Does it feel different from normal turn-based combat?

### Scope

| Feature                         | Included | Excluded |
| ------------------------------- | -------- | -------- |
| 3 characters with 3 skills each | ✅       |          |
| 2 tiers per skill (T1, T2)      | ✅       |          |
| 3 enemy types                   | ✅       |          |
| 5 battles (linear)              | ✅       |          |
| Basic turn UI (text is fine)    | ✅       |          |
| Turn counter display            | ✅       |          |
| Full HP reset between battles   | ✅       |          |
| Roguelike structure             |          | ❌       |
| Relics                          |          | ❌       |
| Skill drafting                  |          | ❌       |
| Meta-progression                |          | ❌       |
| Art/animation                   |          | ❌       |
| Audio                           |          | ❌       |

### Prototype Characters

**Warrior**

-   Slots: T1, T1, T2
-   Skills: Slash (damage), Guard (defense), Power Strike (damage+)

**Mage**

-   Slots: T1, T2, T2
-   Skills: Spark (low damage), Fireball (high damage), Barrier (shield)

**Healer**

-   Slots: T1, T1, T2
-   Skills: Heal (restore HP), Cleanse (remove debuff), Revive (T2 only)

### Prototype Enemies

| Enemy      | Behavior                                   |
| ---------- | ------------------------------------------ |
| **Goblin** | Attacks every turn for low damage          |
| **Orc**    | Charges Turn 1, big attack Turn 2          |
| **Shaman** | Buffs allies on odd turns, attacks on even |

### Success Criteria

The prototype succeeds if:

1. **Tier choice matters:** Players feel the difference between T1 and T2 casts
2. **Turn counting is intuitive:** Players track turns without confusion
3. **Decisions feel meaningful:** "Should I wait?" is a real question
4. **Battles have arc:** Early turns feel different from late turns
5. **No dominant strategy:** "Always wait for T2" or "Always use T1" shouldn't be optimal

### Godot Implementation Notes

-   Turn-based combat: State machine (`PLAYER_TURN`, `ENEMY_TURN`, `ANIMATING`)
-   Skill execution: Dictionary with tier → effect mappings
-   UI: Simple `Label` nodes for HP, turn counter, skill buttons
-   Battle flow: `Array` of combatants, iterate through for turn order

---

## Full Game Vision

_If the prototype succeeds, here's the roguelike version:_

### Content Scope

| Content Type        | Amount                          |
| ------------------- | ------------------------------- |
| Playable characters | 6-8                             |
| Skills (total pool) | 50-80                           |
| Skill tiers         | 5 per skill                     |
| Relics              | 40-60                           |
| Enemies             | 30-40                           |
| Bosses              | 6-10                            |
| Zones               | 4-5                             |
| Run length          | 30-45 minutes                   |
| Unlock progression  | 20-30 hours to see most content |

### Optional Features

| Feature                   | Value Add               | Effort |
| ------------------------- | ----------------------- | ------ |
| Daily run (seeded)        | High (competition)      | Low    |
| Endless mode              | Medium (replayability)  | Low    |
| Custom run modifiers      | Medium (challenge)      | Medium |
| Character-specific quests | Medium (goal structure) | Medium |
| Multiplayer co-op runs    | Low (niche)             | High   |

---

## Risks & Mitigations

| Risk                       | Likelihood | Impact   | Mitigation                                                         |
| -------------------------- | ---------- | -------- | ------------------------------------------------------------------ |
| "Waiting is boring"        | High       | Critical | Enemies punish passivity; T1 skills must be useful                 |
| Too complex to grok        | Medium     | High     | Clear UI; turn counter is prominent; tier preview on hover         |
| Optimal play = always wait | Medium     | High     | Battles end/punish before T5; diminishing returns on high tiers    |
| Slay the Spire comparison  | High       | Medium   | Focus on tier mechanic as differentiator; own the niche            |
| Balance nightmare          | High       | Medium   | Start with 2 tiers, expand slowly; data-driven tuning              |
| Roguelike fatigue          | Medium     | Medium   | Strong core mechanic can stand out; consider non-roguelike variant |

---

## Solo Dev Feasibility

### Why This Is Achievable

| Factor                | Assessment                                          |
| --------------------- | --------------------------------------------------- |
| **Core mechanic**     | Simple to implement (turn counter + skill tiers)    |
| **Art requirements**  | Minimal—can be abstract shapes or portraits only    |
| **Content**           | Skills are data, not assets; easy to expand         |
| **Godot suitability** | Turn-based is easy in any engine                    |
| **Scope control**     | Start with 2 tiers, 3 characters; expand from there |

### Recommended Timeline

| Phase               | Duration       | Focus                              |
| ------------------- | -------------- | ---------------------------------- |
| Prototype           | 2-3 weeks      | Core mechanic feel                 |
| Roguelike structure | 2-4 weeks      | Draft, runs, basic meta            |
| Content pass 1      | 1-2 months     | 4 characters, 30 skills, 20 relics |
| Polish & balance    | 1-2 months     | Tuning, UI, feedback               |
| **Total**           | **4-8 months** |                                    |

---

## Open Questions

### Core Mechanic

-   Should tiers go up to T5, or is T3 enough for simpler design?
-   Is the turn counter per-character or per-team?
-   Can enemies have tiers too, or is it player-only?

### Roguelike

-   How many skills can you hold? Fixed slots, or expandable?
-   Should relics be equipable/swappable, or permanent once acquired?
-   What's the death penalty? Full reset, or some persistence?

### Presentation

-   How do we visualize tiers? Color coding? Numbers? Icons?
-   Should there be a "charge up" animation as turns progress?
-   How do we show skill previews at different tiers?

### Scope

-   Is 5 zones too many for a solo dev? Could 3 be enough?
-   Should there be a "story mode" in addition to roguelike?
-   How much meta-progression is too much?

---

## References & Inspiration

### Games to Play

-   _Slay the Spire_ (roguelike deckbuilder flow)
-   _Octopath Traveler_ (break/boost systems)
-   _Into the Breach_ (perfect information turn-based)
-   _Darkest Dungeon_ (stress, positioning, atmosphere)
-   _Monster Train_ (multi-layer strategy)
-   _Bravely Default_ (Brave/Default turn banking)

### GDC Talks

-   "Slay the Spire: Metrics Driven Design" (MegaCrit)
-   "Into the Breach Design Postmortem" (Subset Games)
-   "Darkest Dungeon: A Design Postmortem" (Red Hook)

---

_End of Document_
