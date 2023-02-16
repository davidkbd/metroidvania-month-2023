extends Node

class_name RoomAreaManager

@onready var camera_room_area_manager = $camera_room_area_manager

func camera_request(_hook : CameraHook) -> void:
	camera_room_area_manager.camera_request(_hook)

func camera_unrequest(_hook : CameraHook) -> void:
	camera_room_area_manager.camera_unrequest(_hook)
