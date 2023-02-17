extends Area2D

func _on_area_entered(area : RoomArea):
	area.enable_camera_hook()
	area.enable_room()

func _on_area_exited(area : RoomArea):
	area.disable_camera_hook()
	area.disable_room()
