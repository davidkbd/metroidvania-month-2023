extends Sprite2D

@onready var host = get_parent()
#@onready var shader_mat = material.duplicate()

func _physics_process(_delta : float) -> void:
	if host.walk_direction > .0:
		flip_h = true
	elif host.walk_direction < .0:
		flip_h = false 

#func _ready() -> void:
#	material = shader_mat
#	shader_mat.set_shader_parameter("animation_columns", hframes)
#	shader_mat.set_shader_parameter("animation_rows", vframes)
