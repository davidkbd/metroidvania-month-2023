extends Node2D
class_name Room

@export var parallax_name : String

@onready var player       : Player             = get_tree().get_first_node_in_group("PLAYER")
@onready var camera       : FollowTargetCamera = get_tree().get_first_node_in_group("CAMERA")
@onready var room_area    : RoomArea           = _find_room_area()
@onready var room_content : RoomContent        = _find_room_content()

var room_data : Dictionary

func activate() -> void:
	room_content.activate(room_data)
	get_tree().call_group("ROOM_LISTENER", "room_listener_on_activated", self)

func deactivate() -> void:
	room_content.deactivate()

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
	
	player.global_position = savepoint.global_position
	player.velocity = Vector2.ZERO
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
