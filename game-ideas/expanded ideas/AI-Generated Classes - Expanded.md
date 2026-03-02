# AI-Generated Classes

## Executive Summary

**Core Hook**: A roguelike RPG where your class isn't chosen from a menu—it's generated uniquely for each run by an AI system. You might get "Echomancer: Wields sound as a weapon, abilities reverberate and chain between enemies" or "Thornwarden: Bleeds health into allies while growing more powerful at low HP." Every run begins with learning what you've become.

**Target Audience**: Roguelike enthusiasts who crave variety—players who've memorized every build in Slay the Spire, Hades, or Risk of Rain and want genuine surprise. Also appeals to the TTRPG/D&D crowd who love character generation.

**Genre**: Roguelike RPG with procedural combat  
**Platform**: PC (single-player)  
**AI Approach**: Hybrid—LLM generates thematic concepts; game logic assembles mechanics from pre-built components

---

## Market Analysis

### What's Succeeding

| Game | Relevant Feature | Why It Works |
|------|------------------|--------------|
| **Slay the Spire** | 4 distinct classes, deep builds | Class identity drives replay; but eventually memorized |
| **Hades II** | Boon combinations | Emergent builds from random offerings |
| **Risk of Rain 2** | 15+ survivors | Character variety is the replay hook |
| **Caves of Qud** | Procedural mutations/cybernetics | Random powers create stories |
| **Noita** | Wand crafting | Emergent spell systems |
| **AI Dungeon / KoboldAI** | AI-driven narrative | Proven audience for AI-generated content |

### Comparable Products

| Game | AI Use | Limitation |
|------|--------|------------|
| **AI Dungeon** | Narrative generation | Text-only, no mechanics |
| **Dwarf Fortress** | Procedural everything | Complex but not AI-generated *design* |
| **Wildermyth** | Procedural story beats | Pre-authored content, not AI |
| **No Man's Sky** | Procedural worlds | Generation is mathematical, not semantic |

### Identified Gap

**No game uses AI to generate mechanically-backed character archetypes.** Procedural generation in games is typically:
- Random stat distributions (boring)
- Pre-authored content remixed (eventually exhausted)
- Purely cosmetic variation (doesn't affect gameplay)

An AI that understands fantasy tropes and can create *coherent, thematic class designs* with real mechanical depth doesn't exist yet. The opportunity is to bridge AI creativity with structured game mechanics.

---

## Core Mechanics

### 1. The Generation Pipeline

```
[LLM/AI Layer]           [Game Logic Layer]           [Player Experience]
     │                          │                            │
  Concept ──────────────► Component ────────────────► Playable Class
  Generation               Assembly                    Presentation
     │                          │                            │
"Echomancer:             Stats: +INT, -STR            Name: Echomancer
 Wields sound..."        Primary: Sonic Bolt          Description: ...
                         Passive: Echo (chain 30%)    Abilities: 4 skills
                         Scaling: damage = INT×1.2    Starting gear: Staff
```

### 2. Component Library (Pre-Programmed Building Blocks)

The AI doesn't generate *code*—it selects and configures from a large library of modular components.

#### Stat Profiles (10-15 variants)

| Profile | Primary | Secondary | Dump | Playstyle |
|---------|---------|-----------|------|-----------|
| Glass Cannon | INT or DEX | Speed | CON | High damage, squishy |
| Bruiser | STR | CON | INT | Melee, tanky |
| Skirmisher | DEX | Speed | STR | Mobile, hit-and-run |
| Summoner | INT | CON | STR | Minion-focused |
| Support | WIS | CON | STR | Healing/buffs |
| Blood Mage | INT | — | CON (costs HP) | Risk/reward caster |

#### Ability Archetypes (50-100 variants)

Each ability has configurable parameters:

| Archetype | Parameters | Example Instance |
|-----------|------------|------------------|
| **Projectile** | Element, speed, size, pierce, homing | "Sonic Bolt: Fast, medium, chains to 2 targets" |
| **AOE** | Shape, radius, delay, element | "Resonance: Circle, 3m, instant, sound damage" |
| **Buff** | Stat affected, %, duration, condition | "War Cry: +30% damage for 5s after kill" |
| **Summon** | Type, count, duration, AI behavior | "Echo Clone: 1 copy, 10s, mimics last ability" |
| **Passive** | Trigger, effect, chance/cooldown | "Reverberate: On hit, 30% chance to chain" |
| **Transform** | Stat changes, duration, ability swap | "Banshee Form: +50% speed, -50% HP, new abilities" |
| **DOT** | Element, tick rate, duration, stacking | "Hemorrhage: Bleed, 1s, 6s, stacks to 5" |

#### Synergy Tags (Emergent Builds)

Each component has tags. AI is instructed to generate classes with coherent tag clusters:

| Tag Examples | Synergy Potential |
|--------------|-------------------|
| `sound`, `echo`, `vibration` | Chain effects, AOE, crowd control |
| `blood`, `sacrifice`, `vitality` | HP costs, lifesteal, low-HP power |
| `shadow`, `stealth`, `ambush` | Crit damage, invisibility, backstab |
| `growth`, `nature`, `thorn` | DOTs, healing, summons |
| `time`, `haste`, `slow` | Speed manipulation, cooldown reduction |

### 3. AI Generation Process

#### Option A: LLM-Powered (Online)

**Prompt Engineering Approach**:

```
System: You are a fantasy class designer for a roguelike RPG. Generate unique, 
flavorful classes using ONLY the provided component library. Output JSON.

Input: Generate a class themed around "primal sound and echoes"

Output:
{
  "name": "Echomancer",
  "title": "Voice of the Hollow",
  "description": "Wields vibrations as weapons. Attacks reverberate, growing 
                  stronger with each echo. Fragile but devastating at range.",
  "stat_profile": "glass_cannon_int",
  "abilities": [
    {"archetype": "projectile", "element": "sound", "chain": 2, "name": "Sonic Bolt"},
    {"archetype": "aoe", "shape": "cone", "element": "sound", "name": "Shriek"},
    {"archetype": "passive", "trigger": "on_ability", "effect": "chain_30%", "name": "Reverberate"},
    {"archetype": "buff", "stat": "damage", "condition": "after_chain", "name": "Resonance"}
  ],
  "starting_equipment": ["tuning_staff", "echo_crystal"],
  "tags": ["sound", "echo", "ranged", "chain", "glass_cannon"]
}
```

**Benefits**: High creativity, thematic coherence, novel combinations  
**Drawbacks**: Requires API (cost, latency, offline impossible)

#### Option B: Markov/Template (Offline)

**Pre-generated corpus approach**:

1. Use LLM to generate 500+ class concepts during development
2. Store as templates with variable slots
3. Runtime: Select template, randomize variables, ensure coherence via rules

```
Template: [ELEMENT]mancer - Wields [ELEMENT] as a weapon...
Variables: ELEMENT = [fire, ice, sound, shadow, blood, crystal, void...]
```

**Benefits**: Offline, fast, predictable  
**Drawbacks**: Eventually exhausted, less magical feeling

#### Option C: Hybrid (Recommended)

- **Offline mode**: Markov/template generation from large pre-generated corpus
- **Online mode**: Real LLM generation for "truly unique" classes (optional)
- **Caching**: Store generated classes for reuse across runs if desired

### 4. Class Presentation (The Reveal)

The moment of class reveal is critical for emotional impact:

1. **Dramatic intro**: Dark screen, text fades in with class name
2. **Lore snippet**: 1-2 sentences of flavor text
3. **Ability showcase**: Each ability demonstrated briefly
4. **Stats revealed**: Visual comparison to "baseline adventurer"
5. **"Accept your fate"**: Player cannot reject—this IS your run

### 5. Enemy & Upgrade Generation

#### Enemies (Simpler Generation)

Enemies can be:
- **Fully static**: Hand-designed enemy roster
- **Tag-reactive**: Spawn enemies that counter or complement player tags
- **Partially generated**: Static base enemies with random modifiers

| Approach | Pros | Cons |
|----------|------|------|
| Static enemies | Predictable balance, hand-tuned | Less variety |
| Tag-reactive spawns | Runs feel tailored | Complexity, potential frustration |
| Modified enemies | Variety within bounds | Still eventually memorized |

**Recommendation**: Start with static enemies. Add tag-reactive modifiers post-MVP.

#### Upgrades (During Run)

| Upgrade Type | Generation Approach |
|--------------|---------------------|
| **Stat boosts** | Generic pool (all classes) |
| **Ability mutations** | Tag-matched to class (sound class → sound upgrades) |
| **New abilities** | Rare; pulled from same archetype library |
| **Synergy unlocks** | If class has specific tag combo, offer synergy upgrades |

---

## Prototype MVP

### Minimal Scope (3-5 weeks)

**One floor. AI class generation working. Combat functional. Run completable.**

#### Must Have
- [ ] Component library: 3 stat profiles, 10 ability archetypes, 20 ability instances
- [ ] AI generation: Template-based offline OR simple LLM integration
- [ ] Class reveal screen with name, description, abilities
- [ ] Basic turn-based or real-time combat (your preference)
- [ ] 3-5 enemy types (static)
- [ ] One floor/area to clear
- [ ] Win/lose condition
- [ ] "New Run" loops back to fresh class generation

#### Nice to Have
- [ ] 2-3 upgrade offerings per floor
- [ ] Tag-based upgrade filtering
- [ ] Class rating/favorites system

### Success Criteria

| Metric | Target | Measurement |
|--------|--------|-------------|
| **Variety perception** | 5 runs feel like 5 different games | Playtest interviews |
| **Class coherence** | Generated classes make thematic sense | Review generated outputs |
| **Mechanical viability** | All generated classes are *playable* (not broken/useless) | Balance testing |
| **Discovery joy** | Players excited to see their new class | Observe reactions |

### Prototype Test Questions

1. Do generated classes feel unique enough to justify the system?
2. Are there "garbage" classes that feel unplayable?
3. Does the component library feel limiting or sufficient?
4. Is offline generation quality acceptable?
5. Do players want to "reroll" their class (bad sign) or embrace it?

---

## Full Vision

### If Prototype Succeeds

#### Expanded Component Library

| Category | MVP Count | Full Vision |
|----------|-----------|-------------|
| Stat profiles | 3 | 15+ |
| Ability archetypes | 10 | 50+ |
| Ability instances | 20 | 200+ |
| Tag categories | 5 | 25+ |
| Equipment types | 5 | 30+ |

#### Content Depth

| Feature | Description |
|---------|-------------|
| **3-5 biomes** | Each with themed enemies and hazards |
| **Boss fights** | Hand-crafted but adapt to player class tags |
| **Meta progression** | Unlock new component pools (dark magic, tech, etc.) |
| **Class journaling** | Save favorite generated classes, view history |
| **Seed sharing** | Share class generation seeds with others |
| **Challenge modes** | "Ironman," "Cursed Classes" (intentionally bad), etc. |

#### AI Enhancement (Online-Optional)

| Feature | Description |
|---------|-------------|
| **Lore generation** | Full backstory paragraphs per class |
| **Ability naming** | Contextually appropriate skill names |
| **Enemy generation** | AI-designed enemies for late-game variety |
| **Run narration** | AI comments on your run's story |

---

## Risks & Mitigations

| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
| **Garbage classes** | High | High | Validation rules; minimum viability checks; curated component combos |
| **Samey classes** | Medium | High | Large component library; ensure tag diversity per run |
| **Balance chaos** | High | Medium | Roguelike forgives imbalance—runs are short; tune via playtesting |
| **API costs (online)** | Medium | Medium | Offline fallback; cache generations; limit API calls per session |
| **AI generates nonsense** | Medium | Medium | Strong prompting; output validation; fallback to templates |
| **Complexity creep** | High | Medium | Strict component boundaries; avoid special-case code |
| **Scope explosion** | High | High | MVP is minimal; validate before expanding |

### Biggest Risk

**The component library is never big enough.** After 10 runs, players will recognize ability archetypes. Mitigation: Variety comes from *combination*, not individual components. Even 20 archetypes with 5 elements and 10 modifiers = 1000+ permutations.

---

## Feasibility Assessment

### Timeline (Solo Dev, Godot/C#)

| Phase | Duration | Deliverables |
|-------|----------|--------------|
| **Core systems** | 2 weeks | Stat system, ability framework, component loading |
| **Generation pipeline** | 2 weeks | Template-based generation, class assembly |
| **Combat prototype** | 2-3 weeks | Basic combat loop with abilities working |
| **Content population** | 2 weeks | Initial component library, enemy roster |
| **Prototype complete** | 2 weeks | Integration, UI, run loop |
| **Validation** | 1-2 weeks | Playtesting, kill/continue decision |
| **Vertical slice** | 6-8 weeks | Polished first biome, expanded library, 30+ classes possible |
| **Full MVP** | 4-6 months | Multiple biomes, meta progression, 100+ class variations |

### Technical Considerations

| System | Complexity | Notes |
|--------|------------|-------|
| Component library | Medium | JSON/data-driven; design good schemas early |
| Ability system | Medium-High | Generic ability executor; avoid per-ability code |
| Template generation | Low | String substitution, weighted random |
| LLM integration | Medium | OpenAI API straightforward; error handling needed |
| Validation logic | Medium | Check class doesn't break game; stat minimums |
| Combat system | Medium | Standard roguelike combat; your choice of real-time vs turn-based |
| Save/load | Low-Medium | Serialize generated class + run state |

### Offline vs Online Tradeoffs

| Factor | Offline (Templates) | Online (LLM) |
|--------|---------------------|--------------|
| Creativity | Limited to templates | High, novel outputs |
| Cost | Free | ~$0.01-0.05 per class |
| Latency | Instant | 1-3 seconds |
| Reliability | 100% | API dependent |
| Player perception | "Procedural" | "AI-generated" (marketing value) |

**Recommendation**: Build offline-first. Add optional online enhancement for players who opt-in.

---

## Open Questions

1. **Combat style?** Turn-based (simpler, clearer) or real-time (more engaging)? Hybrid?

2. **How many abilities per class?** 4 active + 1 passive? More?

3. **Ability unlocking?** Start with all abilities, or unlock during run?

4. **How to handle bad RNG?** If a class feels terrible, do players have *any* recourse?

5. **Meta-progression scope?** Unlock new generation pools, or keep it pure roguelike (no permanent upgrades)?

6. **Art direction?** With infinite classes, how to handle class-specific sprites? Generic character + ability VFX?

7. **What's the fantasy grounding?** Why do players get random classes in-world? Curse? Experiment? Multiverse?

8. **Multiplayer potential?** Co-op with randomly generated complementary classes could be interesting.

---

## Implementation Notes: Component Architecture

### Example Ability Schema (JSON)

```json
{
  "id": "sonic_bolt",
  "archetype": "projectile",
  "name_template": "{ADJECTIVE} {ELEMENT} Bolt",
  "parameters": {
    "damage_base": 15,
    "damage_scaling": {"stat": "INT", "ratio": 1.2},
    "projectile_speed": 400,
    "projectile_count": 1,
    "pierce": false,
    "chain_count": 0,
    "element": "sound"
  },
  "tags": ["ranged", "sound", "single_target"],
  "modifiers_allowed": ["chain", "pierce", "multishot", "homing"],
  "description_template": "Fires a bolt of {ELEMENT} that deals {DAMAGE} damage."
}
```

### Class Generation Pseudocode

```csharp
Class GenerateClass(string themeHint = null)
{
    // 1. Pick or generate theme
    var theme = themeHint ?? PickRandomTheme(); // "sound", "blood", "shadow"
    
    // 2. Select stat profile matching theme
    var statProfile = SelectStatProfile(theme);
    
    // 3. Assemble abilities from pool
    var abilities = new List<Ability>();
    abilities.Add(SelectAbility(theme, "projectile_or_melee")); // Primary
    abilities.Add(SelectAbility(theme, "aoe_or_utility"));       // Secondary
    abilities.Add(SelectAbility(theme, "defensive_or_buff"));    // Defensive
    abilities.Add(SelectPassive(theme));                          // Passive
    
    // 4. Validate (no broken combos, minimum viability)
    while (!Validate(abilities, statProfile))
        abilities = RerollConflicts(abilities);
    
    // 5. Generate presentation
    var name = GenerateName(theme);
    var title = GenerateTitle(theme);
    var description = GenerateDescription(theme, abilities);
    
    return new Class(name, title, description, statProfile, abilities);
}
```

---

## Summary

AI-Generated Classes offers a novel roguelike hook: every run is truly unpredictable because your *character* is unpredictable. By combining LLM creativity with structured component libraries, the system can generate coherent, playable classes that feel thematic and fresh.

The key insight is that AI generates *concepts and configuration*, not code. The game logic remains stable and pre-tested; the AI just decides which pieces to combine and how to describe them.

**Verdict**: High replay value, unique hook, moderate complexity. Offline-first approach is feasible for solo dev. Worth prototyping.
