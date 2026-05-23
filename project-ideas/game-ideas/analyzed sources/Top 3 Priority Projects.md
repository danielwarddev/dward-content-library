# Top 3 Priority Projects for Solo Development

> **Created:** January 2026  
> **Purpose:** Focused breakdown of the three most viable projects based on market trends, solo dev feasibility, and core concept strength.

---

## Selection Criteria

These three projects were selected based on:

-   **Market Fit:** Aligns with genres currently succeeding in indie space
-   **Scope Control:** Can realistically be completed by a solo dev in 1-2 years
-   **Clear Hook:** Pitchable in one sentence, immediately understandable
-   **Unique Angle:** Not just "X but again" — has a fresh twist

---

## 1. Creature Collector Deck Builder with Sleeves

### The Pitch

_"Catch creatures as cards. Sleeve them to transform how they play."_

### Why This Works

-   **Deckbuilders are proven** (Slay the Spire, Balatro, Inscryption)
-   **Creature collectors are having a renaissance** (Cassette Beasts, Coromon showed the market exists)
-   **The combination is underexplored** — most creature games use traditional battle systems
-   **The sleeve mechanic is genuinely novel** — it's not just cosmetic shinies, it's meaningful gameplay variation

### Core Concept

Creatures are captured into cards (think Lost Kingdoms). Your deck IS your monster collection. But the twist: **sleeves** modify how creatures behave.

A Fire Wolf in a standard sleeve plays as designed. Put it in a **Vampiric Sleeve** and it heals you when it deals damage. Put it in an **Echo Sleeve** and it attacks twice but deals half damage. Put it in a **Guardian Sleeve** and it prioritizes protecting your other creatures.

The same 50-creature roster becomes 200+ variations based on sleeves.

### Structure Options

**Option A: Roguelike Runs (Recommended for solo dev)**

-   Each run, start with a basic creature and sleeve
-   Defeat enemies to capture creatures or earn sleeves
-   Build your deck over 30-60 minute runs
-   Unlock new starting options with meta-progression

**Option B: Linear Campaign**

-   Story-driven creature collection
-   Deckbuilding between stages
-   More content-heavy, longer dev time

### Sleeve Categories

| Sleeve Type   | Effect                                     |
| ------------- | ------------------------------------------ |
| **Vampiric**  | Creature heals you when dealing damage     |
| **Echo**      | Creature acts twice at half power          |
| **Guardian**  | Creature takes hits meant for others       |
| **Berserker** | +50% damage, takes damage each turn        |
| **Phantom**   | Can't be targeted but deals less damage    |
| **Toxic**     | Applies poison, takes poison damage itself |
| **Mirror**    | Copies the last enemy action               |
| **Timeworn**  | Stronger each turn it stays in play        |
| **Desperate** | Massive power boost when at low HP         |
| **Sleeper**   | Does nothing for 2 turns, then huge effect |

### Creature Design Approach

Keep creature count **manageable** (40-60 max). Each creature needs:

-   One card art (front only if card-based)
-   Stats (HP, Attack, Speed)
-   Base ability
-   Type/element
-   Maybe an evolution or two

**Art style recommendation:** Stylized, flat colors, or pixel art. Avoid detailed illustrations — you'll burn out.

### Rarity Layers

-   **Common creatures** — easy to find
-   **Rare creatures** — specific encounters or conditions
-   **Sleeves** have their own rarity — a rare sleeve on a common creature is still exciting
-   **Legendary sleeves** — fundamentally change the game (a creature in a Legendary Sleeve might have a completely new ability)

### Revenue Model

-   Premium ($10-15 on Steam)
-   Potential mobile port with cosmetic sleeve skins as IAP

### Risks & Mitigations

| Risk                                  | Mitigation                                                    |
| ------------------------------------- | ------------------------------------------------------------- |
| Art burden                            | Simple art style, limit creature count                        |
| Balance nightmare                     | Roguelike structure forgives imbalance better than campaigns  |
| "Just another deckbuilder" perception | Lead marketing with the sleeve mechanic, not the deckbuilding |

### Development Phases

1. **Prototype (2-3 months):** 10 creatures, 5 sleeves, one run structure. Is it fun?
2. **Vertical Slice (3-4 months):** 25 creatures, 15 sleeves, full run with boss. Playtest.
3. **Content Pass (4-6 months):** Full creature roster, all sleeves, meta-progression, polish.
4. **Launch Prep (1-2 months):** Steam page, trailer, marketing push.

**Estimated total: 12-18 months**

---

## 2. Farming + Roguelike Tower Defense Hybrid

### The Pitch

_"Plant crops by day. They defend you by night."_

### Why This Works

-   **Farming games have massive appeal** (Stardew, Harvest Moon legacy)
-   **Tower defense is proven and evergreen**
-   **Roguelike structure reduces content burden**
-   **The "crops as towers" angle is fresh** — Atomicrops was shooter-focused, not TD-focused
-   **Natural tension:** cozy planting vs. desperate defense

### Core Loop

```
┌─────────────────────────────────────────────────┐
│                    ONE RUN                       │
├─────────────────────────────────────────────────┤
│  DAY PHASE          │  NIGHT PHASE              │
│  - Plant seeds      │  - Waves of enemies       │
│  - Water/tend crops │  - Crops activate         │
│  - Visit shop       │  - Player can fight too   │
│  - Harvest ready    │  - Survive until dawn     │
│    crops            │                           │
├─────────────────────────────────────────────────┤
│  BETWEEN DAYS                                    │
│  - Upgrade crops or player                       │
│  - Choose new seeds                              │
│  - Expand farm plot                              │
├─────────────────────────────────────────────────┤
│  WIN: Survive X nights │  LOSE: Overrun          │
└─────────────────────────────────────────────────┘
```

### Crop Categories

**Attackers**
| Crop | Effect |
|------|--------|
| Corn | Shoots kernels at nearby enemies |
| Pepper | Explodes when enemies step on it |
| Sunflower | Laser beam in a line (PvZ callback) |
| Cactus | Damages enemies that touch it |
| Venus Flytrap | Grabs and holds small enemies |

**Supporters**
| Crop | Effect |
|------|--------|
| Wheat | Speed boost aura for player |
| Carrot | Reveals hidden/burrowing enemies |
| Pumpkin | Wall that blocks enemy paths |
| Potato | Absorbs damage for nearby crops |
| Coffee Bean | Reduces cooldowns in radius |

**Debuffers**
| Crop | Effect |
|------|--------|
| Stinkweed | Slows enemies in radius |
| Garlic | Enemies avoid the area |
| Onion | Makes enemies cry (accuracy debuff) |
| Poison Ivy | DoT to enemies passing through |
| Mushroom | Confuses enemies (random movement) |

**Economy**
| Crop | Effect |
|------|--------|
| Golden Apple | Bonus currency on harvest |
| Magic Bean | Random seed on harvest |
| Truffle | Rare drop chance increase |

### Upgrade Paths

**Crop Upgrades** (per run)

-   Corn → Popcorn Mortar (AoE)
-   Pepper → Ghost Pepper (bigger explosion, fire DoT)
-   Pumpkin → Giant Pumpkin (more HP, larger)

**Player Upgrades** (per run)

-   More inventory slots
-   Faster movement
-   Personal attack options
-   Watering can upgrades (water multiple tiles)

**Meta Progression** (between runs)

-   Unlock new seed types
-   Starting bonuses
-   Permanent stat boosts
-   New farm layouts

### Visual Style Recommendation

**Top-down pixel art.** Think Stardew Valley meets Kingdom: Two Crowns.

Enemies come from the edges. Your farm is the fortress. Simple silhouette enemies work fine (slimes, goblins, skeletons).

### Day/Night Pacing

-   **Day:** 60-90 seconds of planting, shopping, preparing
-   **Night:** 2-3 minutes of waves with escalating difficulty
-   **Later nights:** Longer, more waves, tougher enemies
-   **Boss nights:** Every 5th night, special enemy with patterns

### The Shop

Between nights, spend harvest currency on:

-   New seeds (random selection of 3-5)
-   Fertilizer (instant growth)
-   Scarecrow (decoy enemy target)
-   Fencing (redirect enemy paths)
-   One-time powerups (bomb, freeze, heal crops)

### Why Roguelike Structure

-   **Runs are 30-45 minutes** — respects player time
-   **Randomized seeds each run** — different strategies
-   **Death is progress** — unlock new content for future runs
-   **Replayability baked in** — don't need 100 hours of content

### Risks & Mitigations

| Risk                     | Mitigation                                                   |
| ------------------------ | ------------------------------------------------------------ |
| Balance between phases   | Playtest extensively — neither phase should feel like filler |
| "Just Plants vs Zombies" | Lean into farming sim elements — watering, growth, seasons   |
| Repetitive runs          | Variety in enemy types, crop unlocks, farm layouts           |

### Development Phases

1. **Prototype (2-3 months):** 5 crop types, basic enemies, one full day/night cycle. Is the loop fun?
2. **Systems (3-4 months):** Shop, upgrades, 3-night run with boss. Meta-progression.
3. **Content (4-6 months):** Full crop roster, enemy variety, multiple biomes/themes.
4. **Polish (2-3 months):** Juice, sound, UI, achievements.

**Estimated total: 12-18 months**

---

## 3. Clone Mechanic Platformer

### The Pitch

_"Create clones of yourself to platform, puzzle, and fight."_

### Why This Works

-   **Platformers are eternal** — the market is always there
-   **Single mechanic with massive design space**
-   **Tightest scope of the three** — no inventory systems, no card pools, no crops
-   **Viral clip potential** — the hand-throw is visually striking
-   **Clear influences:** Celeste (precision), Katana Zero (style), The Swapper (clones)

### Core Mechanic: The Clone

**Basic clone (start of game):**

-   Press button to create a clone where you stand
-   Clone is stationary
-   You can grab the clone's hand and it throws you (momentum-based platforming)
-   Clone disappears after 3 seconds or on next clone creation
-   Only one clone at a time

**This single mechanic enables:**

-   Long jumps (throw yourself across gaps)
-   High jumps (clone below, grab hand, throw up)
-   Dodging (create clone, dash away, enemies attack clone)
-   Weight puzzles (clone can stand on pressure plates)
-   Double-body requirements (two buttons at once)

### Ability Unlocks (Game Progression)

| Unlock               | Effect                                       |
| -------------------- | -------------------------------------------- |
| **Clone Swap**       | Teleport to your clone's position            |
| **Mirror Clone**     | Clone mirrors your movements                 |
| **Delayed Clone**    | Clone repeats your last 3 seconds of actions |
| **Combat Clone**     | Clone attacks once before disappearing       |
| **Chain Clone**      | Clone can create its own clone (2 total)     |
| **Persistent Clone** | Clone lasts until destroyed                  |

### Level Design Possibilities

**Pure Platforming**

-   Gap too wide? Throw yourself.
-   Ceiling too low? Clone crawl (swap between positions).
-   Moving platforms? Clone on one, jump to another, swap back.

**Puzzles**

-   Two pressure plates, one player. Clone sits on one.
-   Timed doors. Clone holds door while you pass, swap before it closes.
-   Light beams. Clone blocks beam, you pass through shadow.

**Stealth Sections**

-   Guard patrols. Create clone as distraction, sneak past.
-   Cameras. Clone draws attention, you disable.

**Combat**

-   Throw clone at enemy as projectile attack.
-   Swap positions mid-fight to confuse bosses.
-   Create clone, both attack from different angles.
-   Clone takes a hit meant for you (sacrifice play).

**Boss Fights**

-   Boss attacks are aimed at you, but you can swap to dodge.
-   Multi-phase boss requires hitting multiple weak points simultaneously.
-   Boss creates clones too — identify the real one.

### Visual Style Recommendation

**Minimalist or stylized 2D.** Think Thomas Was Alone, Celeste, or Katana Zero.

-   Main character: simple silhouette or geometric shape
-   Clone: same but different color or slightly translucent
-   Environment: clean, readable, color-coded hazards

Simple art = faster iteration on level design (which is where this game lives or dies).

### Structure

**Option A: Linear Campaign (3-5 hours)**

-   ~40 levels across 5-6 worlds
-   Each world introduces new clone ability
-   Boss at end of each world
-   Story told through environment or brief dialogue

**Option B: Metroidvania**

-   Interconnected map
-   Clone abilities as progression gates
-   More content-heavy but bigger upside

**Recommendation:** Start with linear. Metroidvania can be a sequel or DLC.

### The "Feel"

This game lives or dies on **juice**:

-   Screen shake on throw
-   Speed lines during momentum moves
-   Satisfying clone creation sound/effect
-   Tight controls (Celeste-level responsiveness)
-   Instant restart on death
-   Ghost replay of last attempt (optional)

### Sample Level Progression

1. **Tutorial:** Just jumping, basic platforming
2. **Clone Intro:** Create clone, no throw yet — just see it exists
3. **Throw Intro:** First gap that requires throw
4. **Throw Mastery:** Multiple throws in sequence
5. **Clone Puzzle:** First pressure plate puzzle
6. **Unlock: Clone Swap** — opens new level types
7. **Swap Platforming:** Levels built around swapping
8. ...and so on

### Risks & Mitigations

| Risk                          | Mitigation                                                         |
| ----------------------------- | ------------------------------------------------------------------ |
| Clone mechanic feels gimmicky | Ensure every level genuinely requires clone, not just optional     |
| Frustrating difficulty        | Instant respawn, checkpoints, optional assists (Celeste model)     |
| Too short                     | Quality over quantity — 3-4 polished hours beats 10 mediocre hours |
| Just "The Swapper again"      | Focus on momentum/action, not slow puzzle solving                  |

### Development Phases

1. **Prototype (1-2 months):** Basic clone + throw. 5 test levels. Does it feel good?
2. **Vertical Slice (2-3 months):** One full world (8 levels + boss). All core mechanics working.
3. **Content (4-6 months):** Remaining worlds, all abilities, full level set.
4. **Polish (2-3 months):** Juice, speedrun mode, accessibility options.

**Estimated total: 10-14 months** (shortest of the three)

---

## Comparison Summary

| Factor              | Creature/Sleeves    | Farming TD              | Clone Platformer   |
| ------------------- | ------------------- | ----------------------- | ------------------ |
| **Scope**           | Medium              | Medium                  | Small-Medium       |
| **Dev Time**        | 12-18 months        | 12-18 months            | 10-14 months       |
| **Art Burden**      | Medium (creatures)  | Medium (crops, enemies) | Low (simple style) |
| **Design Risk**     | Medium (balance)    | Medium (loop pacing)    | Low (proven genre) |
| **Market Risk**     | Low (proven genres) | Low (unique angle)      | Low (evergreen)    |
| **Viral Potential** | Medium              | Medium                  | High (clips)       |
| **Replayability**   | High (roguelike)    | High (roguelike)        | Medium (speedruns) |

---

## Recommended First Project

**If you want to ship something:** Clone Platformer. Tightest scope, clearest path to done.

**If you want market upside:** Creature/Sleeves. The hook is strongest and most unique.

**If you want to combine your interests:** Farming TD. Merges cozy and tense in a fresh way.

---

## Next Steps

1. **Pick one.** Commit for at least the prototype phase.
2. **Prototype in 4-8 weeks.** Answer the question: "Is the core loop fun?"
3. **Playtest early.** Get feedback before you're too invested.
4. **Scope down, not up.** Your first version should be embarrassingly small.
5. **Ship it.** A finished small game beats an unfinished ambitious one.

---

_"Pick a game and do it!"_ — Your own notes
