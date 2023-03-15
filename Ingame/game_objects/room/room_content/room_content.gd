extends Node2D
class_name RoomContent

func activate(_room_data : Dictionary) -> void:
	process_mode = Node.PROCESS_MODE_INHERIT
	for child in get_children():
		if child.has_method("activate") and not child is SavepointArea:
			if _room_data.state.has(child.name.to_lower()):
				child.activate(_room_data.state[child.name.to_lower()])
			else:
				child.activate({})

func deactivate() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED
	for child in get_children():
		print(child.name)
		if child.has_method("deactivate") and not child is SavepointArea:
			child.deactivate()

func get_state() -> Dictionary:
	var r : Dictionary = {}
	for child in get_children():
		if child.has_method("get_state") and not child is SavepointArea:
			r[child.name.to_lower()] = child.get_state()
	return r

func is_any_enemy_alive() -> bool:
	for child in get_children():
		if child is EnemySpawner:
			if child.enemy_is_died == false:
				return true
	return false

func _on_enemy_died() -> void:
	if is_any_enemy_alive(): return
	get_tree().call_group("ROOM_LISTENER", "room_listener_on_cleared", get_parent())

func _ready() -> void:
	for child in get_children():
		if child is EnemySpawner:
			child.died.connect(_on_enemy_died)

func _enter_tree() -> void:
	deactivate()
