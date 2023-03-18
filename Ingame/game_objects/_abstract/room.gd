extends Node2D
class_name Room

@export_group("Music")
@export var ost_item        : MusicManager.OstItem = MusicManager.OstItem.SILENT
@export var battle_ost_item : MusicManager.OstItem = MusicManager.OstItem.SILENT

@export_group("Environment")
@export var parallax_name   : String

@onready var player       : Player             = get_tree().get_first_node_in_group("PLAYER")
@onready var camera       : FollowTargetCamera = get_tree().get_first_node_in_group("CAMERA")
@onready var room_area    : RoomArea           = _find_room_area()
@onready var room_content : RoomContent        = _find_room_content()

var room_area_template : PackedScene = preload("res://Ingame/game_objects/room/room_area/room_area.tscn")

var room_data : Dictionary

func is_any_enemy_alive() -> bool:
	return room_content.is_any_enemy_alive()

func activate() -> void:
	room_content.activate(room_data)
	get_tree().call_group("ROOM_LISTENER", "room_listener_on_activated", self)

func deactivate() -> void:
	room_content.deactivate()
	get_tree().call_group("ROOM_LISTENER", "room_listener_on_deactivated", self)

func initialize(_game_state : Dictionary) -> void:
	var room_name = name.to_lower()
	room_data = _game_state.rooms[room_name] if _game_state.rooms.has(room_name) else {}
	if not room_data.has("state"):
		room_data["state"] = {}

func update_room_data() -> void:
	room_data.state = room_content.get_state()
	get_tree().call_group("PROGRESS_LISTENER", "progress_listener_on_room_updated", name, room_data)

func teleport_player() -> void:
	var savepoint : Node2D = _find_savepoint()
	if savepoint == null: return
	
	player.reset_to_savepoint(savepoint)
	room_area.configure_hook()
	room_area.hook.enable(player)
	camera.set_target(room_area.hook)
	camera.teleport()

func _find_room_area() -> RoomArea:
	var r = find_child("room_area", true, false)
	if r == null:
		print("ERROR: this room (%s) has not a room_area node" % name.to_lower())
		get_tree().quit(1)
	return r

func _find_room_content() -> RoomContent:
	var r = find_child("room_content", true, false)
	if r == null:
		print("ERROR: this room (%s) has not a room_content node" % name.to_lower())
		get_tree().quit(2)
	return r

func _find_savepoint() -> Node2D:
	var r = find_child("savepoint", true, false)
	if r == null:
		print("ERROR: this room (%s) has not a savepoint node" % name.to_lower())
		return null
	return r

func _create_room_area() -> void:
	var tilemap : TileMap = find_child("CollisionTileMap")
	var tile_size : Vector2i = tilemap.tile_set.tile_size
	var min_size : Vector2i
	var max_size : Vector2i
	for layer in tilemap.get_layers_count():
		for cell in tilemap.get_used_cells(layer):
			if cell.x < min_size.x: min_size.x = cell.x
			elif cell.x > max_size.x: max_size.x = cell.x
			if cell.y < min_size.y: min_size.y = cell.y
			elif cell.y > max_size.y: max_size.y = cell.y
	min_size *= tile_size
	max_size *= tile_size
	var col : CollisionShape2D = CollisionShape2D.new()
	col.name = "collider"
	col.shape = RectangleShape2D.new()
	col.shape.size = Vector2(
			(max_size.x - min_size.x) + tile_size.x + 32.0,
			(max_size.y - min_size.y) + tile_size.y + 32.0)
	col.position = tilemap.position + Vector2(
			min_size.x + max_size.x + tile_size.x,
			min_size.y + max_size.y + tile_size.y) * .5
	var room_area : Area2D = room_area_template.instantiate()
	room_area.collision_layer = 4
	room_area.collision_mask = 0
	room_area.add_child(col)
	add_child(room_area)

func _enter_tree():
	_create_room_area()
