extends Node2D

@export var item_template : PackedScene

var instance : SkillItem

func activate(_data : Dictionary) -> void:
	if not ProgressManager.game_state.bundle.skill_drop_attack.catched:
		instance = item_template.instantiate()
		call_deferred("add_child", instance)

func deactivate() -> void:
	if is_instance_valid(instance):
		if instance.catched:
			ProgressManager.game_state.bundle.skill_drop_attack.catched = true
		instance.queue_free()
