extends Area2D

class_name DestroyableObject

signal destroyed

@export_group("Progress")
@export var storeable         : bool = true
@export var is_map_secret     : bool = false

@export_group("Gameplay")
@export var life              : int = 3

@onready var particles : CPUParticles2D = get_node("particles")
@onready var target    : Node2D  = get_node("target")

var default_collision_mask : int
var default_collision_layer : int
var target_default_collision_mask  : int
var target_default_collision_layer : int

var instance_data : Dictionary = {
	"storeable": storeable,
	"life": life
}

var hit_tween : Tween

func activate(_data : Dictionary) -> void:
	if _data.has("life"):
		instance_data.life = _data.life
	if instance_data.life <= 0:
		target.hide()
		if target is PhysicsBody2D or Area2D:
			target.collision_mask = 0
			target.collision_layer = 0
		collision_mask = 0
		collision_layer = 0
	else:
		target.show()
		if target is PhysicsBody2D or Area2D:
			target.collision_mask = target_default_collision_mask
			target.collision_layer = target_default_collision_layer
		collision_mask = default_collision_mask
		collision_layer = default_collision_layer
	particles.hide()

func deactivate() -> void:
	if not instance_data.storeable:
		instance_data.life = life

func get_state() -> Dictionary:
	return instance_data

func destroy(_destroyer : CharacterBody2D) -> void:
	if is_instance_valid(target) and instance_data.life > 0:
		particles.show()
		instance_data.life -= 1
		var direction = sign(_destroyer.position.x - global_position.x)
		_hit(direction)
		if instance_data.life <= 0:
			_destruction(direction)
			if is_map_secret:
				get_tree().call_group("ROOM_LISTENER", "room_listener_on_secret_revelated", get_parent().get_parent())

func _hit(direction : float) -> void:
	if hit_tween: hit_tween.kill()
	hit_tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	var pos = target.position.x
	target.position.x += direction * 4.0
	hit_tween.tween_property(target, "position:x", pos, .5)

func _destruction(direction : float) -> void:
	particles.direction.x = particles.direction.x * direction
	particles.restart()
	particles.emitting = true
	target.hide()
	if target is PhysicsBody2D or target is Area2D:
		target.collision_mask = 0
		target.collision_layer = 0
	collision_mask = 0
	collision_layer = 0
	emit_signal("destroyed")
	get_tree().call_group(
			"DESTROYABLE_LISTENER",
			"destroyable_listener_on_destroyed",
			Vector2(direction, .0))

func _ready() -> void:
	instance_data.storeable = storeable
	instance_data.life = life
	if target is PhysicsBody2D or target is Area2D:
		target_default_collision_mask = target.collision_mask
		target_default_collision_layer = target.collision_layer
	default_collision_mask = collision_mask
	default_collision_layer = collision_layer
