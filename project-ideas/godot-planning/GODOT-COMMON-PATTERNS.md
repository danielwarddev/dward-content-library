# Godot Common Game Patterns — Reference Library

## Overview

This document catalogs common game development patterns implemented in GDScript for Godot 4.x. These patterns serve two purposes:

1. **System prompt reference** — Attached to Copilot sessions so the AI knows correct Godot idioms
2. **Scaffolding template source** — Some patterns are complex enough to warrant dedicated scaffolding scripts

---

## Table of Contents

1. [State Machine](#1-state-machine)
2. [Enemy AI — Chase and Patrol](#2-enemy-ai--chase-and-patrol)
3. [Spawner / Wave System](#3-spawner--wave-system)
4. [Health System with Damage](#4-health-system-with-damage)
5. [Inventory System](#5-inventory-system)
6. [Dialogue System](#6-dialogue-system)
7. [Camera Follow with Smoothing](#7-camera-follow-with-smoothing)
8. [Object Pooling](#8-object-pooling)
9. [Save / Load System](#9-save--load-system)
10. [Scene Transition with Fade](#10-scene-transition-with-fade)
11. [Drag and Drop (UI)](#11-drag-and-drop-ui)
12. [Grid-Based Movement](#12-grid-based-movement)
13. [Projectile System](#13-projectile-system)
14. [Parallax Background](#14-parallax-background)
15. [Screen Shake](#15-screen-shake)
16. [Collectibles and Pickups](#16-collectibles-and-pickups)
17. [Timer-Based Mechanics](#17-timer-based-mechanics)
18. [Navigation / Pathfinding (AI)](#18-navigation--pathfinding-ai)

---

## 1. State Machine

**Use for**: Player states (idle, running, jumping, attacking), enemy behavior, game flow, UI screens.

This is the single most important pattern in game development. Nearly every game entity benefits from a state machine.

### Implementation

```gdscript
# state_machine.gd — Reusable state machine component
class_name StateMachine
extends Node

@export var initial_state: State

var current_state: State
var states: Dictionary[String, State] = {}

func _ready() -> void:
    for child in get_children():
        if child is State:
            states[child.name.to_lower()] = child
            child.transitioned.connect(_on_child_transitioned)
    
    if initial_state:
        initial_state.enter()
        current_state = initial_state

func _process(delta: float) -> void:
    if current_state:
        current_state.update(delta)

func _physics_process(delta: float) -> void:
    if current_state:
        current_state.physics_update(delta)

func _on_child_transitioned(state: State, new_state_name: String) -> void:
    if state != current_state:
        return
    var new_state: State = states.get(new_state_name.to_lower())
    if new_state == null:
        return
    current_state.exit()
    new_state.enter()
    current_state = new_state
```

```gdscript
# state.gd — Base state class
class_name State
extends Node

signal transitioned(state: State, new_state_name: String)

func enter() -> void:
    pass

func exit() -> void:
    pass

func update(_delta: float) -> void:
    pass

func physics_update(_delta: float) -> void:
    pass
```

```gdscript
# Example: idle_state.gd
extends State

@export var player: CharacterBody2D

func enter() -> void:
    player.velocity = Vector2.ZERO

func update(_delta: float) -> void:
    if Input.get_vector("move_left", "move_right", "move_up", "move_down") != Vector2.ZERO:
        transitioned.emit(self, "Running")
```

### Scene Tree Structure

```
Player (CharacterBody2D)
├── Sprite2D
├── CollisionShape2D
└── StateMachine
    ├── Idle (State)
    ├── Running (State)
    ├── Jumping (State)
    └── Attacking (State)
```

---

## 2. Enemy AI — Chase and Patrol

**Use for**: Enemies that patrol between waypoints and chase the player when detected.

### Simple Chase (No Pathfinding)

```gdscript
# enemy.gd
extends CharacterBody2D

@export var patrol_speed: float = 50.0
@export var chase_speed: float = 120.0
@export var detection_range: float = 200.0

var player: CharacterBody2D = null

func _ready() -> void:
    # Find player in group
    await get_tree().process_frame
    var players := get_tree().get_nodes_in_group("player")
    if players.size() > 0:
        player = players[0]

func _physics_process(_delta: float) -> void:
    if player == null:
        return
    
    var distance := global_position.distance_to(player.global_position)
    
    if distance < detection_range:
        # Chase player
        var direction := (player.global_position - global_position).normalized()
        velocity = direction * chase_speed
    else:
        # Idle or patrol
        velocity = Vector2.ZERO
    
    move_and_slide()
```

### Patrol Between Waypoints

```gdscript
# patrol_enemy.gd
extends CharacterBody2D

@export var speed: float = 60.0
@export var patrol_points: Array[Vector2] = []
var current_point_index: int = 0

func _physics_process(_delta: float) -> void:
    if patrol_points.is_empty():
        return
    
    var target: Vector2 = patrol_points[current_point_index]
    var direction := (target - global_position).normalized()
    velocity = direction * speed
    
    if global_position.distance_to(target) < 5.0:
        current_point_index = (current_point_index + 1) % patrol_points.size()
    
    move_and_slide()
```

### Detection Area Pattern

```gdscript
# enemy_with_detection.gd
extends CharacterBody2D

var target: CharacterBody2D = null
@export var chase_speed: float = 100.0

func _ready() -> void:
    $DetectionArea.body_entered.connect(_on_detection_area_body_entered)
    $DetectionArea.body_exited.connect(_on_detection_area_body_exited)

func _physics_process(_delta: float) -> void:
    if target:
        velocity = (target.global_position - global_position).normalized() * chase_speed
    else:
        velocity = Vector2.ZERO
    move_and_slide()

func _on_detection_area_body_entered(body: Node2D) -> void:
    if body.is_in_group("player"):
        target = body

func _on_detection_area_body_exited(body: Node2D) -> void:
    if body == target:
        target = null
```

Scene tree for detection:
```
Enemy (CharacterBody2D)
├── Sprite2D
├── CollisionShape2D
└── DetectionArea (Area2D)
    └── CollisionShape2D  # Larger radius for detection
```

---

## 3. Spawner / Wave System

**Use for**: Spawning enemies in waves, spawning pickups, spawning obstacles.

```gdscript
# spawner.gd
extends Node2D

@export var enemy_scene: PackedScene
@export var spawn_interval: float = 2.0
@export var max_enemies: int = 10
@export var spawn_radius: float = 300.0

var enemy_count: int = 0

func _ready() -> void:
    $SpawnTimer.wait_time = spawn_interval
    $SpawnTimer.timeout.connect(_on_spawn_timer_timeout)
    $SpawnTimer.start()

func _on_spawn_timer_timeout() -> void:
    if enemy_count >= max_enemies:
        return
    
    var enemy := enemy_scene.instantiate()
    var angle := randf() * TAU
    var offset := Vector2(cos(angle), sin(angle)) * spawn_radius
    enemy.global_position = global_position + offset
    enemy.tree_exiting.connect(func(): enemy_count -= 1)
    get_parent().add_child(enemy)
    enemy_count += 1
```

### Wave System

```gdscript
# wave_spawner.gd
extends Node

signal wave_started(wave_number: int)
signal wave_completed(wave_number: int)
signal all_waves_completed()

@export var enemy_scene: PackedScene
@export var waves: Array[Dictionary] = [
    {"count": 3, "delay": 1.0},
    {"count": 5, "delay": 0.8},
    {"count": 8, "delay": 0.5},
]

var current_wave: int = 0
var enemies_alive: int = 0
var spawn_points: Array[Node2D] = []

func _ready() -> void:
    for child in get_children():
        if child is Marker2D:
            spawn_points.append(child)

func start_waves() -> void:
    current_wave = 0
    _start_next_wave()

func _start_next_wave() -> void:
    if current_wave >= waves.size():
        all_waves_completed.emit()
        return
    
    var wave: Dictionary = waves[current_wave]
    wave_started.emit(current_wave + 1)
    
    for i in wave["count"]:
        await get_tree().create_timer(wave["delay"]).timeout
        _spawn_enemy()

func _spawn_enemy() -> void:
    var enemy := enemy_scene.instantiate()
    var spawn_point: Node2D = spawn_points.pick_random()
    enemy.global_position = spawn_point.global_position
    enemy.tree_exiting.connect(_on_enemy_died)
    get_parent().add_child(enemy)
    enemies_alive += 1

func _on_enemy_died() -> void:
    enemies_alive -= 1
    if enemies_alive <= 0:
        wave_completed.emit(current_wave + 1)
        current_wave += 1
        await get_tree().create_timer(2.0).timeout
        _start_next_wave()
```

---

## 4. Health System with Damage

**Use for**: Player health, enemy health, destructible objects.

```gdscript
# health_component.gd — Reusable component
class_name HealthComponent
extends Node

signal health_changed(current: int, maximum: int)
signal died()

@export var max_health: int = 100
var current_health: int

func _ready() -> void:
    current_health = max_health

func take_damage(amount: int) -> void:
    current_health = max(0, current_health - amount)
    health_changed.emit(current_health, max_health)
    if current_health <= 0:
        died.emit()

func heal(amount: int) -> void:
    current_health = min(max_health, current_health + amount)
    health_changed.emit(current_health, max_health)

func get_health_percent() -> float:
    return float(current_health) / float(max_health)
```

### Usage with Hurtbox/Hitbox Pattern

```gdscript
# hurtbox.gd — Receives damage
class_name Hurtbox
extends Area2D

signal hurt(damage: int)

func _ready() -> void:
    area_entered.connect(_on_area_entered)

func _on_area_entered(area: Area2D) -> void:
    if area is Hitbox:
        hurt.emit(area.damage)
```

```gdscript
# hitbox.gd — Deals damage
class_name Hitbox
extends Area2D

@export var damage: int = 10
```

Scene tree for a damageable entity:
```
Enemy (CharacterBody2D)
├── Sprite2D
├── CollisionShape2D         # Physics collision
├── HealthComponent
├── Hurtbox (Area2D)         # Receives damage
│   └── CollisionShape2D
└── Hitbox (Area2D)          # Deals damage on contact
    └── CollisionShape2D
```

---

## 5. Inventory System

**Use for**: RPGs, survival games, any game with collectible items.

```gdscript
# inventory.gd
class_name Inventory
extends Resource

signal item_added(item: InventoryItem)
signal item_removed(item: InventoryItem)
signal inventory_changed()

@export var max_slots: int = 20
var items: Array[InventoryItem] = []

func add_item(item: InventoryItem) -> bool:
    if items.size() >= max_slots:
        return false
    items.append(item)
    item_added.emit(item)
    inventory_changed.emit()
    return true

func remove_item(item: InventoryItem) -> void:
    items.erase(item)
    item_removed.emit(item)
    inventory_changed.emit()

func has_item(item_id: String) -> bool:
    for item in items:
        if item.id == item_id:
            return true
    return false
```

```gdscript
# inventory_item.gd
class_name InventoryItem
extends Resource

@export var id: String
@export var name: String
@export var description: String
@export var icon: Texture2D
@export var stackable: bool = false
@export var max_stack: int = 99
var quantity: int = 1
```

---

## 6. Dialogue System

**Use for**: Visual novels, RPGs, adventure games, any game with NPC conversations.

```gdscript
# dialogue_manager.gd — Autoload singleton
extends Node

signal dialogue_started()
signal dialogue_line_displayed(speaker: String, text: String)
signal dialogue_choice_presented(choices: Array[String])
signal dialogue_ended()

var current_dialogue: Array[Dictionary] = []
var current_index: int = 0
var is_active: bool = false

func start_dialogue(dialogue_data: Array[Dictionary]) -> void:
    current_dialogue = dialogue_data
    current_index = 0
    is_active = true
    dialogue_started.emit()
    _show_next_line()

func advance() -> void:
    if not is_active:
        return
    current_index += 1
    if current_index >= current_dialogue.size():
        end_dialogue()
    else:
        _show_next_line()

func choose(choice_index: int) -> void:
    var line: Dictionary = current_dialogue[current_index]
    if "choices" in line and choice_index < line["choices"].size():
        var choice: Dictionary = line["choices"][choice_index]
        if "jump_to" in choice:
            current_index = choice["jump_to"] - 1  # -1 because advance() will +1
            advance()

func end_dialogue() -> void:
    is_active = false
    current_dialogue = []
    dialogue_ended.emit()

func _show_next_line() -> void:
    var line: Dictionary = current_dialogue[current_index]
    dialogue_line_displayed.emit(line.get("speaker", ""), line.get("text", ""))
    if "choices" in line:
        var choice_texts: Array[String] = []
        for choice in line["choices"]:
            choice_texts.append(choice["text"])
        dialogue_choice_presented.emit(choice_texts)
```

### Dialogue Data Format

```gdscript
# Example usage
var sample_dialogue: Array[Dictionary] = [
    {"speaker": "NPC", "text": "Hello, traveler! What brings you here?"},
    {"speaker": "NPC", "text": "I have a quest for you.", "choices": [
        {"text": "Tell me more", "jump_to": 3},
        {"text": "Not interested", "jump_to": 5},
    ]},
    {"speaker": "NPC", "text": "You should never see this line."},
    {"speaker": "NPC", "text": "A dragon has been spotted near the village!"},
    {"speaker": "NPC", "text": "Will you help us defeat it?"},
    {"speaker": "NPC", "text": "Very well. Safe travels."},
]
```

---

## 7. Camera Follow with Smoothing

**Use for**: Following the player, with options for zoom, limits, and smooth movement.

```gdscript
# camera_controller.gd
extends Camera2D

@export var target: Node2D
@export var follow_speed: float = 5.0
@export var look_ahead: float = 50.0

func _process(delta: float) -> void:
    if target == null:
        return
    
    var target_position := target.global_position
    
    # Optional: look ahead in movement direction
    if target is CharacterBody2D:
        target_position += target.velocity.normalized() * look_ahead
    
    global_position = global_position.lerp(target_position, follow_speed * delta)
```

### Camera with Limits and Zoom

```gdscript
# bounded_camera.gd
extends Camera2D

@export var target: Node2D
@export var smoothing: float = 5.0
@export var min_zoom: float = 0.5
@export var max_zoom: float = 2.0
@export var zoom_speed: float = 0.1

func _ready() -> void:
    # Enable camera smoothing (built-in)
    position_smoothing_enabled = true
    position_smoothing_speed = smoothing

func _process(_delta: float) -> void:
    if target:
        global_position = target.global_position

func _unhandled_input(event: InputEvent) -> void:
    if event is InputEventMouseButton:
        if event.button_index == MOUSE_BUTTON_WHEEL_UP:
            zoom = (zoom + Vector2.ONE * zoom_speed).clampf(min_zoom, max_zoom)
        elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
            zoom = (zoom - Vector2.ONE * zoom_speed).clampf(min_zoom, max_zoom)
```

---

## 8. Object Pooling

**Use for**: Bullets, particles, frequently spawned/destroyed objects to avoid GC pressure.

```gdscript
# object_pool.gd
class_name ObjectPool
extends Node

@export var scene: PackedScene
@export var initial_size: int = 20

var pool: Array[Node] = []

func _ready() -> void:
    for i in initial_size:
        var obj := scene.instantiate()
        obj.set_process(false)
        obj.hide()
        add_child(obj)
        pool.append(obj)

func get_object() -> Node:
    for obj in pool:
        if not obj.visible:
            obj.show()
            obj.set_process(true)
            return obj
    # Pool exhausted — create a new one
    var obj := scene.instantiate()
    add_child(obj)
    pool.append(obj)
    return obj

func return_object(obj: Node) -> void:
    obj.set_process(false)
    obj.hide()
```

---

## 9. Save / Load System

**Use for**: Any game that needs to persist progress between sessions.

```gdscript
# save_manager.gd — Autoload singleton
extends Node

const SAVE_PATH := "user://save_data.json"

signal game_saved()
signal game_loaded()

var save_data: Dictionary = {
    "player": {
        "position_x": 0.0,
        "position_y": 0.0,
        "health": 100,
    },
    "game": {
        "score": 0,
        "level": 1,
        "time_played": 0.0,
    },
    "settings": {
        "music_volume": 1.0,
        "sfx_volume": 1.0,
        "fullscreen": false,
    }
}

func save_game() -> void:
    var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
    if file:
        file.store_string(JSON.stringify(save_data, "\t"))
        game_saved.emit()

func load_game() -> bool:
    if not FileAccess.file_exists(SAVE_PATH):
        return false
    var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
    if file == null:
        return false
    var json := JSON.new()
    if json.parse(file.get_as_text()) == OK:
        save_data = json.data
        game_loaded.emit()
        return true
    return false

func delete_save() -> void:
    if FileAccess.file_exists(SAVE_PATH):
        DirAccess.remove_absolute(SAVE_PATH)
```

---

## 10. Scene Transition with Fade

**Use for**: Smooth transitions between levels, menus, and game states.

```gdscript
# scene_manager.gd — Autoload singleton
extends CanvasLayer

@onready var color_rect: ColorRect = $ColorRect
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var is_transitioning: bool = false

func change_scene(scene_path: String, transition_duration: float = 0.5) -> void:
    if is_transitioning:
        return
    is_transitioning = true
    
    # Fade to black
    var tween := create_tween()
    tween.tween_property(color_rect, "color:a", 1.0, transition_duration)
    await tween.finished
    
    # Change scene
    get_tree().change_scene_to_file(scene_path)
    
    # Fade from black
    tween = create_tween()
    tween.tween_property(color_rect, "color:a", 0.0, transition_duration)
    await tween.finished
    
    is_transitioning = false
```

Scene tree for SceneManager autoload:
```
SceneManager (CanvasLayer)
└── ColorRect  # Full screen, black, starts at alpha 0
```

---

## 11. Drag and Drop (UI)

**Use for**: Card games, inventory management, puzzle games, editor tools.

```gdscript
# draggable.gd — Attach to any Control node
extends Control

signal drag_started()
signal drag_ended(dropped_on: Control)

var is_dragging: bool = false
var drag_offset: Vector2

func _gui_input(event: InputEvent) -> void:
    if event is InputEventMouseButton:
        if event.button_index == MOUSE_BUTTON_LEFT:
            if event.pressed:
                is_dragging = true
                drag_offset = global_position - get_global_mouse_position()
                drag_started.emit()
            else:
                is_dragging = false
                drag_ended.emit(null)  # TODO: detect drop target

func _process(_delta: float) -> void:
    if is_dragging:
        global_position = get_global_mouse_position() + drag_offset
```

---

## 12. Grid-Based Movement

**Use for**: Turn-based RPGs, puzzle games (Sokoban, match-3), tactical games.

```gdscript
# grid_mover.gd
extends CharacterBody2D

@export var tile_size: int = 64
@export var move_speed: float = 4.0

var is_moving: bool = false

func _process(delta: float) -> void:
    if is_moving:
        return
    
    var input := Vector2.ZERO
    if Input.is_action_pressed("move_left"):
        input = Vector2.LEFT
    elif Input.is_action_pressed("move_right"):
        input = Vector2.RIGHT
    elif Input.is_action_pressed("move_up"):
        input = Vector2.UP
    elif Input.is_action_pressed("move_down"):
        input = Vector2.DOWN
    
    if input != Vector2.ZERO:
        _move(input)

func _move(direction: Vector2) -> void:
    var target := position + direction * tile_size
    
    # Optional: check for walls using raycast
    $RayCast2D.target_position = direction * tile_size
    $RayCast2D.force_raycast_update()
    if $RayCast2D.is_colliding():
        return
    
    is_moving = true
    var tween := create_tween()
    tween.tween_property(self, "position", target, 1.0 / move_speed)
    await tween.finished
    is_moving = false
```

---

## 13. Projectile System

**Use for**: Bullets, arrows, fireballs, any launched object.

```gdscript
# projectile.gd
extends Area2D

@export var speed: float = 400.0
@export var damage: int = 10
@export var lifetime: float = 3.0

var direction: Vector2 = Vector2.RIGHT

func _ready() -> void:
    body_entered.connect(_on_body_entered)
    $LifetimeTimer.wait_time = lifetime
    $LifetimeTimer.timeout.connect(queue_free)
    $LifetimeTimer.start()

func _physics_process(delta: float) -> void:
    position += direction * speed * delta

func _on_body_entered(body: Node2D) -> void:
    if body.has_method("take_damage"):
        body.take_damage(damage)
    queue_free()

# Call this from the shooter to set direction
func launch(dir: Vector2) -> void:
    direction = dir.normalized()
    rotation = direction.angle()
```

### Spawning Projectiles

```gdscript
# In the player or weapon script:
@export var projectile_scene: PackedScene

func shoot() -> void:
    var projectile := projectile_scene.instantiate()
    projectile.global_position = $Muzzle.global_position
    projectile.launch(Vector2.RIGHT.rotated(rotation))
    get_parent().add_child(projectile)
```

---

## 14. Parallax Background

**Use for**: Side-scrolling games, any game wanting depth perception in 2D.

```gdscript
# Scene tree structure — no custom script needed for basic parallax
# ParallaxBackground
# ├── ParallaxLayer (motion_scale = Vector2(0.2, 0))  # Far background (slow)
# │   └── Sprite2D (sky texture)
# ├── ParallaxLayer (motion_scale = Vector2(0.5, 0))  # Mid background
# │   └── Sprite2D (mountains texture)
# └── ParallaxLayer (motion_scale = Vector2(0.8, 0))  # Near background (fast)
#     └── Sprite2D (trees texture)
```

For MVP purposes with placeholder art:
```gdscript
# parallax_setup.gd — Attach to ParallaxBackground
extends ParallaxBackground

func _ready() -> void:
    # Create layers with colored rectangles
    _add_layer(Color(0.5, 0.7, 1.0), Vector2(0.2, 0))  # Sky blue
    _add_layer(Color(0.3, 0.5, 0.3), Vector2(0.5, 0))  # Green hills
    _add_layer(Color(0.2, 0.4, 0.2), Vector2(0.8, 0))  # Dark green foreground

func _add_layer(color: Color, motion_scale: Vector2) -> void:
    var layer := ParallaxLayer.new()
    layer.motion_scale = motion_scale
    var rect := ColorRect.new()
    rect.size = Vector2(2048, 600)
    rect.position.y = -300
    rect.color = color
    layer.add_child(rect)
    add_child(layer)
```

---

## 15. Screen Shake

**Use for**: Impact feedback, explosions, damage taken, dramatic moments.

```gdscript
# screen_shake.gd — Attach to Camera2D
extends Camera2D

var shake_strength: float = 0.0
var shake_decay: float = 5.0

func shake(strength: float = 10.0, duration: float = 0.3) -> void:
    shake_strength = strength
    var tween := create_tween()
    tween.tween_property(self, "shake_strength", 0.0, duration)

func _process(delta: float) -> void:
    if shake_strength > 0:
        offset = Vector2(
            randf_range(-shake_strength, shake_strength),
            randf_range(-shake_strength, shake_strength)
        )
    else:
        offset = Vector2.ZERO
```

---

## 16. Collectibles and Pickups

**Use for**: Coins, power-ups, health pickups, keys.

```gdscript
# pickup.gd
extends Area2D

signal collected(pickup_type: String)

@export var pickup_type: String = "coin"
@export var value: int = 1

func _ready() -> void:
    body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
    if body.is_in_group("player"):
        collected.emit(pickup_type)
        # Optional: play collection animation
        var tween := create_tween()
        tween.tween_property(self, "scale", Vector2.ZERO, 0.2)
        tween.tween_callback(queue_free)
```

### Integration with GameManager

```gdscript
# In pickup._ready() or via GameManager connection:
func _on_body_entered(body: Node2D) -> void:
    if body.is_in_group("player"):
        match pickup_type:
            "coin":
                GameManager.add_score(value)
            "health":
                body.get_node("HealthComponent").heal(value)
        queue_free()
```

---

## 17. Timer-Based Mechanics

**Use for**: Cooldowns, spawn intervals, timed events, countdowns.

```gdscript
# Godot's built-in Timer node is preferred over manual delta tracking.

# Example: Cooldown-gated ability
extends CharacterBody2D

@export var attack_cooldown: float = 0.5
var can_attack: bool = true

func _ready() -> void:
    $AttackCooldown.wait_time = attack_cooldown
    $AttackCooldown.one_shot = true
    $AttackCooldown.timeout.connect(func(): can_attack = true)

func attack() -> void:
    if not can_attack:
        return
    can_attack = false
    $AttackCooldown.start()
    # ... perform attack
```

```gdscript
# Example: Countdown timer for time-limited gameplay
extends Control

@export var game_time: float = 60.0
var time_remaining: float

signal time_expired()

func _ready() -> void:
    time_remaining = game_time

func _process(delta: float) -> void:
    time_remaining -= delta
    $TimerLabel.text = "%d:%02d" % [int(time_remaining) / 60, int(time_remaining) % 60]
    if time_remaining <= 0:
        time_expired.emit()
        set_process(false)
```

---

## 18. Navigation / Pathfinding (AI)

**Use for**: Smart enemy movement that avoids obstacles, NPC navigation, RTS unit movement.

### Setup Requirements

1. Add a `NavigationRegion2D` to the level scene with a `NavigationPolygon`
2. Bake the navigation mesh (defines walkable area)
3. Add a `NavigationAgent2D` to the entity that needs pathfinding

```gdscript
# navigating_enemy.gd
extends CharacterBody2D

@export var speed: float = 100.0
@export var target: Node2D

@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D

func _ready() -> void:
    nav_agent.path_desired_distance = 4.0
    nav_agent.target_desired_distance = 4.0

func _physics_process(_delta: float) -> void:
    if target == null:
        return
    
    nav_agent.target_position = target.global_position
    
    if nav_agent.is_navigation_finished():
        return
    
    var next_position := nav_agent.get_next_path_position()
    var direction := (next_position - global_position).normalized()
    velocity = direction * speed
    move_and_slide()
```

Scene tree:
```
Level (Node2D)
├── NavigationRegion2D  # Defines walkable area
│   └── NavigationPolygon
├── TileMapLayer        # Level geometry
├── Player
└── Enemy (CharacterBody2D)
    ├── Sprite2D
    ├── CollisionShape2D
    └── NavigationAgent2D
```

---

## Pattern Selection by Game Genre

| Genre | Essential Patterns | Nice-to-Have Patterns |
|-------|-------------------|----------------------|
| **2D Platformer** | State Machine, Health System, Collectibles, Camera Follow, Projectiles | Parallax, Screen Shake, Object Pool |
| **2D Top-Down** | State Machine, Health System, Enemy AI, Navigation, Spawner | Save/Load, Inventory, Dialogue |
| **Puzzle Game** | Grid Movement, State Machine, Timer Mechanics | Save/Load, Scene Transition |
| **Card Game** | Drag & Drop, State Machine, Timer Mechanics | Save/Load, Scene Transition |
| **Visual Novel** | Dialogue System, Scene Transition, Save/Load | State Machine |
| **Tower Defense** | Spawner/Waves, Pathfinding, Health System, Projectiles | Object Pool, Timer Mechanics |
| **Idle/Clicker** | Timer Mechanics, Save/Load, Health System | Scene Transition |
| **3D First Person** | State Machine, Health System, Projectiles, Camera Follow | Navigation, Screen Shake |
| **Survival** | Health System, Inventory, Save/Load, Spawner, Collectibles | Crafting (custom), Day/Night (custom) |
