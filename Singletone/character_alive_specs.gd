class_name CharacterAliveSpecs

static func get_default_specs() -> Dictionary:
	return {
"speed":               300.0,
"acceleration":        48.0,
"air_acceleration":    24.0,
"air_deceleration":    64.0,
"gravity":             ProjectSettings.get_setting("physics/2d/default_gravity"),
"jump_impulse":        -ProjectSettings.get_setting("physics/2d/default_gravity") * .35,
"doublejump_impulse":  -ProjectSettings.get_setting("physics/2d/default_gravity") * .45,
"damage_impulse":      -48.0,
"damage_deceleration": 20.0,
"damage_received_factor": .05, # cantidad de vida que se pierde multiplicandolo por el power del impacto
"max_up_speed":        -10000.0,
"max_down_speed":      700.0,
"max_down_air_speed":  300.0,
"wall_down_speed":     500.0,
"wall_jump_impulse":   200.0,
"basic_attack_power":  10.0,
"basic_attack_feedback_impulse": 250.0,
"basic_attack_down_feedback_impulse": 600.0,
"drop_attack_impulse": 700.0,
"dash_impulse":        800.0,
"air_dash_impulse":    1000.0,
"dash_deceleration":   30.0
}

static func get_knight_specs() -> Dictionary:
	return {
"speed":                   120.0,
"acceleration":            32.0,
"deceleration":            32.0,
"attack_impulse":          700.0,
"attack1_deceleration":    20.0,
"attack2_deceleration":    8.0,
"attack1_distance":        128.0,
"attack2_distance":        256.0,
"damage_feedback_inpulse": .2,
"attack_feedback_impulse": 15.0,
"gravity":                 ProjectSettings.get_setting("physics/2d/default_gravity"),
"max_up_speed":            -10000.0,
"max_down_speed":          700.0,
}

static func get_gremlin_specs() -> Dictionary:
	return {
"speed":                   150.0,
"acceleration":            32.0,
"deceleration":            32.0,
"attack_deceleration":     15.0,
"attack_impulse":          320.0,
"attack_second_impulse":   450.0,
"attack_feedback_impulse": 30.0,
"attack_distance":         160.0,
"damage_feedback_inpulse": .3,
"gravity":                 ProjectSettings.get_setting("physics/2d/default_gravity"),
"max_up_speed":            -10000.0,
"max_down_speed":          700.0,
}

static func get_fairy_specs() -> Dictionary:
	return {
"speed":                   180.0,
"attack_deceleration":     15.0,
"attack_feedback_impulse": 20.0,
"throw_projectile_feedback_impulse": 200.0,
"damage_feedback_inpulse": .5,
"gravity":                 ProjectSettings.get_setting("physics/2d/default_gravity"),
"max_up_speed":            -10000.0,
"max_down_speed":          700.0,
}
