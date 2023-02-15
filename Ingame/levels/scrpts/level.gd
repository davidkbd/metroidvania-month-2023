extends Node2D

class_name Level
@tool

@export_group("Visualization")
@export_dir var skin_textures_directory : String = Directories.LEVELS_PATH + "/sprites/"

@export_group("Objectives")
@export var stars_drops_first     : int = 2
@export var stars_drops_second    : int = 4
@export var stars_drops_third     : int = 5

@export_group("Plant")
@export var plant_health_increment : float = .20
@export var plant_grow_step_size   : int = 64

func _send_level_data() -> void:
	get_tree().call_group("LEVEL_LISTENER", "level_listener_on_ready", {
		"skin": {
			"textures_directory": skin_textures_directory
		},
		"objectives": [ stars_drops_first, stars_drops_second, stars_drops_third ],
		"plant": {
			"health_increment": plant_health_increment,
			"grow_step_size": plant_grow_step_size,
			"max_drop_count": stars_drops_third
		}
	})

func _ready() -> void:
	call_deferred("_send_level_data")
	add_to_group("LEVEL")
