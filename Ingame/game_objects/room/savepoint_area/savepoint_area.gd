extends Area2D
class_name SavepointArea

func activate() -> void:
	var room : Room = _get_room()
	if room == null:
		print("ERROR room no encontrada ???")
		return
	room.update_data()
	get_tree().call_group("PROGRESS_LISTENER", "progress_listener_on_progress_store_requested", room.name)

func _get_room() -> Room:
	var i : int = 0
	var r : Node2D = get_parent()
	while not r is Room:
		r = r.get_parent()
		i += 1
		if i > 20:
			return null
	return r
