extends Node2D
class_name Level

@export_group("Visualization")
@export_dir var skin_textures_directory : String = Directories.LEVELS_PATH + "/sprites/"

#
# Restaura partida, activa la room y teleporta el player al savepoint
#
func initialize(_game_state : Dictionary) -> void:
	var room : Room = get_node(_game_state.level.room_spawn)
#	room.activate()

	for r in get_children():
		if r is Room:
			r.initialize(_game_state)

	await get_tree().physics_frame
	room.teleport_player()

func _ready() -> void:
#	add_to_group("PROGRESS_LISTENER")
#	add_to_group("LEVEL")
	get_tree().call_group("LEVEL_LISTENER", "level_listener_on_ready", {
			"level": { "name": name.to_lower() },
			"skin": {
					"textures_directory": skin_textures_directory
				}
		})
