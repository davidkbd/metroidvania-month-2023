extends Node

@onready var PROGRESS_FILE = Directories.PROGRESS_PATH + "game-state-%s.data"

var game_state : Dictionary = {
	"level": {
		"level": "level_001",
		"room_spawn": "room_001"
	},
	"player": {
	},
	"map": {
	},
	"rooms": {}
}

var current_slot_id : String

func progress_listener_on_room_updated(_room_id : String, _data : Dictionary) -> void:
	game_state.rooms[_room_id] = _data

func progress_listener_on_progress_store_requested(from_room_id : String) -> void:
	game_state.level.room_spawn = from_room_id
	var storeable_game_state = _create_storeable_game_state()
	_update_map(storeable_game_state)
	var file = FileAccess.open(PROGRESS_FILE % current_slot_id, FileAccess.WRITE)
	file.store_var(storeable_game_state)
	game_state.map = storeable_game_state.map
	get_tree().call_group("PROGRESS_LISTENER", "progress_listener_on_progress_stored", game_state)

func room_listener_on_activated(room : Room) -> void:
	if game_state.map.has(room.name): return
	game_state.map[room.name] = {
			"visible": false,
			"position_x": room.global_position.x,
			"position_y": room.global_position.y,
			"variation": 0
		}

func menu_listener_on_game_start_requested(_slot_id : String) -> void:
	current_slot_id = _slot_id
	var file = FileAccess.open(PROGRESS_FILE % current_slot_id, FileAccess.READ)
	if file: game_state = file.get_var()
#	await get_tree().process_frame
	get_tree().call_group("PROGRESS_LISTENER", "progress_listener_on_game_state_loaded", game_state)

func player_listener_on_died() -> void:
	var file = FileAccess.open(PROGRESS_FILE % current_slot_id, FileAccess.READ)
	if file: game_state = file.get_var()
	get_tree().call_group("PROGRESS_LISTENER", "progress_listener_on_player_died_game_state_loaded", game_state)

func player_listener_on_life_updated(_life : Dictionary) -> void:
	game_state.player.life = _life

func player_listener_on_skills_updated(_skills : Dictionary) -> void:
	game_state.player.skills = _skills

func _create_storeable_game_state() -> Dictionary:
	var r : Dictionary = game_state.duplicate(true)
	for room_key in r.rooms.keys():
		var room_state : Dictionary = r.rooms[room_key].state
		for object_key in room_state.keys():
			if not r.rooms[room_key].state[object_key].storeable:
				r.rooms[room_key].state[object_key]={ "storeable": false }
	return r

func _update_map(storeable_game_state : Dictionary) -> void:
	var room : Dictionary
	for key in storeable_game_state.map:
		room = storeable_game_state.map[key]
		room.visible = true
		if room.has("res"):
			room.erase("res")
			

func _ready():
	add_to_group("PLAYER_LISTENER")
	add_to_group("ROOM_LISTENER")
	add_to_group("MENU_LISTENER")
	add_to_group("PROGRESS_LISTENER")
	Directories.create()
	
