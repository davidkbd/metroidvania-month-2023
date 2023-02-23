extends Area2D

func _on_area_entered(area : AutoadvanceArea):
	if is_instance_valid(get_parent().autoadvance_area):
		return
	get_parent().autoadvance_area = area
	if area.fade_out_in:
		get_tree().call_group("PLAYER_LISTENER", "player_listener_on_autoadvance_entered")


func _on_area_exited(area : AutoadvanceArea):
	get_parent().autoadvance_area = null
	get_tree().call_group("PLAYER_LISTENER", "player_listener_on_autoadvance_exited")
