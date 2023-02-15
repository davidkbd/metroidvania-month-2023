extends CharacterBody2D

class_name Player

@export var drop_template : PackedScene

@onready var state_machine        : StateMachine = $state_machine
@onready var drop_target          : Area2D = $drop_target
@onready var drop_spawner_sensor  : Area2D = $drop_spawner_sensor
@onready var go_down_floor_sensor : RayCast2D = $go_down_floor_sensor
@onready var sprite               : Sprite2D = $sprite
@onready var jump_sfx             : AudioStreamPlayer = $jump_sfx
@onready var catch_water_sfx      : AudioStreamPlayer = $catch_water_sfx
@onready var damaged_sfx          : AudioStreamPlayer = $damaged_sfx

@onready var sprite_material      : ShaderMaterial = sprite.material

@onready var cube_can_fill : bool = true
@onready var cube_is_full  : bool = false

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

func catch_drop() -> bool:
	if cube_can_fill and not cube_is_full:
		catch_water_sfx.play()
		cube_is_full = true
		sprite_material.set_shader_parameter("visible", true)
		drop_target.set_collision_mask_value(9, false)
		return true
	return false

func drop_cube(with_inertia : bool = true) -> void:
	if not cube_is_full: return
	cube_is_full = false
	sprite_material.set_shader_parameter("visible", false)
	drop_target.set_collision_mask_value(9, true)
	var drop : Drop = drop_template.instantiate()
	drop.set_collision_layer_value(9, false)
	drop.set_collision_mask_value(9, false)
	get_parent().call_deferred("add_child", drop)
	drop.global_position = global_position
	if with_inertia:
		var impulse = velocity * DROP_CUBE_IMPULSE
		impulse.x += DROP_CUBE_IMPULSE_HORIZONTAL_IMPULSE * (1 if sprite.flip_h else -1)
		drop.apply_central_impulse(impulse)

func is_drop_over_player() -> bool:
	return not cube_is_full and drop_spawner_sensor.is_spawner_detected()

func damage(beetle : Beetle) -> void:
	damager = beetle

func can_hit_enemy() -> bool:
	if enemy_died: return false
	if damager: return false
	if is_on_floor(): return false
	return velocity.y > .0

func fall(delta : float) -> void:
	velocity.y = clamp(velocity.y + gravity * delta, MAX_UP_SPEED, MAX_DOWN_SPEED)

func _edge_teleport() -> void:
	if global_position.x < -330 and velocity.x < .0 \
	or global_position.x > 330 and velocity.x > .0:
		global_position.x *= -1

func _physics_process(delta : float) -> void:
	_edge_teleport()
	state_machine.step(delta)

func _ready() -> void:
	get_tree().call_deferred(
			"call_group",
			"PLAYER_LISTENER",
			"player_listener_on_ready",
			self)
