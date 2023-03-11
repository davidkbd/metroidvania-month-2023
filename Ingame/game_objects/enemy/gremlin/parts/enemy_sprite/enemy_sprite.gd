extends Sprite2D

@onready var host = get_parent()

func _physics_process(_delta : float) -> void:
	if host.walk_direction > .0:
		flip_h = true
	elif host.walk_direction < .0:
		flip_h = false 
