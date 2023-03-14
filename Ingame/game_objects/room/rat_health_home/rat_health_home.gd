extends Node2D

@export var rat_health_template : PackedScene

@onready var destroyable         : DestroyableObject = $base_rat_home_destroyable_object
@onready var rat_output_position : Marker2D          = $rat_output_position
var rat_instance : RatHealthItem

func _on_base_rat_home_destroyable_object_destroyed():
	rat_instance = rat_health_template.instantiate()
	call_deferred("_add_rat")

func _add_rat() -> void:
	add_child(rat_instance)
	rat_instance.global_position = rat_output_position.global_position

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
