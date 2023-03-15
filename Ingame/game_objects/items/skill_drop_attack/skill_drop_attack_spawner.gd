extends Node2D

@export var item_template : PackedScene

var instance : SkillItem

var player_is_died : bool

func player_listener_on_died() -> void:
	player_is_died = true

func activate(_data : Dictionary) -> void:
	player_is_died = false
	instance = item_template.instantiate()
	call_deferred("add_child", instance)
	if ProgressManager.game_state.bundle.skill_drop_attack.catched:
		instance.call_deferred("disable")

func deactivate() -> void:
	if is_instance_valid(instance):
		if instance.catched and not player_is_died:
			ProgressManager.game_state.bundle.skill_drop_attack.catched = true
		instance.queue_free()

func _enter_tree() -> void:
	find_child("sprite").queue_free()
