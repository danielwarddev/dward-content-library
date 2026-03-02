# One Way Heroics Map-Building Variant - Expanded Design Document

> **Last Updated:** January 2026  
> **Status:** Concept Expansion  
> **Working Title:** _Pathmaker_ (placeholder)

---

## Executive Summary

**Core Hook:** A roguelike where the world isn't just procedurally generated—you _choose_ it. Every few steps, you pick from map chunks that shape your journey. Do you take the dangerous dungeon for better loot, or the safe village to restock? You're not just surviving the Darkness; you're building the road ahead of it.

**Target Audience:**

-   Fans of One Way Heroics and Mystery Dungeon games
-   Players who enjoy strategic roguelikes (Slay the Spire, FTL, Into the Breach)
-   Those who like "build your own adventure" mechanics (Inscryption's map, Griftlands)
-   Roguelike veterans looking for fresh decision-making

**Elevator Pitch:** "Run from the Darkness. But you decide what you're running _into_."

---

## Market Analysis

### Comparable Products

| Game                | Strengths                                  | Weaknesses                           | Gap We Fill                               |
| ------------------- | ------------------------------------------ | ------------------------------------ | ----------------------------------------- |
| **One Way Heroics** | Unique auto-scroll, tension, replayability | Map is fully random, limited control | Player agency in map                      |
| **Slay the Spire**  | Brilliant path choice system               | No real-time pressure                | Combine path choice with survival tension |
| **FTL**             | Sector map choices, resource management    | Turn-based jumps, less immediate     | Real-time urgency                         |
| **Into the Breach** | Elegant tactics, small scope               | Grid battles, no exploration         | Exploration + choice                      |
| **Hades**           | Boon/path choices, smooth action           | Choices are rooms, not terrain       | Larger map chunks, more variety           |

### One Way Heroics Deep Dive

The original One Way Heroics excels at:

-   Constant left-to-right pressure (Darkness consumes the left)
-   Resource scarcity creating tough decisions
-   Persistent unlocks across runs
-   Short, replayable sessions

It could improve:

-   Map is fully random—sometimes you get lucky, sometimes screwed
-   Limited strategic planning—react to what's there
-   Sameness after many runs

**Our Value Add:** Turn luck into choice. Every map chunk is an opportunity cost. Bad RNG becomes "I made a risky choice."

### Path Choice Games Analysis

| Game               | Choice Type            | Feedback Timing        | Our Learning                |
| ------------------ | ---------------------- | ---------------------- | --------------------------- |
| **Slay the Spire** | Path nodes (3 options) | Immediate (enter room) | Simple choice UI works      |
| **FTL**            | Sector beacons         | Delayed (travel time)  | Preview info matters        |
| **Inscryption**    | Path cards             | Immediate              | Choices can be visual cards |
| **Griftlands**     | Day planning           | Delayed                | Long-term consequences      |

---

## Core Mechanics

### The Darkness & Forward Motion

Like One Way Heroics, the core pressure is:

-   **The Darkness** advances from the left side of the screen
-   You must keep moving right to survive
-   Getting caught = death (or heavy damage)
-   Creates constant tension and prevents stalling

**Pacing:**

-   Darkness speed increases as run progresses
-   Safe zones (towns, dungeons) temporarily halt Darkness
-   Boss encounters pause Darkness

### Map Building: The Core Innovation

Every time you reach the **edge of the current map chunk**, you're presented with **3 map chunk options**:

```
┌─────────────────────────────────────────────────────┐
│  DARKNESS →   [Current Area]   │   CHOOSE NEXT:    │
│                                │                    │
│               ▓▓▓▓▓▓▓▓▓        │  [1] Forest Path  │
│               ▓▓▓▓▓▓▓▓▓        │  [2] Goblin Camp  │
│               ▓▓▓▓▓▓▓▓▓        │  [3] Ruined Tower │
│                                │                    │
└─────────────────────────────────────────────────────┘
```

**Choice is made quickly** (10-15 seconds before auto-pick lowest difficulty) to maintain tension.

### Map Chunk Types

| Category       | Examples                       | Risk        | Reward                     |
| -------------- | ------------------------------ | ----------- | -------------------------- |
| **Safe Zones** | Village, Camp, Oasis           | Low         | Shop, healing, rest        |
| **Traversal**  | Forest, Plains, Road           | Low-Medium  | Basic loot, quick passage  |
| **Combat**     | Goblin Camp, Bandit Fort, Hive | Medium-High | Better loot, EXP           |
| **Dungeon**    | Ruins, Cave, Tower             | High        | Best loot, special items   |
| **Event**      | Shrine, Caravan, Merchant      | Variable    | Random outcomes            |
| **Boss**       | Lair, Fortress, Arena          | Very High   | Major rewards, progression |

### Risk/Reward Balancing

**Harder chunks should provide:**

1. Better loot inside the chunk
2. Bonus rewards upon completion (exit the chunk)
3. Cumulative "danger bonus" multiplier

| Difficulty | Loot Tier      | Completion Bonus     | Danger Multiplier |
| ---------- | -------------- | -------------------- | ----------------- |
| Easy       | Common         | None                 | ×1.0              |
| Medium     | Uncommon       | +Gold                | ×1.2              |
| Hard       | Rare           | +Gold, +Item         | ×1.5              |
| Deadly     | Epic/Legendary | +Gold, +Item, +Skill | ×2.0              |

**Cumulative Danger Bonus:**

-   Consecutive hard chunks build a multiplier
-   Taking an easy chunk resets the multiplier
-   Creates push-your-luck meta-game

### Long-Term Strategic Considerations

To encourage planning beyond immediate survival:

**Resource Chains:**

-   Some chunks provide resources, others consume them
-   Example: "Mine" provides ore → "Blacksmith Village" uses ore for weapons
-   Taking Mine without planning Blacksmith = wasted opportunity

**Quest Chains:**

-   Accept quest in Village A: "Clear the Goblin Camp ahead"
-   If you pick Goblin Camp later, get bonus rewards
-   If you pick Forest instead, quest fails

**Map Synergies:**

-   "Mushroom Forest" + "Witch's Hut" = special potion crafting
-   "Battlefield" + "Scavenger Camp" = extra loot from corpses
-   Encourages looking 2-3 chunks ahead

**Persistent Map Threats:**

-   Some chunks introduce lasting effects
-   "Cursed Graveyard" = undead spawn in future chunks
-   "Orc Warband" = orc enemies more common ahead
-   Player must weigh short-term vs. long-term

### Combat System: Real-Time with Cooldowns

**Core Design:**

-   Real-time movement and attacks
-   All abilities have cooldowns (no spam)
-   Positioning matters (flanking, terrain)
-   Simple enough for quick decisions, deep enough for mastery

**Controls:**

| Input     | Action            |
| --------- | ----------------- |
| Move      | Arrow keys / WASD |
| Attack    | Spacebar / Click  |
| Abilities | 1-4 keys          |
| Interact  | E key             |
| Inventory | Tab               |

**Combat Stats:**

| Stat     | Effect                    |
| -------- | ------------------------- |
| HP       | Health points             |
| Attack   | Base damage               |
| Defense  | Damage reduction          |
| Speed    | Movement and attack speed |
| Cooldown | Ability recharge rate     |

**Ability System:**

-   Start with 1-2 abilities based on class
-   Find/buy more abilities in chunks
-   Equip up to 4 active abilities
-   Passives are always active (separate slots)

### Class System

| Class        | Playstyle            | Starting Abilities  | Chunk Preferences |
| ------------ | -------------------- | ------------------- | ----------------- |
| **Warrior**  | Tanky, melee         | Slash, Shield Block | Combat chunks     |
| **Ranger**   | Ranged, mobile       | Arrow Shot, Dash    | Open terrain      |
| **Mage**     | High damage, fragile | Fireball, Teleport  | Event chunks      |
| **Rogue**    | Fast, burst damage   | Backstab, Stealth   | Dungeon chunks    |
| **Merchant** | Economy, items       | Appraise, Discount  | Safe zones        |
| **Wanderer** | Balanced, adaptable  | Random              | Versatile         |

### Chunk Completion Mechanics

Each chunk has:

1. **Entrance:** Where you come in
2. **Exit(s):** 1-2 exits leading to next choice
3. **Objective (optional):** Clear enemies, find treasure, talk to NPC
4. **Time Pressure:** Darkness continues (except safe zones)

**Chunk Size Variation:**

-   Small (30-60 seconds to cross)
-   Medium (1-2 minutes)
-   Large (2-4 minutes, dungeons)

---

## Visual & Audio Design

### Art Direction

**Style:** Retro or modern pixel art, lighthearted roguelike aesthetic

| Element             | Description                              |
| ------------------- | ---------------------------------------- |
| **Resolution**      | 320x180 or 400x225 base                  |
| **Color Palette**   | Warm, inviting with danger contrast      |
| **Character Style** | Cute/charming sprites, clear silhouettes |
| **Environment**     | Distinct biomes, readable terrain        |
| **UI**              | Clean, minimal, chunk choice prominent   |

**Tone:** Lighthearted Adventure

-   Death isn't tragic—characters shrug it off
-   Silly enemy designs (goblins wearing pots as helmets)
-   Upbeat music even in danger
-   Success feels triumphant, failure feels "one more run"

### Visual References

-   **One Way Heroics** - UI layout, Darkness effect
-   **Cadence of Hyrule** - Colorful, charming pixel art
-   **Moonlighter** - Shop/adventure balance aesthetic
-   **Shovel Knight** - Clear, readable retro visuals

### The Darkness Visualization

The Darkness should feel threatening but not oppressive:

-   Deep purple/black gradient
-   Subtle particle effects (wisps, eyes)
-   Sound design: low rumble, whispers
-   Screen edge effect warning when close

### Audio Design

| Element           | Feel                          |
| ----------------- | ----------------------------- |
| **Exploration**   | Upbeat, adventurous           |
| **Combat**        | Energetic, driving            |
| **Safe Zones**    | Calm, relief                  |
| **Darkness Near** | Tension, urgency              |
| **Chunk Choice**  | Anticipation, decision weight |
| **Death**         | Brief, not punishing          |

---

## Prototype / MVP Scope

### MVP Goal

Validate that choosing map chunks feels meaningfully different from random generation, and that the risk/reward balance creates interesting decisions.

### MVP Features

| Feature                    | Priority    | Notes                |
| -------------------------- | ----------- | -------------------- |
| Darkness system            | Must Have   | Core pressure        |
| Chunk choice (3 options)   | Must Have   | Core innovation      |
| 5-6 chunk types            | Must Have   | Variety for testing  |
| Real-time movement/combat  | Must Have   | Basic controls       |
| 2 abilities per class      | Must Have   | Minimum depth        |
| 2 playable classes         | Must Have   | Warrior, Ranger      |
| Chunk difficulty tiers     | Must Have   | Easy, Medium, Hard   |
| Basic loot system          | Must Have   | Weapons, consumables |
| Run completion (reach end) | Must Have   | Win condition        |
| Simple meta-progression    | Should Have | Unlock classes       |

### MVP Chunk Types

| Chunk           | Difficulty | Features                  |
| --------------- | ---------- | ------------------------- |
| **Plains**      | Easy       | Open, few enemies, quick  |
| **Forest**      | Easy       | Some cover, basic loot    |
| **Village**     | Safe       | Shop, healing, rest       |
| **Goblin Camp** | Medium     | Combat, better loot       |
| **Ruins**       | Hard       | Dungeon, best loot, traps |
| **Shrine**      | Variable   | Random event              |

### MVP Excludes

-   Quest chains
-   Resource chains
-   Boss encounters
-   More than 2 classes
-   Persistent map threats
-   Detailed meta-progression
-   Multiple difficulty modes

### Success Criteria

| Metric                            | Target                  |
| --------------------------------- | ----------------------- |
| "Chunk choice felt meaningful"    | 85%+ agree              |
| Players consider risk/reward      | Observed in playtesting |
| Run length                        | 10-20 minutes           |
| "I want to try different choices" | 80%+ say yes            |
| Core loop understood              | 90%+                    |

### MVP Timeline Estimate

| Phase            | Duration        | Tasks                              |
| ---------------- | --------------- | ---------------------------------- |
| Core Systems     | 3-4 weeks       | Movement, combat, Darkness         |
| Chunk System     | 3-4 weeks       | Generation, choice UI, transitions |
| Content Creation | 3-4 weeks       | 6 chunk types, enemies, items      |
| Balance & Polish | 2-3 weeks       | Tuning, playtesting                |
| **Total**        | **11-15 weeks** |                                    |

---

## Full Vision

### If Prototype Succeeds...

**Expanded Content:**

| Category    | MVP   | Full Version |
| ----------- | ----- | ------------ |
| Classes     | 2     | 8-10         |
| Chunk Types | 6     | 20-30        |
| Enemies     | 10-15 | 50+          |
| Items       | 20-30 | 100+         |
| Abilities   | 8-10  | 50+          |
| Bosses      | 0     | 5-8          |

**Advanced Systems:**

**1. Quest Chains**

-   NPCs in safe zones offer quests
-   Quests reference future chunks
-   Completing chains unlocks special rewards

**2. Resource Chains**

-   Gather resources in some chunks
-   Spend resources in others
-   Creates meaningful synergies

**3. World Events**

-   Global modifiers that change each run
-   "Eclipse" = Darkness faster, better loot
-   "Festival" = More shops, fewer enemies
-   "Invasion" = Enemy faction dominates

**4. Persistent Threats**

-   Some choices spawn recurring enemies
-   "Freed the Vampire" = vampire ambushes in future chunks
-   Adds long-term consequence weight

**5. Ending Variations**

-   Multiple end conditions based on choices
-   "Reached the Sanctuary" = standard win
-   "Became the Darkness" = special dark ending
-   "Founded New Kingdom" = collected all town chunks

**Meta-Progression:**

| Unlock Type      | How Obtained                        |
| ---------------- | ----------------------------------- |
| New Classes      | Reach certain milestones            |
| Starting Items   | Complete runs with specific classes |
| Chunk Variants   | Encounter base chunk many times     |
| Cosmetics        | Achievements, challenges            |
| Difficulty Modes | Beat the game                       |

**Daily/Weekly Challenges:**

-   Set seed with leaderboards
-   Specific chunk sequences
-   Community-driven challenges

---

## Risks & Mitigations

| Risk                      | Likelihood | Impact | Mitigation                                           |
| ------------------------- | ---------- | ------ | ---------------------------------------------------- |
| Choice paralysis          | Medium     | Medium | Limit to 3 options; time pressure; preview info      |
| Choices feel samey        | Medium     | High   | Distinct visual/mechanical identities per chunk      |
| Optimal path emerges      | Medium     | High   | Randomize rewards; synergy system; run modifiers     |
| Darkness too stressful    | Low        | Medium | Adjustable speed; pause in safe zones                |
| Combat too shallow        | Medium     | Medium | Ability variety; enemy diversity; positioning        |
| Chunk transitions jarring | Medium     | Low    | Smooth camera; brief loading masks; consistent style |
| Scope creep               | High       | High   | Strict MVP; validate before expanding                |

### Balancing Risk/Reward

The core design challenge: making hard chunks worth it without making easy chunks useless.

**If Hard is Always Best:**

-   Players always pick hard, game becomes linear
-   Mitigation: Easy chunks are faster, help with time pressure

**If Easy is Always Best:**

-   Players avoid risk, game is boring
-   Mitigation: Hard chunks have exclusive rewards, completion bonuses

**Sweet Spot:**

-   Easy = safe but slow, worse loot
-   Medium = balanced
-   Hard = risky but rewarding, faster Darkness catch-up danger
-   Player's situation dictates optimal choice

---

## Feasibility Assessment

### Technical Requirements (Godot/C#)

| System                     | Complexity | Notes                           |
| -------------------------- | ---------- | ------------------------------- |
| Chunk loading/unloading    | Medium     | Scene management, async loading |
| Darkness scrolling         | Low        | Visual effect + collision       |
| Real-time combat           | Medium     | Hitboxes, cooldowns, AI         |
| Chunk choice UI            | Low        | Simple menu overlay             |
| Procedural chunk placement | Low        | Select from pool, place         |
| Save system                | Medium     | Run state, meta-progression     |
| Inventory/equipment        | Low        | Standard RPG systems            |

### Chunk Design Approach

**Chunk as Scene:**

-   Each chunk type is a separate Godot scene
-   Variants are created by swapping enemies/loot spawns
-   Scenes loaded/unloaded as player progresses

**Chunk Pooling:**

-   Pre-load next 3 potential chunks
-   Unload chunks behind player (Darkness consumed)
-   Keeps memory manageable

### Art Requirements

| Asset Type                 | Quantity (MVP) | Quantity (Full) |
| -------------------------- | -------------- | --------------- |
| Player sprites (2 classes) | 2 sets         | 8-10 sets       |
| Enemy sprites              | 10-15          | 50+             |
| Tileset (per biome)        | 2-3            | 6-8             |
| Item icons                 | 30-50          | 100+            |
| UI elements                | 15-20          | 30+             |
| Effects/particles          | 15-20          | 40+             |

**Art Approach:**

-   Retro pixel art is achievable solo
-   Consider asset packs for MVP (Kenney, itch.io)
-   Consistent style guide is critical
-   Estimated cost if commissioning: $1000-3000 for MVP

### Solo Dev Reality Check

| Factor                   | Assessment                          |
| ------------------------ | ----------------------------------- |
| Technical skill required | Moderate—standard roguelike systems |
| Art requirements         | Moderate—pixel art is approachable  |
| Design complexity        | High—balance is tricky              |
| Content creation         | High—many chunks/enemies needed     |
| Time investment          | 3-4 months for MVP                  |
| Burnout risk             | Medium—content treadmill risk       |

**Recommendation:** Start with minimal chunk variety (6) and validate the choice system before creating content. The chunk system is content-hungry—only scale up after core is proven.

---

## Open Questions

1. **How much chunk preview info?** Show enemy types? Loot tier? Full layout? More info = easier choice but less surprise.

2. **Can you see multiple chunks ahead?** Like Slay the Spire's path preview? Or just immediate choice?

3. **What happens at run end?** Final boss? Reach sanctuary? Distance score? All of the above?

4. **Should chunk size vary?** Dungeons take longer but have more loot. Does this mess with Darkness pacing?

5. **How punishing is the Darkness?** Instant death? Heavy damage? Lose items? Affects risk calculus.

6. **Multiplayer potential?** Async: share seeds. Sync: co-op runs with shared choices?

7. **Narrative framing?** Why is the Darkness chasing? What's at the end? Minimal story or arc?

8. **Difficulty scaling within run?** Chunks get harder as you progress? Or flat difficulty per chunk type?

9. **How are chunk options generated?** Pure random? Based on recent history? Guarantee variety?

10. **Starting chunk?** Always same (tutorial)? Random? Player-chosen?

---

## References & Inspiration

### Games

-   **One Way Heroics** - Core inspiration, Darkness mechanic
-   **Slay the Spire** - Path choice system, risk/reward
-   **FTL** - Sector choice, resource management
-   **Hades** - Boon choices, run variety
-   **Moonlighter** - Dungeon + commerce loop
-   **Into the Breach** - Elegant tactics, preview systems
-   **Unexplored** - Cyclic dungeon generation (for chunk linking ideas)

### Design Concepts

-   **Opportunity Cost** - Every choice closes doors
-   **Push Your Luck** - Risk vs. immediate cash-out
-   **Cumulative Advantage** - Snowball effects from good choices
-   **Information Asymmetry** - Preview info creates skill expression

### Visual References

-   **One Way Heroics Plus** - Updated visuals
-   **Cadence of Hyrule** - Lighthearted pixel art
-   **CrossCode** - Modern pixel art quality
-   **Shovel Knight** - Clear retro aesthetic

---

_Document generated for solo developer consideration. The chunk choice system is the core innovation—validate it thoroughly before scaling content._
