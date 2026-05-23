# Godot Built-in TileMapLayer vs Tiled App (Post-Godot 4.3)

**Generated:** March 22, 2026  
**Context:** Research into community preferences and technical tradeoffs between Godot's built-in TileMap editor (with 4.3's TileMapLayer nodes) vs the external Tiled Map Editor for Godot 4 level design.

---

## Background: What Changed in Godot 4.3

Godot 4.3 (mid-2024) made a major architectural change to tile maps: **TileMap layers were moved from internal data to individual `TileMapLayer` nodes** ([GH-87379](https://github.com/godotengine/godot/pull/87379), [GH-89179](https://github.com/godotengine/godot/pull/89179)). This brought:

- **Less inspector clutter** — layers are now scene tree nodes, not nested inspector properties
- **Simpler API** — each layer is a standalone node you can script individually
- **Better Godot design pattern alignment** — follows Godot's "everything is a node" philosophy
- **Independent per-layer control** — z-index, visibility, signal connections, etc. are now per-node
- **Editor improvements** — ability to select all layers at once, better multi-layer editing

The old `TileMap` node was deprecated but remains for backward compatibility (no new features).

---

## The Options for Tiled → Godot Workflow

### Option 1: Tiled's Built-in Godot 4 Export (Since Tiled 1.10)

Tiled ships with a **native Godot 4 exporter** that generates `.tscn` files directly. Key details:

- **Format:** Exports `.tscn` scene files that Godot opens natively
- **Custom properties supported:**
  - `ySortEnabled` (bool) — drawing order by Y coordinate
  - `zIndex` (int) — layer depth
  - `noExport` (bool) — suppress layers used only for annotations
  - `tilesetOnly` (bool) — export tileset without the layer
  - `tilesetResPath` (string) — save tileset as shared `.tres` resource (since Tiled 1.11)
  - `resPath` (string, on objects) — replace object with a Godot scene instance
- **Tile custom properties** export as Godot Custom Data Layers (since Tiled 1.10.2)
- **Godot 4.2+ native rotation/flipping** — deprecated the old `exportAlternates` workaround (since Tiled 1.11)

**Limitations of Tiled's built-in export:**
- ❌ No support for **collection of images** tilesets
- ❌ No support for **image layers**
- ❌ Hex maps restricted to side lengths exactly half the tile height
- ❌ Hex maps don't support 120° tile rotations
- ❌ Animation frames must be strictly left-to-right, top-to-bottom, no skips

### Option 2: YATI (Yet Another Tiled Importer) Plugin

**YATI** is the most popular and actively maintained Tiled importer for Godot 4. ([GitHub: Kiamo2/YATI](https://github.com/Kiamo2/YATI))

- **266 GitHub stars**, latest release: v2.2.7 (March 19, 2026)
- Requires **Godot 4.3.0+** (current version)
- Tested with **Godot 4.6.1 and Tiled 1.12**
- Available in both **GDScript and C#**
- **Runtime loading** support (since v1.5.2) — can load Tiled maps at runtime
- Imports `.tmx` and `.tmj` files directly into the Godot editor
- **Support is active** — maintainer responds to issues within days

**Feature coverage (near-complete):**
- All layer types, object types, map orientations
- Visibility, opacity, tint, offsets, probability
- Parallaxes, tile collisions, tile animations
- Templates and custom properties
- Navigation polygons

**YATI limitations:**
- Ellipses approximated as capsules/polygons
- Animation tiles must be equidistant and sequential
- Recommend disabling "Use Multiple Threads" in import settings (may crash)
- C# version doesn't support zstd compression

### Option 3: Godot Built-in TileMap Editor (No External Tool)

Godot's built-in editor has matured significantly since 4.0:

- **TileSet editor** — atlas-based tileset creation with visual editor
- **Autotiling / Terrains** — built-in terrain system (bitmask-based autotiling)
- **Physics layers** — collision shapes defined per-tile in the tileset
- **Navigation layers** — pathfinding meshes per-tile
- **Custom data layers** — arbitrary metadata per tile
- **Painting tools** — brush, line, rect, bucket fill, scatter
- **Scenes as tiles** — embed full scenes as individual tiles
- **Animation** — built-in tile animation support
- **Pattern painting** — save and reuse tile patterns

---

## Community Sentiment: What Do People Prefer?

### The Shift Toward Built-in (Post-4.3)

The general community trend since Godot 4.3 is **increasingly favoring the built-in editor** for most use cases. Key reasons cited:

1. **TileMapLayer nodes solved the biggest complaint** — layers are now proper scene tree nodes, making the system much more flexible and Godot-native
2. **Zero friction** — no import pipeline, no export step, no version sync issues
3. **Terrains/autotiling improved significantly** — the terrain system handles most common autotile patterns
4. **Tight engine integration** — physics, navigation, signals, y-sorting all work natively without translation layers
5. **Scenes-as-tiles** — a unique Godot feature with no real Tiled equivalent, allowing complex interactive tiles

### When People Still Prefer Tiled

Tiled retains advocates for specific workflows:

1. **Teams with dedicated level designers** — Tiled is a standalone app that non-programmers can use without opening the Godot editor
2. **Cross-engine workflows** — teams targeting multiple engines or migrating between engines benefit from Tiled's engine-agnostic format
3. **Very large or complex maps** — Tiled's map editor has more mature tools for massive maps (infinite maps, world system, multi-map management)
4. **Automapping** — Tiled's rule-based automapping is more powerful than Godot's terrain system for complex procedural-style tile placement
5. **Existing Tiled workflow** — developers who already have large Tiled projects and are comfortable with the tool
6. **Object placement workflow** — some find Tiled's object layer workflow faster for placing spawn points, triggers, etc.

### When People Recommend Built-in

1. **Solo developers and small teams** — the simplicity of having everything in one editor wins
2. **New Godot projects** — there's little reason to add the complexity of an external tool for a fresh project
3. **Projects heavily using Godot-specific features** — physics layers, navigation layers, scenes-as-tiles, custom data layers are all smoother without a translation layer
4. **Rapid prototyping** — paint tiles and hit play instantly, no export cycle

### The "Import Pipeline Pain" Factor

A recurring theme in community discussions: **the import pipeline is the main frustration with Tiled + Godot**. Issues include:
- Keeping Tiled changes in sync with Godot
- Import plugins sometimes breaking on Godot version updates
- Custom properties not mapping cleanly between tools
- Extra steps for collision/navigation setup that the built-in does natively
- Debugging import issues adds friction

---

## The LDtk Alternative (Honorable Mention)

**LDtk** (Level Designer Toolkit) is another external editor worth mentioning, created by the developer of Dead Cells.

- **Godot importer:** [godot-ldtk-importer](https://github.com/heygleeson/godot-ldtk-importer) (last updated Feb 2025)
- **Strengths vs Tiled:**
  - More modern UI/UX designed specifically for game level design
  - Built-in entity system with custom fields
  - World management and multi-level support
  - Auto-layer rules (similar to Tiled automapping but more visual)
  - IntGrid layers for procedural collision/metadata
- **Weaknesses vs Tiled:**
  - Less mature Godot integration
  - Smaller community and fewer import options
  - Fewer map orientations (no isometric/hex as of last check)
  - Developer has stated he may reduce maintenance pace

---

## Comparison Table

| Feature | Godot Built-in | Tiled (+ YATI/Export) | LDtk (+ Importer) |
|---|---|---|---|
| **Setup complexity** | ✅ None | ⚠️ Plugin or export config | ⚠️ Plugin required |
| **Learning curve** | ✅ One tool to learn | ⚠️ Two tools | ⚠️ Two tools |
| **Autotiling/Terrains** | ✅ Good (terrains) | ✅ Excellent (automapping) | ✅ Good (auto-layers) |
| **Physics/Collision** | ✅ Native | ⚠️ Via import mapping | ⚠️ Via import/script |
| **Navigation layers** | ✅ Native | ⚠️ Via import mapping | ❌ Manual setup |
| **Scenes as tiles** | ✅ Unique feature | ❌ Not possible | ❌ Not possible |
| **Custom tile data** | ✅ Native | ✅ Via custom properties | ✅ Via custom data |
| **Multi-map/World** | ❌ Manual | ✅ Built-in worlds | ✅ Built-in worlds |
| **Infinite maps** | ❌ No | ✅ Yes | ✅ Yes (with levels) |
| **Object placement** | ⚠️ Use Node2D | ✅ Object layers | ✅ Entity layers |
| **Team workflow** | ⚠️ Needs Godot | ✅ Standalone tool | ✅ Standalone tool |
| **Engine-agnostic** | ❌ Godot only | ✅ Export to many engines | ⚠️ Some export options |
| **Runtime loading** | ⚠️ Via code | ✅ YATI runtime support | ⚠️ Limited |
| **Animation** | ✅ Native | ✅ Good (some restrictions) | ⚠️ Basic |
| **Maintenance** | ✅ Core engine | ✅ Active (YATI + Tiled) | ⚠️ Less active |
| **Performance** | ✅ Direct | ⚠️ Import overhead | ⚠️ Import overhead |

---

## Recommendation Matrix

| Situation | Recommendation |
|---|---|
| Solo dev, new Godot project | **Built-in** — simplest path, great features |
| Small team, all use Godot | **Built-in** — keep everything in-engine |
| Team with dedicated level designer (non-programmer) | **Tiled** — standalone app advantage |
| Cross-engine project | **Tiled** — engine-agnostic format |
| Very large maps / world system needed | **Tiled** — worlds + infinite maps |
| Complex automapping rules | **Tiled** — automapping is more powerful |
| Heavy use of physics/navigation layers | **Built-in** — native support, no import headaches |
| Scenes-as-tiles needed | **Built-in** — exclusive feature |
| Migrating from Tiled workflow | **Tiled + YATI** — keep your existing workflow, YATI is excellent |
| Rapid prototyping | **Built-in** — zero pipeline friction |

---

## Bottom Line

**For most developers starting new Godot 4.3+ projects, the built-in tilemap system is now the better default choice.** The TileMapLayer node architecture resolved the biggest usability complaints, and the zero-friction workflow is a huge advantage.

**Tiled remains the better choice when** you need standalone level editing for non-programmers, cross-engine compatibility, very large map management (worlds/infinite maps), or advanced automapping rules. The **YATI plugin** is the gold standard for Tiled→Godot import and is actively maintained.

The gap has narrowed significantly since 4.3. The days of Tiled being the obvious choice for Godot level editing are over — it's now a legitimate decision based on your specific workflow needs.

---

## Sources

- [Godot 4.3 Beta 1 Announcement — TileMapLayer section](https://godotengine.org/article/dev-snapshot-godot-4-3-beta-1/)
- [Godot Docs — Using TileMaps](https://docs.godotengine.org/en/stable/tutorials/2d/using_tilemaps.html)
- [Godot Docs — Upgrading to 4.3 (TileMap migration)](https://docs.godotengine.org/en/stable/tutorials/migrating/upgrading_to_godot_4.3.html)
- [Tiled Docs — Godot 4 Export](https://doc.mapeditor.org/en/stable/manual/export-tscn/)
- [YATI GitHub — Kiamo2/YATI](https://github.com/Kiamo2/YATI) (266 stars, v2.2.7)
- [LDtk Importer — heygleeson/godot-ldtk-importer](https://github.com/heygleeson/godot-ldtk-importer)
- [Godot Asset Library — Tiled plugins](https://godotengine.org/asset-library/asset?filter=tiled)
- [Godot TileMap Rework Proposal (GH-1769)](https://github.com/godotengine/godot-proposals/issues/1769)

---

## Notes

- Reddit and most search engines blocked automated access during this research, so community sentiment is synthesized from multiple accessible sources (GitHub issues, Godot forums, Tiled docs, plugin activity/stars) rather than direct Reddit thread analysis.
- YATI had v2.2.7 released just 3 days ago (March 19, 2026) with active issue resolution, indicating strong ongoing community need for Tiled integration.
- The Godot forums had a recent post (Aug 2025) from a user wanting to **export Godot tilemap data to external editors (LDtk or Tiled)** for "visual passes" — suggesting some devs use a hybrid workflow where they design in Godot but use external editors for art polish.
