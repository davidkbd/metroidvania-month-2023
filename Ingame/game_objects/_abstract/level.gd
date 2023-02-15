extends Node2D
class_name Level

@export_group("Visualization")
@export_dir var skin_textures_directory : String = Directories.LEVELS_PATH + "/sprites/"

#
# Restaura partida, activa la room y teleporta el player al savepoint
#
func progress_listener_on_level_opened(_level_data : Dictionary) -> void:
	var room = get_node(_level_data.level.room_spawn)
	room.activate()
	room.teleport_player()

	await get_tree().physics_frame
	room.apply_data()

func _ready() -> void:
	add_to_group("PROGRESS_LISTENER")
	add_to_group("LEVEL")
	get_tree().call_group("LEVEL_LISTENER", "level_listener_on_ready", {
			"level": { "name": name.to_lower() },
			"skin": {
					"textures_directory": skin_textures_directory
				}
		})
