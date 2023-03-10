extends Area2D

@export var power                  : float = 10.0

func get_damage_data() -> Dictionary:
	get_parent().velocity.x = -get_parent().specs.attack_feedback_impulse * power * get_parent().walk_direction
	return {
		"global_position": global_position,
		"power": power
		}

func hit(_position : Vector2, _power : float) -> void:
	get_parent().hit(_position, _power)
