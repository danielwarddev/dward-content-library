# Godot MVP Generation — Master Planning Document

## Overview

This document outlines the considerations, architecture, and implementation plan for extending PocGenerator to create **Godot game engine MVPs** alongside the existing .NET SaaS MVPs. Unlike .NET projects where `dotnet new` templates and NuGet packages provide a deterministic scaffolding path, Godot projects require a fundamentally different approach due to their scene-based architecture, resource system, and game-specific patterns.

---

## 1. Why Godot Is Different from .NET SaaS Projects

| Dimension | .NET SaaS MVP | Godot Game MVP |
|-----------|---------------|----------------|
| **Project structure** | `.sln` + `.csproj` files, NuGet packages | `project.godot` + `.tscn` scenes + `.gd`/`.cs` scripts |
| **Scaffolding** | `dotnet new` templates (deterministic CLI) | No equivalent CLI scaffolding — scenes/nodes are created in-editor or via text files |
| **Build system** | `dotnet build` / `dotnet test` | Godot CLI (`--headless --quit`) for scene validation; no built-in test runner |
| **Package manager** | NuGet | Godot Asset Library (no CLI install) or manual addon download |
| **UI framework** | Blazor + Radzen components | Godot Control nodes (`Button`, `Label`, `Panel`, etc.) |
| **Architecture** | Vertical slices, services, DI | Scene tree, nodes, signals, autoloads |
| **Validation** | `dotnet build` + `dotnet test` (xUnit) | Headless run + GUT/GdUnit4 test framework (if using tests) |
| **File format** | C# source files | `.tscn` (scene), `.tres` (resource), `.gd` (GDScript), `.cs` (C# option) |

### Key Insight

The .NET pipeline works because `dotnet new` is a reliable, deterministic CLI that always produces valid project structures. **Godot has no equivalent.** Scene files (`.tscn`) are text-based and can be hand-crafted, but they have specific formatting requirements and resource ID conventions. This is the single biggest challenge.

---

## 2. Scripting Language Decision: GDScript vs C#

### Option A: GDScript (Recommended for MVPs)

**Pros:**
- Tighter Godot integration — code completion, signals, node references all work natively
- Simpler syntax — Python-like, less boilerplate, faster to generate
- More community resources and tutorials — AI models have more training data
- No external build step — scripts are interpreted/JIT-compiled by the engine
- Smaller file count — no `.csproj`, no `using` statements, no namespaces needed
- Works on all export platforms including web

**Cons:**
- No static typing by default (gradual typing available)
- No NuGet ecosystem
- Less familiar to .NET developers

### Option B: C# (Godot .NET build)

**Pros:**
- Familiar to the existing PocGenerator audience
- Strong typing, existing .NET patterns apply
- Could potentially share some scaffolding logic with existing .NET scripts

**Cons:**
- Requires .NET build of Godot editor (separate download)
- C# Godot projects can't export to web platform
- More complex project structure (`.csproj` + `project.godot`)
- AI models often produce incorrect C# Godot bindings (the API surface is large and changed significantly between Godot 3→4)

### Recommendation

**Start with GDScript** for MVP generation. It has the simplest project structure, widest platform support, and the AI will produce more consistent output since GDScript is closely tied to Godot's own documentation. C# support can be added as a follow-up.

---

## 3. Godot Project Structure Fundamentals

A typical Godot 4.x project has this structure:

```
my_game/
├── project.godot              # Project config (equivalent to .csproj/.sln)
├── icon.svg                   # Default app icon
├── .godot/                    # Editor cache (gitignored)
│   ├── imported/              # Imported asset cache
│   └── editor/                # Editor state
├── scenes/                    # Scene files (.tscn)
│   ├── main.tscn              # Main scene (entry point)
│   ├── player/
│   │   ├── player.tscn        # Player scene
│   │   └── player.gd          # Player script
│   ├── enemies/
│   │   ├── enemy.tscn
│   │   └── enemy.gd
│   └── ui/
│       ├── hud.tscn
│       ├── hud.gd
│       ├── main_menu.tscn
│       └── main_menu.gd
├── scripts/                   # Standalone scripts (autoloads, utilities)
│   ├── game_manager.gd        # Autoload singleton
│   └── utils.gd
├── assets/                    # Art, audio, fonts
│   ├── sprites/
│   ├── audio/
│   └── fonts/
├── addons/                    # Third-party plugins
│   └── gut/                   # GUT test framework (if using tests)
└── tests/                     # Test scripts (if using GUT)
    ├── test_player.gd
    └── test_enemy.gd
```

### Critical Files

| File | Purpose | Format |
|------|---------|--------|
| `project.godot` | Project settings, autoloads, input map, physics layers | INI-like config |
| `*.tscn` | Scene files — define node trees + property overrides | Text-based (Godot-specific format) |
| `*.tres` | Resource files — materials, themes, curves, data | Text-based resource format |
| `*.gd` | GDScript source files | Python-like script |
| `export_presets.cfg` | Export configurations | INI-like config |

### The `.tscn` Format Challenge

Scene files are the heart of any Godot project. They look like this:

```
[gd_scene load_steps=3 format=3 uid="uid://abc123"]

[ext_resource type="Script" path="res://scenes/player/player.gd" id="1_abc"]
[ext_resource type="Texture2D" path="res://assets/sprites/player.png" id="2_def"]

[sub_resource type="RectangleShape2D" id="RectangleShape2D_xyz"]
size = Vector2(16, 32)

[node name="Player" type="CharacterBody2D"]
script = ExtResource("1_abc")

[node name="Sprite" type="Sprite2D" parent="."]
texture = ExtResource("2_def")

[node name="CollisionShape" type="CollisionShape2D" parent="."]
shape = SubResource("RectangleShape2D_xyz")
```

**Key challenges for AI generation:**
- Resource IDs must be unique and referenced consistently
- `uid://` identifiers are auto-generated by the editor
- `load_steps` must match the actual number of resources
- Node paths (`parent="."`) must form a valid tree
- Property values use Godot-specific types (`Vector2`, `Color`, etc.)

---

## 4. What Scaffolding Scripts Need to Do

Unlike .NET where `dotnet new` creates a valid project in one command, Godot scaffolding requires generating multiple files that reference each other. See **[GODOT-SCAFFOLDING-SCRIPTS.md](./GODOT-SCAFFOLDING-SCRIPTS.md)** for detailed script designs.

### Scripts Needed

| Script | Purpose |
|--------|---------|
| `create-godot-project.ps1` | Create `project.godot`, icon, `.gitignore`, folder structure |
| `create-2d-scene.ps1` | Create a 2D scene with common node setup |
| `create-3d-scene.ps1` | Create a 3D scene with camera, lighting, environment |
| `create-ui-scene.ps1` | Create a Control-based UI scene (menus, HUD) |
| `create-autoload.ps1` | Create a singleton script + register in `project.godot` |
| `create-player-controller.ps1` | Create player scene with movement, collision, camera |
| `create-tilemap-scene.ps1` | Create a TileMap-based level scene (2D) |
| `add-input-actions.ps1` | Register input actions in `project.godot` |
| `add-gut-tests.ps1` | Add GUT test framework and test scaffold |

---

## 5. Validation Strategy

### The Biggest Gap: No `dotnet build` Equivalent

With .NET, `dotnet build` catches type errors, missing references, and compilation issues. Godot has no single validation command that catches all issues. Validation must be multi-layered:

#### Layer 1: Static Analysis (Cheapest)
- **GDScript parser check**: `godot --headless --check-only --script res://path/to/script.gd` (Godot 4.3+)
- **Scene file validation**: Custom script or parser to verify `.tscn` files have valid structure (correct `load_steps`, matching resource IDs, valid node types)
- **project.godot validation**: Verify autoloads reference existing files, input actions are defined, etc.

#### Layer 2: Headless Import (Medium Cost)
- Run `godot --headless --import --quit` to trigger the import pipeline
- This catches missing resources, broken references, invalid scene trees
- Requires Godot binary available on the system

#### Layer 3: Headless Run (Most Expensive)
- Run `godot --headless --quit-after 60` to actually start the game
- Catches runtime errors: null references, missing nodes, signal connection failures
- Can be combined with test framework for automated assertions

#### Layer 4: Test Framework (Optional but Valuable)
- **GUT** (Godot Unit Test) — most popular, GDScript-based
- **GdUnit4** — alternative with more features, supports C#
- Run via: `godot --headless -s addons/gut/gut_cmdline.gd -gexit`

### Recommended Validation Pipeline

```
1. Generate all files
2. Validate project.godot syntax
3. Validate all .tscn files (custom parser or godot --check-only)
4. Run godot --headless --import --quit (catch import errors)
5. Run GUT tests if test files exist
6. Run godot --headless --quit-after 10 (catch runtime startup errors)
```

---

## 6. Godot Binary Requirement

Unlike `dotnet` which is typically installed system-wide, Godot is usually a standalone binary. The pipeline needs a strategy for ensuring Godot is available.

### Options

1. **Require pre-installed Godot** — user must have `godot` on PATH
   - Simplest, but adds a prerequisite
   - Document the required version (e.g., Godot 4.4+)

2. **Auto-download Godot** — scaffolding script downloads the correct version
   - More reliable, version-pinned
   - Can use GitHub releases API: `https://github.com/godotengine/godot/releases`
   - Download the headless/server build for CI environments

3. **Docker with Godot** — extend the existing Dockerfile
   - Best for CI/overnight runs
   - `barichello/godot-ci` is a popular base image

### Recommendation

Support both options 1 and 2: check if `godot` is on PATH, and if not, auto-download the headless build to a tools directory. The `create-godot-project.ps1` script should handle this.

---

## 7. Input Map & Physics Configuration

Games require input configuration that SaaS apps don't. The scaffolding must pre-configure common input actions in `project.godot`.

### Standard Input Actions to Pre-Configure

```ini
[input]
move_left={ "deadzone": 0.5, "events": [Object(InputEventKey,"resource_local_to_scene":false,"resource_name":"","device":-1,"window_id":0,"alt_pressed":false,"shift_pressed":false,"ctrl_pressed":false,"meta_pressed":false,"pressed":false,"keycode":65,"physical_keycode":0,"key_label":0,"unicode":0,"location":0,"echo":false,"script":null), Object(InputEventKey,"resource_local_to_scene":false,"resource_name":"","device":-1,"window_id":0,"alt_pressed":false,"shift_pressed":false,"ctrl_pressed":false,"meta_pressed":false,"pressed":false,"keycode":4194319,"physical_keycode":0,"key_label":0,"unicode":0,"location":0,"echo":false,"script":null)] }
move_right=...
move_up=...
move_down=...
jump=...
interact=...
pause=...
```

This is verbose and error-prone to generate manually. A PowerShell script that appends these to `project.godot` programmatically is essential.

---

## 8. Asset Pipeline Considerations

### The Asset Problem

Unlike SaaS apps which can be "complete" with just code, games need visual and audio assets. Options:

1. **Placeholder shapes** — Use Godot's built-in primitives (ColorRect, Sprite2D with placeholder texture). Good enough for MVP.
2. **Free asset packs** — Bundle a small set of CC0 assets with the scaffolding scripts
3. **AI-generated assets** — Use image generation models (future enhancement)
4. **Kenney.nl assets** — CC0 game assets, very popular. Could include a small curated set.

### Recommendation for MVPs

Use **placeholder shapes and colors** for initial generation. The AI should generate games that are functionally complete with colored rectangles, simple shapes, and text labels. Visual polish is not the goal of an MVP.

Include a small set of Kenney.nl CC0 assets (sprites, sounds) as optional resources that the AI can reference when it wants to add visual flair.

---

## 9. Game Genre Templates

Different game genres require very different architectures. The planning phase needs to understand genre to pick the right scaffolding. See **[GODOT-COMMON-PATTERNS.md](./GODOT-COMMON-PATTERNS.md)** for detailed patterns.

### Supported Genre Templates (Initial Set)

| Genre | Key Components | Complexity |
|-------|---------------|------------|
| **2D Platformer** | CharacterBody2D, TileMap, Camera2D, AnimatedSprite2D | Medium |
| **2D Top-Down** | CharacterBody2D, TileMap, Camera2D, Area2D (interactions) | Medium |
| **Puzzle Game** | Grid system, state machine, UI-heavy | Low-Medium |
| **Card Game** | Control nodes, drag-and-drop, state management | Medium |
| **Visual Novel** | DialogueManager, RichTextLabel, TextureRect, branching | Low |
| **Tower Defense** | Path2D/PathFollow2D, enemy waves, placement grid | Medium-High |
| **Idle/Clicker** | Timer nodes, UI-heavy, save/load system | Low |
| **3D First Person** | CharacterBody3D, Camera3D, RayCast3D, basic level | High |

---

## 10. Integration with Existing PocGenerator Pipeline

### Approach: Parallel Pipeline, Shared Orchestration

The Godot pipeline should mirror the .NET pipeline's three-phase structure but with Godot-specific implementations:

```
Phase 1: Planning (Mostly Reusable)
├── IdeaFileLocator — reuse as-is (reads mvp.md)
├── SlugGenerator — reuse as-is
├── ProjectPlanner — NEW Godot variant (different scripts, architecture guidance)
└── SpecSplitter — reuse as-is (specs are project-agnostic)

Phase 2: Generation (Godot-Specific)
├── CopilotService — reuse (add Godot tool functions)
├── ProjectTools — NEW GodotProjectTools class (Godot scaffolding scripts)
├── SystemPrompt — NEW Godot-specific developing prompt
└── CodeGenerator — reuse (Godot validation instead of dotnet build/test)

Phase 3: Verification (Partially New)
├── Build verification — NEW (godot --headless --import)
├── Test runner — NEW (GUT headless runner)
├── Browser testing — NOT APPLICABLE (no web server to test)
├── Gameplay verification — NEW (headless run + screenshot comparison?)
└── README generation — reuse (Godot project structure instead of .NET)
```

### Pipeline Selection

Add a `--platform` CLI argument:

```powershell
dotnet run --project PocGenerator -- --idea "My Game Idea" --platform godot
dotnet run --project PocGenerator -- --idea "My SaaS Idea" --platform dotnet  # default
```

Or auto-detect from the MVP description (presence of game-related keywords).

---

## 11. System Prompt Considerations

The Copilot system prompt for Godot generation needs to encode significant domain knowledge. See **[GODOT-SYSTEM-PROMPTS.md](./GODOT-SYSTEM-PROMPTS.md)** for detailed prompt designs.

Key areas the system prompt must cover:
- Godot node type reference (when to use which node)
- Scene composition patterns
- Signal connection conventions
- GDScript style guide (snake_case, type hints)
- Common pitfalls (node ready order, physics process vs process, etc.)
- Available scaffolding tools and when to use them

---

## 12. Testing Strategy for Godot MVPs

### Option A: GUT (Godot Unit Test) — Recommended

```gdscript
# tests/test_player.gd
extends GutTest

func test_player_starts_at_origin():
    var player = preload("res://scenes/player/player.tscn").instantiate()
    add_child(player)
    assert_eq(player.position, Vector2.ZERO)
    player.queue_free()

func test_player_moves_right():
    var player = preload("res://scenes/player/player.tscn").instantiate()
    add_child(player)
    # Simulate input
    player.velocity = Vector2(100, 0)
    player.move_and_slide()
    assert_gt(player.position.x, 0)
    player.queue_free()
```

### Running Tests Headlessly

```bash
godot --headless -s addons/gut/gut_cmdline.gd \
  -gdir=res://tests \
  -gexit \
  -glog=1
```

### Test Scaffolding

The `add-gut-tests.ps1` script should:
1. Download GUT addon to `addons/gut/`
2. Enable the plugin in `project.godot`
3. Create a `tests/` directory with a sample test
4. Create a `.gutconfig.json` with default settings

---

## 13. Risk Assessment & Mitigation

| Risk | Severity | Mitigation |
|------|----------|------------|
| AI generates invalid `.tscn` files | **High** | Provide `.tscn` templates in scaffolding scripts; validate with parser |
| AI doesn't know Godot 4 API (trained on Godot 3) | **High** | Comprehensive system prompt with Godot 4 API reference; attach cheat sheets as context |
| No deterministic project creation CLI | **High** | PowerShell scripts generate all boilerplate files; AI only writes game logic scripts |
| Godot binary not available on system | **Medium** | Auto-download headless build; document prerequisites |
| Asset dependencies (sprites, sounds) | **Medium** | Use placeholder shapes; bundle small CC0 asset pack |
| Scene file resource ID conflicts | **Medium** | Scaffolding scripts use deterministic ID generation |
| Input map configuration is complex | **Low** | Pre-configure common actions via script |
| Physics layers need configuration | **Low** | Pre-configure common layers (player, enemy, environment, projectile) |

---

## 14. Implementation Roadmap

### Phase 1: Foundation (MVP of the MVP Generator)
1. ✏️ Create `create-godot-project.ps1` — generates valid `project.godot` + folder structure
2. ✏️ Create `create-2d-scene.ps1` — generates a basic 2D scene with script
3. ✏️ Create `add-input-actions.ps1` — configures standard input map
4. ✏️ Write `SystemPrompt_Developing_Godot.md` — Godot-specific AI guidance
5. ✏️ Create `GodotProjectTools` class — expose scaffolding scripts as Copilot tools
6. ✏️ Add `--platform godot` CLI flag
7. ✏️ Implement basic validation: `godot --headless --import --quit`
8. 🧪 Test end-to-end: generate a simple 2D game from an idea

### Phase 2: Genre Support
1. ✏️ Create `create-player-controller.ps1` — 2D/3D player with movement
2. ✏️ Create `create-ui-scene.ps1` — main menu, HUD, pause menu
3. ✏️ Create `create-autoload.ps1` — game manager singleton
4. ✏️ Add genre-specific templates (platformer, top-down, puzzle)
5. ✏️ Write AI reference: common game patterns cheat sheet (attached to sessions)
6. 🧪 Test: generate a 2D platformer, a puzzle game, a card game

### Phase 3: Testing & Polish
1. ✏️ Create `add-gut-tests.ps1` — GUT framework integration
2. ✏️ Implement test running in validation pipeline
3. ✏️ Add 3D scene support (`create-3d-scene.ps1`)
4. ✏️ Bundle small CC0 asset pack for visual polish
5. ✏️ Add Godot Docker image support
6. 🧪 Full integration test: overnight generation of 5+ different game types

---

## 15. Open Questions

1. **Should we support both GDScript and C# from the start, or GDScript only?**
   - Recommendation: GDScript only for v1, C# as a follow-up
   
2. **How do we handle the Godot binary version?**
   - Pin to a specific version (e.g., 4.4) and document it
   - Auto-download if not found on PATH

3. **Should the AI create `.tscn` files directly, or use scaffolding scripts for all scenes?**
   - Hybrid: scaffolding scripts for complex scenes (player, UI), AI writes simple scenes directly
   - Include a `.tscn` validator in the pipeline

4. **How do we verify gameplay quality beyond "it compiles"?**
   - Headless run with timeout (catches crashes)
   - GUT tests for logic
   - Future: screenshot comparison, Playwright-style game testing

5. **Should we include a pre-built asset library?**
   - Start with placeholder shapes
   - Bundle Kenney CC0 assets as an optional enhancement

---

## Related Documents

- **[GODOT-SCAFFOLDING-SCRIPTS.md](./GODOT-SCAFFOLDING-SCRIPTS.md)** — Detailed designs for each PowerShell scaffolding script
- **[GODOT-SYSTEM-PROMPTS.md](./GODOT-SYSTEM-PROMPTS.md)** — System prompt content for Godot code generation
- **[GODOT-COMMON-PATTERNS.md](./GODOT-COMMON-PATTERNS.md)** — Reference patterns for common game dev tasks (enemy AI, physics, UI, etc.)
