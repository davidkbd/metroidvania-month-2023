extends CharacterAlive

class_name Player

@export var drop_template : PackedScene

@onready var go_down_floor_sensor : RayCast2D = $go_down_floor_sensor
@onready var sprite               : Sprite2D = $sprite
@onready var jump_sfx             : AudioStreamPlayer = $jump_sfx
@onready var catch_water_sfx      : AudioStreamPlayer = $catch_water_sfx
@onready var damaged_sfx          : AudioStreamPlayer = $damaged_sfx

@onready var specs                : Dictionary = PlayerSpecs.get_default_specs()

@onready var space_state = get_world_2d().get_direct_space_state()


var crouching := true

var damager    : CharacterBody2D = null
var enemy_died : CharacterBody2D = null

func can_hit_enemy() -> bool:
	if enemy_died: return false
	if damager: return false
	if is_on_floor(): return false
	return velocity.y > .0

func fall(_delta : float) -> void:
	velocity.y = clamp(
			velocity.y + specs.gravity * _delta,
			specs.max_up_speed, specs.max_down_speed)

func _physics_process(delta : float) -> void:
	state_machine.step(delta)

func _ready() -> void:
	get_tree().call_deferred(
			"call_group",
			"PLAYER_LISTENER",
			"player_listener_on_ready",
			self)
