extends Area2D

class_name DestroyableObject

@export var life              : int = 5

@onready var particles : CPUParticles2D = get_node("particles")
@onready var target    : PhysicsBody2D  = get_node("target")

@onready var target_default_collision_mask : int = target.collision_mask
@onready var target_default_collision_layer : int = target.collision_layer

var instance_data : Dictionary = {
	"storeable": true,
	"life": life
}

var hit_tween : Tween

func activate(_data : Dictionary) -> void:
	if _data.has("life"):
		instance_data.life = _data.life
	if instance_data.life <= 0:
		target.hide()
		target.collision_mask = 0
		target.collision_layer = 0
	else:
		target.show()
		target.collision_mask = target_default_collision_mask
		target.collision_layer = target_default_collision_layer

func deactivate() -> void:
	if not instance_data.storeable:
		instance_data.life = life

func get_state() -> Dictionary:
	return instance_data

func destroy(_destroyer : CharacterBody2D) -> void:
	if is_instance_valid(target) and instance_data.life > 0:
		instance_data.life -= 1
		var direction = sign(_destroyer.position.x - position.x)
		_hit(direction)
		if instance_data.life <= 0:
			_destruction(direction)

func _hit(direction : float) -> void:
	if hit_tween: hit_tween.kill()
	hit_tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	var pos = target.position.x
	target.position.x += direction * 4.0
	hit_tween.tween_property(target, "position:x", pos, .5)

func _destruction(direction : float) -> void:
	particles.direction.x = particles.direction.x
	particles.emitting = true
	target.hide()
	target.collision_mask = 0
	target.collision_layer = 0
	get_tree().call_group(
			"DESTROYABLE_LISTENER",
			"destroyable_listener_on_destroyed",
			Vector2(direction, .0))
