extends Area2D

class_name DestroyableObject

@export var life              : int = 5

@onready var particles : CPUParticles2D = get_node("particles")
@onready var target    : Node2D         = get_node("target")

@onready var current_life : int = life

var hit_tween : Tween

func destroy(_destroyer : CharacterBody2D) -> void:
	if is_instance_valid(target) and current_life > 0:
		current_life -= 1
		var direction = sign(_destroyer.position.x - position.x)
		_hit(direction)
		if current_life <= 0:
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
	target.queue_free()
	get_tree().call_group(
			"DESTROYABLE_LISTENER",
			"destroyable_listener_on_destroyed",
			Vector2(direction, .0))
