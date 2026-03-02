# Ecosystem RPG - Expanded Design Document

## Executive Summary

**Working Title:** _Verdant Cascade_ (placeholder)

**Core Hook:** A first-person open-world RPG where the world isn't just a backdrop—it's a living, reactive ecosystem that remembers everything you do. Step on flowers and they don't grow back. Hunt too many predators and prey populations explode. Introduce an invasive plant and watch it spread across the continent. Your actions cascade through food webs, plant communities, and creature behaviors, creating emergent stories and consequences that persist throughout your journey.

**Target Audience:**

-   Players who loved the ecosystem feel of Subnautica but wanted more agency
-   Fans of immersive sims (Dishonored, Prey) who want world reactivity
-   Nature lovers who want fantasy ecology
-   RPG players tired of static worlds
-   Age 18-40, appreciates systemic depth

**Elevator Pitch:** "Subnautica meets Breath of the Wild—except the world actually remembers what you did to it."

---

## Market Analysis

### Comparable Products

| Game                   | What It Does Well                                                | Gap/Opportunity                                          |
| ---------------------- | ---------------------------------------------------------------- | -------------------------------------------------------- |
| **Subnautica**         | Alien ecosystem feel, survival tension, first-person exploration | Limited player impact on ecosystem, no combat control    |
| **Breath of the Wild** | Open world, systemic interactions (fire spreads, etc.)           | Ecosystem doesn't evolve, creatures respawn identically  |
| **Rain World**         | True ecosystem simulation, food chain gameplay                   | You're prey, not the main character; extremely punishing |
| **Eco**                | Real ecosystem with player impact                                | MMO, not single-player RPG; more sim than game           |
| **Dwarf Fortress**     | Deep simulation, cascading consequences                          | Roguelike/colony sim, not first-person RPG               |
| **Horizon Zero Dawn**  | Living machine "ecosystem"                                       | Purely aesthetic, no actual simulation                   |
| **The Long Dark**      | Wildlife behavior, predator/prey                                 | Survival focus, no fantasy elements or ecosystem growth  |

### Market Gap Identified

No first-person RPG currently offers:

1. Persistent ecosystem that evolves based on player actions
2. Creature populations that grow/shrink dynamically
3. Plant communities that spread, compete, and respond to trampling/harvesting
4. Cascading consequences visible over gameplay hours
5. Combat as a meaningful choice (fight back like Subnautica allows but doesn't encourage)

### Recent Successes in Adjacent Space

-   **Subnautica: Below Zero** (2021): Continued ecosystem appeal
-   **Valheim** (2021): Open world survival with biome identity
-   **Sons of the Forest** (2023): First-person survival with creature AI

---

## Core Mechanics/Features

### 1. Living Ecosystem Simulation

The heart of the game. Every creature and plant exists in an interconnected web.

#### Creature Population System

| Factor                | Effect on Population                                       |
| --------------------- | ---------------------------------------------------------- |
| **Food availability** | More food = more breeding; scarcity = starvation/migration |
| **Predation**         | More predators = fewer prey; fewer prey = predator decline |
| **Player hunting**    | Reduces population; overhunting triggers cascade           |
| **Habitat quality**   | Damaged terrain = reduced carrying capacity                |
| **Competition**       | Species compete for same resources                         |

**Example Cascade:**

1. Player overhunts wolves to feel safer
2. Deer population explodes (no predators)
3. Deer overgraze vegetation
4. Smaller herbivores starve (no plants)
5. Predatory birds that ate those herbivores decline
6. Insect population explodes (birds ate them)
7. Crops/useful plants get devastated by insects
8. Player now faces food scarcity + insect swarm annoyance

#### Plant System

| Mechanic             | Description                                                              |
| -------------------- | ------------------------------------------------------------------------ |
| **Trampling**        | Walking through vegetation damages it; paths form over time              |
| **Harvesting**       | Picking plants reduces local population; sustainable harvesting possible |
| **Spreading**        | Plants propagate naturally; some faster than others                      |
| **Competition**      | Dense plants choke out weaker species                                    |
| **Invasive Species** | Introduce plants to new biomes; may spread uncontrollably                |
| **Pollination**      | Certain plants need pollinators (bees, birds) to reproduce               |

**Visibility:** Players see their impact—trampled paths, overgrazed meadows, invasive vine overtaking a forest.

#### Creature Behavior

| Behavior Type        | Description                                   |
| -------------------- | --------------------------------------------- |
| **Territorial**      | Some creatures defend areas; others roam      |
| **Migration**        | Seasonal movement, fleeing degraded habitats  |
| **Predation AI**     | Predators hunt prey realistically             |
| **Fear/Aggression**  | Creatures learn player is dangerous over time |
| **Nesting/Breeding** | Creatures reproduce in appropriate conditions |
| **Adaptation**       | Over long timescales, behavior may shift      |

### 2. Player Impact Tools

**Intentional Ecosystem Manipulation:**

| Action            | Potential Effect                               |
| ----------------- | ---------------------------------------------- |
| **Hunting**       | Reduce predator/prey populations               |
| **Planting**      | Introduce species to new areas                 |
| **Building**      | Block creature paths, alter terrain            |
| **Fire**          | Clear vegetation, kill creatures, enrich soil  |
| **Pollution**     | Alchemy/industry byproducts affect water/soil  |
| **Feeding**       | Attract creatures, alter behavior              |
| **Domestication** | Remove creatures from wild, breed in captivity |

**Unintentional Impact:**

-   Walking creates paths
-   Camping near water scares away wildlife
-   Dropping seeds spreads plants
-   Killing one creature may attract scavengers

### 3. World Structure

**Open World, Biome-Based:**

| Biome                | Signature Creatures                             | Key Resources               | Ecosystem Dynamics                  |
| -------------------- | ----------------------------------------------- | --------------------------- | ----------------------------------- |
| **Temperate Forest** | Deer, wolves, bears, songbirds                  | Wood, herbs, mushrooms      | Classic predator/prey chain         |
| **Grasslands**       | Bison-like herds, raptors, burrowing mammals    | Grains, hides, rare flowers | Fire-dependent plant cycle          |
| **Wetlands**         | Fish, amphibians, wading birds, alligator-types | Reeds, medicine, rare fauna | Water level fluctuation             |
| **Mountains**        | Goats, eagles, snow creatures                   | Ore, rare herbs, crystals   | Vertical territory layers           |
| **Corrupted Zones**  | Mutated creatures, parasitic plants             | Magical materials           | Unstable, spreads if unchecked      |
| **Ancient Groves**   | Elder creatures, rare species                   | Ancient wood, memory herbs  | Fragile, hard to restore if damaged |

**World Size:** Medium-large, traversable in ~10-15 minutes at a run but with vertical complexity and density.

### 4. Combat System

**Design Philosophy:** Combat is important but not constant. Like Subnautica, tension comes from the possibility of danger.

**Combat Style:** First-person, real-time action

| Weapon Type                | Use Case                 | Ecosystem Impact                     |
| -------------------------- | ------------------------ | ------------------------------------ |
| **Melee (swords, spears)** | Close range, reliable    | Direct kills                         |
| **Ranged (bows, thrown)**  | Safer, requires ammo     | Can hunt from distance               |
| **Magic**                  | Versatile, resource-cost | Various—fire spreads, poison lingers |
| **Traps**                  | Passive hunting, defense | Can catch unintended creatures       |
| **Non-lethal**             | Subdue without killing   | Creature survives, may flee area     |

**Enemy Types:**

| Category             | Examples                                         | Frequency                  |
| -------------------- | ------------------------------------------------ | -------------------------- |
| **Wildlife**         | Normal animals reacting defensively or predating | Common                     |
| **Corrupted Beasts** | Twisted by magical corruption                    | Uncommon, in certain zones |
| **Rival Factions**   | Other humans/sentients exploiting ecosystem      | Uncommon                   |
| **Boss Creatures**   | Apex predators, elder beings                     | Rare, major encounters     |
| **Invasive Horrors** | Creatures from another realm                     | Late-game threat           |

**Combat-Ecosystem Integration:**

-   Killing affects population
-   Wounded creatures may be finished by other predators
-   Blood attracts scavengers
-   Loud combat scares nearby wildlife
-   Fire from magic/weapons spreads

### 5. RPG Systems

**Character Progression:**

| System         | Description                                                      |
| -------------- | ---------------------------------------------------------------- |
| **Skills**     | Improve through use (hunting, foraging, crafting, combat styles) |
| **Perks**      | Earned at milestones; specialize playstyle                       |
| **Reputation** | With factions, and with the ecosystem itself                     |
| **Equipment**  | Crafted from gathered/hunted materials                           |
| **Knowledge**  | Learn creature behaviors, plant properties, recipes              |

**Ecosystem Reputation System:**

| Reputation Level    | Effects                                                  |
| ------------------- | -------------------------------------------------------- |
| **Destroyer**       | Creatures fear/flee you; corrupted zones may embrace you |
| **Hunter**          | Predators respect you; prey avoids you                   |
| **Neutral**         | Default; creatures react based on species norms          |
| **Guardian**        | Wildlife is calmer around you; may assist in combat      |
| **One With Nature** | Rare creatures approach; plants grow faster near you     |

**Crafting:**

All crafting uses gathered/hunted materials:

-   Weapons/armor (hides, bones, ore, wood)
-   Potions/medicine (plants, creature parts)
-   Tools (various)
-   Structures (wood, stone, special materials)

Sustainability matters: overharvesting = scarcity = weaker gear

### 6. Narrative Integration

**Main Story:**
The land faces a creeping Corruption that disrupts ecosystems. The player investigates its source and must decide how to address it.

**Key Narrative Questions:**

-   Is the Corruption unnatural, or nature's way of resetting?
-   Should you fight it directly, or restore ecosystems to resist it?
-   Are some sacrifices (species extinction) necessary for the greater good?

**Story Delivery:**

-   Environmental storytelling (see consequences)
-   NPC factions with different ecosystem philosophies
-   Personal journal tracking observations
-   Rare elder creatures that communicate

**Faction Examples:**

| Faction            | Philosophy                             | Relationship with Player                   |
| ------------------ | -------------------------------------- | ------------------------------------------ |
| **The Wardens**    | Preserve balance, minimal intervention | Approve of guardianship                    |
| **The Harvesters** | Sustainable use of nature              | Approve of hunting/gathering in moderation |
| **The Dominion**   | Nature exists to serve civilization    | Approve of exploitation                    |
| **The Rewilders**  | Remove all humanoid influence          | Approve only if you minimize footprint     |
| **The Corrupted**  | Embrace the Corruption as evolution    | Approve if you spread Corruption           |

---

## Prototype MVP

### Minimum Viable Prototype Scope

**Included:**

-   1 biome (Temperate Forest, ~5-10 min traversal)
-   5-7 creature species with population dynamics
-   3 trophic levels (plants → herbivores → predators)
-   Basic plant system (trampling, harvesting, regrowth)
-   First-person movement and exploration
-   Simple combat (1-2 weapon types)
-   Crafting (5-10 recipes)
-   Population tracking visible to player
-   Cascade demonstration (hunting predators → prey explosion)
-   Day/night cycle with behavior changes

**Excluded from MVP:**

-   Multiple biomes
-   Full narrative
-   Factions/NPCs
-   Magic system
-   Corruption mechanic
-   Base building
-   Complex reputation

### Development Milestones

| Milestone                   | Description                                         | Est. Time |
| --------------------------- | --------------------------------------------------- | --------- |
| **M1: World & Movement**    | First-person controller, terrain, basic environment | 2-3 weeks |
| **M2: Creatures (Static)**  | Creature models, idle behavior, spawning            | 2-3 weeks |
| **M3: Population Dynamics** | Breeding, death, food requirements                  | 3-4 weeks |
| **M4: Predation AI**        | Creatures hunt each other                           | 2-3 weeks |
| **M5: Plant System**        | Growth, trampling, harvesting                       | 2-3 weeks |
| **M6: Combat**              | Player attacks, creature reactions, death           | 2-3 weeks |
| **M7: Cascades**            | Connect systems, verify emergent behavior           | 2-3 weeks |
| **M8: Feedback Loop**       | UI for population tracking, player knowledge        | 2 weeks   |
| **M9: Polish Pass**         | Visual feedback, balance, tutorialization           | 2-3 weeks |

**Total MVP Estimate:** 20-28 weeks (solo, part-time)

### Success Criteria

| Metric             | Target                                               |
| ------------------ | ---------------------------------------------------- |
| Cascade visibility | Testers notice and describe population changes       |
| Emergent stories   | Testers share "I did X and Y happened" stories       |
| Combat tension     | Testers feel danger without constant fighting        |
| Exploration pull   | Testers want to see what's over the next hill        |
| Impact regret      | Testers occasionally regret overhunting/overforaging |

---

## Full Vision

If the prototype validates, the full game could include:

### Content Expansion

-   **6+ Biomes** with unique ecosystems
-   **50+ Creature Species** with distinct niches
-   **Seasonal Changes** affecting behavior and availability
-   **Full Narrative** with multiple endings based on ecosystem state
-   **5 Factions** with reputation and questlines
-   **Corruption System** as dynamic late-game threat
-   **Rare/Legendary Creatures** with unique encounters
-   **Underwater Areas** (Subnautica homage)

### Systems Expansion

-   **Domestication:** Tame and breed creatures
-   **Farming:** Sustainable food production
-   **Base Building:** Impact surrounding ecosystem
-   **Magic System:** Nature-themed abilities
-   **Weather:** Affects ecosystems dynamically
-   **Fossils/Paleontology:** Discover extinct species, possibly resurrect
-   **Photo Mode:** Document ecosystem discoveries

### Advanced Simulation

-   **Genetic Variation:** Creatures have traits that affect fitness
-   **Evolution Over Time:** Long-term play sees adaptation
-   **Symbiosis/Parasitism:** Complex species relationships
-   **Seasonal Migration:** Creatures move between biomes
-   **Ecosystem Services:** Certain species benefit the player (pollinators, soil enrichers)

---

## Risks & Mitigations

| Risk                                | Likelihood | Impact | Mitigation                                                                         |
| ----------------------------------- | ---------- | ------ | ---------------------------------------------------------------------------------- |
| **Simulation too complex**          | High       | High   | Start minimal (5 species); add complexity gradually                                |
| **Performance issues**              | High       | Medium | Batch processing, LOD for distant creatures, limit simultaneous simulated entities |
| **Unintended cascades break game**  | Medium     | High   | Implement population floors, extinction recovery mechanisms                        |
| **Player misses ecosystem changes** | Medium     | Medium | Clear UI feedback, NPC comments, journal observations                              |
| **Combat feels disconnected**       | Medium     | Medium | Ensure every combat has ecosystem consequence                                      |
| **3D first-person scope**           | High       | High   | Consider scope reduction (smaller world, simpler visuals)                          |
| **Narrative doesn't land**          | Medium     | Medium | Environmental storytelling first; explicit narrative optional                      |
| **Art asset burden**                | High       | High   | Use stylized/low-poly aesthetic; prioritize creature variety over detail           |

---

## Feasibility Assessment

### Technical Considerations (Godot + C#)

| System                     | Complexity  | Notes                                          |
| -------------------------- | ----------- | ---------------------------------------------- |
| 3D First-Person Controller | Low-Medium  | Well-documented, Godot handles well            |
| Creature AI                | Medium      | State machines + steering behaviors            |
| Population Simulation      | Medium-High | Needs efficient update loop; consider chunking |
| Plant System               | Medium      | Cellular automata or agent-based               |
| Combat                     | Medium      | First-person melee/ranged in 3D                |
| Open World Streaming       | Medium-High | Godot 4.x has better support                   |
| Save System                | Medium      | Must serialize entire ecosystem state          |
| Performance Optimization   | High        | Key risk; profile early and often              |

### 3D Art Considerations

**Recommended Style:** Stylized, low-poly with good color design

**Why:**

-   Faster to create
-   Better performance
-   Ages well
-   Solo-dev friendly

**Asset Strategy:**

-   Core creatures: Commission or purchase packs
-   Environment: Modular tilesets, procedural placement
-   Animations: Minimal but characterful

### Realistic Timeline (Solo, Part-Time ~20hr/week)

| Phase                    | Duration         |
| ------------------------ | ---------------- |
| Pre-production           | 4-6 weeks        |
| MVP Development          | 24-32 weeks      |
| MVP Testing/Polish       | 6-8 weeks        |
| **MVP Total**            | **~8-12 months** |
| Full Game (if validated) | +18-24 months    |

**Note:** This is an ambitious scope for a solo developer. Consider:

-   Starting with 2D top-down version to validate ecosystem mechanics
-   Partnering with an artist
-   Longer timeline expectations

---

## Open Questions

1. **Scope Reduction:** Would a 2D top-down version still capture the appeal? Much more feasible.

2. **Simulation Visibility:** How do you show players the ecosystem state without overwhelming UI?

3. **Time Acceleration:** Should the game have a "wait" function to see long-term changes faster?

4. **Creature Attachment:** How do you balance emotional attachment to creatures with hunting necessity?

5. **Irreversibility:** If a player causes extinction, is recovery possible? Should it be?

6. **Multiplayer Potential:** Would shared ecosystem manipulation enhance or complicate the experience?

7. **Difficulty:** How to balance ecosystem harshness with player fun?

8. **Tutorial Challenge:** How to teach ecosystem thinking without infodumping?

9. **Performance Budget:** How many simultaneous simulated creatures can Godot handle in 3D?

10. **Corruption Design:** Is the Corruption a solvable problem, or an endless threat to manage?

---

## Research & References

### Games to Study

-   **Rain World:** Deep ecosystem AI
-   **Dwarf Fortress:** Procedural history and ecology
-   **Subnautica:** First-person exploration with ecosystem feel
-   **Eco:** Actual ecosystem simulation (too complex for solo, but study dynamics)
-   **Breath of the Wild:** Systemic world design
-   **The Long Dark:** Wildlife behavior modeling

### Academic/Technical

-   Lotka-Volterra equations (predator/prey modeling)
-   Agent-based modeling for ecosystems
-   Carrying capacity and population dynamics
-   Invasive species spread patterns

---

## Next Steps

1. **Paper Prototype:** Model 5-species ecosystem in spreadsheet; verify cascades work on paper
2. **2D Prototype Option:** Consider building ecosystem sim in 2D first to validate
3. **Creature AI Test:** Build one predator hunting one prey in Godot 3D
4. **Performance Benchmark:** How many simple agents can Godot handle at 60fps?
5. **Art Direction Test:** Create one stylized creature to establish visual language

---

_Document Version: 1.0_
_Created: January 3, 2026_
