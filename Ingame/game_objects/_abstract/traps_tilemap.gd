extends StaticBody2D
class_name TrapFloor

enum Type {
	VANISH
}

@export var type : Type = Type.VANISH

@export var vanish_delay             : float = 1.0
@export var vanish_anim_to_hide_time : float = .5
@export var vanish_anim_to_show_time : float = .5
@export var vanish_hidden_time       : float = 5.0

@onready var working : bool = false

func interact(rid : RID) -> void:
	if working: return
	match type:
		Type.VANISH: _vanish()

func _vanish() -> void:
	working = true
	await create_tween().tween_interval(vanish_delay).finished

	modulate = Color.RED
	await create_tween().tween_interval(vanish_anim_to_hide_time).finished

	set_collision_layer_value(1, false)
	hide()
	await create_tween().tween_interval(vanish_hidden_time).finished

	modulate = Color.GREEN
	show()
	await create_tween().tween_interval(vanish_anim_to_show_time).finished

	modulate = Color.WHITE
	set_collision_layer_value(1, true)
	working = false


#extends TileMap
#class_name TrapsTileMap
#
#const CELL_ROLLING_SPIKES       : Vector2i = Vector2i(0,0)
#const CELL_VANISH_NORMAL        : Vector2i = Vector2i(0,3)
#const CELL_VANISH_ANIM_TO_HIDE  : Vector2i = Vector2i(0,4)
#const CELL_VANISH_ANIM_TO_SHOW  : Vector2i = Vector2i(0,5)
#const CELL_VANISH_HIDDEN        : Vector2i = Vector2i(1,3)
#
#const LAYER : int = 0
#
#@export var vanish_delay             : float = 1.0
#@export var vanish_anim_to_hide_time : float = .5
#@export var vanish_anim_to_show_time : float = .5
#@export var vanish_hidden_time       : float = 5.0
#
#@onready var working_tiles : Array[int] = []
#
#func interact(rid : RID) -> void:
#	if _is_tile_locked(rid): return
#	_lock_tile(rid)
#
##	print(get_coords_for_body_rid(rid))
##	print(get_coords_for_body_rid(rid))
##	print(get_coords_for_body_rid(rid))
##	print(get_coords_for_body_rid(rid))
##	print(get_coords_for_body_rid(rid))
#	print(get_coords_for_body_rid(rid))
#
#	# devuelve 0,0 cuando se hace set_cell
#	var coords : Vector2i = get_coords_for_body_rid(rid)
#	var data : TileData = get_cell_tile_data(LAYER, coords)
#	if data == null: return
#
##	print(rid.get_id(), "   ", data.get_custom_data("type"))
#	match data.get_custom_data("type"):
#		1: _vanish_tile(coords, data, rid)
#		0: _unlock_tile(rid)
#
#func _vanish_tile(coords : Vector2i, data : TileData, rid : RID) -> void:
#	var tile_source_id : int = get_cell_source_id(LAYER, coords)
#	print("Source id ", coords, "  ", tile_source_id)
#	await create_tween().tween_interval(vanish_delay).finished
#
#	set_cell(LAYER, coords, tile_source_id, CELL_VANISH_ANIM_TO_HIDE)
#	await create_tween().tween_interval(vanish_anim_to_hide_time).finished
#
#	set_cell(LAYER, coords, tile_source_id, CELL_VANISH_HIDDEN)
#	await create_tween().tween_interval(vanish_hidden_time).finished
#
#	set_cell(LAYER, coords, tile_source_id, CELL_VANISH_ANIM_TO_SHOW)
#	await create_tween().tween_interval(vanish_anim_to_show_time).finished
#
#	set_cell(LAYER, coords, tile_source_id, CELL_VANISH_NORMAL)
#	_unlock_tile(rid)
#
#func _is_tile_locked(rid : RID) -> bool:
#	return working_tiles.find(rid.get_id()) > -1
#
#func _lock_tile(rid : RID) -> void:
#	working_tiles.append(rid.get_id())
#
#func _unlock_tile(rid : RID) -> void:
#	working_tiles.erase(rid.get_id())
