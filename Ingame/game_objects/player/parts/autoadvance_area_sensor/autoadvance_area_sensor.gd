extends Area2D

@onready var player : Player = get_parent()

func _on_area_entered(area : AutoadvanceArea):
	if is_instance_valid(player.autoadvance_area) or player.state_machine.current_state == player.state_machine.on_autoadvancing:
		return
	player.autoadvance_area = area
	if area.fade_out_in:
		get_tree().call_group("PLAYER_LISTENER", "player_listener_on_autoadvance_entered")


func _on_area_exited(area : AutoadvanceArea):
	player.autoadvance_area = null
	get_tree().call_group("PLAYER_LISTENER", "player_listener_on_autoadvance_exited")
