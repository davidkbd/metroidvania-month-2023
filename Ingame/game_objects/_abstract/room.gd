extends Node2D
class_name Room

var room_data : Dictionary

func activate() -> void:
	print("ROOM ACTIVATED ", get_path())

func apply_data() -> void:
	get_tree().call_group("PROGRESS_LISTENER", "progress_listener_room_player_exited", name, room_data)

func teleport_player() -> void:
	var savepoint : Node2D = _find_savepoint()
	if savepoint == null: return
	var room_area : RoomArea = _find_room_area()
	if room_area == null: return
	
	var player : Player             = get_tree().get_first_node_in_group("PLAYER")
	player.teleport(savepoint.global_position)

	var camera : FollowTargetCamera = get_tree().get_first_node_in_group("CAMERA")
	room_area.hook.enable(player)
	camera.set_target(room_area.hook)
	camera.teleport()

func _find_room_area() -> RoomArea:
	var r = find_child("room_area", true, false)
	if r == null:
		print("ERROR: this room (%s) has not a room_area node" % name.to_lower())
		return null
	return r

func _find_savepoint() -> Node2D:
	var r = find_child("savepoint", true, false)
	if r == null:
		print("ERROR: this room (%s) has not a savepoint node" % name.to_lower())
		return null
	return r
