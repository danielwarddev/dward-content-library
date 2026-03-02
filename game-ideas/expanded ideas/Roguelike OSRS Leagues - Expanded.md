# Roguelike OSRS Leagues - Expanded Design Document

## Executive Summary

**Working Title:** _Runebound Gauntlet_ (placeholder)

**Core Hook:** A roguelike that captures the addictive "task hunting and build optimization" feel of OSRS Leagues, where each run presents a procedurally generated world with unique resources, challenges, and opportunities. Players choose powerful Relics that fundamentally change their playstyle, complete tasks to unlock more Relics, and try to optimize their 30-60 minute runs for maximum progression. Between runs, permanent unlocks expand the possibility space.

**Target Audience:**

-   Fans of OSRS Leagues who want that experience in bite-sized sessions
-   Roguelike enthusiasts who enjoy build-crafting (Vampire Survivors, Hades, Slay the Spire)
-   Players who like optimization puzzles (Forager, Melvor Idle, Loop Hero)
-   Age 16-35, comfortable with moderate complexity

**Elevator Pitch:** "Every run is a new Leagues season—procedural world, random Relics, 45 minutes to min-max your way to glory."

---

## Market Analysis

### Comparable Products

| Game                  | What It Does Well                              | Gap/Opportunity                                  |
| --------------------- | ---------------------------------------------- | ------------------------------------------------ |
| **OSRS Leagues**      | Task systems, Relic choices, build diversity   | Not standalone, requires massive time investment |
| **Vampire Survivors** | Quick runs, build synergies, meta progression  | Lacks depth in resource gathering/crafting       |
| **Loop Hero**         | Procedural world building, expedition planning | Passive combat, less direct player agency        |
| **Forager**           | Satisfying gather/craft loop, unlocks          | No run structure, becomes grindy long-term       |
| **Melvor Idle**       | OSRS-like skilling, offline progress           | Fully idle, no active decision-making            |
| **Hades**             | Tight runs, excellent meta-progression         | Combat-focused, no gathering/skilling            |

### Market Gap Identified

No game currently combines:

1. OSRS-style skilling/gathering as core gameplay
2. Roguelike run structure (30-60 min sessions)
3. Leagues-style Relic system for radical build diversity
4. Procedural worlds that demand adaptation
5. Meaningful meta-progression

### Recent Successes in Adjacent Space

-   **Backpack Battles** (2024): Autobattler with build crafting
-   **Brotato** (2022): Quick runs, build synergy focus
-   **Dome Keeper** (2022): Mining + defense, session-based

---

## Core Mechanics/Features

### 1. Run Structure

Each run follows this flow:

```
World Generation → Starting Choices → Gather/Skill/Task Loop → Boss/Goal → Run End → Meta Rewards
```

**Run Length Target:** 30-60 minutes (tunable via settings or run type)

**Victory Conditions:**

-   Complete the World Goal (defeat final boss, gather X artifact pieces, etc.)
-   Goals vary by world seed and chosen difficulty

**Failure Conditions:**

-   Death (health depleted)
-   Time limit exceeded (optional hardcore mode)
-   Starvation/resource depletion

### 2. World Generation

Each run generates a unique world with:

| Element                   | Variation Examples                                                      |
| ------------------------- | ----------------------------------------------------------------------- |
| **Biomes**                | Forest, Desert, Tundra, Swamp, Volcanic, Crystal Caves                  |
| **Resource Distribution** | Ore-rich but tree-scarce, fish-abundant coastal, balanced inland        |
| **Threats**               | Monster density, environmental hazards, rival NPC factions              |
| **Special Locations**     | Shrines (grant Relics), Dungeons (high risk/reward), Villages (trading) |
| **World Modifiers**       | "Eternal Night," "Abundant Herbs," "Aggressive Fauna"                   |

**Key Design Principle:** The world you get should heavily influence optimal strategy. An ore-rich world favors Smithing builds; a monster-dense world favors Combat.

### 3. Skills System

Inspired by OSRS but streamlined for roguelike pacing:

| Skill Category | Skills                                 | Primary Function                          |
| -------------- | -------------------------------------- | ----------------------------------------- |
| **Gathering**  | Mining, Woodcutting, Fishing, Foraging | Collect raw resources                     |
| **Processing** | Smithing, Cooking, Crafting, Alchemy   | Transform resources into usable items     |
| **Combat**     | Melee, Ranged, Magic                   | Fight monsters, clear dungeons            |
| **Utility**    | Agility, Thieving, Exploration         | Access shortcuts, steal items, reveal map |

**Leveling:** Skills level through use (simplified XP curve for run length). Higher levels unlock:

-   Better resource yields
-   Access to tier-locked resources/recipes
-   Passive bonuses
-   Relic synergies

### 4. Relic System (Core Feature)

Relics are powerful, build-defining bonuses chosen at key moments:

**Acquisition:**

-   Start of run: Choose 1 from 3 random Relics (from unlocked pool)
-   Shrines: Found in world, offer Relic choices
-   Task completion milestones (every X tasks)
-   Boss drops

**Relic Tiers:**

| Tier          | Power Level    | Example                                              |
| ------------- | -------------- | ---------------------------------------------------- |
| **Minor**     | Small boost    | "+15% Mining speed"                                  |
| **Major**     | Build-enabling | "Ore veins never deplete"                            |
| **Legendary** | Game-changing  | "All gathered resources are automatically processed" |

**Relic Examples:**

| Relic Name              | Effect                                       | Synergy Potential                         |
| ----------------------- | -------------------------------------------- | ----------------------------------------- |
| _Prospector's Instinct_ | Ore veins visible through walls              | Pairs with Mining speed relics            |
| _Chain Harvest_         | 20% chance gathering triggers adjacent nodes | Density-dependent, amazing in rich biomes |
| _Alchemist's Touch_     | Potions have double effect and duration      | Alchemy + Combat builds                   |
| _Berserker's Hunger_    | +50% damage, but must eat twice as often     | Risk/reward, needs food supply            |
| _Artisan's Efficiency_  | Processing uses 50% fewer resources          | Stretch limited resources further         |
| _Echo of Action_        | 10% chance any action repeats free           | Universal value, scales with fast actions |
| _Minimalist_            | +100% XP gain, can only equip 3 items        | Extreme specialization                    |
| _Polymath_              | -30% XP gain, but all skills train together  | Generalist builds                         |

**Design Goal:** No single "best" Relic. World conditions, other Relics, and playstyle should all factor into choices.

### 5. Task System

Tasks provide direction and reward engagement:

**Task Types:**

| Category        | Examples                                                               |
| --------------- | ---------------------------------------------------------------------- |
| **Gathering**   | "Mine 50 Iron Ore," "Catch 10 Rare Fish"                               |
| **Processing**  | "Smith a Steel Sword," "Cook 20 Meals"                                 |
| **Combat**      | "Defeat 30 Goblins," "Clear a Dungeon"                                 |
| **Exploration** | "Discover 5 Shrines," "Map 80% of world"                               |
| **Challenge**   | "Reach Smithing 20 before Mining 10," "Win without eating cooked food" |

**Task Rewards:**

-   Relic unlock points
-   Immediate resources/items
-   Skill XP bonuses
-   Meta-currency for permanent unlocks

**Task Generation:** Seeded per world—players can see upcoming tasks and plan accordingly.

### 6. Starting Options

**Classes:** (Unlocked via meta-progression)

| Class          | Starting Bonus                      | Playstyle                  |
| -------------- | ----------------------------------- | -------------------------- |
| **Adventurer** | Balanced stats, no special bonuses  | Default, learn the game    |
| **Miner**      | +3 Mining, starts with pickaxe      | Resource gathering focus   |
| **Warrior**    | +3 Melee, starts with sword + armor | Combat-first approach      |
| **Artisan**    | +2 to all Processing skills         | Efficient crafting         |
| **Scavenger**  | +3 Thieving, starts with lockpicks  | High risk, steal from NPCs |
| **Naturalist** | +3 Foraging, reveals herb locations | Alchemy/potion builds      |

**Starting Traits:** (Choose 1-3 depending on difficulty)

| Trait           | Effect                                                 |
| --------------- | ------------------------------------------------------ |
| _Lucky_         | +10% chance for rare drops                             |
| _Hardy_         | +25% max health                                        |
| _Swift Learner_ | +15% XP gain for first 10 levels                       |
| _Night Owl_     | No penalties during night                              |
| _Green Thumb_   | Foraged items give double yield                        |
| _Haggler_       | 20% better shop prices                                 |
| _Cursed_        | Start with a random negative effect, +50% task rewards |

**Negative Traits:** (Optional, increase rewards)

-   _Glass Cannon:_ -50% health, +30% damage
-   _Clumsy:_ Fail 10% of actions, +20% XP
-   _Hunted:_ Elite enemies spawn more often, +25% drops

### 7. Combat System

Streamlined for roguelike pacing:

**Style:** Real-time with simple controls (or turn-based if preferred for development simplicity)

**Core Loop:**

1. Engage enemy (or be ambushed)
2. Use attacks, abilities, consumables
3. Enemies drop resources, sometimes Relics
4. Heal up, continue

**Combat Stats:**

-   Health, Damage, Defense, Speed
-   Derived from equipment + skill levels + Relics

**Enemy Variety:**

-   Common mobs (grinding)
-   Elites (mini-bosses, guard resources)
-   Dungeon bosses (major rewards)
-   World boss (run goal)

---

## Meta-Progression System

### Currencies

| Currency      | Earned From            | Spent On                       |
| ------------- | ---------------------- | ------------------------------ |
| **Renown**    | Completing runs, tasks | Unlock Classes, Traits, Relics |
| **Artifacts** | Rare drops, challenges | Cosmetics, quality-of-life     |

### Unlock Categories

1. **Classes:** New starting archetypes
2. **Traits:** More options at run start
3. **Relic Pool:** Add new Relics to the drop pool
4. **World Modifiers:** Unlock special world types
5. **Difficulty Modes:** Harder modes with better rewards
6. **Cosmetics:** Character skins, visual effects
7. **Quality of Life:** Recipe book, task tracker upgrades

### Progression Feel

-   First 5-10 hours: Rapidly unlocking core content
-   10-30 hours: Mastering systems, unlocking advanced options
-   30+ hours: Challenge modes, optimization, build experimentation

---

## Prototype MVP

### Minimum Viable Prototype Scope

**Included:**

-   1 biome type (Forest)
-   5 skills (Mining, Woodcutting, Smithing, Cooking, Melee)
-   3 resource tiers per gathering skill
-   10-15 Relics (mix of tiers)
-   15-20 tasks
-   5 enemy types + 1 boss
-   Basic procedural world generation
-   1 class, 3 starting traits
-   Simple meta-progression (unlock 2-3 things)

**Excluded from MVP:**

-   Multiple biomes
-   Full class roster
-   Extensive Relic pool
-   Polish, juice, audio
-   Saving mid-run

### Development Milestones

| Milestone                 | Description                                | Est. Time |
| ------------------------- | ------------------------------------------ | --------- |
| **M1: Core Loop**         | Move, gather, basic inventory              | 2-3 weeks |
| **M2: Skills & Crafting** | XP system, processing stations             | 2 weeks   |
| **M3: Relics**            | Relic selection, effect system             | 2 weeks   |
| **M4: Combat**            | Enemies, combat stats, death               | 2-3 weeks |
| **M5: Tasks**             | Task tracking, rewards                     | 1-2 weeks |
| **M6: World Gen**         | Procedural generation basics               | 2-3 weeks |
| **M7: Run Flow**          | Start screen, victory/defeat, meta rewards | 1-2 weeks |
| **M8: Polish Pass**       | UI, feedback, balance                      | 2-3 weeks |

**Total MVP Estimate:** 14-20 weeks (solo, part-time)

### Success Criteria

| Metric                 | Target                                        |
| ---------------------- | --------------------------------------------- |
| Run completion rate    | 20-40% (challenging but fair)                 |
| Average run length     | 35-50 minutes                                 |
| "One more run" moments | Players frequently start new runs immediately |
| Build diversity        | Testers try different Relic combos            |
| World adaptation       | Testers change strategy based on world        |

---

## Full Vision

If the prototype validates, the full game could include:

### Content Expansion

-   **8-10 Biomes** with unique resources, enemies, and challenges
-   **100+ Relics** with deep synergy potential
-   **8-10 Classes** with distinct playstyles
-   **30+ Traits** for run customization
-   **Boss Rush Mode:** Chain bosses, keep Relics between fights
-   **Daily/Weekly Challenges:** Seeded runs with leaderboards
-   **Endless Mode:** See how long you can survive

### Systems Expansion

-   **Relic Crafting:** Combine Relics for new effects
-   **Skill Mastery:** Permanent small bonuses per skill
-   **NPC Factions:** Reputation system, faction-specific rewards
-   **Base Building:** Permanent camp that provides run bonuses
-   **Multiplayer Co-op:** 2-4 player runs with shared Relics

### Quality of Life

-   **Run History:** Track stats, favorite builds
-   **Recipe/Task Codex:** Discovered recipes persist
-   **Accessibility Options:** Speed adjustments, colorblind modes
-   **Cloud Saves:** Cross-device progression

---

## Risks & Mitigations

| Risk                              | Likelihood | Impact | Mitigation                                                   |
| --------------------------------- | ---------- | ------ | ------------------------------------------------------------ |
| **Runs feel samey**               | Medium     | High   | Invest in world variety, Relic diversity, task randomization |
| **Balance nightmare**             | High       | Medium | Start with fewer Relics, add gradually with testing          |
| **Scope creep**                   | High       | High   | Strict MVP boundaries, cut features ruthlessly               |
| **Combat feels tacked-on**        | Medium     | Medium | Consider making combat optional for some builds              |
| **Procedural gen is boring**      | Medium     | High   | Study Loop Hero, ensure meaningful variation                 |
| **"No best build" is impossible** | Medium     | Medium | Accept soft meta, rotate with updates/seasons                |
| **Burnout (solo dev)**            | Medium     | High   | Set realistic milestones, take breaks, ship MVP early        |

---

## Feasibility Assessment

### Technical Considerations (Godot + C#)

| System               | Complexity  | Notes                                             |
| -------------------- | ----------- | ------------------------------------------------- |
| Procedural World Gen | Medium-High | Use established algorithms (BSP, noise-based)     |
| Skill/XP System      | Low         | Data-driven, straightforward                      |
| Relic Effects        | Medium      | Needs flexible modifier system                    |
| Inventory/Crafting   | Low-Medium  | Well-documented patterns exist                    |
| Combat               | Medium      | Real-time easier in Godot; turn-based also viable |
| Save System          | Low-Medium  | Meta-progression needs persistence                |
| UI                   | Medium      | Many screens, but standard components             |

### Resource Requirements

| Resource   | Requirement                                                                                          |
| ---------- | ---------------------------------------------------------------------------------------------------- |
| **Art**    | Pixel art tileset, character sprites, item icons. Could use asset packs initially, commission later. |
| **Audio**  | SFX library, ambient tracks. Low priority for MVP.                                                   |
| **Design** | Heavy upfront (this document), ongoing balance tuning.                                               |
| **Code**   | ~15-25k lines estimated for MVP.                                                                     |

### Realistic Timeline (Solo, Part-Time ~20hr/week)

| Phase                    | Duration        |
| ------------------------ | --------------- |
| Pre-production           | 2-4 weeks       |
| MVP Development          | 16-24 weeks     |
| MVP Testing/Polish       | 4-6 weeks       |
| **MVP Total**            | **~6-8 months** |
| Full Game (if validated) | +12-18 months   |

---

## Open Questions

1. **Combat Depth:** Real-time action, or simpler auto-combat with positioning? Could combat be optional for "pacifist" builds?

2. **Run Length Tuning:** Should short (20 min) and long (90 min) run modes exist, or one target length?

3. **Multiplayer Feasibility:** Is async co-op worth scoping? (Shared world, take turns running)

4. **Monetization:** Premium ($10-15), with optional cosmetic DLC? Early Access model?

5. **Relic Discovery:** Should all Relics be visible from start (choose not to unlock), or hidden until found?

6. **Difficulty Scaling:** Traditional difficulty levels, or Hades-style "Heat" system with modular modifiers?

7. **Mobile Port Potential:** Is touch-friendly UI worth considering from the start?

8. **Seasonal Content:** Post-launch leagues/seasons with new Relics and world modifiers?

---

## Next Steps

1. **Paper Prototype:** Test Relic combos and task flow on paper/spreadsheet
2. **Core Loop Prototype:** Movement, one skill, basic gathering in Godot
3. **Relic System Prototype:** Implement 5 Relics with varied effect types
4. **Playtest:** Get feedback on core loop before expanding

---

_Document Version: 1.0_
_Created: January 3, 2026_
