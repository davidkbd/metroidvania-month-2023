extends Area2D

class_name DropInitial

signal converted

@export var drop_template : PackedScene
@export var min_seconds := 2.0
@export var max_seconds := 4.0

@onready var sprite : Sprite2D = $sprite

@onready var seconds := randf_range(min_seconds, max_seconds)

var tween : Tween

func _exit_tree():
	tween.kill()

func _on_tween_finished() -> void:
	var drop : Drop = drop_template.instantiate()
	emit_signal("converted", drop)
	queue_free()

func _ready() -> void:
	sprite.frame = 0
	tween = get_tree().create_tween()
	tween.tween_property(sprite, "frame", sprite.hframes - 1, seconds) \
			.set_ease(Tween.EASE_IN_OUT) \
			.set_trans(Tween.TRANS_LINEAR)
	tween.connect("finished", _on_tween_finished)
