extends Area2D

@onready var player : Player = get_parent()

func _on_area_entered(area : AutoadvanceArea):
	if is_instance_valid(player.autoadvance_area) or player.state_machine.current_state == player.state_machine.on_autoadvancing:
		return
	player.autoadvance_area = area
	get_tree().call_group("PLAYER_LISTENER", "player_listener_on_autoadvance_entered", area)


func _on_area_exited(area : AutoadvanceArea):
	if player.autoadvance_area == area:
		get_tree().call_group("PLAYER_LISTENER", "player_listener_on_autoadvance_exited", area)
		player.autoadvance_area = null
