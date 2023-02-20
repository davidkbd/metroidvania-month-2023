extends Node2D
class_name DropSpawner

@export var drop_initial_template : PackedScene

@onready var spawn_position : Node2D = $spawn_position

@onready var busy : bool = false

var drop_initial : DropInitial
var drop         : Drop

func spawn() -> void:
	busy = true
	call_deferred("_instance_drop")

func _instance_drop() -> void:
	drop_initial = drop_initial_template.instantiate()
	drop_initial.connect("converted", _on_drop_initial_converted)
	add_child(drop_initial)
	drop_initial.global_position = global_position

func _on_drop_initial_converted(new_drop) -> void:
	drop_initial = null
	drop = new_drop
	drop.connect("dropped", _on_drop_dropped)
	add_child(drop)
	drop.global_position = spawn_position.global_position

func _on_drop_dropped() -> void:
	drop = null
	busy = false
