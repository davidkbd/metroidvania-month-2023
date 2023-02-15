extends Node

@onready var PROGRESS_FILE = Directories.PROGRESS_PATH + "progress-%s.data"

var game_state : Dictionary = {
	"level": {
		"room_spawn": "room_001"
	},
	"rooms": {}
}

var current_level_id : String

func progress_listener_on_room_updated(_room_id : String, _data : Dictionary) -> void:
	game_state.rooms[_room_id] = _data

func progress_listener_on_progress_store_requested(from_room_id : String) -> void:
	game_state.level.room_spawn = from_room_id
	var file = FileAccess.open(PROGRESS_FILE % current_level_id, FileAccess.WRITE)
	file.store_var(game_state)
	get_tree().call_group("PROGRESS_LISTENER", "progress_listener_on_progress_stored")

func level_listener_on_ready(_level_data : Dictionary) -> void:
	current_level_id = _level_data.level.name
	var file = FileAccess.open(PROGRESS_FILE % current_level_id, FileAccess.READ)
	if file: game_state = file.get_var()
	await get_tree().process_frame
	get_tree().call_group("PROGRESS_LISTENER", "progress_listener_on_saved_game_state_loaded", game_state)
	print(game_state)

func _ready():
	add_to_group("LEVEL_LISTENER")
	add_to_group("PROGRESS_LISTENER")
	Directories.create()
