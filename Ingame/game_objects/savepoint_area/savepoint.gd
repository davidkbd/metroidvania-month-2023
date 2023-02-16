extends Node2D

func teleport_player() -> void:
	var player : Player             = get_tree().get_first_node_in_group("PLAYER")
	player.teleport(global_position)

func teleport_camera() -> void:
	var camera : FollowTargetCamera = get_tree().get_first_node_in_group("CAMERA")
	camera.set_target(get_parent())
	camera.teleport()
