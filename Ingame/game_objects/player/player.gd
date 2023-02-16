extends CharacterAlive

class_name Player

@export var drop_template : PackedScene

@onready var space_state = get_world_2d().get_direct_space_state()

@onready var go_down_floor_sensor : RayCast2D         = $go_down_floor_sensor
@onready var savepoint_sensor     : Area2D            = $savepoint_sensor
@onready var jump_sfx             : AudioStreamPlayer = $jump_sfx
@onready var catch_water_sfx      : AudioStreamPlayer = $catch_water_sfx
@onready var damaged_sfx          : AudioStreamPlayer = $damaged_sfx
@onready var skills               : PlayerSkills      = $skills

var crouching := true

var damager    : CharacterBody2D = null
var enemy_died : CharacterBody2D = null

func can_hit_enemy() -> bool:
	if enemy_died: return false
	if damager: return false
	if is_on_floor(): return false
	return velocity.y > .0

func teleport(_global_position : Vector2) -> void:
	global_position = _global_position
	savepoint_sensor.temporarily_deactivate()

func _ready() -> void:
	get_tree().call_deferred(
			"call_group",
			"PLAYER_LISTENER",
			"player_listener_on_ready",
			self)
	global_position = Vector2.ONE * 9999999999.0
