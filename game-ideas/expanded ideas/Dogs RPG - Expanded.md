# Dogs RPG - Expanded Design Document

> **Last Updated:** January 2026  
> **Genre:** Turn-Based RPG / Comedy  
> **Engine:** Godot 4 with C#  
> **Platform:** PC  
> **Scope:** Prototype → MVP → Potential Full Release

---

## Table of Contents

1. [Executive Summary](#executive-summary)
2. [Market Analysis](#market-analysis)
3. [Core Mechanics](#core-mechanics)
4. [Prototype MVP](#prototype-mvp)
5. [Full Vision](#full-vision)
6. [Risks & Mitigations](#risks--mitigations)
7. [Feasibility Assessment](#feasibility-assessment)
8. [Open Questions](#open-questions)

---

## Executive Summary

### The Core Hook

**You are a pack of dogs.** Not a human with dog companions—an actual pack of dogs navigating a world built for humans, solving problems with tricks, teamwork, and the unique abilities of different breeds. It's a turn-based RPG with comedy at its core, where stats like "TAIL (Total Attitude Indicator Length)" determine your luck, and "tricks" replace traditional skills.

### Target Audience

-   **Primary:** Fans of lighthearted RPGs with unique premises (Undertale, Citizens of Earth, Bug Fables)
-   **Secondary:** Dog lovers, creature collector fans, players tired of "chosen one" narratives
-   **Tertiary:** Streamers/content creators looking for charming, meme-able content

### Unique Selling Points

| Feature               | Why It Matters                                          |
| --------------------- | ------------------------------------------------------- |
| All-dog party         | Fresh perspective rarely explored in RPGs               |
| Breed-based mechanics | Real dog breeds = instant recognition + humor potential |
| Comedy tone           | Underserved niche in turn-based RPGs                    |
| Pack dynamics         | Alpha system creates emergent gameplay decisions        |
| "Tricks" as skills    | Thematic renaming that reinforces the dog fantasy       |

---

## Market Analysis

### Comparable Products

| Game                    | Similarities                                           | Differences                             | Lessons                                                                   |
| ----------------------- | ------------------------------------------------------ | --------------------------------------- | ------------------------------------------------------------------------- |
| **Undertale/Deltarune** | Comedy RPG, subversive, memorable characters           | Human protagonist, bullet hell combat   | Prove comedy RPGs have massive market potential. Personality > graphics.  |
| **Bug Fables**          | Party-based, non-human protagonists, Paper Mario style | Insects, more traditional RPG structure | Shows creature-based RPGs can succeed. Badge system worth studying.       |
| **Okami**               | Dog protagonist, Japanese aesthetic                    | Action RPG, single character, AAA scope | Dog protagonists resonate emotionally. Celestial brush = unique mechanic. |
| **Dog's Life (PS2)**    | All-dog gameplay, comedy                               | Adventure game, not RPG, dated          | Proves the concept has appeal, but execution matters.                     |
| **Monster Sanctuary**   | Creature collection, turn-based                        | Monsters not dogs, metroidvania hybrid  | Skill trees per creature work well.                                       |
| **Citizens of Earth**   | Comedy RPG, recruiting party members                   | Human-centric, satirical tone           | Recruitment mechanics can drive exploration.                              |

### Market Gaps Identified

1. **No modern "all-dog" RPGs exist** — The niche is completely open
2. **Comedy RPGs are rare** — Most RPGs take themselves seriously; comedy ones (Undertale, West of Loathing) punch above their weight
3. **Breed-based mechanics untapped** — Real dog breeds have built-in personality/stat associations players already understand
4. **Cozy + Combat hybrid** — Players want games that are relaxing but still have satisfying gameplay loops

### Audience Size Indicators

-   "Dog games" consistently trend on Steam
-   Stray (2022) sold 1M+ copies in first month — proves animal protagonist games have mass appeal
-   Undertale/Deltarune community proves comedy RPG fans are highly engaged and evangelical

---

## Core Mechanics

### The Stats System

#### Individual Stats (Randomly Rolled Per Dog)

These stats vary between dogs of the same breed, creating uniqueness.

| Stat    | Full Name    | Effect                                               | Range |
| ------- | ------------ | ---------------------------------------------------- | ----- |
| **POW** | Power        | Damage dealt in battle, carrying capacity            | 1-10  |
| **SPD** | Speed        | Turn order, dodge chance, overworld movement         | 1-10  |
| **INT** | Intelligence | Trick learning speed, puzzle hints, dialogue options | 1-10  |

#### Breed Stats (Fixed Per Breed)

These stats are predetermined and cannot change, reflecting breed characteristics.

| Stat     | Full Name                       | Effect                                                   | Example Breeds                    |
| -------- | ------------------------------- | -------------------------------------------------------- | --------------------------------- |
| **BARK** | Bark                            | Intimidation, alerting, certain tricks, aggro management | Beagle (10), Basenji (1)          |
| **SIZE** | Size                            | HP pool, blocking, fitting through spaces, mounting      | Great Dane (10), Chihuahua (1)    |
| **LEAD** | Leadership                      | Determines alpha status, party buff effectiveness        | German Shepherd (8), Pug (3)      |
| **TAIL** | Total Attitude Indicator Length | Luck — crit chance, loot quality, dodge variance         | Golden Retriever (9), Bulldog (4) |

#### Stat Interactions (Examples)

-   **High BARK + Low SIZE** = Chihuahua-type yappy energy (can aggro enemies, trigger events)
-   **High LEAD + High INT** = Natural commander (buffs more effective, can direct pack tactics)
-   **High TAIL + High SPD** = Lucky dodger (enemies miss more often, better escape chance)
-   **High SIZE + Low SPD** = Tank (can body-block for smaller dogs, but acts late in turn order)

### The Pack System

#### Party Composition

-   Maximum **4 dogs** in active pack at any time
-   Additional companions stored at **"The Yard"** (home base)
-   Can only swap pack members at designated locations (dog parks, The Yard, certain NPCs)

#### Alpha Mechanics

The dog with the highest **LEAD** stat becomes the **Alpha** and:

-   Appears as the overworld sprite
-   Gets first pick of loot
-   Their TAIL stat affects party-wide luck
-   Can use **Alpha Commands** (special pack-wide abilities)
-   If Alpha is KO'd, leadership passes to next highest LEAD (temporary debuff to pack morale)

#### Pack Morale

A hidden-ish stat that affects battle performance:

| Morale Level   | Effect                                  |
| -------------- | --------------------------------------- |
| **Ecstatic**   | +15% all stats, chance to act twice     |
| **Happy**      | +5% all stats (default after winning)   |
| **Neutral**    | No modifier                             |
| **Anxious**    | -5% all stats, tricks cost more stamina |
| **Distressed** | -15% all stats, chance to skip turn     |

**Morale Modifiers:**

-   Winning battles: +Morale
-   Losing pack members: -Morale
-   Finding treats: +Morale
-   Encountering fireworks/vacuum cleaners: -Morale (unless specific breed)
-   Petting/praise from NPCs: +Morale

### Companions & Recruitment

#### Finding New Dogs

1. **Strays** — Found in the wild, must be befriended through items/tricks
2. **Rescue** — Freed from enemy encounters (e.g., dogcatchers, abusive owners)
3. **Defectors** — Enemy dogs that can be convinced to join
4. **Breeders/Shelters** — Can "adopt" specific breeds (costs currency or quest completion)

#### Companion Affinity

Each dog has an affinity rating with the pack:

| Affinity | Status   | Effect                                                        |
| -------- | -------- | ------------------------------------------------------------- |
| 0-25     | Wary     | May disobey commands, reduced effectiveness                   |
| 26-50    | Friendly | Normal performance                                            |
| 51-75    | Loyal    | Bonus damage when defending packmates                         |
| 76-100   | Bonded   | Unique combo tricks unlock, will sacrifice self to save Alpha |

Affinity increases through:

-   Winning battles together
-   Using support tricks on them
-   Sharing treats
-   Keeping them in active party

### Tricks (Skills)

"Tricks" are the skill system, thematically tied to dog training.

#### Trick Categories

| Category           | Description               | Examples                                                |
| ------------------ | ------------------------- | ------------------------------------------------------- |
| **Basic**          | All dogs can learn        | Bite, Bark, Fetch, Roll Over                            |
| **Breed-Specific** | Only certain breeds       | Retrieve (Retrievers), Herd (Shepherds), Track (Hounds) |
| **Pack Tactics**   | Require multiple dogs     | Surround, Relay, Distraction                            |
| **Alpha Commands** | Only usable by Alpha      | Rally, Retreat, Hunt                                    |
| **Contest Tricks** | For non-combat challenges | Cute Eyes, Play Dead, Dance                             |

#### Learning Tricks

-   **Leveling up** unlocks trick slots
-   **Training** with NPCs teaches new tricks
-   **Observation** — watching enemies use tricks can unlock them
-   **Breed instinct** — some tricks auto-unlock at certain levels for specific breeds

#### Trick Examples (Detailed)

| Trick             | Category           | Effect                                               | Stamina Cost |
| ----------------- | ------------------ | ---------------------------------------------------- | ------------ |
| **Bite**          | Basic              | Single target damage, scales with POW                | 5            |
| **Howl**          | Basic              | Raises pack morale, may call reinforcements          | 10           |
| **Play Dead**     | Contest            | Enemies may skip you, enables sneak attack next turn | 8            |
| **Dig**           | Basic              | Find buried items mid-battle, or create cover        | 12           |
| **Zoomies**       | Breed (Small dogs) | Multi-hit attack on all enemies, lowers own defense  | 15           |
| **Intimidate**    | Breed (Large dogs) | Chance to make enemy flee, scales with BARK          | 10           |
| **Track**         | Breed (Hounds)     | Reveals enemy weaknesses and hidden information      | 8            |
| **Retrieve**      | Breed (Retrievers) | Steal item from enemy                                | 12           |
| **Herd**          | Breed (Shepherds)  | Force enemy into position, enables combo attacks     | 14           |
| **Pack Surround** | Pack Tactic        | All dogs attack one target, bonus damage per dog     | 8 each       |
| **Rally**         | Alpha Command      | Remove negative status from all pack members         | 20           |

### Combat System

#### Turn Order

1. Determined by SPD stat
2. Ties broken by TAIL (luck)
3. Some tricks modify turn order (Quick Bark = act first, Lazy Day = act last but heal)

#### Action Economy

Each dog gets per turn:

-   **1 Main Action** (Trick, Item, Swap Position)
-   **1 Bonus Action** (Bark, Sniff, Wag Tail — minor effects)
-   **1 Movement** (Reposition on battlefield)

#### Positioning

The battlefield has positions that matter:

```
[FRONT] [FRONT] [FRONT]
[BACK]  [BACK]  [BACK]
```

-   **Front row:** Can use melee tricks, take more damage, block for back row
-   **Back row:** Can use ranged tricks, protected by front row, some tricks only work from here

#### Status Effects (Dog-Themed)

| Status         | Effect                                  | Caused By                      |
| -------------- | --------------------------------------- | ------------------------------ |
| **Distracted** | May attack wrong target                 | Squirrels, cats, thrown toys   |
| **Spooked**    | May skip turn or flee                   | Loud noises, larger enemies    |
| **Tired**      | Reduced SPD, tricks cost more           | Extended combat, no rest       |
| **Wet**        | Reduced POW, shake to remove (hits all) | Water attacks, rain            |
| **Muddy**      | Reduced SPD, leaves trail               | Mud, Dig trick                 |
| **Pampered**   | Increased TAIL, decreased POW           | Grooming, treats               |
| **Feral**      | Increased POW, decreased INT            | Prolonged combat, wolf enemies |

### Contest System

Non-combat challenges that use different stats:

| Contest Type | Primary Stat | Secondary      | Example Situations                         |
| ------------ | ------------ | -------------- | ------------------------------------------ |
| **Cuteness** | TAIL         | SIZE (inverse) | Convincing NPCs, getting treats            |
| **Fight**    | POW          | BARK           | Intimidation standoffs, territory disputes |
| **Tricks**   | INT          | SPD            | Dog shows, impressing trainers             |
| **Tracking** | INT          | BARK           | Finding items, following trails            |
| **Herding**  | LEAD         | SPD            | Puzzle solving, controlling NPCs           |

---

## Prototype MVP

### Goal

Validate the core gameplay loop: **pack-based turn-based combat with dog-themed mechanics feels fun and the comedy lands.**

### Scope (4-6 Weeks)

#### Content Checklist

| Element         | Quantity  | Notes                                                               |
| --------------- | --------- | ------------------------------------------------------------------- |
| Playable breeds | 3         | One small (Corgi), one medium (Beagle), one large (German Shepherd) |
| Areas           | 1         | "The Neighborhood" — tutorial area                                  |
| Enemy types     | 3         | Angry Cat, Mailman, Rival Dog                                       |
| Tricks          | 8-10      | Mix of basic and breed-specific                                     |
| NPCs            | 2-3       | One friendly human, one dog, one antagonist tease                   |
| Battles         | 5-7       | Including one "boss" (Animal Control Officer)                       |
| Playtime        | 20-30 min | Enough to test all systems                                          |

#### Core Systems to Implement

1. **Pack management** — 3 dogs, alpha system
2. **Turn-based combat** — Basic positioning, tricks, stamina
3. **Overworld movement** — Alpha as sprite, basic interaction
4. **Stat system** — All stats functional, breed stats visible
5. **Morale** — Basic implementation (happy/neutral/anxious)
6. **One contest** — Cuteness contest to test non-combat

#### Art Requirements (Minimum)

-   3 dog sprites (idle, walk, attack, hurt, KO) — can be simple/placeholder
-   3 enemy sprites
-   1 tileset (neighborhood/suburban)
-   Basic UI (health bars, trick menu, pack display)
-   Portrait art for dialogue (can be simple busts)

#### Audio (Minimum)

-   Bark sounds (3 variations per size)
-   Battle music (1 track)
-   Overworld music (1 track)
-   Basic SFX (hit, miss, heal, UI)

### Success Criteria

| Metric                 | Target                                | How to Measure                                          |
| ---------------------- | ------------------------------------- | ------------------------------------------------------- |
| Combat feels distinct  | Qualitative                           | Playtester feedback — "feels different from other RPGs" |
| Comedy lands           | 70%+ laughs                           | Track joke moments, measure response                    |
| Pack system adds depth | Players make meaningful alpha choices | Observe if players consider LEAD when building party    |
| Breed identity matters | Players differentiate breeds          | Ask playtesters to describe each breed's role           |
| Replayability interest | "Would try different breeds"          | Post-play survey                                        |

### Prototype Risks

| Risk                        | Mitigation                                      |
| --------------------------- | ----------------------------------------------- |
| Combat too simple           | Add positioning depth, combo system             |
| Comedy doesn't land in text | Playtest jokes early, iterate on timing         |
| Too similar to Pokemon      | Emphasize pack tactics, alpha mechanics, morale |
| Scope creep                 | Strict feature freeze after week 2              |

---

## Full Vision

### Complete Game Scope

If the prototype succeeds, here's the expanded vision:

#### Content Scale

| Element           | Quantity                                                     |
| ----------------- | ------------------------------------------------------------ |
| Playable breeds   | 30-50 (representing major real breeds + some fantasy breeds) |
| Areas/Regions     | 8-10 (suburbs, city, countryside, beach, mountains, etc.)    |
| Main story length | 15-20 hours                                                  |
| Side content      | 10-15 hours                                                  |
| Unique enemies    | 80-100                                                       |
| Boss fights       | 12-15                                                        |
| NPCs              | 100+                                                         |
| Tricks            | 100+                                                         |

#### Expanded Mechanics

##### Breeding System (Optional)

-   Dogs can have puppies at The Yard
-   Puppies inherit traits from parents
-   Creates attachment and long-term goals

##### Trick Evolution

-   Basic tricks upgrade into advanced versions
-   Example: Bite → Chomp → Savage Maul
-   Some evolutions breed-locked

##### Pack Home (The Yard)

A hub area that expands as you progress:

| Upgrade       | Effect                          |
| ------------- | ------------------------------- |
| Dog House     | Increases companion capacity    |
| Training Area | Faster trick learning           |
| Toy Box       | Equippable items storage        |
| Food Bowls    | Passive healing between battles |
| Fence Upgrade | Unlocks new breed recruitment   |

##### Equipment System

Dogs can equip:

-   **Collars** — Stat modifiers, status resistance
-   **Tags** — Passive abilities (Rabies Tag = poison immunity)
-   **Accessories** — Cosmetic + minor buffs (Bandana, Goggles, Booties)

##### Relationship Web

Dogs have relationships with each other:

-   **Best Friends** — Combo tricks unlocked
-   **Rivals** — Can't be in same party without morale penalty
-   **Mentor/Student** — XP sharing, trick teaching

#### Story & World

##### Main Narrative

The pack discovers that dogs across the city are disappearing. The trail leads to **The Pound** — but this isn't a normal shelter. It's a front for something darker. As you investigate, you uncover a conspiracy involving:

-   A corrupt dog show circuit
-   Illegal dog fighting rings
-   A mysterious figure called **"The Breeder"** who's creating "perfect" dogs
-   The truth about where strays really come from

**Tone:** Despite dark themes, kept lighthearted through dog perspective — dogs don't fully understand human evil, which creates dark comedy.

##### Regional Breakdown

| Region               | Theme             | Key Content                         |
| -------------------- | ----------------- | ----------------------------------- |
| **The Neighborhood** | Tutorial/Suburbs  | Meet first companions, learn basics |
| **Downtown**         | Urban exploration | Strays, food trucks, pigeon enemies |
| **The Park**         | Open area hub     | Dog shows, training, social hub     |
| **The Junkyard**     | Dungeon           | Feral dogs, environmental hazards   |
| **The Beach**        | Vacation area     | Water mechanics, crab enemies       |
| **The Country**      | Farm/pastoral     | Livestock herding, wolf encounters  |
| **The Pound**        | Mid-game dungeon  | Rescue mission, major story beat    |
| **The Mansion**      | Late-game         | Dog show finals, The Breeder's lair |

##### Key Characters

| Character       | Role                  | Breed            | Notes                                             |
| --------------- | --------------------- | ---------------- | ------------------------------------------------- |
| **Rex**         | Starter/Default Alpha | German Shepherd  | Reliable, brave, slightly dumb                    |
| **Duchess**     | Starter companion     | Poodle           | Snobby but secretly kind, high INT                |
| **Biscuit**     | Starter companion     | Corgi            | Comic relief, high TAIL                           |
| **Shadow**      | Rival → Ally          | Doberman         | Mysterious past, escaped from The Pound           |
| **Mr. Pickles** | Mentor                | Old Basset Hound | Wise, knows the city's secrets                    |
| **The Breeder** | Main Antagonist       | Human            | Obsessed with "perfection," sees dogs as products |
| **Fang**        | Boss                  | Wolf-dog hybrid  | The Breeder's "masterpiece," tragic villain       |

#### Quality of Life Features

-   **Fast travel** via dog doors placed around the world
-   **Auto-save** at every screen transition
-   **Difficulty options** affecting combat tuning
-   **Bestiary** tracking all breeds and enemies encountered
-   **Trick journal** with descriptions and tips
-   **Photo mode** for capturing cute moments

---

## Risks & Mitigations

### Development Risks

| Risk                            | Likelihood | Impact | Mitigation                                                 |
| ------------------------------- | ---------- | ------ | ---------------------------------------------------------- |
| **Scope creep** with breeds     | High       | High   | Limit launch to 20 breeds, add more post-launch            |
| **Comedy writing quality**      | Medium     | High   | Get external feedback early, hire writer if needed         |
| **Balance across breeds**       | High       | Medium | Use stat archetypes, playtest extensively                  |
| **Art consistency**             | Medium     | Medium | Create style guide before production, consider asset packs |
| **Godot C# documentation gaps** | Medium     | Low    | Lean on GDScript examples, translate as needed             |

### Design Risks

| Risk                          | Likelihood | Impact | Mitigation                                                                  |
| ----------------------------- | ---------- | ------ | --------------------------------------------------------------------------- |
| **"Just Pokemon with dogs"**  | Medium     | High   | Emphasize pack tactics, alpha system, morale — systems Pokemon doesn't have |
| **Breeds feel same-y**        | Medium     | High   | Ensure breed-specific tricks and stat spreads create distinct playstyles    |
| **Alpha system feels forced** | Medium     | Medium | Make alpha benefits meaningful but not mandatory                            |
| **Morale too punishing**      | Medium     | Medium | Keep morale recoverable, don't make it spiral                               |
| **Combat too simple**         | Medium     | High   | Add positioning depth, combo system, status effects                         |

### Market Risks

| Risk                                 | Likelihood | Impact | Mitigation                                        |
| ------------------------------------ | ---------- | ------ | ------------------------------------------------- |
| **Niche appeal**                     | Low        | Medium | Dogs have universal appeal; comedy helps          |
| **Competition from similar release** | Low        | Medium | First-mover advantage; unique tone differentiates |
| **Streamers don't pick it up**       | Medium     | Medium | Build in shareable moments, meme potential        |

---

## Feasibility Assessment

### Solo Developer Timeline

#### Prototype Phase (1-2 Months)

| Week | Focus                                  |
| ---- | -------------------------------------- |
| 1-2  | Core systems (stats, pack, turn order) |
| 3-4  | Combat implementation                  |
| 5-6  | Content creation, polish, playtesting  |

#### MVP Phase (3-4 Months)

| Month | Focus                                             |
| ----- | ------------------------------------------------- |
| 1     | Expand combat (positioning, more tricks), 3 areas |
| 2     | Story implementation, 5-6 breeds, NPCs            |
| 3     | Art pass (if using paid assets, commission here)  |
| 4     | Polish, bug fixing, more playtesting              |

#### Full Game (12-18 Months from MVP)

-   Content creation (areas, breeds, story)
-   Art production (biggest time investment)
-   Audio (music, bark variations, SFX)
-   Polish and QA
-   Marketing and release prep

### Resource Requirements

#### If Staying Solo

| Resource  | Approach                     | Estimated Cost |
| --------- | ---------------------------- | -------------- |
| Art       | Asset packs + simple custom  | $200-500       |
| Music     | Royalty-free or AI-generated | $0-100         |
| SFX       | Freesound.org + custom       | $0-50          |
| Marketing | Social media, devlogs        | $0 (time only) |

#### If Expanding After MVP

| Resource      | Approach                 | Estimated Cost |
| ------------- | ------------------------ | -------------- |
| Pixel artist  | Commission breed sprites | $2,000-5,000   |
| Composer      | Original soundtrack      | $500-2,000     |
| Writer        | Dialogue polish          | $500-1,500     |
| Voice (barks) | Fiverr for variations    | $100-300       |

### Technical Considerations (Godot + C#)

| System            | Complexity | Notes                                          |
| ----------------- | ---------- | ---------------------------------------------- |
| Turn-based combat | Medium     | Godot handles this well; state machine pattern |
| Save system       | Medium     | Use Godot's built-in ResourceSaver or JSON     |
| Dialogue system   | Low-Medium | Consider Dialogic addon or simple custom       |
| Pack management   | Medium     | Scene management + persistent data             |
| Stat calculations | Low        | Pure C# logic, well-suited                     |
| UI                | Medium     | Godot's Control nodes + C# bindings work well  |

---

## Open Questions

### Design Questions

1. **Should there be permadeath or just KO?** Dogs being KO'd is funny; permadeath might be too punishing/sad
2. **How many dogs can the player ultimately collect?** All breeds? Limit to encourage choices?
3. **Can the player's dogs die of old age?** Realistic but potentially heartbreaking
4. **Should there be a "starter dog" trio choice like Pokemon?** Or just give the player a set starting pack?
5. **How to handle dog fighting thematically?** It's the obvious late-game conflict, but sensitive topic
6. **Should wild animals (cats, squirrels, etc.) be recruitable?** Breaks the "dogs only" theme but adds variety
7. **What happens when the Alpha is KO'd mid-battle?** Temporary new Alpha? Morale crash?

### Technical Questions

1. **Procedural breed generation?** Late-game content could include random "mutt" generation
2. **How to handle breed sprite variations?** Color palettes? Unique sprites per breed?
3. **Cloud saves?** Worth implementing for PC release?

### Content Questions

1. **Real breed names or parody names?** "Corgi" vs "Corg" — legal considerations?
2. **Include fantasy/mythical dog breeds?** Hellhounds, Cerberus, ghost dogs?
3. **Crossover potential?** Could other indie dog games be referenced?

### Monetization Questions (If Full Release)

1. **Price point?** $15-20 feels right for scope
2. **DLC potential?** New regions, breed packs, story expansions
3. **Merch?** Dog plushies are an obvious fit if the game succeeds

---

## Appendix: Breed Concepts

### Starter Pack Candidates

| Breed            | Size   | Archetype       | Unique Trait                   |
| ---------------- | ------ | --------------- | ------------------------------ |
| German Shepherd  | Large  | Balanced tank   | High LEAD, natural Alpha       |
| Beagle           | Medium | Tracker/Support | High BARK, tracking abilities  |
| Corgi            | Small  | Speedy DPS      | High SPD, Zoomies trick        |
| Poodle           | Medium | Magic/INT       | High INT, learns tricks fast   |
| Golden Retriever | Large  | Luck/Support    | High TAIL, retrieval abilities |
| Chihuahua        | Small  | Glass cannon    | Very high POW, very low SIZE   |

### Enemy Breed Concepts

| Enemy                     | Type      | Behavior                                          |
| ------------------------- | --------- | ------------------------------------------------- |
| Feral Strays              | Common    | Pack-based, low stats, high numbers               |
| Guard Dogs                | Elite     | High POW, territorial, won't leave zone           |
| Show Dogs                 | Special   | High contest stats, may challenge to non-combat   |
| Wolf Pack                 | Boss      | High everything, requires full party coordination |
| The Breeder's Experiments | Late-game | Stat-boosted, tragic backstory potential          |

---

_Document will be updated as development progresses._
