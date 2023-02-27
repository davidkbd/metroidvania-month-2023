extends Control

@onready var lifes = $lifes

func player_listener_on_life_updated(player : Player) -> void:
	print(player)
	lifes.value = player.life
	lifes.max_value = player.max_life
	lifes.queue_redraw()
