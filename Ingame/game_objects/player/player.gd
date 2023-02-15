extends CharacterBody2D

class_name Player

@export var drop_template : PackedScene

@onready var state_machine        : StateMachine = $state_machine
@onready var go_down_floor_sensor : RayCast2D = $go_down_floor_sensor
@onready var sprite               : Sprite2D = $sprite
@onready var jump_sfx             : AudioStreamPlayer = $jump_sfx
@onready var catch_water_sfx      : AudioStreamPlayer = $catch_water_sfx
@onready var damaged_sfx          : AudioStreamPlayer = $damaged_sfx

@onready var space_state = get_world_2d().get_direct_space_state()

@onready var sprite_material      : ShaderMaterial = sprite.material

var crouching := true

var damager    : CharacterBody2D = null
var enemy_died : CharacterBody2D = null

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var SPEED = 300.0
var ACCELERATION = 32.0
var DECELERATION = ACCELERATION * 4.0
var AIR_ACCELERATION = ACCELERATION * .75
var AIR_DECELERATION = AIR_ACCELERATION * .5
var JUMP_IMPULSE = -gravity * .25
var DOUBLEJUMP_IMPULSE = JUMP_IMPULSE
var DAMAGE_IMPULSE = -gravity * .25
var DAMAGE_DECELERATION = 20.0
var DROP_CUBE_IMPULSE = 1.9
var DROP_CUBE_IMPULSE_HORIZONTAL_IMPULSE = 210.0

var MAX_UP_SPEED = -10000.0
var MAX_DOWN_SPEED = 700.0

func can_hit_enemy() -> bool:
	if enemy_died: return false
	if damager: return false
	if is_on_floor(): return false
	return velocity.y > .0

func fall(delta : float) -> void:
	velocity.y = clamp(velocity.y + gravity * delta, MAX_UP_SPEED, MAX_DOWN_SPEED)

func _physics_process(delta : float) -> void:
	state_machine.step(delta)

func _ready() -> void:
	get_tree().call_deferred(
			"call_group",
			"PLAYER_LISTENER",
			"player_listener_on_ready",
			self)
