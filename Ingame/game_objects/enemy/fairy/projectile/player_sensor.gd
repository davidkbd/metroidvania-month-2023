extends Area2D

@export var power                  : float = 10.0
@export var enable_invulnerability : bool = true

func get_damage_data() -> Dictionary:
	get_parent()._destroy()
	return {
		"global_position": global_position,
		"power": power,
		"enable_invulnerability": enable_invulnerability
		}
