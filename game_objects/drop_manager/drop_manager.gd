extends Node

class_name drop_manager

@export var button_nodepath : NodePath
@export var min_seconds : float = 3.0
@export var max_seconds : float = 6.0
@export var spawners_array : Array[NodePath]

@onready var timer : Timer = $Timer
	
func event_trigger_listener_on_button_enabled(emitter : Node2D, _trigger_id : String) -> void:
	if emitter == get_node(button_nodepath):
		_on_timer_timeout()
#		remove_from_group("EVENT_TRIGGER_LISTENER")

func event_trigger_listener_on_button_disabled(emitter : Node2D, _trigger_id : String) -> void:
	if emitter == get_node(button_nodepath):
		timer.stop()
#		add_to_group("EVENT_TRIGGER_LISTENER")

func _on_timer_timeout():
	_spawn()
	timer.start(randf_range(min_seconds, max_seconds))

func _get_random_spawner() -> DropSpawner:
	var selected : DropSpawner
	var array : Array = []
	while true:
		selected = get_node(spawners_array[randi_range(0,spawners_array.size() - 1)])
		if (selected.busy == false):
			return selected
		if (array.find(selected) == -1):
			array.append(selected)
		if (array.size() == spawners_array.size()):
			return null
	return null

func _spawn():
	var spawner = _get_random_spawner()
	if spawner:
		spawner.spawn()
