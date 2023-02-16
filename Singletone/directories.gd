class_name Directories

const SETTINGS_PATH      : String = "user://settings/"
const PROGRESS_PATH      : String = "user://progress/"
const LEVEL_SPRITES_PATH : String = "res://Ingame/level-sprites/"
const RECENT_PASSED_PATH : String = PROGRESS_PATH + "recent-passed"
const LEVEL_STARS_PATH   : String = PROGRESS_PATH + "/level-stars/"

const LEVELS_PATH : String = "res://Ingame/levels/"

static func create() -> void:
	DirAccess.make_dir_recursive_absolute(SETTINGS_PATH)
	DirAccess.make_dir_recursive_absolute(LEVEL_STARS_PATH)
