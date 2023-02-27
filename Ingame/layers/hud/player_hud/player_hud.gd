extends Control

@onready var lifes = $lifes

func player_listener_on_life_updated(_life : Dictionary) -> void:
	lifes.value = _life.value
	lifes.max_value = _life.max_value
	lifes.queue_redraw()
