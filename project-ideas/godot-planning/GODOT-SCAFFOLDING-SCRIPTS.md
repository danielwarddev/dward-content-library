# Godot Scaffolding Scripts — Detailed Design

## Overview

This document specifies the PowerShell scripts needed to deterministically create Godot project structures. These scripts serve the same role as the existing `create-console-project.ps1`, `create-blazor-project.ps1`, etc. — they ensure consistent, valid project structures that the AI can build on top of.

### Design Principles

1. **Scripts generate all structural boilerplate** — `project.godot`, folder structure, base scenes
2. **AI writes game logic** — scripts attached to nodes, autoload singletons, game-specific behavior
3. **Every script produces a valid, runnable state** — after any script runs, `godot --headless --import --quit` should succeed
4. **Scripts are idempotent where possible** — running them twice doesn't break things

---

## Script 1: `create-godot-project.ps1`

### Purpose
Create a new Godot 4.x project from scratch with proper folder structure, config, and `.gitignore`.

### Parameters
```powershell
param(
    [Parameter(Mandatory=$true)]
    [string]$ProjectName,          # e.g. "DodgeTheCreeps"
    
    [ValidateSet("2d", "3d")]
    [string]$Mode = "2d",          # 2D or 3D project
    
    [string]$WindowWidth = "1152",
    [string]$WindowHeight = "648"
)
```

### What It Creates

```
{ProjectName}/
├── project.godot          # Full project config with sensible defaults
├── icon.svg               # Default Godot icon (or a simple placeholder)
├── .gitignore             # Godot-specific ignores
├── .gitattributes         # LFS tracking for common asset types
├── scenes/
│   └── main.tscn          # Empty main scene (Node2D or Node3D based on Mode)
├── scripts/               # For autoload/singleton scripts
├── assets/
│   ├── sprites/
│   ├── audio/
│   └── fonts/
├── addons/                # Third-party plugins
└── tests/                 # GUT test scripts (if tests added later)
```

### Generated `project.godot` Content

```ini
; Engine configuration file.
; It's best edited using the editor UI and not directly.

[application]

config/name="{ProjectName}"
run/main_scene="res://scenes/main.tscn"
config/features=PackedStringArray("4.4", "GL Compatibility")

[display]

window/size/viewport_width={WindowWidth}
window/size/viewport_height={WindowHeight}
window/stretch/mode="canvas_items"

[rendering]

renderer/rendering_method="gl_compatibility"
renderer/rendering_method.mobile="gl_compatibility"
```

### Generated `.gitignore`

```
# Godot 4+ specific ignores
.godot/

# Exported builds
*.translation
export_presets.cfg

# Mono-specific ignores (if using C#)
.mono/
data_*/
mono_crash.*.json
```

### Generated `main.tscn` (2D)

```
[gd_scene format=3 uid="uid://main_scene_001"]

[node name="Main" type="Node2D"]
```

### Generated `main.tscn` (3D)

```
[gd_scene load_steps=2 format=3 uid="uid://main_scene_001"]

[sub_resource type="ProceduralSkyMaterial" id="ProceduralSkyMaterial_001"]

[node name="Main" type="Node3D"]

[node name="Camera3D" type="Camera3D" parent="."]
transform = Transform3D(1, 0, 0, 0, 0.94, 0.34, 0, -0.34, 0.94, 0, 5, 10)

[node name="DirectionalLight3D" type="DirectionalLight3D" parent="."]
transform = Transform3D(1, 0, 0, 0, 0.71, 0.71, 0, -0.71, 0.71, 0, 10, 0)
shadow_enabled = true

[node name="WorldEnvironment" type="WorldEnvironment" parent="."]
```

### Validation
After running, verify: `godot --headless --path {ProjectName} --import --quit` exits with code 0.

---

## Script 2: `create-2d-scene.ps1`

### Purpose
Create a new 2D scene file with a root node and optional common child nodes.

### Parameters
```powershell
param(
    [Parameter(Mandatory=$true)]
    [string]$SceneName,            # e.g. "Player", "Enemy", "Level1"
    
    [Parameter(Mandatory=$true)]
    [string]$ProjectPath,          # Path to the Godot project root
    
    [ValidateSet("Node2D", "CharacterBody2D", "RigidBody2D", "Area2D", "StaticBody2D")]
    [string]$RootNodeType = "Node2D",
    
    [switch]$WithScript,           # Attach a .gd script to the root node
    [switch]$WithCollision,        # Add a CollisionShape2D child
    [switch]$WithSprite,           # Add a Sprite2D child (placeholder)
    [switch]$WithAnimatedSprite    # Add an AnimatedSprite2D instead of Sprite2D
)
```

### What It Creates

```
scenes/{scene_name}/
├── {scene_name}.tscn      # Scene file with configured node tree
└── {scene_name}.gd        # Script file (if -WithScript)
```

### Generated Scene (Example: CharacterBody2D with collision + sprite)

```
[gd_scene load_steps=3 format=3]

[ext_resource type="Script" path="res://scenes/player/player.gd" id="1_script"]

[sub_resource type="RectangleShape2D" id="RectangleShape2D_001"]
size = Vector2(32, 32)

[sub_resource type="PlaceholderTexture2D" id="PlaceholderTexture2D_001"]
size = Vector2(32, 32)

[node name="Player" type="CharacterBody2D"]
script = ExtResource("1_script")

[node name="CollisionShape2D" type="CollisionShape2D" parent="."]
shape = SubResource("RectangleShape2D_001")

[node name="Sprite2D" type="Sprite2D" parent="."]
texture = SubResource("PlaceholderTexture2D_001")
```

### Generated Script Template (if `-WithScript`)

```gdscript
extends {RootNodeType}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass
```

---

## Script 3: `create-3d-scene.ps1`

### Purpose
Create a new 3D scene with appropriate root node, camera, and lighting defaults.

### Parameters
```powershell
param(
    [Parameter(Mandatory=$true)]
    [string]$SceneName,
    
    [Parameter(Mandatory=$true)]
    [string]$ProjectPath,
    
    [ValidateSet("Node3D", "CharacterBody3D", "RigidBody3D", "Area3D", "StaticBody3D")]
    [string]$RootNodeType = "Node3D",
    
    [switch]$WithScript,
    [switch]$WithCollision,
    [switch]$WithMesh,             # Add a MeshInstance3D child (box placeholder)
    [switch]$WithCamera,           # Add a Camera3D child
    [switch]$WithLight             # Add a DirectionalLight3D
)
```

---

## Script 4: `create-ui-scene.ps1`

### Purpose
Create a UI scene using Godot's Control node system. Used for menus, HUDs, dialogs, and overlays.

### Parameters
```powershell
param(
    [Parameter(Mandatory=$true)]
    [string]$SceneName,            # e.g. "MainMenu", "HUD", "PauseMenu"
    
    [Parameter(Mandatory=$true)]
    [string]$ProjectPath,
    
    [ValidateSet("MainMenu", "HUD", "PauseMenu", "GameOver", "Settings", "Custom")]
    [string]$Template = "Custom",
    
    [switch]$WithScript
)
```

### Template: MainMenu

```
[gd_scene load_steps=2 format=3]

[ext_resource type="Script" path="res://scenes/main_menu/main_menu.gd" id="1_script"]

[node name="MainMenu" type="Control"]
layout_mode = 3
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
script = ExtResource("1_script")

[node name="VBoxContainer" type="VBoxContainer" parent="."]
layout_mode = 1
anchors_preset = 8
anchor_left = 0.5
anchor_top = 0.5
anchor_right = 0.5
anchor_bottom = 0.5
offset_left = -100.0
offset_top = -75.0
offset_right = 100.0
offset_bottom = 75.0

[node name="TitleLabel" type="Label" parent="VBoxContainer"]
layout_mode = 2
text = "{ProjectName}"
horizontal_alignment = 1

[node name="PlayButton" type="Button" parent="VBoxContainer"]
layout_mode = 2
text = "Play"

[node name="QuitButton" type="Button" parent="VBoxContainer"]
layout_mode = 2
text = "Quit"
```

### MainMenu Script Template

```gdscript
extends Control

func _ready() -> void:
    %PlayButton.pressed.connect(_on_play_pressed)
    %QuitButton.pressed.connect(_on_quit_pressed)

func _on_play_pressed() -> void:
    get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_quit_pressed() -> void:
    get_tree().quit()
```

### Template: HUD

Generates a HUD with score label, health bar, and timer display.

### Template: PauseMenu

Generates a pause menu overlay with resume/quit buttons and `get_tree().paused` handling.

### Template: GameOver

Generates a game over screen with score display and retry/quit buttons.

---

## Script 5: `create-autoload.ps1`

### Purpose
Create a singleton/autoload script and register it in `project.godot`. Autoloads are Godot's equivalent of globally accessible services.

### Parameters
```powershell
param(
    [Parameter(Mandatory=$true)]
    [string]$AutoloadName,         # e.g. "GameManager", "AudioManager", "SaveSystem"
    
    [Parameter(Mandatory=$true)]
    [string]$ProjectPath,
    
    [ValidateSet("GameManager", "AudioManager", "SceneManager", "SaveSystem", "SignalBus", "Custom")]
    [string]$Template = "Custom"
)
```

### What It Does
1. Creates `scripts/{autoload_name}.gd` with template code
2. Appends to the `[autoload]` section in `project.godot`:
   ```ini
   [autoload]
   GameManager="*res://scripts/game_manager.gd"
   ```

### Template: GameManager

```gdscript
extends Node

# Game state
var score: int = 0
var high_score: int = 0
var is_game_over: bool = false

# Signals
signal score_changed(new_score: int)
signal game_over()
signal game_started()

func start_game() -> void:
    score = 0
    is_game_over = false
    score_changed.emit(score)
    game_started.emit()

func add_score(points: int) -> void:
    score += points
    if score > high_score:
        high_score = score
    score_changed.emit(score)

func end_game() -> void:
    is_game_over = true
    game_over.emit()

func reset() -> void:
    score = 0
    is_game_over = false
```

### Template: SignalBus

```gdscript
extends Node

# Global signal bus for decoupled communication between scenes.
# Connect to these signals from any node in the scene tree.

signal player_died()
signal enemy_killed(enemy_type: String)
signal item_collected(item_type: String)
signal level_completed(level_id: int)
signal ui_requested(screen_name: String)
```

### Template: AudioManager

```gdscript
extends Node

var music_bus_index: int
var sfx_bus_index: int

func _ready() -> void:
    music_bus_index = AudioServer.get_bus_index("Music")
    sfx_bus_index = AudioServer.get_bus_index("SFX")

func set_music_volume(volume_db: float) -> void:
    AudioServer.set_bus_volume_db(music_bus_index, volume_db)

func set_sfx_volume(volume_db: float) -> void:
    AudioServer.set_bus_volume_db(sfx_bus_index, volume_db)

func play_sfx(sfx_path: String) -> void:
    var player := AudioStreamPlayer.new()
    player.stream = load(sfx_path)
    player.bus = "SFX"
    add_child(player)
    player.play()
    player.finished.connect(player.queue_free)
```

### Template: SaveSystem

```gdscript
extends Node

const SAVE_PATH := "user://save_data.json"

var save_data: Dictionary = {}

func save_game() -> void:
    var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
    if file:
        file.store_string(JSON.stringify(save_data, "\t"))

func load_game() -> bool:
    if not FileAccess.file_exists(SAVE_PATH):
        return false
    var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
    if file:
        var json := JSON.new()
        if json.parse(file.get_as_text()) == OK:
            save_data = json.data
            return true
    return false
```

---

## Script 6: `create-player-controller.ps1`

### Purpose
Create a player scene with movement, collision, and camera follow. This is the most complex scaffolding script because player controllers are the #1 source of AI-generation issues.

### Parameters
```powershell
param(
    [Parameter(Mandatory=$true)]
    [string]$ProjectPath,
    
    [ValidateSet("Platformer", "TopDown", "FirstPerson")]
    [string]$MovementType = "TopDown",
    
    [switch]$WithCamera              # Attach a Camera2D/Camera3D
)
```

### Template: TopDown 2D

```gdscript
extends CharacterBody2D

@export var speed: float = 200.0

func _physics_process(_delta: float) -> void:
    var input_direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
    velocity = input_direction * speed
    move_and_slide()
```

### Template: Platformer 2D

```gdscript
extends CharacterBody2D

@export var speed: float = 300.0
@export var jump_velocity: float = -400.0

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta: float) -> void:
    # Gravity
    if not is_on_floor():
        velocity.y += gravity * delta

    # Jump
    if Input.is_action_just_pressed("jump") and is_on_floor():
        velocity.y = jump_velocity

    # Horizontal movement
    var direction := Input.get_axis("move_left", "move_right")
    if direction:
        velocity.x = direction * speed
    else:
        velocity.x = move_toward(velocity.x, 0, speed)

    move_and_slide()
```

### Template: First Person 3D

```gdscript
extends CharacterBody3D

@export var speed: float = 5.0
@export var jump_velocity: float = 4.5
@export var mouse_sensitivity: float = 0.002

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready() -> void:
    Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event: InputEvent) -> void:
    if event is InputEventMouseMotion:
        rotate_y(-event.relative.x * mouse_sensitivity)
        $Camera3D.rotate_x(-event.relative.y * mouse_sensitivity)
        $Camera3D.rotation.x = clamp($Camera3D.rotation.x, -PI/2, PI/2)
    
    if event.is_action_pressed("ui_cancel"):
        Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _physics_process(delta: float) -> void:
    if not is_on_floor():
        velocity.y -= gravity * delta

    if Input.is_action_just_pressed("jump") and is_on_floor():
        velocity.y = jump_velocity

    var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")
    var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
    if direction:
        velocity.x = direction.x * speed
        velocity.z = direction.z * speed
    else:
        velocity.x = move_toward(velocity.x, 0, speed)
        velocity.z = move_toward(velocity.z, 0, speed)

    move_and_slide()
```

---

## Script 7: `add-input-actions.ps1`

### Purpose
Register standard input actions in `project.godot`. Games need input configuration that SaaS apps don't.

### Parameters
```powershell
param(
    [Parameter(Mandatory=$true)]
    [string]$ProjectPath,
    
    [ValidateSet("Platformer", "TopDown", "FirstPerson", "UI")]
    [string]$Preset = "TopDown"
)
```

### What It Does
Appends an `[input]` section to `project.godot` with the correct event objects for each action. Each preset includes:

- **TopDown**: `move_left` (A/←), `move_right` (D/→), `move_up` (W/↑), `move_down` (S/↓), `interact` (E), `pause` (Esc)
- **Platformer**: `move_left` (A/←), `move_right` (D/→), `jump` (Space/W/↑), `pause` (Esc)
- **FirstPerson**: `move_left` (A), `move_right` (D), `move_up` (W), `move_down` (S), `jump` (Space), `interact` (E), `pause` (Esc)
- **UI**: `confirm` (Enter/Space), `cancel` (Esc), `pause` (Esc)

### Implementation Note
The input event format in `project.godot` is verbose (each key is a serialized `InputEventKey` object). The script should use a helper function to generate these consistently:

```powershell
function New-InputEventKey {
    param([int]$Keycode)
    return "Object(InputEventKey,`"resource_local_to_scene`":false,`"resource_name`":`"`",`"device`":-1,`"window_id`":0,`"alt_pressed`":false,`"shift_pressed`":false,`"ctrl_pressed`":false,`"meta_pressed`":false,`"pressed`":false,`"keycode`":$Keycode,`"physical_keycode`":0,`"key_label`":0,`"unicode`":0,`"location`":0,`"echo`":false,`"script`":null)"
}
```

---

## Script 8: `add-gut-tests.ps1`

### Purpose
Add the GUT (Godot Unit Test) framework to a Godot project and scaffold initial test files.

### Parameters
```powershell
param(
    [Parameter(Mandatory=$true)]
    [string]$ProjectPath
)
```

### What It Does

1. Downloads the GUT addon (from GitHub releases or bundled):
   ```
   addons/gut/
   ├── gut.gd
   ├── gut_cmdline.gd
   ├── test.gd           # Base class for test scripts
   ├── plugin.cfg
   └── ... (other GUT files)
   ```

2. Enables the plugin in `project.godot`:
   ```ini
   [editor_plugins]
   enabled=PackedStringArray("res://addons/gut/plugin.cfg")
   ```

3. Creates `.gutconfig.json`:
   ```json
   {
     "dirs": ["res://tests/"],
     "include_subdirs": true,
     "prefix": "test_",
     "suffix": ".gd",
     "log_level": 1,
     "should_exit": true,
     "should_exit_on_success": true
   }
   ```

4. Creates a sample test:
   ```gdscript
   # tests/test_example.gd
   extends GutTest

   func test_sanity_check():
       assert_true(true, "Basic test should pass")
   ```

### Running Tests
```bash
godot --headless -s addons/gut/gut_cmdline.gd -gexit
```

---

## Script 9: `create-tilemap-scene.ps1`

### Purpose
Create a TileMap-based level scene for 2D games. TileMaps are extremely common in 2D games and tricky to set up correctly.

### Parameters
```powershell
param(
    [Parameter(Mandatory=$true)]
    [string]$SceneName,            # e.g. "Level1", "World"
    
    [Parameter(Mandatory=$true)]
    [string]$ProjectPath,
    
    [int]$TileSize = 16,           # Tile size in pixels
    
    [switch]$WithCollisionLayer,   # Add physics layer to tiles
    [switch]$WithScript
)
```

### What It Creates
- A scene with a `TileMapLayer` node (Godot 4.3+ replaced `TileMap` with `TileMapLayer`)
- A `TileSet` resource with a placeholder atlas
- Optional collision physics layer configuration

---

## Copilot Tool Function Definitions

These correspond to how the scripts would be exposed to Copilot in a `GodotProjectTools` class:

```csharp
private sealed class GodotProjectTools(IProcessRunner processRunner, string outputDirectory)
{
    [DisplayName("create_godot_project")]
    [Description("Create a new Godot 4.x game project with folder structure, project.godot, and main scene.")]
    public Task<string> CreateGodotProject(
        [Description("The name of the game project, e.g. 'DodgeTheCreeps'")] string projectName,
        [Description("Whether the game is 2D or 3D. Use '2d' or '3d'.")] string mode = "2d")
        => processRunner.RunProjectScript("create-godot-project.ps1", $"-ProjectName {projectName} -Mode {mode}", outputDirectory);

    [DisplayName("create_2d_scene")]
    [Description("Create a new 2D scene file (.tscn) with a root node and optional collision/sprite children.")]
    public Task<string> Create2DScene(
        [Description("Scene name, e.g. 'Player', 'Enemy', 'Level1'")] string sceneName,
        [Description("Root node type: Node2D, CharacterBody2D, RigidBody2D, Area2D, or StaticBody2D")] string rootNodeType = "Node2D",
        [Description("Whether to create a matching .gd script")] bool withScript = true,
        [Description("Whether to add a CollisionShape2D child")] bool withCollision = false,
        [Description("Whether to add a Sprite2D child with placeholder texture")] bool withSprite = false)
        => processRunner.RunProjectScript("create-2d-scene.ps1", 
            $"-SceneName {sceneName} -ProjectPath {outputDirectory} -RootNodeType {rootNodeType}" +
            $"{(withScript ? " -WithScript" : "")}{(withCollision ? " -WithCollision" : "")}{(withSprite ? " -WithSprite" : "")}", 
            outputDirectory);

    [DisplayName("create_ui_scene")]
    [Description("Create a UI scene (menu, HUD, dialog) using Godot Control nodes.")]
    public Task<string> CreateUIScene(
        [Description("Scene name, e.g. 'MainMenu', 'HUD', 'PauseMenu'")] string sceneName,
        [Description("Template: MainMenu, HUD, PauseMenu, GameOver, Settings, or Custom")] string template = "Custom",
        [Description("Whether to create a matching .gd script")] bool withScript = true)
        => processRunner.RunProjectScript("create-ui-scene.ps1",
            $"-SceneName {sceneName} -ProjectPath {outputDirectory} -Template {template}{(withScript ? " -WithScript" : "")}",
            outputDirectory);

    [DisplayName("create_autoload")]
    [Description("Create a singleton/autoload script and register it in project.godot. Use for global game state, audio management, or scene transitions.")]
    public Task<string> CreateAutoload(
        [Description("Autoload name, e.g. 'GameManager', 'AudioManager', 'SignalBus'")] string autoloadName,
        [Description("Template: GameManager, AudioManager, SceneManager, SaveSystem, SignalBus, or Custom")] string template = "Custom")
        => processRunner.RunProjectScript("create-autoload.ps1",
            $"-AutoloadName {autoloadName} -ProjectPath {outputDirectory} -Template {template}",
            outputDirectory);

    [DisplayName("create_player_controller")]
    [Description("Create a player scene with movement script, collision, and optional camera. Use the appropriate movement type for the game genre.")]
    public Task<string> CreatePlayerController(
        [Description("Movement type: Platformer (side-scrolling jump), TopDown (4-directional), or FirstPerson (3D FPS)")] string movementType = "TopDown",
        [Description("Whether to attach a following camera")] bool withCamera = true)
        => processRunner.RunProjectScript("create-player-controller.ps1",
            $"-ProjectPath {outputDirectory} -MovementType {movementType}{(withCamera ? " -WithCamera" : "")}",
            outputDirectory);

    [DisplayName("add_input_actions")]
    [Description("Register standard input actions (movement, jump, interact, pause) in project.godot.")]
    public Task<string> AddInputActions(
        [Description("Input preset: Platformer, TopDown, FirstPerson, or UI")] string preset = "TopDown")
        => processRunner.RunProjectScript("add-input-actions.ps1",
            $"-ProjectPath {outputDirectory} -Preset {preset}",
            outputDirectory);

    [DisplayName("add_gut_tests")]
    [Description("Add the GUT (Godot Unit Test) framework and scaffold initial test files.")]
    public Task<string> AddGutTests()
        => processRunner.RunProjectScript("add-gut-tests.ps1",
            $"-ProjectPath {outputDirectory}",
            outputDirectory);
}
```

---

## Script Execution Order

The typical order for a new Godot game project:

```
1. create-godot-project.ps1     → Project shell exists
2. add-input-actions.ps1        → Input map configured
3. create-player-controller.ps1 → Player scene + movement script
4. create-2d-scene.ps1 (×N)    → Enemy, item, level scenes
5. create-ui-scene.ps1 (×N)    → Main menu, HUD, pause menu
6. create-autoload.ps1 (×N)    → GameManager, SignalBus, etc.
7. add-gut-tests.ps1           → Test framework ready
8. [AI writes game logic scripts, connects scenes, implements features]
9. godot --headless --import --quit  → Validate
10. godot --headless -s addons/gut/gut_cmdline.gd -gexit  → Run tests
```
