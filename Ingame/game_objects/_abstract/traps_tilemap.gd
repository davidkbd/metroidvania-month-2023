extends TileMap
class_name TrapsTileMap

const CELL_ROLLING_SPIKES : int = 0
const CELL_VANISH_NORMAL  : int = 3
const CELL_VANISH_ANIM    : int = 4
const CELL_VANISH_HIDDEN  : int = 5

func interact(coords : Vector2i) -> void:
	for layer in get_layers_count():
		var data : TileData = get_cell_tile_data(layer, coords)
		match data.get_custom_data("type"):
			0: _vanish_tile(coords)

func _vanish_tile(coords : Vector2i) -> void:
	print("VANISH -> anim")
	set_cell(CELL_VANISH_ANIM, coords)
	await create_tween().tween_interval(1.0).finished
	print("VANISH -> hidden")
	set_cell(CELL_VANISH_HIDDEN, coords)
	await create_tween().tween_interval(5.0).finished
	print("VANISH -> normal")
	set_cell(CELL_VANISH_NORMAL, coords)
