# Creature Collector Deck Builder with Sleeves — Expanded Design Document

> **Created:** January 2026  
> **Purpose:** Comprehensive design reference for the Creature/Sleeve deckbuilder concept  
> **Status:** Pre-production brainstorming

---

## Executive Summary

A roguelike deckbuilder where creatures ARE your cards, and **sleeves** fundamentally transform how each creature plays. The core innovation is that a single creature roster (50-60 creatures) becomes 300+ functional variations through the sleeve system, solving the content problem that plagues creature collectors while maintaining the strategic depth of modern deckbuilders.

**The Elevator Pitch:** _"Catch creatures as cards. Sleeve them to transform how they play."_

---

## Table of Contents

1. [Core Concept Deep Dive](#core-concept-deep-dive)
2. [The Sleeve System — Expanded](#the-sleeve-system--expanded)
3. [Creature Design Bible](#creature-design-bible)
4. [Battle System](#battle-system)
5. [Run Structure & Progression](#run-structure--progression)
6. [Meta-Progression](#meta-progression)
7. [Boss Encounters](#boss-encounters)
8. [Events & Encounters](#events--encounters)
9. [Visual & Audio Direction](#visual--audio-direction)
10. [UI/UX Considerations](#uiux-considerations)
11. [Monetization & Platform Strategy](#monetization--platform-strategy)
12. [Development Roadmap](#development-roadmap)
13. [Wild Ideas & Stretch Goals](#wild-ideas--stretch-goals)
14. [Risk Analysis](#risk-analysis)

---

## Core Concept Deep Dive

### Why Creatures as Cards Works

Traditional creature collectors have a problem: you catch 100+ monsters but only use 6. The rest rot in a box. Deckbuilders solve this by making every card matter — your deck is lean, every draw counts.

By merging these genres:

-   **Every creature matters** — your deck is your active team
-   **No wasted designs** — even "weak" creatures can be powerful with the right sleeve
-   **Synergy over stats** — team composition beats raw power
-   **Roguelike variance** — each run feels different based on what you find

### The Sleeve Innovation

Sleeves aren't just stat modifiers. They're **behavior modifiers**. A creature in different sleeves plays like a different creature entirely.

**Example: Fire Wolf**

-   Base stats: 8 ATK, 12 HP, Medium Speed
-   Base ability: "Flame Bite" — Deal damage, apply 1 Burn stack

| Sleeve    | How Fire Wolf Now Plays                               |
| --------- | ----------------------------------------------------- |
| Standard  | Straightforward damage dealer with burn               |
| Vampiric  | Aggressive sustain — heal 3 HP per hit                |
| Echo      | Attacks twice (4 ATK each), applies 2 Burn stacks     |
| Guardian  | Taunts enemies, burns attackers on contact            |
| Phantom   | Can't be targeted, sneaky burn applier                |
| Berserker | 12 ATK but loses 2 HP per turn — glass cannon         |
| Timeworn  | Starts weak, gains +2 ATK each turn it survives       |
| Sleeper   | Does nothing for 2 turns, then massive AoE fire burst |

One creature, eight completely different playstyles.

---

## The Sleeve System — Expanded

### Sleeve Rarity Tiers

| Tier          | Drop Rate | Power Level    | Example               |
| ------------- | --------- | -------------- | --------------------- |
| **Common**    | 60%       | Mild modifier  | Basic Sleeve (+1 ATK) |
| **Uncommon**  | 25%       | Notable change | Vampiric, Echo        |
| **Rare**      | 12%       | Build-defining | Phantom, Mirror       |
| **Legendary** | 3%        | Game-warping   | Cosmic, Awakened      |

### Complete Sleeve Catalog

#### 🟢 PRACTICAL — Core sleeves, essential for balance

**Offensive Sleeves**
| Sleeve | Effect | Design Notes |
|--------|--------|--------------|
| **Berserker** | +50% damage, take 2 damage/turn | High risk, high reward |
| **Predator** | +25% damage vs wounded enemies | Execution synergy |
| **Relentless** | Attacks ignore 50% of enemy armor | Tank buster |
| **Charged** | First attack each battle deals double | Opener sleeve |
| **Frenzy** | Gain +1 ATK each time this creature attacks | Snowball potential |

**Defensive Sleeves**
| Sleeve | Effect | Design Notes |
|--------|--------|--------------|
| **Guardian** | Taunt — enemies must target this creature | Classic tank role |
| **Fortified** | +50% HP, -25% ATK | Stat trade |
| **Regenerating** | Heal 2 HP at end of each turn | Sustain |
| **Evasive** | 25% chance to dodge attacks | RNG defensive |
| **Reflective** | Return 25% of damage taken to attacker | Punish aggression |

**Utility Sleeves**
| Sleeve | Effect | Design Notes |
|--------|--------|--------------|
| **Vampiric** | Heal equal to 30% of damage dealt | Sustain through offense |
| **Echo** | Act twice at 50% power | Double triggers, half stats |
| **Toxic** | All attacks apply Poison (2/turn for 3 turns) | DoT specialist |
| **Stunning** | 20% chance attacks stun for 1 turn | Crowd control |
| **Swift** | Always acts first in turn order | Priority control |

**Support Sleeves**
| Sleeve | Effect | Design Notes |
|--------|--------|--------------|
| **Inspiring** | Adjacent creatures gain +2 ATK | Positioning matters |
| **Shielding** | Grant 3 Shield to a random ally each turn | Passive protection |
| **Energizing** | When played, draw 1 card | Cycle/tempo |
| **Mentor** | Other creatures gain +1 to all stats permanently when this dies | Sacrifice value |

#### 🟡 EXPERIMENTAL — Interesting but need testing

**Conditional Sleeves**
| Sleeve | Effect | Risk Level |
|--------|--------|------------|
| **Desperate** | Triple stats when below 25% HP | High — requires near-death |
| **Timeworn** | +3 ATK/+3 HP each turn it stays in play | Medium — slow but powerful |
| **Sleeper** | Skip 2 turns, then deal 5x damage attack | High — tempo loss |
| **Underdog** | +100% stats if your deck has fewer cards than enemy | Situational |
| **Glutton** | Gains stats of defeated enemies | Snowball, maybe OP |

**Weird Sleeves**
| Sleeve | Effect | Risk Level |
|--------|--------|------------|
| **Mirror** | Copy the last enemy action | Medium — reactive play |
| **Phantom** | Cannot be targeted, -30% damage dealt | Low — safe but slow |
| **Chaos** | Random effect each turn (from pool of 10) | High — fun but swingy |
| **Symbiotic** | Shares HP pool with another random creature | Medium — interesting risk |
| **Copycat** | Becomes a copy of the last creature played | High — complex |

#### 🔴 WILD — Probably broken, but fun to try

**Legendary Sleeves**
| Sleeve | Effect | Notes |
|--------|--------|-------|
| **Cosmic** | Creature gains an entirely new, powerful ability | Unique per creature |
| **Awakened** | Creature evolves into its final form permanently | One-time mega buff |
| **Void** | Creature can't die but is removed after 3 turns | Invincible window |
| **Temporal** | Acts at the start AND end of each turn | Double turns |
| **Sovereign** | Other sleeves on your team have +50% effect | Sleeve synergy master |
| **Primal** | Remove all sleeves from all creatures; this one gets +10 all stats | Anti-sleeve tech |

**Cursed Sleeves** (Powerful but dangerous)
| Sleeve | Effect | Curse |
|--------|--------|-------|
| **Bloodbound** | +100% all stats | Lose 5 HP per turn (player HP) |
| **Doomed** | Start with 50 ATK | Dies in 3 turns guaranteed |
| **Parasitic** | Absorbs stats from your other creatures | Cannibalizes team |
| **Corrupted** | Huge stats but... | 10% chance to attack your own team |

### Sleeve Crafting System 🟡 EXPERIMENTAL

**Concept:** Combine two sleeves to create a hybrid.

| Sleeve 1 | Sleeve 2   | Result        | Effect                                         |
| -------- | ---------- | ------------- | ---------------------------------------------- |
| Vampiric | Berserker  | **Bloodlust** | Heal on hit, but damage scales with missing HP |
| Echo     | Toxic      | **Pandemic**  | Double attacks, double poison stacks           |
| Guardian | Reflective | **Martyr**    | Taunt + return 50% damage                      |
| Swift    | Charged    | **Ambush**    | Always first, first hit crits                  |

**Implementation Notes:**

-   Could be a mid-run event ("The Sleeve Weaver")
-   Alternatively, unlock recipes through meta-progression
-   Risk: Combinatorial explosion if every pair works
-   Solution: Curated list of ~20-30 valid combinations

### Sleeve Durability 🟡 EXPERIMENTAL

**Concept:** Some sleeves wear out, adding resource management.

-   **Permanent Sleeves:** Common/Uncommon — always available
-   **Consumable Sleeves:** Rare/Legendary — 3-5 uses per run
-   **Charges refill** at rest sites or via specific events

**Pros:** Adds decision-making, prevents always using best sleeves
**Cons:** Feels bad to "waste" rare sleeves, complexity creep

**Verdict:** Test in prototype, may cut if unfun

---

## Creature Design Bible

### Design Pillars

1. **Readable Silhouettes** — Each creature identifiable at card size
2. **Clear Element/Type** — Color coding for quick recognition
3. **Personality in Pose** — Static art should convey behavior
4. **Sleeve Compatibility** — Design abilities that interact interestingly with sleeves

### Element System

| Element     | Strong Against | Weak Against     | Thematic               |
| ----------- | -------------- | ---------------- | ---------------------- |
| 🔥 Fire     | Nature, Ice    | Water, Earth     | Aggressive, burn DoT   |
| 💧 Water    | Fire, Earth    | Nature, Electric | Flexible, healing      |
| 🌿 Nature   | Water, Earth   | Fire, Ice        | Growth, buffs          |
| ⚡ Electric | Water, Metal   | Earth, Nature    | Speed, chain damage    |
| 🪨 Earth    | Electric, Fire | Water, Nature    | Tanky, slow            |
| ❄️ Ice      | Nature, Water  | Fire, Metal      | Control, freeze        |
| ⚙️ Metal    | Ice, Nature    | Electric, Fire   | Armor, constructs      |
| 👻 Spirit   | Spirit, Metal  | Spirit, —        | Weird effects, untyped |

### Creature Roster (50 Creatures)

#### 🔥 Fire Creatures (6)

| Name                  | Stats      | Ability                          | Sleeve Synergies                       |
| --------------------- | ---------- | -------------------------------- | -------------------------------------- |
| **Ember Pup**         | 5/8/Fast   | Flame Nip: 5 damage, 1 Burn      | Starter creature, scales with Frenzy   |
| **Fire Wolf**         | 8/12/Med   | Flame Bite: 7 damage, 2 Burn     | Vampiric makes it self-sustaining      |
| **Inferno Drake**     | 12/15/Slow | Blaze Breath: 10 AoE damage      | Guardian + Reflective = untouchable    |
| **Ash Wisp**          | 4/4/Fast   | Combustion: Dies to deal 15 AoE  | Desperate makes it a bomb              |
| **Magma Tortoise**    | 6/25/Slow  | Heat Shell: 50% damage reduction | Already tanky, Regenerating = immortal |
| **Phoenix Hatchling** | 7/10/Med   | Rebirth: Revive once at 50% HP   | Legendary synergy — stacks with Void   |

#### 💧 Water Creatures (6)

| Name               | Stats     | Ability                           | Sleeve Synergies                       |
| ------------------ | --------- | --------------------------------- | -------------------------------------- |
| **Puddle Frog**    | 4/6/Fast  | Splash: 4 damage, heal 2          | Starter option, good with Echo         |
| **Tide Serpent**   | 9/14/Med  | Tidal Wave: 8 damage, push back   | Relentless ignores pushed armor        |
| **Abyssal Angler** | 7/10/Slow | Lure: Force enemy to attack this  | Already has taunt, Vampiric = immortal |
| **Coral Crab**     | 5/20/Slow | Harden: Gain 5 Shield             | Fortified + this = 30 HP wall          |
| **Mist Spirit**    | 6/8/Fast  | Fog: All creatures have 20% dodge | Evasive stacks to 45%                  |
| **Depth Lurker**   | 11/12/Med | Pressure: Bonus damage vs wounded | Predator sleeve = execution machine    |

#### 🌿 Nature Creatures (6)

| Name                | Stats     | Ability                               | Sleeve Synergies                  |
| ------------------- | --------- | ------------------------------------- | --------------------------------- |
| **Sprout**          | 3/5/Fast  | Grow: Gain +1/+1 each turn            | Timeworn makes it scale 2x        |
| **Thornback**       | 6/14/Med  | Thorns: Deal 3 to attackers           | Reflective = 6 damage return      |
| **Elder Treant**    | 8/22/Slow | Root: Immobilize one enemy            | Guardian makes sense thematically |
| **Pollen Moth**     | 5/6/Fast  | Spore Cloud: Poison all enemies       | Toxic + Echo = mass poison        |
| **Bloom Fairy**     | 4/7/Med   | Heal: Restore 5 HP to one ally        | Inspiring + support build         |
| **Fungal Shambler** | 7/16/Slow | Decompose: Stronger per dead creature | Mentor synergy (deaths matter)    |

#### ⚡ Electric Creatures (6)

| Name                    | Stats      | Ability                                | Sleeve Synergies                 |
| ----------------------- | ---------- | -------------------------------------- | -------------------------------- |
| **Spark Mouse**         | 4/5/VFast  | Zap: 4 damage, chain to adjacent       | Swift means always first         |
| **Storm Hawk**          | 8/9/Fast   | Divebolt: 10 damage, take 3 recoil     | Vampiric offsets recoil          |
| **Thunder Ox**          | 10/18/Slow | Charge: Next attack deals +50%         | Charged sleeve = permanent buff  |
| **Static Eel**          | 6/10/Med   | Discharge: AoE 5 when hit              | Reflective + natural counter     |
| **Lightning Elemental** | 9/8/Fast   | Overload: Triple damage, die after     | Void sleeve = 3 turns of this    |
| **Volt Specter**        | 7/7/VFast  | Phase: 50% dodge, shock dodged attacks | Evasive + Phantom = untargetable |

#### 🪨 Earth Creatures (6)

| Name                | Stats       | Ability                            | Sleeve Synergies                   |
| ------------------- | ----------- | ---------------------------------- | ---------------------------------- |
| **Pebble Golem**    | 5/15/Slow   | Sturdy: Reduce damage by 2         | Fortified makes it a wall          |
| **Sandstorm Djinn** | 7/12/Med    | Blind: Enemies have 25% miss       | Stacks with Stunning               |
| **Crystal Beetle**  | 6/10/Med    | Refract: Reflect status effects    | Mirror + this = no debuffs stick   |
| **Quake Mole**      | 8/14/Slow   | Burrow: Untargetable for 1 turn    | Natural Phantom                    |
| **Boulder Titan**   | 12/30/VSlow | Seismic Slam: 15 damage, stun self | Devastating but needs support      |
| **Gem Wyrm**        | 9/16/Med    | Treasure: Bonus gold on kill       | Economy creature, any sleeve works |

#### ❄️ Ice Creatures (6)

| Name                  | Stats      | Ability                              | Sleeve Synergies                  |
| --------------------- | ---------- | ------------------------------------ | --------------------------------- |
| **Frost Sprite**      | 4/6/Fast   | Chill: Slow enemy by 1 tier          | Swift + control                   |
| **Ice Wolf**          | 8/11/Med   | Frozen Fang: 8 damage, freeze 20%    | Stunning = more control           |
| **Glacier Bear**      | 10/20/Slow | Avalanche: AoE 8, push all           | Guardian protects while pushing   |
| **Snowdrift**         | 5/5/Fast   | Blizzard: All enemies lose speed     | Stacks with Frost Sprite          |
| **Icicle Wraith**     | 9/9/Med    | Shatter: Bonus damage to frozen      | Predator + freeze synergy         |
| **Permafrost Dragon** | 14/25/Slow | Absolute Zero: Freeze all for 1 turn | Boss killer, any offensive sleeve |

#### ⚙️ Metal Creatures (6)

| Name               | Stats     | Ability                             | Sleeve Synergies             |
| ------------------ | --------- | ----------------------------------- | ---------------------------- |
| **Gear Sprite**    | 4/8/Med   | Repair: Heal 3 to ally              | Inspiring support build      |
| **Iron Hound**     | 7/12/Med  | Shred: Remove enemy Shield          | Relentless anti-tank         |
| **Steel Sentinel** | 6/18/Slow | Armor Up: Gain 5 Shield/turn        | Regenerating = immortal wall |
| **Scrap Swarm**    | 5/6/Fast  | Split: Summon copy when hit         | Echo creates 2 copies        |
| **Chrome Dragon**  | 11/14/Med | Metal Storm: 10 damage to all       | Berserker for raw power      |
| **Construct King** | 9/20/Slow | Command: All Metal creatures +3 ATK | Tribal synergy piece         |

#### 👻 Spirit Creatures (8)

| Name                  | Stats       | Ability                            | Sleeve Synergies               |
| --------------------- | ----------- | ---------------------------------- | ------------------------------ |
| **Will-o-Wisp**       | 3/4/VFast   | Flicker: 30% dodge, curse attacker | Phantom stacks                 |
| **Shade**             | 6/8/Fast    | Haunt: Copy random enemy ability   | Mirror makes it double copy    |
| **Poltergeist**       | 7/10/Med    | Possession: Control enemy 1 turn   | Chaos sleeve for maximum chaos |
| **Banshee**           | 8/6/Fast    | Wail: Fear all enemies (-ATK)      | Debuff specialist              |
| **Reaper Specter**    | 10/10/Med   | Execute: Kill enemy below 20% HP   | Predator + Execution build     |
| **Ethereal Guardian** | 5/15/Slow   | Phase Shield: 50% magic resist     | Unusual tank                   |
| **Nightmare**         | 9/9/Med     | Terror: Disable enemy ability      | Control build                  |
| **Void Entity**       | ???/???/??? | Anomaly: Stats change each turn    | Pure chaos, Chaos sleeve fits  |

### Evolution System 🟢 PRACTICAL

Some creatures evolve mid-run:

| Base         | Evolution         | Trigger                    |
| ------------ | ----------------- | -------------------------- |
| Ember Pup    | Fire Wolf         | Deal 50 total Burn damage  |
| Puddle Frog  | Tide Serpent      | Heal 30 total HP           |
| Sprout       | Elder Treant      | Survive 10 turns           |
| Spark Mouse  | Storm Hawk        | Get 5 kills                |
| Pebble Golem | Boulder Titan     | Take 50 damage and survive |
| Frost Sprite | Permafrost Dragon | Freeze 10 enemies          |

**Design Notes:**

-   Evolutions are optional — some strategies prefer base form
-   Evolved creatures can't devolve
-   Some sleeves prevent evolution (balance lever)

### Creature Relationships 🟡 EXPERIMENTAL

**Concept:** Certain creature pairs have special synergies.

| Pair                               | Bonus                                         |
| ---------------------------------- | --------------------------------------------- |
| Fire Wolf + Ice Wolf               | "Thermal Shock" — +25% damage each            |
| Elder Treant + Bloom Fairy         | "Forest Bond" — Fairy heals are doubled       |
| Storm Hawk + Chrome Dragon         | "Lightning Rod" — Share electric damage       |
| Reaper Specter + Phoenix Hatchling | "Death Defied" — Phoenix gives Specter revive |

**Implementation Notes:**

-   Visual indicator when bonded creatures are in deck
-   Could be discovery-based (hidden until triggered)
-   Risk: Too complex to track mentally

---

## Battle System

### Turn Structure

```
┌─────────────────────────────────────────────────────────────┐
│                      TURN START                              │
├─────────────────────────────────────────────────────────────┤
│  1. Start-of-turn effects trigger (Regenerating, Timeworn)  │
│  2. Draw cards (default: 3)                                  │
│  3. Gain Energy (default: 3)                                 │
├─────────────────────────────────────────────────────────────┤
│                      PLAYER PHASE                            │
├─────────────────────────────────────────────────────────────┤
│  - Play creature cards (costs Energy based on creature)      │
│  - Creatures on field attack automatically OR               │
│  - Activate creature abilities (some cost additional Energy) │
│  - Use items if any                                          │
│  - End turn when ready                                       │
├─────────────────────────────────────────────────────────────┤
│                      ENEMY PHASE                             │
├─────────────────────────────────────────────────────────────┤
│  - Enemies act in speed order                                │
│  - Target selection based on AI (or random)                  │
│  - Effects resolve                                           │
├─────────────────────────────────────────────────────────────┤
│                      TURN END                                │
├─────────────────────────────────────────────────────────────┤
│  - End-of-turn effects (Burn, Poison, Temporal sleeve)       │
│  - Dead creatures removed                                    │
│  - Check win/lose conditions                                 │
└─────────────────────────────────────────────────────────────┘
```

### Energy System 🟢 PRACTICAL

-   Start each turn with **3 Energy** (upgradeable)
-   Creatures cost Energy to play:
    -   Common: 1 Energy
    -   Uncommon: 2 Energy
    -   Rare: 3 Energy
    -   Legendary: 4 Energy
-   Some abilities cost additional Energy to activate
-   Unspent Energy does NOT carry over (use it or lose it)

### Field Limits

-   **Active Creatures:** Max 4 on your side at once
-   **Bench:** Creatures in hand but not played
-   Playing a 5th creature requires sacrificing one already in play

### Targeting & Positioning 🟡 EXPERIMENTAL

**Option A: Simple (Recommended)**

-   No positioning
-   Creatures attack "the enemy team"
-   Single-target abilities auto-target or player chooses

**Option B: Row-Based**

-   Front row (2 slots) and Back row (2 slots)
-   Front row takes hits first
-   Back row has damage reduction but can't taunt
-   Adds tactical depth but complexity

**Option C: Full Grid**

-   2x3 or 3x3 grid
-   Positioning matters for AoE, adjacency
-   Significant complexity increase
-   Maybe save for sequel

**Verdict:** Start with Option A, playtest Option B

### Status Effects

| Status       | Effect                 | Stacks?      | Duration         |
| ------------ | ---------------------- | ------------ | ---------------- |
| **Burn**     | Take 2 damage/turn     | Yes (max 5)  | Until cured      |
| **Poison**   | Take 1 damage/turn     | Yes (max 10) | Until cured      |
| **Freeze**   | Skip next action       | No           | 1 turn           |
| **Stun**     | Skip next action       | No           | 1 turn           |
| **Slow**     | Act last in turn order | No           | 1 turn           |
| **Shield**   | Absorbs damage         | Yes          | Until broken     |
| **Regen**    | Heal 2 HP/turn         | No           | 3 turns          |
| **Strength** | +50% damage            | No           | 2 turns          |
| **Weakness** | -50% damage            | No           | 2 turns          |
| **Fear**     | -50% ATK               | No           | 2 turns          |
| **Taunt**    | Enemies must target    | No           | Until removed    |
| **Stealth**  | Cannot be targeted     | No           | Until you attack |

### Combat Math

**Damage Formula (Simple):**

```
Final Damage = (ATK × Sleeve Modifier) - Enemy Armor
```

**With full modifiers:**

```
Base = ATK × Sleeve ATK Modifier
Type Bonus = ×1.5 if strong, ×0.75 if weak
Status = ×1.5 if Strength, ×0.5 if Weakness
Final = Base × Type × Status - (Armor + Shield)
```

---

## Run Structure & Progression

### Map System (Slay the Spire Style)

```
                    👑 FINAL BOSS
                       /    \
                     💀      💀
                    /  \    /  \
                  ⚔️   ❓  🛒   ⚔️
                 /  \   |   |   /  \
               ⚔️  🏕️  ❓  ❓  ⚔️  🛒
              /  \   \   |   |   /
            START  START  START  START
```

### Node Types

| Node        | Icon | Description                              |
| ----------- | ---- | ---------------------------------------- |
| **Combat**  | ⚔️   | Fight 2-4 enemy creatures, earn rewards  |
| **Elite**   | 💀   | Harder fight, better rewards + sleeve    |
| **Boss**    | 👑   | End of act, major rewards                |
| **Shop**    | 🛒   | Buy/sell creatures, sleeves, items       |
| **Rest**    | 🏕️   | Heal 30% HP or upgrade a creature/sleeve |
| **Mystery** | ❓   | Random event (see Events section)        |
| **Capture** | 🥅   | Weakened wild creature, try to catch     |

### Act Structure

**Act 1: The Wilds**

-   12-15 nodes
-   Basic enemies, introduce mechanics
-   Boss: **Pack Alpha** (single strong creature)

**Act 2: The Trials**

-   12-15 nodes
-   Tougher enemies, more elites
-   Boss: **Twin Tamers** (two enemies who synergize)

**Act 3: The Sanctum**

-   12-15 nodes
-   Endgame enemies, brutal elites
-   Boss: **Collector Prime** (your mirror — uses creatures and sleeves)

**Act 4 (Optional/Unlockable): The Void**

-   5 nodes, no shops or rests
-   Boss: **The Unsleeved** — a creature so powerful it destroyed its sleeve

### Run Length

-   **Target:** 45-60 minutes per run
-   ~12 combats + 3 elites + 3 bosses
-   Pacing: Tension builds through acts

### Rewards System

| Source      | Possible Rewards                              |
| ----------- | --------------------------------------------- |
| **Combat**  | Gold, 1 creature OR 1 sleeve (player picks)   |
| **Elite**   | Gold, 1 creature AND 1 sleeve, rare chance    |
| **Boss**    | Rare creature, Rare sleeve, Relic (see below) |
| **Capture** | Specific creature based on encounter          |

### Relics 🟢 PRACTICAL

Passive bonuses that last the entire run.

| Relic                    | Effect                                               | Rarity   |
| ------------------------ | ---------------------------------------------------- | -------- |
| **Lucky Clover**         | +10% rare drop chance                                | Common   |
| **Extra Pocket**         | +1 starting Energy                                   | Common   |
| **Thick Sleeves**        | All sleeves have +1 use if consumable                | Uncommon |
| **Bonding Amulet**       | Creature relationships always active                 | Uncommon |
| **Golden Sleeve**        | One random creature starts Legendary sleeved         | Rare     |
| **Mirror Shard**         | Start each combat with a copy of your first creature | Rare     |
| **Void Heart**           | Can't heal, but +50% damage                          | Boss     |
| **The Collector's Tome** | Creatures cost 1 less Energy                         | Boss     |

---

## Meta-Progression

### Unlock System

**Creatures Unlocked By:**

-   Reaching Act 2 (unlock batch 2)
-   Reaching Act 3 (unlock batch 3)
-   Beating the game (unlock batch 4)
-   Specific achievements (unlock legendaries)

**Sleeves Unlocked By:**

-   Using sleeve X times (unlock upgrade)
-   Specific combos (unlock crafted sleeves)
-   Boss kills (unlock boss sleeves)

### Achievement-Based Unlocks

| Achievement                  | Unlock                                     |
| ---------------------------- | ------------------------------------------ |
| Win a run                    | Void Entity (creature)                     |
| Win with only Fire creatures | Inferno Sleeve                             |
| Win using no Rare sleeves    | Purist Sleeve (+stats, can't use rare+)    |
| Beat Act 4                   | Cosmic Sleeve                              |
| Win in under 30 minutes      | Speedster Sleeve (all creatures +1 Speed)  |
| Have 10+ creatures at once   | Swarm Sleeve (weaker but +1 max creatures) |

### Starter Deck Options

Unlock new starting options:

| Starter           | Starting Creatures       | Starting Sleeve |
| ----------------- | ------------------------ | --------------- |
| **Flame Heart**   | Ember Pup, Ash Wisp      | Berserker       |
| **Tidecaller**    | Puddle Frog, Coral Crab  | Regenerating    |
| **Overgrowth**    | Sprout, Pollen Moth      | Timeworn        |
| **Thunderstruck** | Spark Mouse, Static Eel  | Swift           |
| **Stonehide**     | Pebble Golem, Quake Mole | Fortified       |
| **Frost Warden**  | Frost Sprite, Snowdrift  | Guardian        |
| **Iron Legion**   | Gear Sprite, Iron Hound  | Inspiring       |
| **Spirit Walker** | Will-o-Wisp, Shade       | Phantom         |

### Collection & Codex

-   **Creature Codex:** Lore entries, stats, art viewer
-   **Sleeve Gallery:** All discovered sleeves, usage stats
-   **Combo Log:** Discovered creature + sleeve synergies
-   **Run History:** Stats from past runs
-   **Achievements:** Tracking and rewards

---

## Boss Encounters

### Design Philosophy

Bosses should:

-   Test specific mechanics (not just "big stats")
-   Be memorable encounters
-   Have phases that change the fight
-   Reward smart deckbuilding

### Boss Roster

#### Act 1: Pack Alpha

**Theme:** Raw aggression, tests basic combat understanding

| Phase            | HP  | Behavior                                 |
| ---------------- | --- | ---------------------------------------- |
| Phase 1          | 60  | Summons 2 Wolf Minions, attacks randomly |
| Phase 2 (50% HP) | —   | Enrages: +50% damage, attacks twice      |

**Counter:** Bring defensive sleeves, kill minions first

---

#### Act 2: The Twin Tamers

**Theme:** Synergy, tests your ability to handle multiple threats

| Enemy               | HP     | Behavior                               |
| ------------------- | ------ | -------------------------------------- |
| **Tamer Kira**      | 45     | Buffs creatures, heals partner         |
| **Tamer Kade**      | 45     | Direct damage, debuffs your creatures  |
| **Their Creatures** | Varies | 1 creature each, share a sleeve effect |

**Mechanic:** If one Tamer dies, the other enrages.
**Counter:** Burn them down evenly, or have an execute ready

---

#### Act 3: Collector Prime

**Theme:** Mirror match, tests your understanding of sleeves

| Phase   | Behavior                                           |
| ------- | -------------------------------------------------- |
| Phase 1 | Uses 3 random creatures YOU'VE captured this run   |
| Phase 2 | Those creatures now have Legendary sleeves         |
| Phase 3 | Summons "Primal Sleeve" — a sleeve creature itself |

**Counter:** Build a versatile deck; your strength is their strength

---

#### Act 4: The Unsleeved 🔴 WILD

**Theme:** Anti-sleeve, pure primal power

| Phase   | HP  | Behavior                                        |
| ------- | --- | ----------------------------------------------- |
| Phase 1 | 100 | Removes one sleeve from your creatures per turn |
| Phase 2 | —   | Absorbs removed sleeves, gains their effects    |
| Phase 3 | —   | Uses all absorbed effects simultaneously        |

**Counter:** Use creatures with strong base abilities, or sacrifice weak-sleeved creatures

---

### Elite Enemies

Elites are mini-bosses encountered on the map.

| Elite               | Gimmick                                         | Reward                  |
| ------------------- | ----------------------------------------------- | ----------------------- |
| **Sleeve Thief**    | Steals your sleeves, uses them against you      | Rare sleeve             |
| **Hoard Guardian**  | Summons endless weak creatures                  | 2 creatures             |
| **Elemental Nexus** | Changes element each turn, resist accordingly   | Element-specific sleeve |
| **The Collector**   | Offers a deal: take damage for rare reward      | Choice-based            |
| **Chrono Beast**    | Rewinds 1 turn if you kill it (must kill twice) | Temporal sleeve         |

---

## Events & Encounters

### Event Structure

Events are text-based encounters with choices.

```
┌──────────────────────────────────────────────────────┐
│  🎭 THE WANDERING MERCHANT                            │
├──────────────────────────────────────────────────────┤
│  A cloaked figure beckons from the roadside.         │
│  "I have something special... for a price."          │
│                                                       │
│  [A] Buy a random Legendary Sleeve (costs 80% gold)   │
│  [B] Trade a creature for a random creature           │
│  [C] Decline and leave                                │
└──────────────────────────────────────────────────────┘
```

### Event Catalog

#### Positive Events

| Event                | Options                                                       | Outcomes              |
| -------------------- | ------------------------------------------------------------- | --------------------- |
| **The Shrine**       | Pray (random buff) / Offer creature (guaranteed buff) / Leave | Buff lasts whole run  |
| **Wild Creature**    | Fight it / Try to catch it / Leave                            | Capture chance is 50% |
| **Sleeve Enchanter** | Upgrade sleeve / Fuse two sleeves / Leave                     | Quality of life       |
| **Creature Trainer** | Train creature (+5 stats) / Learn move / Leave                | Permanent improvement |
| **The Hot Spring**   | Rest (heal 20%) / Train (upgrade) / Both (costs gold)         | Choice                |

#### Risk Events

| Event                | Options                                                           | Outcomes                 |
| -------------------- | ----------------------------------------------------------------- | ------------------------ |
| **The Gambler**      | Bet gold (50/50 double or nothing) / Bet creature / Leave         | High risk                |
| **Cursed Sleeve**    | Take it (powerful but cursed) / Destroy it (small reward) / Leave | Risk/reward              |
| **The Mimic**        | Open chest (80% reward, 20% fight) / Leave                        | Standard risk            |
| **Dimensional Rift** | Enter (random Act change) / Ignore                                | Could skip ahead or back |

#### Negative Events (Rare)

| Event               | Effect                       | Mitigation           |
| ------------------- | ---------------------------- | -------------------- |
| **Creature Plague** | Lose a random creature       | Can pay gold to cure |
| **Sleeve Decay**    | A random sleeve loses a tier | Rare events only     |
| **Ambush**          | Forced hard fight            | Win = extra rewards  |

---

## Visual & Audio Direction

### Art Style Recommendation

**Primary:** Stylized 2D, flat colors with bold outlines

**References:**

-   Slay the Spire (card art style)
-   Pokémon TCG (creature readability)
-   Dicey Dungeons (clean, colorful)
-   Cassette Beasts (modern creature design)

**Why This Works:**

-   Fast to produce as solo dev
-   Scales well at card size
-   Distinctive and marketable
-   Allows personality despite simplicity

### Color Language

| Element  | Primary | Accent |
| -------- | ------- | ------ |
| Fire     | Orange  | Red    |
| Water    | Blue    | Cyan   |
| Nature   | Green   | Brown  |
| Electric | Yellow  | White  |
| Earth    | Brown   | Gray   |
| Ice      | Cyan    | White  |
| Metal    | Silver  | Gold   |
| Spirit   | Purple  | Black  |

**Sleeves:** Colored borders around cards

-   Common: Gray border
-   Uncommon: Blue border
-   Rare: Purple border
-   Legendary: Gold border with particles

### Audio Direction

**Music:**

-   Exploration: Ambient, mysterious
-   Combat: Energetic but not overwhelming
-   Boss: Intense, memorable themes
-   Victory: Triumphant jingle
-   Defeat: Somber but not punishing

**SFX Priority:**

-   Card draw (satisfying shuffle)
-   Card play (creature summoning)
-   Attack hit (element-specific)
-   Sleeve equip (magical "click")
-   Sleeve effect trigger (distinct per sleeve type)
-   Death (creature and enemy)
-   Level up / unlock (rewarding)

---

## UI/UX Considerations

### Core Screens

1. **Main Menu:** Play, Collection, Achievements, Options
2. **Run Start:** Choose starter deck, see unlocks
3. **Map:** Node selection, path planning
4. **Combat:** Hand, field, enemy field, energy, HP
5. **Rewards:** Card selection, sleeve selection
6. **Collection:** Creature codex, sleeve gallery

### Combat UI Layout

```
┌─────────────────────────────────────────────────────────────┐
│  Enemy HP: ████████░░  Enemy Creatures: [C][C][C]            │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│                    BATTLEFIELD                               │
│                                                              │
├─────────────────────────────────────────────────────────────┤
│  Your Creatures: [C][C][C][C]                                │
│  Energy: ⚡⚡⚡    HP: ████████████░░                         │
├─────────────────────────────────────────────────────────────┤
│  Hand: [Card][Card][Card][Card][Card]     [End Turn]         │
└─────────────────────────────────────────────────────────────┘
```

### Accessibility Features

-   **Colorblind modes:** Pattern overlays for elements/rarities
-   **Text scaling:** Adjustable card text size
-   **Speed options:** Combat animation speed slider
-   **Undo:** Take back last action (before enemy turn)
-   **Tooltips:** Hover for detailed explanations
-   **Keyboard navigation:** Full keyboard support

---

## Monetization & Platform Strategy

### Launch Strategy

**Platform:** Steam (PC only initially)
**Price:** $14.99 USD
**Launch window:** When vertical slice is polished

### Post-Launch Content (If Successful)

| Content                                              | Price | Timeline   |
| ---------------------------------------------------- | ----- | ---------- |
| **Expansion 1:** New creatures, sleeves, Act 4       | $4.99 | +6 months  |
| **Expansion 2:** New starter decks, challenge modes  | $4.99 | +12 months |
| **Cosmetic DLC:** Alternate card backs, sleeve skins | $2.99 | Ongoing    |

### Mobile Port Considerations 🟡 EXPERIMENTAL

-   Touch controls work well for card games
-   F2P with ads or premium ($4.99)?
-   If F2P: Cosmetic sleeves as IAP only (no gameplay advantage)
-   Separate consideration after PC success

---

## Development Roadmap

### Phase 1: Prototype (2-3 Months)

**Goal:** Answer "Is the core loop fun?"

**Deliverables:**

-   [ ] 10 creatures (2 per element, basic set)
-   [ ] 5 sleeves (Vampiric, Echo, Guardian, Berserker, Toxic)
-   [ ] Basic combat system
-   [ ] 1 act with 5 nodes
-   [ ] Placeholder art (shapes/colors)
-   [ ] No meta-progression yet

**Success Criteria:** Playtesters want to do "one more run"

### Phase 2: Vertical Slice (3-4 Months)

**Goal:** Prove the full game works

**Deliverables:**

-   [ ] 25 creatures with art
-   [ ] 15 sleeves
-   [ ] Full Act 1 + boss
-   [ ] Shop, rest, events
-   [ ] Basic meta-progression
-   [ ] Sound effects
-   [ ] Core UI polish

**Success Criteria:** Could be shown to press/streamers

### Phase 3: Content Complete (4-6 Months)

**Goal:** All content implemented

**Deliverables:**

-   [ ] 50 creatures
-   [ ] 30+ sleeves
-   [ ] All 3 acts + bosses
-   [ ] All events
-   [ ] Full meta-progression
-   [ ] Achievements
-   [ ] Music

**Success Criteria:** Game is "done" but unpolished

### Phase 4: Polish & Launch (2-3 Months)

**Goal:** Ship it

**Deliverables:**

-   [ ] Balance pass
-   [ ] Bug fixes
-   [ ] Accessibility features
-   [ ] Steam page, trailer, marketing
-   [ ] Localization (if budget allows)
-   [ ] Achievement integration

**Total Estimated Time: 12-18 months**

---

## Wild Ideas & Stretch Goals

### 🔴 Definitely Post-Launch

**Multiplayer PvP**

-   Async battles (submit deck, fight ghosts)
-   Real-time 1v1 (huge balance undertaking)
-   Draft mode (both players pick from same pool)

**Endless Mode**

-   Infinite scaling enemies
-   Leaderboards
-   Daily seeds

**Custom Sleeves**

-   Player-designed sleeves (balance nightmare)
-   Steam Workshop integration

### 🟡 Maybe If Time Allows

**Creature Fusion**

-   Sacrifice two creatures to create a hybrid
-   Inherits abilities/stats from both
-   Unique fusion art (big asset burden)

**Story Mode**

-   Linear campaign with narrative
-   Boss characters with dialogue
-   Cutscenes (scope explosion)

**Daily Challenges**

-   Fixed seed
-   Weird modifiers
-   Leaderboards

### 🟢 Actually Achievable Stretch Goals

**Challenge Modifiers (Ascension)**

-   Incrementing difficulty
-   Each level adds a new challenge
-   20 levels like Slay the Spire

**Alternate Game Modes**

-   Draft mode (pick from shared pool)
-   Sealed mode (random cards, build best deck)
-   Boss rush

**Cosmetics**

-   Alternate card backs
-   Sleeve visual variants
-   Card foils/holos

---

## Risk Analysis

### High Risk

| Risk                  | Likelihood | Impact | Mitigation                                      |
| --------------------- | ---------- | ------ | ----------------------------------------------- |
| Balance is impossible | Medium     | High   | Roguelike forgives imbalance; patch post-launch |
| Art takes too long    | High       | High   | Simple style, contract out if needed            |
| Market saturated      | Medium     | Medium | Sleeve hook differentiates                      |

### Medium Risk

| Risk                 | Likelihood | Impact | Mitigation                                             |
| -------------------- | ---------- | ------ | ------------------------------------------------------ |
| Scope creep          | High       | Medium | Strict phase gates, cut features early                 |
| Burnout              | Medium     | High   | Sustainable pace, breaks, playtesting keeps motivation |
| Poor discoverability | Medium     | Medium | Festival demos, streamer outreach                      |

### Low Risk

| Risk                      | Likelihood | Impact | Mitigation                                    |
| ------------------------- | ---------- | ------ | --------------------------------------------- |
| Technical issues          | Low        | Medium | Proven tech (Unity/Godot), no complex systems |
| Complete market rejection | Low        | High   | Validate with demo/prototype                  |

---

## Next Steps

1. **Decide on game engine** (Unity vs Godot)
2. **Create paper prototype** — test sleeve/creature combos manually
3. **Block out 10 creatures, 5 sleeves** in code
4. **Build combat loop** without art
5. **Playtest immediately** — is it fun?

---

## Appendix: Naming Ideas

**Game Title Options:**

-   Sleeve Masters
-   Creature Sleeves
-   Sleevebound
-   Card Creatures
-   Pocket Sleeves
-   Sleeve & Spell
-   The Sleeving
-   Sleeved Legends

**Tagline Options:**

-   "Same creature. Different sleeve. New strategy."
-   "Catch them. Sleeve them. Conquer."
-   "The sleeve makes the monster."

---

_Last Updated: January 2026_
_Status: Pre-production concept document_
