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
	var savepoint = find_child("savepoint", true, false)
	if savepoint == null:
		print("ERROR: this room (%s) has not a savepoint node" % name.to_lower())
		return
	savepoint.teleport_player()
	savepoint.teleport_camera()
