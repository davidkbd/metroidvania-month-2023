extends Node2D
class_name RoomContent

func activate(_data : Dictionary) -> void:
	process_mode = Node.PROCESS_MODE_INHERIT
	for spawner in find_children("*_spawner*"):
		spawner.activate(_data)

func deactivate() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED
	for spawner in find_children("*_spawner*"):
		spawner.deactivate()

func get_state() -> Array[Dictionary]:
	var r : Array[Dictionary] = []
	for spawner in find_children("*_spawner*"):
		r.append(spawner.instance_data)
	return r

func _enter_tree() -> void:
	deactivate()

