extends Node2D

@export var rat_health_template : PackedScene

@onready var destroyable : DestroyableObject = $base_rat_home_destroyable_object

var rat_instance : RatHealth

func _on_base_rat_home_destroyable_object_destroyed():
	rat_instance = rat_health_template.instantiate()
	call_deferred("add_child", rat_instance)

func activate(_data : Dictionary) -> void:
	destroyable.activate({
		"storeable": false,
		"life": 1
	})

func deactivate() -> void:
	if is_instance_valid(rat_instance):
		rat_instance.queue_free()
	if is_instance_valid(destroyable):
		destroyable.deactivate()
