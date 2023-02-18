extends Node2D
class_name Room

@onready var player       : Player             = get_tree().get_first_node_in_group("PLAYER")
@onready var camera       : FollowTargetCamera = get_tree().get_first_node_in_group("CAMERA")
@onready var room_area    : RoomArea           = _find_room_area()
@onready var room_content : RoomContent        = _find_room_content()
@onready var savepoint    : Node2D             = _find_savepoint()

var room_data : Dictionary

#
# Restaura partida, carga los datos en cada room
#
func progress_listener_on_saved_game_state_loaded(_saved_state : Dictionary) -> void:
	var room_name = name.to_lower()
	room_data = _saved_state.rooms[room_name] if _saved_state.rooms.has(room_name) else {}
#	activate()

func activate() -> void:
	print("ROOM DATA: ", room_data)
	room_content.activate(room_data)

func deactivate() -> void:
	room_content.deactivate()

func update_data() -> void:
	room_data.state = room_content.get_state()
	get_tree().call_group("PROGRESS_LISTENER", "progress_listener_on_room_updated", name, room_data)

func teleport_player() -> void:
	if savepoint == null: return
	
	player.teleport(savepoint.global_position)
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

func _enter_tree() -> void:
	add_to_group("PROGRESS_LISTENER")
