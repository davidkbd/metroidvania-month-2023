class_name CharacterAliveSpecs

static func get_default_specs() -> Dictionary:
	return {
"speed":               300.0,
"acceleration":        32.0,
"deceleration":        128.0,
"air_acceleration":    24.0,
"air_deceleration":    64.0,
"gravity":             ProjectSettings.get_setting("physics/2d/default_gravity"),
"jump_impulse":        -ProjectSettings.get_setting("physics/2d/default_gravity") * .27,
"doublejump_impulse":  -ProjectSettings.get_setting("physics/2d/default_gravity") * .35,
"damage_impulse":      -ProjectSettings.get_setting("physics/2d/default_gravity") * .15,
"damage_deceleration": 20.0,
"max_up_speed":        -10000.0,
"max_down_speed":      700.0,
"wall_down_speed":     500.0,
"wall_jump_impulse":   200.0
}
