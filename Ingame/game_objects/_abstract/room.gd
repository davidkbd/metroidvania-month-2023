extends Node2D
class_name Room

@onready var player       : Player             = get_tree().get_first_node_in_group("PLAYER")
@onready var camera       : FollowTargetCamera = get_tree().get_first_node_in_group("CAMERA")
@onready var room_area    : RoomArea           = _find_room_area()
@onready var room_content : RoomContent        = _find_room_content()
@onready var savepoint    : Node2D             = _find_savepoint()

var room_data : Dictionary

func activate() -> void:
	room_content.activate()

func deactivate() -> void:
	room_content.deactivate()

func apply_data() -> void:
	get_tree().call_group("PROGRESS_LISTENER", "progress_listener_room_player_exited", name, room_data)

func teleport_player() -> void:
	if savepoint == null: return
	
	player.teleport(savepoint.global_position)
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
