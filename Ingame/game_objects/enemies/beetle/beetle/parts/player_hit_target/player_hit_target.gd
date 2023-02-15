extends Area2D

@onready var beetle : Beetle = get_parent()

func hit() -> Beetle:
	beetle.mark_to_die()
	return beetle
