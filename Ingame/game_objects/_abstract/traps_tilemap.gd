extends TileMap
class_name TrapsTileMap

const CELL_ROLLING_SPIKES       : Vector2i = Vector2i(0,0)
const CELL_VANISH_NORMAL        : Vector2i = Vector2i(0,3)
const CELL_VANISH_ANIM_TO_HIDE  : Vector2i = Vector2i(0,4)
const CELL_VANISH_ANIM_TO_SHOW  : Vector2i = Vector2i(0,5)
const CELL_VANISH_HIDDEN        : Vector2i = Vector2i(1,3)

@export var vanish_delay             : float = 1.0
@export var vanish_anim_to_hide_time : float = .5
@export var vanish_anim_to_show_time : float = .5
@export var vanish_hidden_time       : float = 5.0

func interact(coords : Vector2i) -> void:
	for layer in get_layers_count():
		var data : TileData = get_cell_tile_data(layer, coords)
		if data != null: 
			if data.get_custom_data("working") == false:
				match data.get_custom_data("type"):
					1: 
						_vanish_tile(coords, data)

func _vanish_tile(coords : Vector2i, data : TileData) -> void:
	data.set_custom_data("working", true)
	await create_tween().tween_interval(vanish_delay).finished
	print("VANISH -> anim")
	set_cell(0, coords, get_cell_source_id(0, coords), CELL_VANISH_ANIM_TO_HIDE)
	await create_tween().tween_interval(vanish_anim_to_hide_time).finished
	print("VANISH -> hidden")
	set_cell(0, coords, get_cell_source_id(0, coords), CELL_VANISH_HIDDEN)
	await create_tween().tween_interval(vanish_hidden_time).finished
	print("VANISH -> to_show")
	set_cell(0, coords, get_cell_source_id(0, coords), CELL_VANISH_ANIM_TO_SHOW)
	await create_tween().tween_interval(vanish_anim_to_show_time).finished
	print("VANISH -> normal")
	set_cell(0, coords, get_cell_source_id(0, coords), CELL_VANISH_NORMAL)
	data.set_custom_data("working", false)
