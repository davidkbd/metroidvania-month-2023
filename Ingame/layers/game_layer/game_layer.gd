extends CanvasLayer

@onready var game_container = $game_container

var level_instance   : Node2D

const LEVEL_FILE_PATH = Directories.LEVELS_PATH + "%s.tscn"

func hud_listener_on_level_finished() -> void:
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED

func instance_level(_game_state : Dictionary) -> void:
	print(LEVEL_FILE_PATH % _game_state.level.level)
	level_instance = load(LEVEL_FILE_PATH % _game_state.level.level).instantiate()
	game_container.add_child(level_instance)
	level_instance.initialize(_game_state)
	game_container.initialize(_game_state)

func reset_level(_game_state : Dictionary) -> void:
	level_instance.initialize(_game_state)
	game_container.initialize(_game_state)
