# Skill Tree with Positives and Negatives

## Executive Summary

**Core Hook**: A skill tree where every node is a tradeoff—you gain something powerful, but you also accept a permanent drawback that reshapes how you play. Want "Adrenaline Rush" (+50% damage at low HP)? You also get "Glass Nerves" (take +25% damage below half health). The tree forces meaningful, identity-defining choices rather than pure power accumulation.

**Target Audience**: Players who love build crafting and character identity—fans of Path of Exile's complex trees, Hades' god builds, or any RPG where choices feel consequential. Also appeals to challenge-run enthusiasts who *like* restrictions.

**Genre**: Roguelike RPG (permanent choices per run) or traditional RPG (limited respec)  
**Core Philosophy**: Every point spent changes *how* you play, not just *how powerful* you are

---

## Market Analysis

### What's Succeeding

| Game | Skill Tree Approach | Strength / Weakness |
|------|---------------------|---------------------|
| **Path of Exile** | Massive passive tree | Depth overwhelming; mostly "+X%" nodes feel samey |
| **Hades** | Boon combinations | Synergy hunting is fun; choices not permanent |
| **Slay the Spire** | Card additions as "skills" | Every card is a tradeoff (deck dilution); elegant |
| **Dark Souls** | Stat allocation | Simple but meaningful; soft caps create decisions |
| **Vampire Survivors** | Simple unlocks | Accessible; no real tradeoffs |
| **Darkest Dungeon** | Quirks (positive/negative) | Negative traits create character identity |

### Comparable Products

| Game | Tradeoff Mechanic | Limitation |
|------|-------------------|------------|
| **Darkest Dungeon quirks** | Random positive/negative pairs | Not chosen, just endured |
| **Binding of Isaac items** | Some items have downsides | Inconsistent; many are pure upgrades |
| **Caves of Qud mutations** | Defects required for points | Point-buy, not tree structure |
| **Risk of Rain 2 Artifact of Command** | Tradeoff artifacts | Separate system, not skill tree |

### Identified Gap

**No game has a *skill tree* where every single node is explicitly a tradeoff.** Games have:
- Trees with mostly-positive nodes and occasional negative gates
- Random negative traits alongside random positives
- Point-buy systems where negatives fund positives

A unified tree where *choosing growth means choosing limitation* is unexplored. The design space allows for:
- Builds defined by their *weaknesses* as much as strengths
- Strategic depth from synergizing positives while mitigating negatives
- Runs that feel radically different based on tradeoff combinations

---

## Core Mechanics

### 1. Tradeoff Node Structure

Every node contains **one positive effect** and **one negative effect**. You cannot take one without the other.

```
┌─────────────────────────────────────┐
│         ADRENALINE RUSH             │
├─────────────────────────────────────┤
│  ✓ +50% damage when below 30% HP    │
│  ✗ Take +25% damage when below 50%  │
├─────────────────────────────────────┤
│  Synergizes: Low HP builds          │
│  Conflicts: Tank/sustain builds     │
└─────────────────────────────────────┘
```

### 2. Tradeoff Categories

Nodes are categorized by what kind of tradeoff they represent:

| Category | Positive Example | Negative Example | Playstyle Impact |
|----------|------------------|------------------|------------------|
| **Risk/Reward** | More damage at low HP | More vulnerable at low HP | Aggressive, edge-riding |
| **Specialization** | +100% fire damage | -50% all other elements | Committed to one element |
| **Resource Shift** | Abilities cost HP instead of mana | HP pool is your mana now | Blood mage fantasy |
| **Tempo Swap** | +50% damage for 10s at fight start | -30% damage after 10s | Burst vs. sustain |
| **Stat Redistribution** | +30% STR | -15% DEX and INT | Classic stat tradeoff |
| **Situational** | +80% damage to full HP enemies | -20% damage to low HP enemies | Opener specialist |
| **Ability Mutation** | Attack hits all enemies in range | Attack speed halved | AOE vs. single target |
| **Defense/Offense** | Block grants attack buff | Cannot dodge | Playstyle pivot |

### 3. Tree Structure

#### Layout Philosophy

- **One universal tree** (all players access the same tree)
- **Multiple entry points** (players start at different edges based on... starting class? random? choice?)
- **Branching paths** that encourage commitment
- **Cross-tree connections** for hybrid builds (at higher cost?)

#### Visual Concept

```
                    [Elemental Mastery]
                          │
            ┌─────────────┼─────────────┐
            │             │             │
      [Fire Focus]   [Ice Focus]   [Lightning Focus]
            │             │             │
      [Pyromaniac]   [Shatter]     [Static Field]
            │             │             │
            └──────┬──────┴─────────────┘
                   │
              [Elemental Chaos]
                   │
                   │
    ═══════════════╪═══════════════ (center line)
                   │
                   │
              [Glass Cannon]
                   │
            ┌──────┴──────┐
            │             │
      [Speed Demon]  [Heavy Hitter]
            │             │
       [Evasion Master] [Armor Break]
```

#### Connection Rules

| Rule | Description | Example |
|------|-------------|---------|
| **Adjacency requirement** | Must have an adjacent node to unlock | Can't skip to center |
| **No backtracking** | Taken nodes are permanent | Roguelike: no respec |
| **Cross-branch paths** | Some nodes connect distant branches | Hybrid builds possible but costly |
| **Keystone nodes** | Rare, powerful nodes with harsh tradeoffs | "All or Nothing: 2x damage, 1 HP" |

### 4. Example Nodes (Detailed)

#### Tier 1 (Early Game / Mild Tradeoffs)

| Node Name | Positive | Negative | Tags |
|-----------|----------|----------|------|
| **Quick Draw** | +20% attack speed | -10% damage per hit | Speed, DPS neutral |
| **Heavy Strikes** | +25% damage | -15% attack speed | Damage, slow |
| **Thick Skin** | +15% max HP | -10% movement speed | Tank, slow |
| **Light Feet** | +15% movement speed | -10% max HP | Mobile, glass |
| **Sharp Eyes** | +20% crit chance | -10% base damage | Crit build, inconsistent |
| **Broad Strokes** | Attacks hit +1 target | -15% accuracy | AOE, unreliable |

#### Tier 2 (Mid Game / Significant Tradeoffs)

| Node Name | Positive | Negative | Tags |
|-----------|----------|----------|------|
| **Pyromaniac** | +80% fire damage | -40% ice and lightning damage | Element specialist |
| **Blood Pact** | Lifesteal on all attacks (10%) | -25% max HP | Sustain, risk |
| **Adrenaline Junkie** | +2% damage per 1% missing HP | Take +1% damage per 1% missing HP | Low HP |
| **Crowd Pleaser** | +15% damage per nearby enemy | -5% damage per nearby ally | Solo fighter |
| **Glass Cannon** | +40% damage | Defense reduced by 50% | High risk |
| **Turtle Stance** | +50% defense when standing still | -30% defense when moving | Positional |

#### Tier 3 (Late Game / Build-Defining)

| Node Name | Positive | Negative | Tags |
|-----------|----------|----------|------|
| **All or Nothing** | Damage ×2 | Max HP set to 1 | Extreme glass cannon |
| **Pacifist's Rage** | Damage +10% for each enemy you haven't killed | Damage -50% base | Pacifist/boss killer |
| **One With Shadows** | Invisible while standing still | Cannot attack while invisible | Stealth |
| **Chrono Shift** | +100% damage to first enemy each room | Cannot damage last enemy (must wait) | Opener |
| **Blood for Blood** | Abilities cost 0 mana | Abilities cost 10% current HP | Blood mage |
| **Perfectionist** | +100% crit damage | Normal hits deal 50% damage | High variance |

#### Keystone Nodes (Ultra-Rare, Run-Defining)

| Node Name | Positive | Negative | Notes |
|-----------|----------|----------|-------|
| **Immortal Coward** | Cannot die (revive at 1 HP) | Cannot deal damage for 10s after revival | Survival focused |
| **Berserker's End** | Damage scales to ∞ as HP approaches 0 | Healing is disabled | The ultimate gamble |
| **Elemental Singularity** | All damage becomes all elements | Base damage reduced by 70% | Synergy master |
| **The Tortoise** | Regenerate 10% HP/s when not attacking | Cannot attack for 3s after being hit | Passive sustain |

### 5. Synergy & Anti-Synergy

The system's depth comes from how tradeoffs interact:

#### Positive Synergies

| Combo | Synergy |
|-------|---------|
| Adrenaline Junkie + Blood Pact | Low HP build with sustain |
| Glass Cannon + Evasion Master | High damage, dodge to survive |
| Pyromaniac + Fire Starter | Commit to fire, stack bonuses |
| Quick Draw + Bleed on Hit | Fast attacks = fast stacking |

#### Negative Synergies (Avoid)

| Combo | Conflict |
|-------|----------|
| Glass Cannon + Adrenaline Junkie | Double damage taken at low HP = instant death |
| Heavy Strikes + Quick Draw | Speed penalty + speed bonus = wasted point |
| Pyromaniac + Ice Focus | Element bonuses cancel |

#### Mitigation Strategies

Part of the game is finding ways to *mitigate* the negatives:

| Negative | Mitigation Approach |
|----------|---------------------|
| Reduced HP | Lifesteal, shields, one-shot prevention |
| Reduced damage | Attack speed, DOTs, summons |
| Reduced speed | Mobility abilities, ranged playstyle |
| Element restriction | Commit fully, build around one element |

---

## Prototype MVP

### Minimal Scope (2-3 weeks)

**Functional skill tree with 15-20 nodes. Basic combat to test tradeoffs. One run completable.**

#### Must Have
- [ ] Skill tree UI: Visual tree with node selection
- [ ] 15-20 tradeoff nodes across 3 tiers
- [ ] Stat system: HP, damage, speed, defense, crit (basic)
- [ ] Node unlocking: Adjacency requirement, permanent selection
- [ ] Basic combat: Attack, take damage, see stats in action
- [ ] 3-5 enemy types to test against
- [ ] One completable run (3-5 rooms)
- [ ] Node tooltip: Shows positive, negative, and current stats

#### Nice to Have
- [ ] Synergy/anti-synergy warnings in UI
- [ ] Build summary screen
- [ ] "Undo last point" for testing (disabled in real runs)

### Success Criteria

| Metric | Target | Measurement |
|--------|--------|-------------|
| **Meaningful choices** | No "always take" or "never take" nodes | Observe diverse builds in playtesting |
| **Tradeoff felt** | Negatives impact gameplay noticeably | Players adapt playstyle to negatives |
| **Build identity** | Different trees feel like different characters | Playtest feedback |
| **Decision tension** | Players pause and consider before taking nodes | Observe hesitation |

### Prototype Test Questions

1. Are the negatives annoying or interesting?
2. Do players avoid the tree (bad sign) or engage with it eagerly?
3. Are there dominant strategies? (Specific node combos always taken)
4. Is the tree readable and navigable?
5. Do runs feel different based on tree choices?

---

## Full Vision

### If Prototype Succeeds

#### Expanded Tree

| Category | MVP Count | Full Vision |
|----------|-----------|-------------|
| Total nodes | 15-20 | 80-120 |
| Tiers | 3 | 5 |
| Keystone nodes | 2 | 10-15 |
| Entry points | 1 | 4-6 |

#### Class-Specific Branches (Optional)

If variety is needed:

| Class | Unique Branch | Theme |
|-------|---------------|-------|
| Warrior | "Rage" branch | Low HP power, berserker |
| Mage | "Arcane" branch | Mana manipulation, glass cannon |
| Rogue | "Shadow" branch | Stealth, crit, positioning |
| Cleric | "Sacrifice" branch | HP costs for team buffs |

#### Meta-Progression

| Feature | Description |
|---------|-------------|
| **Unlock new nodes** | Completing runs unlocks deeper tree layers |
| **Mastery tracks** | Using a node type unlocks enhanced versions |
| **Negative mitigation items** | Rare items that partially offset negatives |

#### Advanced Systems

| System | Description |
|--------|-------------|
| **Node evolution** | Some nodes "upgrade" after conditions met (kill 100 with fire → Pyromaniac+) |
| **Negative conversion** | Rare effects that flip negatives to positives |
| **Anti-node** | Nodes that *remove* previously taken nodes (with consequences) |
| **Run modifiers** | "This run, all negatives are doubled but all positives are +50%" |

---

## Risks & Mitigations

| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
| **Negatives feel punishing, not fun** | Medium | High | Tune negatives to be interesting, not frustrating; avoid pure stat penalties |
| **Dominant builds** | High | Medium | Playtest extensively; rotate balance; ensure anti-synergy prevents stacking |
| **Analysis paralysis** | Medium | Medium | Good UI; clear synergy indicators; small tree for MVP |
| **Negatives ignorable** | Medium | High | If negatives don't matter, system fails—tune up impact |
| **Complexity creep** | High | Medium | Start small; add nodes only when needed |
| **Math optimization** | Medium | Low | Some players will spreadsheet it—that's okay |

### Biggest Risk

**The tradeoffs don't feel like tradeoffs.** If the positives dramatically outweigh the negatives, players take everything and the system becomes a standard skill tree. If negatives are too harsh, players avoid the tree entirely.

**Mitigation**: Every node should pass the "would I ever NOT take this?" test. If the answer is "I'd always take it," the negative is too weak.

---

## Feasibility Assessment

### Timeline (Solo Dev, Godot/C#)

| Phase | Duration | Deliverables |
|-------|----------|--------------|
| **Stat system** | 1 week | Core stats, modifiers, calculation pipeline |
| **Tree data structure** | 1 week | Node definitions, adjacency, unlock logic |
| **Tree UI** | 1-2 weeks | Visual tree, tooltips, selection |
| **Combat integration** | 1-2 weeks | Stats affect combat, basic enemy AI |
| **Prototype complete** | 1 week | Run loop, balance pass, playtest |
| **Validation** | 1-2 weeks | Playtesting, iteration |
| **Vertical slice** | 4-6 weeks | Polished tree (40+ nodes), full run |
| **Full MVP** | 3-4 months | Complete tree, progression, polish |

### Technical Considerations

| System | Complexity | Notes |
|--------|------------|-------|
| Stat modifiers | Medium | Additive vs. multiplicative stacking |
| Node data | Low | JSON-driven, easy to add/balance |
| Tree UI | Medium | Graph visualization in Godot |
| Adjacency logic | Low | Simple graph traversal |
| Synergy detection | Medium | Tag matching between nodes |
| Save/load | Low | Serialize taken nodes |

### Balance Philosophy

| Principle | Approach |
|-----------|----------|
| **No pure upgrades** | Every node has meaningful downside |
| **Soft counters** | Negatives create weakness, not impossibility |
| **Depth from combination** | Individual nodes simple; combos complex |
| **Failure is learning** | Bad builds teach, not just punish |

---

## Open Questions

1. **How many points per run?** 5? 10? 20? Fewer = each choice heavier. More = more build variety.

2. **Point acquisition?** One per level? Per floor? Per boss? Found in world?

3. **Can you see the full tree from the start?** Or reveal as you explore?

4. **Starting position in tree?** Random? Class-based? Player chooses quadrant?

5. **Respec in non-roguelike mode?** Free? Costly? Limited uses?

6. **Negative intensity scaling?** Early nodes mild, late nodes harsh? Or flat?

7. **Visual representation of negatives on character?** Scars, mutations, auras?

8. **What if a build becomes literally unplayable?** Safety valves? "Undo run" option?

9. **Multiplayer considerations?** In co-op, do negatives affect teammates?

---

## Design Principles Summary

| Principle | Description |
|-----------|-------------|
| **No free lunch** | Every power has a cost |
| **Identity over power** | Builds defined by playstyle, not just DPS |
| **Readable tradeoffs** | Players should understand the deal instantly |
| **Meaningful mitigation** | Skill in combining nodes to offset weaknesses |
| **Embrace restriction** | Negatives aren't punishment—they're puzzle pieces |
| **Variety through combination** | 20 nodes with interesting interactions > 100 boring nodes |

---

## Example Build Paths

### "Glass Berserker"

**Philosophy**: Maximum damage, survive through killing.

| Node | Positive | Negative | Running Effect |
|------|----------|----------|----------------|
| Quick Draw | +20% attack speed | -10% damage | Fast but light |
| Glass Cannon | +40% damage | -50% defense | Very light, very fast |
| Blood Pact | 10% lifesteal | -25% max HP | Tiny HP pool, self-sustain |
| Adrenaline Junkie | +2%/1% missing HP | +1%/1% damage taken | Near-death god mode |
| All or Nothing | ×2 damage | 1 HP max | Kill or be killed |

**Result**: A character with 1 HP that deals obscene damage and must lifesteal to survive. One hit = death. Every fight is a knife's edge.

### "Immortal Turtle"

**Philosophy**: Can't die, but can barely kill.

| Node | Positive | Negative | Running Effect |
|------|----------|----------|----------------|
| Thick Skin | +15% HP | -10% speed | Slow tank |
| Turtle Stance | +50% defense still | -30% defense moving | Positional |
| Regenerator | +5% HP/s | -20% damage | Unkillable, weak hits |
| Immortal Coward | Can't die | No damage 10s after revive | Literally immortal |
| Patience | +5% damage per second not attacking (stacks to 10) | -50% damage instant | Slow burn |

**Result**: A character that can't die but takes forever to kill anything. Fights are wars of attrition. Patience required.

### "One-Shot Artist"

**Philosophy**: First hit kills. After that, run.

| Node | Positive | Negative | Running Effect |
|------|----------|----------|----------------|
| Sharp Eyes | +20% crit chance | -10% base damage | Crit fishing |
| Perfectionist | +100% crit damage | Normal hits 50% damage | All or nothing |
| Opener | +50% damage to full HP | -25% to damaged | First blood |
| Chrono Shift | +100% to first enemy | Can't kill last enemy | Glass cannon opener |
| Fade Away | Invisible 3s after kill | -30% damage when visible | Assassination loop |

**Result**: Delete the first enemy instantly, go invisible, reposition. Repeat. But if you miss the opening, you're weak and exposed.

---

## Summary

The Skill Tree with Positives and Negatives reimagines character progression as a series of meaningful tradeoffs rather than pure power accumulation. Every point spent *changes* how you play—not just *how well*.

The system's depth comes from combining positives while mitigating negatives, creating builds that feel like puzzle solutions rather than stat stacking. The roguelike context (permanent choices) raises stakes and ensures each run has a unique identity.

**Verdict**: Elegant concept, high replayability, moderate scope. The balance work is significant but front-loaded (node design). Worth prototyping.
