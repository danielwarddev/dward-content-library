# Farming + Roguelike Tower Defense Hybrid — Expanded Design Document

> **Created:** January 2026  
> **Purpose:** Comprehensive design reference for the Farming Tower Defense concept  
> **Status:** Pre-production brainstorming

---

## Executive Summary

A roguelike where you **plant crops by day** and **those crops defend your farm by night**. The core innovation is merging the cozy satisfaction of farming sims with the desperate tension of tower defense, wrapped in a roguelike structure that keeps each run fresh. Every crop you plant is also a tower. Every harvest is also ammo. Every sunrise is a relief.

**The Elevator Pitch:** _"Plant crops by day. They defend you by night."_

---

## Table of Contents

1. [Core Loop Deep Dive](#core-loop-deep-dive)
2. [Crop System — Expanded](#crop-system--expanded)
3. [Enemy Bestiary](#enemy-bestiary)
4. [Player Systems](#player-systems)
5. [Farm Management](#farm-management)
6. [Seasonal & Weather Systems](#seasonal--weather-systems)
7. [Economy & Shop](#economy--shop)
8. [Progression Systems](#progression-systems)
9. [Boss Encounters](#boss-encounters)
10. [Visual & Audio Direction](#visual--audio-direction)
11. [Narrative & World](#narrative--world)
12. [UI/UX Considerations](#uiux-considerations)
13. [Development Roadmap](#development-roadmap)
14. [Wild Ideas & Stretch Goals](#wild-ideas--stretch-goals)
15. [Risk Analysis](#risk-analysis)

---

## Core Loop Deep Dive

### The Day/Night Cycle

This game lives and dies by the **contrast** between phases:

| Phase     | Duration    | Mood      | Activities                   |
| --------- | ----------- | --------- | ---------------------------- |
| **Dawn**  | 10 sec      | Relief    | Survey damage, collect drops |
| **Day**   | 60-90 sec   | Cozy      | Plant, water, harvest, shop  |
| **Dusk**  | 10 sec      | Tension   | Warning, final preparations  |
| **Night** | 120-180 sec | Desperate | Defend, fight, survive       |

### Why This Works

**Farming games** are beloved for:

-   Satisfying growth loops
-   Low-stakes relaxation
-   Incremental progress
-   "Just one more day" hooks

**Tower defense** is beloved for:

-   Strategic planning
-   Execution under pressure
-   Clear success/failure
-   Watching your plan work (or fail spectacularly)

**Combined:** The cozy planting makes you care about your farm. The night attacks threaten everything you've built. The cycle creates constant tension and relief.

### Core Loop Diagram

```
        ┌─────────────────────────────────────────────┐
        │                RUN START                     │
        │  Choose starting seeds + player loadout      │
        └─────────────────────┬───────────────────────┘
                              │
        ┌─────────────────────▼───────────────────────┐
        │                 DAY PHASE                    │
        │  ┌────────────────────────────────────────┐ │
        │  │ • Plant seeds on farm tiles            │ │
        │  │ • Water crops (speeds growth)          │ │
        │  │ • Harvest mature crops (gain resources)│ │
        │  │ • Visit shop (spend resources)         │ │
        │  │ • Upgrade existing crops               │ │
        │  │ • Build structures (fences, paths)     │ │
        │  │ • Position yourself for night          │ │
        │  └────────────────────────────────────────┘ │
        │                    │                         │
        │            [Sun sets - DUSK]                │
        │         Warning: "Night 3 begins..."        │
        └─────────────────────┬───────────────────────┘
                              │
        ┌─────────────────────▼───────────────────────┐
        │                NIGHT PHASE                   │
        │  ┌────────────────────────────────────────┐ │
        │  │ • Enemies spawn from map edges         │ │
        │  │ • Crops auto-attack based on type      │ │
        │  │ • Player can fight directly            │ │
        │  │ • Collect enemy drops mid-wave         │ │
        │  │ • Crops can be damaged/destroyed       │ │
        │  │ • Survive until dawn                   │ │
        │  └────────────────────────────────────────┘ │
        │                    │                         │
        │           [Sun rises - DAWN]                │
        │        Victory: Resources + continue        │
        │        Defeat: Farm overrun → run ends      │
        └─────────────────────┬───────────────────────┘
                              │
        ┌─────────────────────▼───────────────────────┐
        │              BETWEEN NIGHTS                  │
        │  • Upgrade crops OR player (choose)          │
        │  • Pick from 3 new seed options              │
        │  • Expand farm plot (if resources allow)     │
        │  • Heal damaged crops                        │
        └─────────────────────┬───────────────────────┘
                              │
                              ▼
              [Repeat until Night 15 (Final Boss)]
                              │
                              ▼
        ┌─────────────────────────────────────────────┐
        │               RUN COMPLETE                   │
        │  • Unlock new seeds/upgrades for future runs │
        │  • See run stats                             │
        │  • Return to menu                            │
        └─────────────────────────────────────────────┘
```

### Run Structure

-   **15 nights per run** (30-45 minutes total)
-   **Boss nights:** Night 5, 10, 15
-   **Difficulty curve:** Gradual ramp with spikes at bosses
-   **Win condition:** Survive Night 15's final boss
-   **Lose condition:** Farm core is destroyed

---

## Crop System — Expanded

### Design Philosophy

Every crop should:

1. Have a clear role (attacker, defender, support, economy)
2. Be visually readable at small size
3. Upgrade in interesting ways
4. Synergize with other crops

### Growth Mechanics

| Stage         | Time (Real) | Visual                | Defense Capability |
| ------------- | ----------- | --------------------- | ------------------ |
| Seed          | 0           | Dirt mound            | None               |
| Sprout        | 15 sec      | Small green shoot     | 25% power          |
| Growing       | 30 sec      | Half-size plant       | 50% power          |
| Mature        | 45 sec      | Full plant            | 100% power         |
| Harvest Ready | 60 sec      | Glowing/fruit visible | 100% + harvestable |

**Water bonus:** Watered crops grow 50% faster
**Fertilizer:** Instant growth to next stage

### Complete Crop Catalog

---

#### 🔫 ATTACKER CROPS

Primary damage dealers. Kill enemies before they reach important crops.

| Crop               | Effect                                         | Upgrade                                       | Synergy                                   | Practicality    |
| ------------------ | ---------------------------------------------- | --------------------------------------------- | ----------------------------------------- | --------------- |
| **Corn**           | Shoots kernel projectiles at nearest enemy     | **Popcorn Mortar**: AoE explosions            | More damage near other Corn (field bonus) | 🟢 Core         |
| **Pepper**         | Explodes when enemy steps on it (one-time)     | **Ghost Pepper**: Bigger blast, fire DoT      | Plant in clusters for chain explosions    | 🟢 Core         |
| **Sunflower**      | Fires laser beam in a line                     | **Solar Cannon**: Pierces all enemies in line | Stronger during day phase (charges up)    | 🟢 Core         |
| **Cactus**         | Damages enemies that touch it (contact damage) | **Barrel Cactus**: Larger hitbox, more damage | Pairs with slowing crops                  | 🟢 Core         |
| **Venus Flytrap**  | Grabs and holds small enemies, deals DoT       | **Giant Flytrap**: Can grab medium enemies    | Stalls for other crops to kill            | 🟢 Core         |
| **Pea Shooter**    | Classic rapid-fire pea shots                   | **Gatling Pea**: Triple shot speed            | Basic reliable damage                     | 🟢 Core         |
| **Rose**           | Thorns whip at enemies in radius               | **Briar Rose**: Thorns extend further         | Covers blind spots                        | 🟡 Experimental |
| **Snapdragon**     | Breathes fire in cone AoE                      | **Dragon's Breath**: Larger cone, more damage | Front-line crop                           | 🟡 Experimental |
| **Bomb Beet**      | Throws explosive beets at enemies              | **Cluster Beet**: Multiple smaller explosions | Unreliable but high damage                | 🟡 Experimental |
| **Lightning Leek** | Chain lightning to 3 enemies                   | **Storm Leek**: Chains to 6, stuns briefly    | Swarm clear                               | 🟡 Experimental |
| **Ice Berry**      | Freezes enemies on hit temporarily             | **Permafrost Berry**: Longer freeze, AoE      | Control + damage                          | 🟢 Core         |
| **Razor Wheat**    | Slashing attacks in straight line              | **Scythe Wheat**: 360° slash                  | Melee range attacker                      | 🔴 Wild         |

---

#### 🛡️ DEFENDER CROPS

Block, redirect, or absorb enemy attacks. Protect your valuable attackers.

| Crop             | Effect                          | Upgrade                                          | Synergy                        | Practicality    |
| ---------------- | ------------------------------- | ------------------------------------------------ | ------------------------------ | --------------- |
| **Pumpkin**      | Wall that blocks enemy paths    | **Giant Pumpkin**: 3x HP, larger                 | Funnel enemies into kill zones | 🟢 Core         |
| **Potato**       | Absorbs damage for nearby crops | **Iron Potato**: Reflects 25% damage             | Protect fragile attackers      | 🟢 Core         |
| **Hedge**        | Creates impassable terrain      | **Thorny Hedge**: Damages climbers               | Shape the battlefield          | 🟢 Core         |
| **Oak Sapling**  | Tall tree blocks flyers, tanky  | **Ancient Oak**: Massive HP, roots immobilize    | Only anti-air blocker          | 🟡 Experimental |
| **Rock Melon**   | Regenerates HP slowly           | **Boulder Melon**: Regen 2x, knockback           | Self-sustaining wall           | 🟡 Experimental |
| **Rubber Plant** | Bounces enemies back            | **Trampoline Plant**: Bounces into other enemies | Crowd control + repositioning  | 🔴 Wild         |
| **Shield Fern**  | Projects barrier in front       | **Aegis Fern**: Barrier absorbs projectiles      | Protects a row                 | 🟡 Experimental |

---

#### 🎯 SUPPORT CROPS

Buff your other crops, debuff enemies, provide utility.

| Crop                 | Effect                              | Upgrade                                                     | Synergy                       | Practicality    |
| -------------------- | ----------------------------------- | ----------------------------------------------------------- | ----------------------------- | --------------- |
| **Wheat**            | Speed boost aura for player         | **Golden Wheat**: Also boosts crop attack speed             | Pair with player combat build | 🟢 Core         |
| **Carrot**           | Reveals hidden/burrowing enemies    | **X-Ray Carrot**: Also reveals enemy HP bars                | Essential vs sneaky enemies   | 🟢 Core         |
| **Coffee Bean**      | Reduces cooldowns of nearby crops   | **Espresso Bean**: 2x effect, jitters (random targeting)    | High risk, high reward        | 🟢 Core         |
| **Mint**             | Heals nearby crops slowly           | **Peppermint**: Burst heal when any crop is destroyed       | Sustain during long nights    | 🟡 Experimental |
| **Lavender**         | Calms enemies (reduced aggro range) | **Hypnotic Lavender**: Enemies attack each other 10% chance | Subtle but powerful           | 🟡 Experimental |
| **Four-Leaf Clover** | Increases resource drop rate        | **Lucky Clover**: Rare drops more common                    | Economy booster               | 🟡 Experimental |
| **Sage**             | Crops in radius gain +25% damage    | **Elder Sage**: +50% damage but uses water faster           | Damage multiplier             | 🟢 Core         |
| **Aloe**             | Heals player when they walk past    | **Healing Aloe**: Larger heal, leaves residue               | Player sustain                | 🟡 Experimental |
| **Ginseng**          | Boosts XP gain from kills           | **Mega Ginseng**: Double XP                                 | Leveling optimization         | 🔴 Wild         |
| **Companion Flower** | Attracts beneficial insects         | **Queen Flower**: Insects attack enemies                    | Passive damage                | 🔴 Wild         |

---

#### 🐌 DEBUFFER CROPS

Weaken, slow, confuse, or otherwise impair enemies.

| Crop              | Effect                                   | Upgrade                                          | Synergy                 | Practicality    |
| ----------------- | ---------------------------------------- | ------------------------------------------------ | ----------------------- | --------------- |
| **Stinkweed**     | Slows enemies in radius (50% speed)      | **Putrid Stinkweed**: 75% slow, enemies take DoT | Essential crowd control | 🟢 Core         |
| **Garlic**        | Enemies avoid the area (repel zone)      | **Ghost Garlic**: Repel zone 2x larger           | Redirect pathing        | 🟢 Core         |
| **Onion**         | Makes enemies cry (accuracy debuff -50%) | **Red Onion**: Also reduces enemy damage         | Against ranged enemies  | 🟢 Core         |
| **Poison Ivy**    | DoT to enemies passing through (3/sec)   | **Toxic Ivy**: DoT spreads to nearby enemies     | Path denial             | 🟢 Core         |
| **Mushroom**      | Confuses enemies (random movement)       | **Psychedelic Shroom**: Enemies attack allies    | Chaos option            | 🟡 Experimental |
| **Nettle**        | Blinds enemies (reduced vision range)    | **Stinging Nettle**: Blind + DoT                 | Stealth build synergy   | 🟡 Experimental |
| **Skunk Cabbage** | Fear aura (enemies flee briefly)         | **Dread Cabbage**: Longer fear, wider range      | Defensive panic button  | 🟡 Experimental |
| **Nightshade**    | Curses enemies (take 50% more damage)    | **Deadly Nightshade**: Curse is permanent        | Damage amp              | 🔴 Wild         |
| **Tar Pit Tuber** | Creates sticky ground (90% slow)         | **Asphalt Tuber**: Enemies stuck for 2 seconds   | Total movement denial   | 🔴 Wild         |

---

#### 💰 ECONOMY CROPS

Generate resources, provide passive income, enable bigger farms.

| Crop              | Effect                              | Upgrade                                   | Synergy               | Practicality    |
| ----------------- | ----------------------------------- | ----------------------------------------- | --------------------- | --------------- |
| **Golden Apple**  | Bonus currency on harvest (+50%)    | **Platinum Apple**: +100% harvest value   | Pure economy          | 🟢 Core         |
| **Magic Bean**    | Random seed on harvest              | **Wishing Bean**: Rarer seeds more likely | Slot machine          | 🟢 Core         |
| **Truffle**       | Rare drop chance increase (+10%)    | **Black Truffle**: +25% rare drop chance  | Long-term value       | 🟡 Experimental |
| **Money Tree**    | Passive income (1 gold/10 sec)      | **Cash Crop**: 2 gold/10 sec              | Early game investment | 🟡 Experimental |
| **Seed Pod**      | Spawns free random seeds on death   | **Mother Pod**: Spawns 3 seeds            | Sacrifice economy     | 🟡 Experimental |
| **Recycler Root** | Converts enemy corpses to resources | **Composter Root**: 2x resources          | Combat economy        | 🔴 Wild         |

---

### Crop Upgrade Paths 🟢 PRACTICAL

Each crop can be upgraded mid-run. Upgrades require resources and choosing between options.

**Upgrade Structure:**

```
        [Base Crop]
            │
      ┌─────┴─────┐
      ▼           ▼
   [Path A]    [Path B]
   (Offense)   (Utility)
```

**Example: Corn**

-   **Path A: Popcorn Mortar** — AoE explosions, less range
-   **Path B: Corn Maze** — Fires continuously, lower damage but no cooldown

**Example: Pumpkin**

-   **Path A: Giant Pumpkin** — 3x HP, larger blocking area
-   **Path B: Jack-o-Lantern** — Lower HP, but scares enemies (fear aura)

---

### Crop Synergies 🟡 EXPERIMENTAL

Certain crops boost each other when planted adjacently.

| Combo                         | Bonus                                 | Strategy             |
| ----------------------------- | ------------------------------------- | -------------------- |
| Corn + Corn + Corn            | "Field Bonus": All corn +25% damage   | Corn spam build      |
| Sunflower + Sage              | "Solar Focus": Sunflower beam 2x wide | Damage nuke lane     |
| Pumpkin + Potato              | "Fortified": Both gain +50% HP        | Ultimate wall        |
| Stinkweed + Poison Ivy        | "Toxic Zone": Combined DoT + slow     | Kill zone            |
| Coffee Bean + Any Attacker    | "Caffeinated": Attack speed doubled   | DPS boost            |
| Venus Flytrap + Nightshade    | "Death Trap": Held enemies cursed     | Single target delete |
| Money Tree + Four-Leaf Clover | "Prosperity": Triple passive income   | Greed build          |

---

### Crop Breeding 🔴 WILD

**Concept:** Plant two different crops in adjacent tiles with a special "Breeding Soil" item. After 2 days, they combine into a new hybrid.

| Parent 1      | Parent 2       | Hybrid Result      | Effect                       |
| ------------- | -------------- | ------------------ | ---------------------------- |
| Corn          | Pepper         | **Popcorn Pepper** | Explosive rapid-fire shots   |
| Sunflower     | Ice Berry      | **Aurora Flower**  | Freezing laser beam          |
| Venus Flytrap | Poison Ivy     | **Toxic Maw**      | Grabs and poisons            |
| Pumpkin       | Cactus         | **Spiked Gourd**   | Wall that damages attackers  |
| Coffee Bean   | Lightning Leek | **Storm Brew**     | Crops in radius attack twice |

**Implementation Notes:**

-   Hybrids are powerful but:
    -   Breeding takes time (2 day phases)
    -   Requires rare Breeding Soil item
    -   Only one hybrid at a time
-   Could be a late-game unlock system

---

## Enemy Bestiary

### Enemy Design Philosophy

-   **Clear silhouettes** — Identifiable at a glance
-   **Telegraphed behaviors** — Player understands what they do
-   **Counter-play** — Each enemy type has crops that counter it
-   **Escalation** — Later nights mix enemy types dangerously

### Enemy Categories

#### 🐛 SWARM (Many weak enemies)

| Enemy      | HP  | Speed | Behavior                                | Counter        |
| ---------- | --- | ----- | --------------------------------------- | -------------- |
| **Slime**  | 5   | Slow  | Mindless march toward farm core         | AoE crops      |
| **Rat**    | 8   | Fast  | Rushes directly, ignores crops          | Wall crops     |
| **Beetle** | 10  | Med   | Eats crops it passes (destroys them)    | Kill priority  |
| **Locust** | 3   | Fast  | Flying swarm, ignores walls             | Oak Sapling    |
| **Spider** | 7   | Med   | Creates web (slows your movement)       | Fire crops     |
| **Ant**    | 4   | Med   | Carry away resources if they reach core | Economy threat |

#### 🦏 TANK (Slow, high HP)

| Enemy             | HP  | Speed | Behavior                                 | Counter          |
| ----------------- | --- | ----- | ---------------------------------------- | ---------------- |
| **Golem**         | 80  | VSlow | Ignores debuffs, smashes walls           | High DPS crops   |
| **Armored Boar**  | 50  | Slow  | Front armor (take 25% damage from front) | Flank attacks    |
| **Snail**         | 40  | VSlow | Leaves slime trail (slows crops)         | Elevated crops   |
| **Mammoth**       | 100 | VSlow | Charges, destroys everything in line     | Bait with walls  |
| **Living Tree**   | 60  | VSlow | Heals near other Living Trees            | Separate them    |
| **Iron Tortoise** | 120 | VSlow | Reflects projectiles back                | Melee crops only |

#### 🦅 FLYER (Ignores ground defenses)

| Enemy               | HP  | Speed | Behavior                               | Counter              |
| ------------------- | --- | ----- | -------------------------------------- | -------------------- |
| **Crow**            | 15  | Fast  | Steals crops (picks up and flies away) | Oak, anti-air        |
| **Bat**             | 10  | Fast  | Comes in clouds, hard to hit           | AoE attacks          |
| **Moth**            | 20  | Med   | Drops powder (damages crops over time) | Kill fast            |
| **Harpy**           | 30  | Med   | Swoops down, attacks, flies up         | Timing crops         |
| **Dragon-fly**      | 25  | Fast  | Fire breath as it passes               | Fire-resistant crops |
| **Storm Elemental** | 40  | Med   | Lightning strikes random crops         | Spread layout        |

#### 🐍 BURROWER (Underground movement)

| Enemy             | HP  | Speed | Behavior                              | Counter         |
| ----------------- | --- | ----- | ------------------------------------- | --------------- |
| **Worm**          | 20  | Med   | Pops up inside farm, bypasses walls   | Carrot reveals  |
| **Mole**          | 25  | Slow  | Creates tunnels for other burrowers   | Kill the mole   |
| **Gopher**        | 15  | Fast  | Steals root vegetables (economy loss) | Carrot + trap   |
| **Sand Shark**    | 35  | Med   | Attacks from below, high damage       | Deep-root crops |
| **Tremor Beetle** | 45  | Slow  | Shakes ground, disrupts crop aim      | Stable crops    |

#### 🧙 SPECIAL (Unique mechanics)

| Enemy           | HP     | Speed | Behavior                                 | Counter           |
| --------------- | ------ | ----- | ---------------------------------------- | ----------------- |
| **Necromancer** | 30     | Slow  | Revives dead enemies                     | Kill first        |
| **Shaman**      | 25     | Slow  | Buffs all enemies (+50% stats)           | Kill first        |
| **Thief**       | 20     | Fast  | Steals one crop, runs away               | Chase down        |
| **Mimic**       | Varies | Med   | Disguised as a crop until approached     | Carrot reveals    |
| **Splitter**    | 40     | Med   | Splits into 2 smaller versions on death  | Prepare for split |
| **Ghost**       | 15     | Slow  | Phases through walls, attacks crops      | Spirit crops      |
| **Parasite**    | 1      | Fast  | Infects crops, turns them against you    | Remove infected   |
| **Decoy**       | 50     | Slow  | Doesn't attack, wastes your crop attacks | Ignore it         |

---

### Enemy Wave Composition

**Night 1-3 (Tutorial):** Pure Slimes
**Night 4:** Slimes + Rats (speed variety)
**Night 5:** BOSS — The Swarm King (spawns slimes)
**Night 6-7:** Introduce Beetles + Golems
**Night 8-9:** Introduce Flyers (Crows, Bats)
**Night 10:** BOSS — The Hive Mind (flyer swarm)
**Night 11-12:** Introduce Burrowers + mixed waves
**Night 13-14:** Full mixture, high difficulty
**Night 15:** FINAL BOSS — The Blight (corrupts everything)

---

## Player Systems

### Player Combat 🟢 PRACTICAL

The player isn't just a passive farmer — they can fight directly.

**Starting Equipment:**

-   **Hoe** — Melee weapon, moderate damage, can till soil
-   **Watering Can** — Waters crops, can splash enemies (tiny damage)

**Unlockable Weapons:**

| Weapon             | Type   | Damage    | Special                        | Unlock         |
| ------------------ | ------ | --------- | ------------------------------ | -------------- |
| **Pitchfork**      | Melee  | High      | Pierces 2 enemies              | Beat Night 5   |
| **Sickle**         | Melee  | Medium    | Fast attack, harvest 2x        | Beat Night 10  |
| **Seed Cannon**    | Ranged | Medium    | Plants seeds on hit            | Buy for 500g   |
| **Flamethrower**   | Ranged | High      | DoT, hurts crops too           | Beat fire boss |
| **Bug Net**        | Melee  | Low       | Captures enemies for resources | Find in event  |
| **Blessed Shovel** | Melee  | Very High | One-shots undead               | Secret         |

### Player Upgrades (Per-Run)

**Between Nights:** Choose 1 of 3 upgrades

| Upgrade        | Effect                        |
| -------------- | ----------------------------- |
| Speed Boots    | Move 20% faster               |
| Deep Pockets   | +3 inventory slots            |
| Green Thumb    | Crops grow 10% faster         |
| Iron Skin      | Take 20% less damage          |
| Harvester      | Harvest speed 50% faster      |
| Night Vision   | See enemy spawn points        |
| Second Wind    | Revive once per run at 50% HP |
| Gold Rush      | +15% resource drops           |
| Crop Whisperer | Crops have +10% accuracy      |

### Companion Animals 🟡 EXPERIMENTAL

**Concept:** Unlockable pets that help during runs.

| Companion    | Effect                                | Unlock          |
| ------------ | ------------------------------------- | --------------- |
| **Farm Dog** | Attacks nearby enemies                | Default unlock  |
| **Cat**      | Collects resource drops automatically | Beat Night 10   |
| **Chicken**  | Lays eggs (minor healing items)       | Find in event   |
| **Owl**      | Reveals map at night                  | Beat flyer boss |
| **Pig**      | Finds buried treasure                 | Find 10 secrets |
| **Goat**     | Eats weeds, clears debris             | Economy run     |

---

## Farm Management

### Farm Layout 🟢 PRACTICAL

**Starting Farm:** 5x5 grid (25 tiles)
**Expandable:** Spend resources to add rows/columns
**Max Size:** 9x9 grid (81 tiles) — but expensive

```
┌───────────────────────────────────┐
│                                   │
│   [Expansion Zone - Locked]       │
│                                   │
├───────────────────────────────────┤
│  ╔═══╦═══╦═══╦═══╦═══╗           │
│  ║   ║   ║   ║   ║   ║           │
│  ╠═══╬═══╬═══╬═══╬═══╣           │
│  ║   ║   ║ C ║   ║   ║  C = Core │
│  ╠═══╬═══╬═══╬═══╬═══╣           │
│  ║   ║   ║   ║   ║   ║           │
│  ╠═══╬═══╬═══╬═══╬═══╣           │
│  ║   ║   ║   ║   ║   ║           │
│  ╠═══╬═══╬═══╬═══╬═══╣           │
│  ║   ║   ║   ║   ║   ║           │
│  ╚═══╩═══╩═══╩═══╩═══╝           │
│                                   │
│   [Expansion Zone - Locked]       │
│                                   │
└───────────────────────────────────┘
```

### Farm Core

-   **The Heart of Your Farm**
-   If destroyed, run ends
-   Can be upgraded:
    -   **Reinforced Core:** +50% HP
    -   **Regenerating Core:** Heals 5 HP/night
    -   **Inspiring Core:** All crops +10% damage

### Structures 🟢 PRACTICAL

Non-crop buildings that provide utility.

| Structure         | Cost | Effect                                     |
| ----------------- | ---- | ------------------------------------------ |
| **Fence**         | 10g  | Blocks paths, cheap walls                  |
| **Scarecrow**     | 50g  | Decoy — enemies attack it first            |
| **Sprinkler**     | 100g | Auto-waters adjacent crops                 |
| **Torch**         | 25g  | Reveals area at night, scares some enemies |
| **Compost Bin**   | 75g  | Convert excess crops to resources          |
| **Silo**          | 150g | Store extra seeds for future nights        |
| **Watch Tower**   | 200g | See further, reveals enemy spawn           |
| **Well**          | 100g | Unlimited water, but takes a tile          |
| **Lightning Rod** | 50g  | Protects area from storm damage            |

### Terrain Features 🟡 EXPERIMENTAL

Some maps have natural terrain to work with.

| Terrain           | Effect                         | Strategy            |
| ----------------- | ------------------------------ | ------------------- |
| **River**         | Impassable, must bridge        | Natural choke point |
| **Rocks**         | Block building                 | Can't plant here    |
| **Fertile Soil**  | Crops grow 50% faster          | Prioritize          |
| **Cursed Ground** | Crops take damage over time    | Avoid or cleanse    |
| **Pond**          | Water source, attracts frogs   | Frog ally?          |
| **Ancient Tree**  | Indestructible, provides shade | Plan around it      |

---

## Seasonal & Weather Systems

### Seasons 🟡 EXPERIMENTAL

**Concept:** Each run takes place in a random season (or player chooses). Season affects which crops are available and enemy types.

| Season     | Available Crops          | Enemy Theme         | Bonus                    |
| ---------- | ------------------------ | ------------------- | ------------------------ |
| **Spring** | Fast-growing, fragile    | Insects, small      | +25% growth speed        |
| **Summer** | Fire-based, strong       | Heat creatures      | Fire crops +50% damage   |
| **Autumn** | Harvest-focused, economy | Harvesters, thieves | +50% resource drops      |
| **Winter** | Ice-based, defensive     | Frost creatures     | Debuff crops +50% effect |

### Weather Events 🟡 EXPERIMENTAL

**Concept:** Random weather affects each night differently.

| Weather        | Effect                                           | Preparation                   |
| -------------- | ------------------------------------------------ | ----------------------------- |
| **Rain**       | Crops auto-watered, but slippery (player slides) | Skip watering, bring traction |
| **Drought**    | No natural water, crops need 2x watering         | Water stockpile, fire risk    |
| **Storm**      | Lightning hits random tiles, damages anything    | Lightning rods, spread crops  |
| **Fog**        | Reduced vision, enemies spawn closer             | Torches, Carrot crops         |
| **Wind**       | Projectiles curve, flying enemies faster         | Adjust aim, anti-air          |
| **Hail**       | Periodic damage to everything                    | Defensive crops, healing      |
| **Blood Moon** | Enemies +50% stronger, +50% drops                | All-out defense, risk/reward  |

---

## Economy & Shop

### Currency Types

| Currency     | Source                | Used For                    |
| ------------ | --------------------- | --------------------------- |
| **Gold**     | Enemy drops, harvests | Seeds, structures, upgrades |
| **Seeds**    | Drops, harvests, shop | Planting crops              |
| **Crystals** | Rare drops, bosses    | Permanent unlocks           |

### Shop System 🟢 PRACTICAL

**The Traveling Merchant** appears each morning.

**Shop Inventory (Random 5 from pool):**

| Item                 | Price | Effect                      |
| -------------------- | ----- | --------------------------- |
| Random Seed (Common) | 20g   | Random common crop          |
| Random Seed (Rare)   | 75g   | Random rare crop            |
| Specific Seed        | 40g   | Choose type, limited stock  |
| Fertilizer           | 30g   | Instant growth for one crop |
| Super Fertilizer     | 100g  | Instant mature + upgraded   |
| Crop Heal            | 50g   | Full heal one crop          |
| Mass Heal            | 150g  | Heal all crops 50%          |
| Scarecrow            | 50g   | Decoy structure             |
| Fence Kit (x5)       | 40g   | 5 fence segments            |
| Breeding Soil        | 200g  | Enables one crop hybrid     |
| Mystery Seed         | 60g   | Could be anything           |
| Rare Drop            | 150g  | Random rare item            |

### Gambling Mechanics 🟡 EXPERIMENTAL

**Seed Packs:** Pay 100g for 3 random seeds (could be 3 commons or a legendary)

**The Gambler (Event):**

-   Bet gold on coin flip
-   Bet seeds for mystery seeds
-   Bet crops for upgraded versions

---

## Progression Systems

### Meta-Progression 🟢 PRACTICAL

**Permanent unlocks** between runs using Crystals.

**Unlock Categories:**

| Category             | Examples                                 |
| -------------------- | ---------------------------------------- |
| **New Seeds**        | Start with new crop types available      |
| **Starting Bonuses** | Begin with extra gold, a free crop, etc. |
| **Player Upgrades**  | Permanent stat boosts                    |
| **Farm Layouts**     | New starting configurations              |
| **Companions**       | Unlock animal helpers                    |
| **Challenge Modes**  | Difficulty modifiers                     |

### Unlock Tree

```
                    [Core Unlocks]
                         │
        ┌────────────────┼────────────────┐
        ▼                ▼                ▼
   [Crop Tree]     [Player Tree]    [Farm Tree]
        │                │                │
   Rare seeds       More HP          Bigger start
   Hybrid recipes   Better weapons   Structures
   Legendary crops  Companions       Terrain types
```

### Achievement System

| Achievement     | Requirement                    | Reward                |
| --------------- | ------------------------------ | --------------------- |
| First Blood     | Kill 100 enemies               | 10 Crystals           |
| Green Thumb     | Grow 50 crops in one run       | Rare seed             |
| Exterminator    | Kill 1000 enemies total        | Legendary crop unlock |
| Pacifist Farmer | Win without player attacking   | Unique companion      |
| Speedrunner     | Win in under 20 minutes        | Speed buff unlock     |
| Hoarder         | Have 50 crops at once          | Bigger inventory      |
| Poverty Run     | Win with never buying anything | Challenge mode        |

---

## Boss Encounters

### Boss Design Philosophy

-   **Multi-phase fights** that escalate
-   **Unique mechanics** that test different skills
-   **Memorable visuals** — the moment you remember
-   **Fair but challenging** — learnable patterns

---

### Night 5 Boss: The Swarm King 🟢 PRACTICAL

**A massive slime that splits into smaller slimes when damaged.**

| Phase                      | HP  | Behavior                                      |
| -------------------------- | --- | --------------------------------------------- |
| **Phase 1**                | 200 | Slowly approaches, spawns Slimes every 10 sec |
| **Phase 2 (50%)**          | —   | Splits into 4 Prince Slimes (50 HP each)      |
| **Phase 3 (Princes dead)** | 100 | King reforms, enraged, faster spawns          |

**Counters:**

-   AoE crops for slime swarm
-   High single-target for King himself
-   Walls to slow approach

**Rewards:**

-   "Slime Seed" — Friendly slime crop (blocks/absorbs)
-   Crystal x3

---

### Night 10 Boss: The Hive Queen 🟢 PRACTICAL

**A giant flying insect that commands swarms.**

| Phase             | HP  | Behavior                                 |
| ----------------- | --- | ---------------------------------------- |
| **Phase 1**       | 250 | Hovers, sends waves of Locusts and Moths |
| **Phase 2 (50%)** | —   | Lands, becomes targetable, melee attacks |
| **Phase 3 (25%)** | —   | Takes off again, spawns elite Harpies    |

**Gimmick:** While flying, can only be hit by anti-air crops or player ranged weapons.

**Counters:**

-   Oak Saplings essential
-   Player ranged weapon for Phase 1/3
-   Melee damage for Phase 2

**Rewards:**

-   "Hive Mind Seed" — Friendly insect swarm crop
-   Crystal x5

---

### Night 15 Boss: The Blight 🟢 PRACTICAL

**A creeping corruption that spreads across your farm.**

| Phase       | Behavior                                                          |
| ----------- | ----------------------------------------------------------------- |
| **Phase 1** | Blight tendrils grow from edges, corrupt tiles they touch         |
| **Phase 2** | Corrupted crops turn hostile, attack other crops                  |
| **Phase 3** | The Blight Core emerges, must destroy before it reaches Farm Core |

**Gimmick:**

-   Corrupted tiles can't be used
-   Corrupted crops fight for the enemy
-   The Blight Core is immune while tendrils exist (must clear tendrils first)

**Counters:**

-   Fire crops to burn tendrils
-   High mobility to clear spreading corruption
-   Sacrifice corrupted crops before they turn

**Rewards:**

-   Run complete!
-   "Purified Seed" — Legendary crop (cleansing aura)
-   Crystal x10

---

### Secret Boss: The Drought 🔴 WILD

**Unlocked by winning without ever watering (use sprinklers only).**

A sun elemental that scorches everything.

| Phase       | Behavior                                            |
| ----------- | --------------------------------------------------- |
| **Phase 1** | Heat waves damage all crops periodically            |
| **Phase 2** | Summons Fire Elementals, immune to fire             |
| **Phase 3** | Charges up "Solar Flare" — must block line of sight |

**Counters:**

-   Ice crops essential
-   Water-based anything helps
-   Pumpkin walls block Solar Flare

---

## Visual & Audio Direction

### Art Style 🟢 PRACTICAL

**Primary:** Top-down pixel art (32x32 or 48x48 tiles)

**References:**

-   Stardew Valley (farm tiles, crops)
-   Kingdom: Two Crowns (day/night cycle, sieges)
-   Vampire Survivors (enemy swarms, readability)
-   Moonlighter (shop, dungeon contrast)

**Why This Works:**

-   Manageable asset count for solo dev
-   Clear readability at gameplay zoom
-   Nostalgic appeal
-   Works on modest hardware

### Visual Language

| Element            | Visual Cue                            |
| ------------------ | ------------------------------------- |
| **Allies (crops)** | Green/warm colors, rounded shapes     |
| **Enemies**        | Red/purple tints, sharp edges         |
| **UI elements**    | Wooden frames, parchment textures     |
| **Night**          | Blue overlay, stars, glowing elements |
| **Day**            | Warm yellow, bright, hopeful          |
| **Damage**         | Red flash, screen shake               |
| **Heal**           | Green particles, soft pulse           |

### Audio Direction

**Music:**

-   **Day Phase:** Cozy, pastoral, Stardew-like
-   **Dusk:** Ominous transition, drums
-   **Night Phase:** Tense, urgent, but not exhausting
-   **Boss:** Intense, memorable theme per boss
-   **Victory:** Triumphant fanfare
-   **Defeat:** Somber, short

**SFX Priority:**

-   Planting (satisfying "thunk")
-   Watering (splash, growth jingle)
-   Harvesting (pop, coins)
-   Crop attacks (varied by type)
-   Enemy hits (meaty impact)
-   Enemy death (pop, drop sounds)
-   Night start (ominous horn)
-   Dawn (rooster crow, relief)

---

## Narrative & World

### The Hook

**Why are enemies attacking the farm?**

**Option A: The Blighted Land**

-   Your farm sits on the only fertile soil in a corrupted wasteland
-   Monsters are drawn to life energy
-   Your crops literally fight corruption

**Option B: The Last Harvest**

-   You're the last farmer in a dying world
-   Each night, you hold back the apocalypse
-   The seeds you plant are hope

**Option C: The Experiment**

-   You're a botanist who created weaponized plants
-   Now you must defend against monsters your experiments attracted
-   Science gone right? Or wrong?

### Environmental Storytelling

-   **Ruins** in the distance — the world wasn't always like this
-   **Old equipment** — previous farmers tried and failed
-   **Monster variations** — corrupted versions of normal animals
-   **Day visitors** — NPCs who pass through, share lore

### NPC Visitors 🟡 EXPERIMENTAL

**Concept:** Between nights, occasional visitors offer quests or trades.

| Visitor              | Offers                                   |
| -------------------- | ---------------------------------------- |
| **The Merchant**     | Shop (always present)                    |
| **The Scholar**      | Lore, tips, crop combinations            |
| **The Hunter**       | Bounties (kill X enemy type for reward)  |
| **The Refugee**      | Protect them for 1 night, reward         |
| **The Thief**        | Can steal from you or offer stolen goods |
| **The Ghost Farmer** | Cryptic hints about secret unlocks       |

---

## UI/UX Considerations

### HUD Layout

```
┌─────────────────────────────────────────────────────────────────┐
│  [NIGHT 7]          [☀️ DAY PHASE - 0:45]          [⚙️ Menu]     │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  Gold: 💰 523                                                    │
│  Seeds: 🌱 12                                                    │
│                                                                  │
│                    ┌───────────────────────┐                     │
│                    │                       │                     │
│                    │      FARM VIEW        │                     │
│                    │                       │                     │
│                    │       [Core ❤️]        │                     │
│                    │                       │                     │
│                    └───────────────────────┘                     │
│                                                                  │
│  [Player HP: ████████░░]                                        │
│                                                                  │
├─────────────────────────────────────────────────────────────────┤
│  [Inventory: 🌽 🌻 🥔 🎃 🌶️ ___ ___ ___]                        │
└─────────────────────────────────────────────────────────────────┘
```

### Night Phase Changes

-   Timer becomes "WAVE 2/5"
-   Enemy spawn indicators flash at edges
-   Core HP prominently displayed
-   Crop HP bars visible

### Accessibility

-   **Speed controls** — Adjust game speed
-   **Pause during combat** — Plan without pressure
-   **Colorblind modes** — Shape indicators for crop types
-   **Large text option** — Scalable UI
-   **One-hand mode** — Mouse-only controls

---

## Development Roadmap

### Phase 1: Prototype (2-3 Months)

**Goal:** Is the core loop fun?

**Deliverables:**

-   [ ] 5 crops (Corn, Pepper, Pumpkin, Stinkweed, Golden Apple)
-   [ ] 3 enemy types (Slime, Rat, Golem)
-   [ ] Basic day/night cycle
-   [ ] Placeholder art
-   [ ] 3 nights playable
-   [ ] Core damage = lose

**Success Criteria:** "One more night" feeling

---

### Phase 2: Vertical Slice (3-4 Months)

**Goal:** Full loop with polish

**Deliverables:**

-   [ ] 15 crops with art
-   [ ] 10 enemy types
-   [ ] Night 1-5 + first boss
-   [ ] Shop system
-   [ ] Player upgrades
-   [ ] Basic meta-progression
-   [ ] Sound effects
-   [ ] One biome complete

**Success Criteria:** Could demo to press/streamers

---

### Phase 3: Content Complete (4-6 Months)

**Goal:** All content in

**Deliverables:**

-   [ ] 30+ crops
-   [ ] 20+ enemies
-   [ ] All 15 nights + 3 bosses
-   [ ] All structures
-   [ ] Full meta-progression
-   [ ] Seasonal system (if keeping)
-   [ ] Weather system (if keeping)
-   [ ] Music

**Success Criteria:** Complete run possible, balanced

---

### Phase 4: Polish (2-3 Months)

**Goal:** Ship quality

**Deliverables:**

-   [ ] Balance pass
-   [ ] Bug fixes
-   [ ] Achievements
-   [ ] Steam integration
-   [ ] Trailer
-   [ ] Marketing
-   [ ] Accessibility features

**Total: 12-18 months**

---

## Wild Ideas & Stretch Goals

### 🔴 Post-Launch Dreams

**Co-op Mode**

-   2 players share one farm
-   One focuses defense, one offense
-   Shared economy, split responsibilities

**Endless Mode**

-   Survive as long as possible
-   Leaderboards
-   Daily seeds

**Farm Designer**

-   Custom starting layouts
-   Share with Steam Workshop

### 🟡 Maybe If Time

**Multiple Biomes**

-   Desert farm (water scarce, fire enemies)
-   Tundra farm (slow growth, ice enemies)
-   Swamp farm (water everywhere, undead)

**Seasonal Campaign**

-   4 runs (one per season) connected
-   Carry some progress between

**Creature Capture**

-   Net enemies, convert to allies
-   Monster crops?

### 🟢 Achievable Stretch Goals

**Challenge Modes**

-   No player combat
-   No defenders
-   Speed run

**Daily Challenges**

-   Fixed seed
-   Weird modifiers
-   Leaderboard

**Additional Bosses**

-   Secret unlockable bosses
-   Nightmare difficulty variants

---

## Risk Analysis

### High Risk

| Risk                      | Likelihood | Impact | Mitigation                             |
| ------------------------- | ---------- | ------ | -------------------------------------- |
| Day phase feels boring    | Medium     | High   | Add more activities, shorten if needed |
| Night phase feels unfair  | Medium     | High   | Clear telegraphs, difficulty options   |
| PvZ comparison too strong | High       | Medium | Lean into farming sim elements         |

### Medium Risk

| Risk                                  | Likelihood | Impact | Mitigation                              |
| ------------------------------------- | ---------- | ------ | --------------------------------------- |
| Scope creep (seasons, breeding, etc.) | High       | Medium | Cut experimental features if behind     |
| Art burden                            | Medium     | Medium | Stylized pixel art, outsource if needed |
| Runs feel samey                       | Medium     | Medium | Variety in seeds, weather, enemy combos |

### Low Risk

| Risk             | Likelihood | Impact | Mitigation                  |
| ---------------- | ---------- | ------ | --------------------------- |
| Technical issues | Low        | Medium | Simple tech, proven engines |
| Market rejection | Low        | High   | Validate with demo          |

---

## Appendix: Naming Ideas

**Title Options:**

-   Nightfall Farm
-   Siege Garden
-   Harvest Defense
-   Crops & Carnage
-   Farm Fortress
-   Night Harvest
-   Grow to Survive
-   The Last Garden
-   Bloom & Doom
-   Fertile Grounds

**Tagline Options:**

-   "Plant by day. Defend by night."
-   "Your crops fight back."
-   "Farm like your life depends on it."
-   "The harvest is war."

---

_Last Updated: January 2026_
_Status: Pre-production concept document_
