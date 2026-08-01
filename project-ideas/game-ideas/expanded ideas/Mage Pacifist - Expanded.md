# Mage Pacifist Game - Expanded Design Document

> **Last Updated:** January 2026  
> **Genre:** Puzzle / Adventure / Metroidvania  
> **Engine:** Godot 4 with C#  
> **Platform:** PC  
> **Scope:** Prototype → MVP → Potential Full Release  
> **Estimated Length:** 8-10 hours

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

**A mage who refuses to harm—in a world that expects violence.** You are a powerful spellcaster navigating a hostile world filled with monsters, traps, and a talking antagonist who mocks your peaceful approach. Every puzzle requires creative non-violent solutions. Every ability transforms, redirects, or heals—never harms. The story unfolds without dialogue, told through environmental storytelling, discovered texts, and the lone exception: the antagonist's taunting voice.

### Target Audience

-   **Primary:** Fans of puzzle-platformers with narrative depth (Braid, Fez, The Swapper)
-   **Secondary:** Metroidvania enthusiasts who want fresh mechanics
-   **Tertiary:** Players who appreciated Undertale's pacifist route and want a game built entirely around that concept

### Unique Selling Points

| Feature                     | Why It Matters                                         |
| --------------------------- | ------------------------------------------------------ |
| Pacifist-only design        | Not an optional route—it's the only way to play        |
| No dialogue storytelling    | Visual narrative creates mystery and immersion         |
| Antagonist as sole voice    | Creates unique dynamic—evil speaks, good acts silently |
| Metroidvania ability gating | Abilities unlock new areas without combat power creep  |
| Environmental puzzle focus  | Every obstacle is a puzzle, not an enemy to defeat     |

### The "No Dialogue" Rule (Clarified)

-   **No dialogue** means no speech bubbles, no spoken words from NPCs or the player
-   **Text exists** in the world: journals, signs, books, ancient inscriptions
-   **The Antagonist speaks** — they are the exception, creating a stark contrast
-   **Environmental storytelling** carries the narrative: murals, body language, object placement

---

## Market Analysis

### Comparable Products

| Game                     | Similarities                                      | Differences                       | Lessons                                                     |
| ------------------------ | ------------------------------------------------- | --------------------------------- | ----------------------------------------------------------- |
| **Undertale (Pacifist)** | Non-violence, emotional story                     | RPG combat exists, optional route | Proves pacifism resonates; but combat was still there       |
| **Braid**                | Puzzle-platformer, wordless story, time mechanics | No metroidvania structure         | Visual storytelling can be profound; puzzles carry gameplay |
| **Fez**                  | Exploration, cryptic world, minimal text          | Less narrative focus              | Discovery = reward; players love decoding meaning           |
| **The Swapper**          | Puzzle-platformer, atmosphere, clone mechanics    | Darker tone, sci-fi               | Non-violent puzzles can be deeply engaging                  |
| **Hollow Knight**        | Metroidvania, atmospheric, mysterious world       | Combat-focused                    | Art and atmosphere sell; ability gating works               |
| **Celeste**              | Precision platforming, emotional narrative        | No puzzle focus, no metroidvania  | Story through environment works; accessibility matters      |
| **GRIS**                 | No words, emotional journey, puzzle-light         | Very short, more art game         | Wordless narrative can be powerful; may lack replay value   |
| **Ori series**           | Metroidvania, beautiful art, emotional            | Combat exists                     | Ability-based exploration is satisfying                     |

### Market Gaps Identified

1. **No pure pacifist metroidvanias exist** — Games either have combat or are linear
2. **"No dialogue" games are rare and short** — GRIS, Journey are brief; this offers 8-10 hours
3. **Mages are always combat-oriented** — Subverting this trope is fresh
4. **Single-voice antagonist is untapped** — Creates asymmetric narrative tension

### Audience Size Indicators

-   Hollow Knight sold 3M+ copies — metroidvania market is proven
-   Undertale's pacifist route is the most celebrated — players _want_ to be peaceful
-   GRIS sold well despite being 3 hours — art + emotion sells
-   "Puzzle metroidvania" is an underexplored subgenre with built-in demand

---

## Core Mechanics

### Movement & Traversal

The mage starts with basic movement that expands through ability acquisition.

#### Base Movement

| Action       | Input      | Notes                      |
| ------------ | ---------- | -------------------------- |
| Walk         | Left/Right | Standard movement          |
| Jump         | A/Space    | Single jump initially      |
| Crouch       | Down       | Fits through small spaces  |
| Look Up/Down | Up/Down    | Camera pan for exploration |

#### Unlockable Movement Abilities

| Ability         | Unlock Point | Function                | Puzzle Uses                |
| --------------- | ------------ | ----------------------- | -------------------------- |
| **Float**       | Area 1 Boss  | Slow fall, brief hover  | Cross gaps, ride updrafts  |
| **Phase**       | Area 2 Boss  | Pass through thin walls | Access hidden areas        |
| **Anchor**      | Area 3 Boss  | Lock position in air    | Platform on moving objects |
| **Recall**      | Area 4 Boss  | Return to set point     | Backtracking puzzles       |
| **Double Jump** | Hidden       | Second jump mid-air     | Verticality                |

### Magic System (Non-Violent)

All magic is utility-based. Spells cannot directly harm anything.

#### Spell Categories

| Category           | Description                       | Examples                                    |
| ------------------ | --------------------------------- | ------------------------------------------- |
| **Transformation** | Change objects or environment     | Turn stone to sand, water to ice            |
| **Redirection**    | Alter movement of objects/hazards | Deflect projectiles, redirect water flow    |
| **Illumination**   | Reveal hidden elements            | Light dark areas, show invisible platforms  |
| **Temporal**       | Slow or pause elements            | Freeze moving platforms, slow hazards       |
| **Restoration**    | Heal or repair                    | Heal NPCs/creatures, restore broken objects |

#### Core Spell List (Full Game)

| Spell             | Category       | Effect                                     | Gated Content                              |
| ----------------- | -------------- | ------------------------------------------ | ------------------------------------------ |
| **Light Orb**     | Illumination   | Creates light source, reveals hidden paths | Dark zones, invisible platforms            |
| **Stone to Sand** | Transformation | Crumbles stone blocks                      | Blocked passages, creates sand piles       |
| **Iceform**       | Transformation | Freezes water, creates platforms           | Water traversal, enemy slowing             |
| **Windpush**      | Redirection    | Creates gust pushing objects               | Move blocks, change projectile paths       |
| **Magnetize**     | Redirection    | Attracts/repels metal objects              | Metal block puzzles, platform manipulation |
| **Slow Field**    | Temporal       | Area that slows everything inside          | Timing puzzles, hazard navigation          |
| **Mend**          | Restoration    | Repairs broken objects                     | Restore bridges, machinery                 |
| **Lifeblossom**   | Restoration    | Heals creatures, causes plant growth       | NPC healing, organic platforms             |
| **Echo**          | Illumination   | Reveals past state of objects              | See what was destroyed, find secrets       |
| **Nullify**       | Redirection    | Cancels magical effects                    | Counter antagonist's magic                 |

### Puzzle Design Framework

#### Puzzle Types

| Type               | Description                                | Example                                            |
| ------------------ | ------------------------------------------ | -------------------------------------------------- |
| **Traversal**      | Get from A to B using abilities            | Phase through wall, float across gap               |
| **Mechanism**      | Activate/deactivate environmental machines | Redirect power, arrange mirrors                    |
| **Transformation** | Change the environment to proceed          | Freeze river, crumble wall                         |
| **Timing**         | Execute actions in correct sequence/timing | Slow field + platforming                           |
| **Escort**         | Help creature/NPC through hazards          | Heal injured animal so it can trigger switch       |
| **Restoration**    | Repair broken elements                     | Mend bridge while avoiding antagonist's disruption |
| **Memory**         | Use Echo to understand past state          | Discover what happened, find hidden paths          |

#### Puzzle Complexity Curve

| Area  | Complexity | New Mechanics               | Puzzle Length |
| ----- | ---------- | --------------------------- | ------------- |
| 1     | Simple     | Light Orb, basic movement   | 1-2 minutes   |
| 2     | Moderate   | Stone to Sand, Iceform      | 2-4 minutes   |
| 3     | Moderate+  | Windpush, Float             | 3-5 minutes   |
| 4     | Complex    | Magnetize, Phase            | 5-8 minutes   |
| 5     | Complex+   | Slow Field, Anchor          | 5-10 minutes  |
| 6     | Advanced   | Mend, Lifeblossom           | 8-12 minutes  |
| 7     | Master     | Echo, Recall, combinations  | 10-15 minutes |
| Final | Expert     | All abilities, all concepts | Multi-stage   |

### "Enemy" Encounters (Hazards)

Since you cannot harm anything, traditional enemies become environmental hazards.

#### Hazard Types

| Hazard                 | Behavior            | Non-Violent Solution                        |
| ---------------------- | ------------------- | ------------------------------------------- |
| **Patrol Creatures**   | Walk set paths      | Avoid, distract with Light Orb              |
| **Aggressive Animals** | Chase if spotted    | Phase through wall, slow with field         |
| **Turrets**            | Fire projectiles    | Redirect with Windpush, freeze with Iceform |
| **Corrupted Zones**    | Damage on contact   | Nullify, find alternate path                |
| **Environmental**      | Spikes, pits, lava  | Transform, platform, float                  |
| **Antagonist Magic**   | Direct interference | Nullify, outmaneuver                        |

#### Creature Interactions

Some creatures are helpful when healed or aided:

| Creature       | Issue           | Solution              | Reward                  |
| -------------- | --------------- | --------------------- | ----------------------- |
| Wounded bird   | Can't fly       | Lifeblossom           | Carries you across gap  |
| Blocked turtle | Shell stuck     | Windpush debris away  | Becomes moving platform |
| Frozen fish    | Trapped in ice  | Wait near heat source | Reveals underwater path |
| Sad spirit     | Lost, wandering | Echo shows home       | Opens sealed door       |

### The Antagonist

The Antagonist is the only speaking character—and they speak _a lot_.

#### Characterization

-   **Voice:** Mocking, intellectual, condescending
-   **Presence:** Appears as a projection/shadow throughout the game
-   **Motivation:** Believes power must be used violently; your pacifism is an affront
-   **Evolution:** Starts amused → becomes frustrated → eventually desperate

#### Antagonist Mechanics

| Mechanic                | Description                                                 |
| ----------------------- | ----------------------------------------------------------- |
| **Taunting Dialogue**   | Speaks during puzzles, tries to distract/demoralize         |
| **Direct Interference** | Creates obstacles: walls, corrupted zones, hazards          |
| **False Hints**         | Sometimes "helps" with misleading advice                    |
| **Escalation**          | As you progress, interference becomes more aggressive       |
| **Boss Encounters**     | Not fights—survival puzzles where you outlast their assault |

#### Sample Antagonist Lines

**Early Game (Amused):**

-   "Oh, a pacifist mage. How... quaint."
-   "You know those creatures would eat you if they could, right?"
-   "I'm genuinely curious how long this little experiment lasts."

**Mid Game (Frustrated):**

-   "You're making this harder than it needs to be."
-   "One spell. One offensive spell, and this would all be over."
-   "Why do you INSIST on this... this LIMITATION?"

**Late Game (Desperate):**

-   "You're going to die here, and for what? PRINCIPLE?"
-   "I'm offering you POWER. Real power. Not this... this parlor trick healing!"
-   "Fine. If you won't use force... I'LL USE ENOUGH FOR BOTH OF US."

### World Narrative (No Dialogue)

#### Environmental Storytelling Methods

| Method                  | Example                                                               |
| ----------------------- | --------------------------------------------------------------------- |
| **Murals/Paintings**    | Depict history of the world, the mage's origin, the antagonist's fall |
| **Object Placement**    | Abandoned toys = lost children, broken weapons = past battle          |
| **NPC Body Language**   | Cowering creature = fear, reaching gesture = gratitude                |
| **Architecture**        | Pristine = safe zone, corrupted = antagonist's influence              |
| **Sequential Scenes**   | Multiple murals telling a story across a room                         |
| **Before/After (Echo)** | Show what areas looked like before destruction                        |

#### Discoverable Text

| Text Type                | Purpose                               |
| ------------------------ | ------------------------------------- |
| **Journals**             | Personal accounts of past inhabitants |
| **Signs**                | Practical guidance (lore-appropriate) |
| **Ancient Inscriptions** | Deep lore, spell origins, prophecies  |
| **Letters**              | Character relationships, plot context |
| **Books**                | World history, magic theory           |

---

## Prototype MVP

### Goal

Validate that **non-violent puzzle-solving with metroidvania structure feels satisfying and the silent-protagonist-vs-taunting-antagonist dynamic works.**

### Scope (4-6 Weeks)

#### Content Checklist

| Element                | Quantity  | Notes                                  |
| ---------------------- | --------- | -------------------------------------- |
| Areas                  | 2         | Starting area + first dungeon          |
| Spells                 | 3         | Light Orb, Stone to Sand, Iceform      |
| Movement abilities     | 1         | Float (end of prototype unlock)        |
| Puzzles                | 12-15     | Escalating complexity                  |
| Hazard types           | 3         | Patrol creature, turret, environmental |
| Antagonist appearances | 3-4       | Intro + during dungeon + "boss"        |
| Discoverable texts     | 5-8       | Journals, signs                        |
| Playtime               | 30-45 min | Full loop through both areas           |

#### Core Systems to Implement

1. **Player movement** — Walk, jump, crouch, plus Float unlock
2. **Spell system** — Casting, spell switching, mana/cooldown
3. **Puzzle elements** — Pushable blocks, transformable objects, switches
4. **Hazard system** — Patrol AI, projectiles, damage zones
5. **Antagonist presence** — Voice lines, visual appearance, basic interference
6. **Text discovery** — Interactable objects that display text
7. **Map/ability gating** — Doors that require Float to pass

#### Art Requirements (Minimum)

-   Mage character (idle, walk, jump, cast, float)
-   2 tilesets (starting village, dungeon)
-   3 hazard sprites (creature, turret, corruption)
-   Antagonist projection sprite (shadowy, ethereal)
-   Spell effects (3 spells)
-   UI (mana bar, spell selection, minimap optional)
-   4-5 journal/book illustrations

#### Audio (Minimum)

-   Antagonist voice lines (10-15 lines, can be placeholder)
-   Ambient tracks (2 — village, dungeon)
-   Spell SFX (3 spells)
-   Environmental SFX (footsteps, hazards, doors)

### Success Criteria

| Metric                            | Target                         | How to Measure                                    |
| --------------------------------- | ------------------------------ | ------------------------------------------------- |
| Puzzles feel satisfying           | 80%+ clear without frustration | Playtester feedback, time-to-solve                |
| Non-violence feels intentional    | Not "missing" combat           | Playtesters don't ask "where's the attack button" |
| Antagonist dynamic works          | Creates tension/humor          | Playtesters react to lines                        |
| Environmental story is understood | Basic plot grasped             | Post-play comprehension check                     |
| Metroidvania loop functions       | Backtracking feels rewarding   | Playtesters explore after Float unlock            |

### Prototype Risks

| Risk                                | Mitigation                                          |
| ----------------------------------- | --------------------------------------------------- |
| Puzzles too hard/obscure            | Extensive playtesting, hint system design           |
| Antagonist annoying vs entertaining | Careful writing, player control over volume?        |
| Lack of action feels boring         | Ensure puzzles have satisfying "clicks," animations |
| Silent story too confusing          | Add more environmental context, test comprehension  |

---

## Full Vision

### Complete Game Scope

#### Content Scale

| Element                   | Quantity                                     |
| ------------------------- | -------------------------------------------- |
| Areas/Regions             | 7-8 major zones + hidden areas               |
| Spells                    | 10-12 unique spells                          |
| Movement abilities        | 5-6                                          |
| Puzzles                   | 100+                                         |
| Unique hazards            | 20-25                                        |
| Antagonist encounters     | 15-20 throughout game                        |
| "Boss" survival sequences | 6-8                                          |
| Discoverable texts        | 60-80                                        |
| Playtime                  | 8-10 hours (main path) + 3-4 hours (secrets) |

### World Structure (Metroidvania Map)

```
                    [FINAL AREA]
                         |
        [TEMPLE] ----[HUB]---- [TOWER]
           |           |           |
    [FOREST] ----[VILLAGE]---- [CAVES]
                       |
                 [UNDERGROUND]
```

#### Area Breakdown

| Area                | Theme                      | New Abilities          | Key Mechanics                    |
| ------------------- | -------------------------- | ---------------------- | -------------------------------- |
| **Village (Start)** | Ruined peaceful town       | Light Orb              | Tutorial, environmental intro    |
| **Forest**          | Overgrown, natural hazards | Stone to Sand, Iceform | Transformation puzzles           |
| **Caves**           | Dark, echo-heavy           | Windpush, Float        | Redirection, vertical puzzles    |
| **Underground**     | Mechanical, ancient        | Magnetize, Phase       | Complex mechanism puzzles        |
| **Temple**          | Sacred, corrupted          | Slow Field, Anchor     | Timing, precision                |
| **Tower**           | Antagonist's domain        | Mend, Lifeblossom      | Restoration, healing             |
| **Hub (Central)**   | Crossroads, evolving       | Recall                 | Central fast travel, story beats |
| **Final Area**      | Combination of all         | Echo, Nullify          | All abilities, culmination       |

### Narrative Arc

#### Act 1: Discovery (Areas 1-2)

**Setup:** The mage awakens in a destroyed village. Through murals and journals, we learn this was once a peaceful place. A shadowy figure—the Antagonist—appears and introduces themselves, mocking the mage's apparent weakness.

**Key Story Beats:**

-   Discover murals showing the mage's past (a powerful pacifist tradition)
-   Antagonist reveals they share history with the mage
-   First creature healing creates emotional connection

#### Act 2: Journey (Areas 3-4)

**Development:** The mage travels deeper, encountering more corrupted areas. The Antagonist becomes more aggressive, directly interfering with puzzles. Environmental storytelling reveals the world was corrupted by someone seeking power.

**Key Story Beats:**

-   Flashback murals show the Antagonist was once a student of the pacifist tradition
-   They were expelled for wanting to use magic violently
-   The corruption is the result of their vengeance

#### Act 3: Confrontation (Areas 5-6)

**Escalation:** The mage enters the Antagonist's domain. The interference becomes constant. Survival sequences become longer and harder. But the mage also becomes more powerful—in a non-violent way.

**Key Story Beats:**

-   The Antagonist's true plan revealed: to force the mage to use violence, proving pacifism is a lie
-   NPCs/creatures encountered throughout are trapped here, can be freed
-   Echo reveals the Antagonist's tragic past—they suffered and concluded only power protects

#### Act 4: Resolution (Final Area)

**Climax:** A gauntlet of all skills, all concepts. The Antagonist throws everything at the mage. At the final moment, the mage has a choice—but it's not attack vs. don't attack.

**The Choice:**

-   **Nullify the Antagonist's power** (leave them powerless but alive)
-   **Lifeblossom to heal the corruption in them** (harder, but true to pacifism)

Both endings are valid. The Nullify ending is "good but incomplete." The Lifeblossom ending is the "true" ending, requiring a harder final sequence.

### Boss Survival Sequences

Since there's no combat, "bosses" are extended survival/puzzle sequences.

| Boss                         | Area         | Challenge                                                          |
| ---------------------------- | ------------ | ------------------------------------------------------------------ |
| **Guardian Golem**           | Forest       | Avoid its path while transforming environment to make it stop      |
| **Storm Spirit**             | Caves        | Navigate wind tunnels while creature chases                        |
| **The Corruption**           | Underground  | Spreading corruption zone, must outrun and block with Iceform      |
| **Time Eater**               | Temple       | Slow-motion creature, must freeze it in multiple Slow Fields       |
| **Shadow Army**              | Tower        | Multiple hazards at once, must survive until Mend restores barrier |
| **The Antagonist (Phase 1)** | Their domain | Direct magical interference, Nullify everything                    |
| **The Antagonist (Phase 2)** | Final        | Depends on ending chosen                                           |

### Secret Content

-   **Hidden Areas:** 3-4 bonus zones with lore and challenges
-   **Speed Run Routes:** Ability shortcuts for experienced players
-   **True Ending Requirements:** Heal all creatures, find all journals, complete bonus puzzles
-   **New Game+:** Antagonist commentary track unlocked, reacts to you knowing the story

---

## Risks & Mitigations

### Development Risks

| Risk                                 | Likelihood | Impact | Mitigation                                         |
| ------------------------------------ | ---------- | ------ | -------------------------------------------------- |
| **Puzzle design burnout**            | High       | High   | Create puzzle templates, take breaks between areas |
| **Antagonist writing quality**       | Medium     | High   | Get voice actor input, playtest lines extensively  |
| **Voice acting cost**                | Medium     | Medium | Start with text-only, add voice if funded          |
| **Level design complexity**          | High       | Medium | Use modular tileset approach                       |
| **Metroidvania backtracking tedium** | Medium     | Medium | Design efficient paths, fast travel                |

### Design Risks

| Risk                               | Likelihood | Impact | Mitigation                                                |
| ---------------------------------- | ---------- | ------ | --------------------------------------------------------- |
| **Puzzles too obscure**            | High       | High   | Playtest constantly, add optional hint system             |
| **Antagonist becomes annoying**    | Medium     | High   | Allow volume control, vary appearance frequency           |
| **Players feel powerless**         | Medium     | High   | Make non-violent abilities feel impactful and satisfying  |
| **Story unclear without dialogue** | Medium     | Medium | Redundant storytelling through multiple methods           |
| **Lack of conflict engagement**    | Medium     | Medium | Antagonist provides narrative tension even without combat |

### Market Risks

| Risk                                 | Likelihood | Impact | Mitigation                                         |
| ------------------------------------ | ---------- | ------ | -------------------------------------------------- |
| **Niche appeal**                     | Medium     | Medium | Lean into uniqueness for marketing differentiation |
| **Comparison to Undertale pacifist** | High       | Low    | Clarify this is pacifist-ONLY, not a route         |
| **Too "artsy" perception**           | Low        | Low    | Ensure puzzles are satisfying, not just aesthetic  |

---

## Feasibility Assessment

### Solo Developer Timeline

#### Prototype Phase (4-6 Weeks)

| Week | Focus                                              |
| ---- | -------------------------------------------------- |
| 1-2  | Core movement, spell system, basic puzzle elements |
| 3    | Hazard system, first area design                   |
| 4    | Antagonist implementation, voice placeholder       |
| 5-6  | Second area, Float unlock, polish, playtesting     |

#### MVP Phase (3-5 Months)

| Month | Focus                                          |
| ----- | ---------------------------------------------- |
| 1     | Expand to 4 areas, 6 spells                    |
| 2     | Full antagonist implementation, narrative pass |
| 3     | Art refinement (commission if needed)          |
| 4     | Audio pass, voice recording                    |
| 5     | Polish, bug fixing, extended playtesting       |

#### Full Game (12-18 Months from MVP)

-   All areas, all abilities
-   Full narrative implementation
-   Voice acting recording
-   Multiple endings
-   Secret content
-   Polish and QA

### Resource Requirements

#### If Staying Solo

| Resource                  | Approach                                         | Estimated Cost |
| ------------------------- | ------------------------------------------------ | -------------- |
| Art                       | 2D hand-drawn or pixel, mix of original + assets | $300-800       |
| Music                     | Ambient tracks, royalty-free or commission       | $100-500       |
| Voice Acting (Antagonist) | Fiverr or indie VA                               | $200-600       |
| SFX                       | Freesound.org + generated                        | $0-100         |

#### If Expanding After MVP

| Resource    | Approach                                  | Estimated Cost |
| ----------- | ----------------------------------------- | -------------- |
| Artist      | Commission full tileset and character art | $3,000-6,000   |
| Composer    | Original ambient soundtrack               | $1,000-2,500   |
| Voice Actor | Professional antagonist VA                | $500-1,500     |
| Writer      | Narrative polish, journal entries         | $500-1,000     |

### Technical Considerations (Godot + C#)

| System            | Complexity | Notes                                            |
| ----------------- | ---------- | ------------------------------------------------ |
| 2D Platforming    | Low-Medium | Well-supported in Godot                          |
| Spell System      | Medium     | State machine for spell effects                  |
| Transformation    | Medium     | Tile manipulation, scene management              |
| Hazard AI         | Low-Medium | Basic state machine, patrol paths                |
| Voice Line System | Low        | Audio stream with triggers                       |
| Save System       | Medium     | Must track all ability unlocks, text discoveries |
| Map System        | Medium     | Consider Godot addons for metroidvania maps      |

### Godot-Specific Recommendations

| Need          | Recommendation                                      |
| ------------- | --------------------------------------------------- |
| Tilemaps      | Use TileMapLayers for multiple terrain types        |
| Spell Effects | Particle systems + Area2D for zones                 |
| Dialogue/Text | Consider Dialogic addon adapted for text-only       |
| Saving        | JSON serialization for game state                   |
| Audio         | AudioStreamPlayer2D for positional antagonist voice |

---

## Open Questions

### Design Questions

1. **How much should the Antagonist talk?** Constant commentary might be annoying; too little loses the dynamic
2. **Should there be a hint system?** Optional? Progressive? Diegetic (antagonist mocks you into hints)?
3. **Can the player ever die?** If hazards damage, is there respawning? Checkpoint system?
4. **How to handle players trying to find violence?** What happens if they try to attack?
5. **Should there be difficulty options?** Puzzle skip? More forgiving hazards?
6. **How "dark" can the discovered texts be?** Tragic stories work, but tone consistency matters

### Narrative Questions

1. **What is the mage's gender/identity?** Ambiguous? Customizable?
2. **Is the Antagonist redeemable?** Does the Lifeblossom ending redeem or merely neutralize?
3. **What happened to the pacifist tradition?** All dead? Hiding? Just the mage left?
4. **Should there be other friendly NPCs who gesture?** Or keep it lonely?
5. **How explicit should the backstory be?** Mystery vs. clarity

### Technical Questions

1. **Voice lines: Text + voice or voice only?** Accessibility considerations
2. **How to handle ability demonstration?** Show new spell's full potential before player has it?
3. **Procedural elements anywhere?** Probably not for puzzle game, but worth asking

### Content Questions

1. **Art style: Pixel art or hand-drawn?** Both work; hand-drawn might sell the emotional story better
2. **Music style: Ambient or melodic?** Ambient reinforces atmosphere; melodic creates memorable moments
3. **Antagonist voice tone: Theatrical villain or subtle manipulator?** Both have merits

---

## Appendix: Spell Ideas Expansion

### Spell Evolution Concepts

Some spells could upgrade throughout the game:

| Base Spell    | Upgrade 1                     | Upgrade 2                            |
| ------------- | ----------------------------- | ------------------------------------ |
| Light Orb     | Light Beam (directional)      | Light Explosion (reveals large area) |
| Stone to Sand | Sand to Glass                 | Glass Prism (redirects light)        |
| Iceform       | Deep Freeze (longer duration) | Ice Bridge (solid platforms)         |
| Windpush      | Gust Tunnel (continuous)      | Cyclone (persistent area)            |

### Spell Combination Possibilities

| Combo                     | Effect                                 |
| ------------------------- | -------------------------------------- |
| Iceform + Windpush        | Slippery wind-pushed platforms         |
| Light Orb + Slow Field    | Slow everything in lit area            |
| Magnetize + Stone to Sand | Metal objects fall through sand        |
| Echo + Mend               | See what was broken, repair it exactly |

---

## Appendix: Environmental Storytelling Examples

### Area 1 (Village) Story Beats

| Scene         | Elements                                    | Story Conveyed                  |
| ------------- | ------------------------------------------- | ------------------------------- |
| Opening room  | Broken crib, scattered toys, open window    | Family fled in panic            |
| Market square | Overturned stalls, frozen mid-action        | Attack was sudden               |
| Library       | Books burned, one shelf protected by ice    | Someone tried to save knowledge |
| End mural     | Shadowy figure surrounded by peaceful mages | The Antagonist's origin         |

### Antagonist Visual Evolution

| Game Point | Appearance                           |
| ---------- | ------------------------------------ |
| Early      | Translucent shadow, barely visible   |
| Mid        | More solid, features distinguishable |
| Late       | Fully formed, visibly corrupted      |
| Final      | Depending on player actions, changes |

---

_Document will be updated as development progresses._
