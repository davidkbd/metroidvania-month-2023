extends CanvasLayer

@onready var game_container = $game_container

var level_instance  : Node2D

func hud_listener_on_level_finished() -> void:
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED

func load_level(level_name : String) -> void:
	level_instance  = load(Directories.LEVELS_PATH + level_name + "/level.tscn").instantiate()
	game_container.add_child(level_instance)
