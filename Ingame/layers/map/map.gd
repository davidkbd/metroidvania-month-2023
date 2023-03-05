extends Node2D

@export var offset : Vector2 = Vector2.ZERO

@onready var MAP_IMAGES : Dictionary = _preload_pngs()

const PATH = "map-%s%s.png"

var map_state : Dictionary


func initialize_map_state(_map_state : Dictionary) -> void:
	map_state = _map_state

func _draw():
	var room : Dictionary
	var path : String
	var res  : CompressedTexture2D
	var pos  : Vector2
	for key in map_state:
		room = map_state[key]
		if room.visible:
			pos = Vector2(room.position_x, room.position_y)
			var secrets = "" if room.variation == 0 else "-SECRETS"
			draw_texture(MAP_IMAGES[PATH % [key,secrets]], floor(pos * .08) + offset)

func _preload_pngs() -> Dictionary:
	var r : Dictionary = {}
	var dir = DirAccess.open(Directories.MAP_PNG_PATH)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.begins_with("map-room") and file_name.ends_with(".png"):
				r[file_name] = load(Directories.MAP_PNG_PATH + file_name)
			file_name = dir.get_next()
	return r
