extends Node2D

@export var offset : Vector2 = Vector2.ZERO

const PATH = Directories.MAP_PNG_PATH + "map-%s.png"

var map_state : Dictionary


func initialize_map_state(_map_state : Dictionary) -> void:
	map_state = _map_state

func open() -> void:
	var room : Dictionary
	for key in map_state:
		room = map_state[key]
		if not room.has("res"): room["res"] = load(PATH % key)
			

func _draw():
	var room : Dictionary
	var path : String
	var res  : CompressedTexture2D
	var pos  : Vector2
	for key in map_state:
		room = map_state[key]
		if room.visible:
			pos = Vector2(room.position_x, room.position_y)
			draw_texture(load(PATH % key), floor(pos * .08) + offset)
#	while i < map_pos.size():
#		draw_texture(map_image[i], map_pos[i])
##		draw_texture(map_image[i], map_pos[i]  + Vector2.ONE)
#		i += 1
