extends Node

class_name RoomAreaManager

@onready var camera_room_area_manager = $camera_room_area_manager

func camera_request(_hook : CameraHook) -> void:
	camera_room_area_manager.camera_request(_hook)

func camera_unrequest(_hook : CameraHook) -> void:
	camera_room_area_manager.camera_unrequest(_hook)

func room_activate(_room : Room) -> void:
	_room.activate()

func room_deactivate(_room : Room) -> void:
	_room.deactivate()
	_room.update_room_data()

