extends Node

@onready var camera : FollowTargetCamera = get_tree().get_first_node_in_group("CAMERA")
@onready var player : Player             = get_tree().get_first_node_in_group("PLAYER")

var requested_camera_target : Node2D
var current_camera_target   : Node2D

func camera_request(_hook : CameraHook) -> void:
	requested_camera_target = _hook
	_hook.enable(player)

func camera_unrequest(_hook : CameraHook) -> void:
	if _hook == requested_camera_target: return
	current_camera_target = requested_camera_target
	camera.set_target(requested_camera_target)
	_hook.disable()
