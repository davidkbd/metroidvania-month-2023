class_name Directories

const SETTINGS_PATH      : String = "user://settings/"
const PROGRESS_PATH      : String = "user://progress/"
const LEVEL_SPRITES_PATH : String = "res://Ingame/level-sprites/"

const LEVELS_PATH : String = "res://Ingame/levels/"

static func create() -> void:
	DirAccess.make_dir_recursive_absolute(SETTINGS_PATH)
	DirAccess.make_dir_recursive_absolute(PROGRESS_PATH)
