extends Node2D

@export var offset : Vector2 = Vector2.ZERO

const PATH = Directories.MAP_PNG_PATH + "map-%s.png"

var rooms_state : Dictionary
var map_image : Array[Texture]
var map_pos   : Array[Vector2]

func initialize_rooms_state(_rooms_state : Dictionary) -> void:
	rooms_state = _rooms_state

	var level = get_tree().get_first_node_in_group("LEVEL")

	map_image.clear()
	map_pos.clear()
	var room : Room
	for key in rooms_state:
		room = level.find_child(key)
		map_image.append(load(PATH % key))
		map_pos.append(room.global_position * .08 + offset)
	queue_redraw()

func _draw():
	var i : int = 0
	while i < map_pos.size():
		draw_texture(map_image[i], map_pos[i])
#		draw_texture(map_image[i], map_pos[i]  + Vector2.ONE)
		i += 1
