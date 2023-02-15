extends CharacterBody2D

class_name Beetle

@onready var state_machine        : StateMachine = $state_machine
@onready var sprite               : Sprite2D     = $sprite
@onready var delete_timer         : Timer        = $delete_timer
@onready var player_hit_target    : Area2D       = $player_hit_target
@onready var player_damage        : Area2D       = $player_damage

const SPEED = 60.0
const ACCELERATION = 120.0
const DECELERATION = 120.0
const AIR_DECELERATION = 10.0

var direction

@onready var eating_sfx : AudioStreamPlayer2D = $eating_sfx
@onready var die_sfx    : AudioStreamPlayer2D = $die_sfx

var is_marked_to_delete : float = false
var is_marked_to_die    : float = false
var plant               : Plant = null
var hitting_player      : Player = null

var MAX_UP_SPEED = -10000.0
var MAX_DOWN_SPEED = 700.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func mark_to_delete() -> void:
	is_marked_to_delete = true
	delete_timer.start()

func mark_to_die() -> void:
	is_marked_to_die = true
	player_hit_target.set_collision_layer_value(4, false)
	player_damage.set_collision_mask_value(4, false)

func fall(delta : float) -> void:
	velocity.y = clamp(velocity.y + gravity * delta, MAX_UP_SPEED, MAX_DOWN_SPEED)

func _edge_teleport() -> void:
	if is_marked_to_delete: return
	if global_position.x < -320 and velocity.x < .0 \
	or global_position.x > 320 and velocity.x > .0:
		global_position.x *= -1

func _physics_process(delta : float) -> void:
	_edge_teleport()
	state_machine.step(delta)

func _on_delete_timer_timeout():
	queue_free()
