extends Sprite2D

@onready var host = get_parent()

var walk_direction : float

func _physics_process(delta : float) -> void:
	walk_direction = host.walk_direction
	if walk_direction > .0:
		flip_h = true
	elif walk_direction < .0:
		flip_h = false 
