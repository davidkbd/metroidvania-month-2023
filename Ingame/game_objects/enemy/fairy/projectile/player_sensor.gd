extends Area2D

@export var power                  : float = 10.0

func get_damage_data() -> Dictionary:
	get_parent()._destroy()
	return {
		"global_position": global_position,
		"power": power
		}

func hit(_position : Vector2, _power : float) -> void:
	get_parent()._destroy()
