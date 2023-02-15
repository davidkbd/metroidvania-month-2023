extends Node2D
class_name Room

var room_data : Dictionary

func activate() -> void:
	print("ROOM ACTIVATED ", get_path())

#
# Envia los datos de la sala al manager, para ser almacenado temporalmente
#
func apply_data() -> void:
	get_tree().call_group("PROGRESS_LISTENER", "progress_listener_room_player_exited", name, room_data)

func teleport_player() -> void:
	var player : Player             = get_tree().get_first_node_in_group("PLAYER")
	var camera : FollowTargetCamera = get_tree().get_first_node_in_group("CAMERA")
	var savepoint = find_child("savepoint", true, false)
	if savepoint == null:
		print("ERROR: this room (%s) has not a savepoint node" % name.to_lower())
		return
	player.global_position = savepoint.global_position
	camera.teleport()
