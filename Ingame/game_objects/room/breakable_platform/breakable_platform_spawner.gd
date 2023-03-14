extends Node2D

class_name BreakablePlatformSpawner

@export var breakable_platform_template : PackedScene

var instance : BreakablePlatform

func activate(_data : Dictionary) -> void:
	instance = breakable_platform_template.instantiate()
	add_child(instance)

func deactivate() -> void:
	if is_instance_valid(instance):
		instance.queue_free()

func _enter_tree() -> void:
	find_child("sprite").queue_free()

