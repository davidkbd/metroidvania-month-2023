extends Node2D
class_name RoomContent

func activate(_room_data : Dictionary) -> void:
	process_mode = Node.PROCESS_MODE_INHERIT
	for spawner in find_children("*_spawner*"):
		if _room_data.state.has(spawner.name.to_lower()):
			spawner.activate(_room_data.state[spawner.name.to_lower()])
		else:
			spawner.activate({})

func deactivate() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED
	for spawner in find_children("*_spawner*"):
		spawner.deactivate()

func get_state() -> Dictionary:
	var r : Dictionary = {}
	for spawner in find_children("*_spawner*"):
		r[spawner.name.to_lower()] = spawner.instance_data
	return r

func _enter_tree() -> void:
	deactivate()

