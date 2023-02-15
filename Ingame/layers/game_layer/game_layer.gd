extends CanvasLayer

@onready var game_container = $game_container

var level_instance   : Node2D

const LEVEL_FILE_PATH = Directories.LEVELS_PATH + "%s.tscn"

func hud_listener_on_level_finished() -> void:
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED

func instance_level(_level_id : String) -> void:
	print(LEVEL_FILE_PATH % _level_id)
	level_instance = load(LEVEL_FILE_PATH % _level_id).instantiate()
	game_container.add_child(level_instance)
