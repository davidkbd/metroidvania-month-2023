extends Node2D

@export var item_template : PackedScene

var instance : SkillItem

func activate(_data : Dictionary) -> void:
	instance = item_template.instantiate()
	call_deferred("add_child", instance)
	if ProgressManager.game_state.bundle.skill_snap_wall.catched:
		instance.call_deferred("disable")

func deactivate() -> void:
	if is_instance_valid(instance):
		if instance.catched:
			ProgressManager.game_state.bundle.skill_snap_wall.catched = true
		instance.queue_free()

func _enter_tree() -> void:
	find_child("sprite").queue_free()
