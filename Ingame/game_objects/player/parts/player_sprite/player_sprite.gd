extends Sprite2D

@onready var player : Player = get_parent()

var walk_direction : float

func _physics_process(_delta : float) -> void:
	walk_direction = player.walk_direction
	if walk_direction > .0:
		flip_h = true
	elif walk_direction < .0:
		flip_h = false 

func _ready() -> void:
	var mat : ShaderMaterial = material
	mat.set_shader_parameter("animation_columns", hframes)
	mat.set_shader_parameter("animation_rows", vframes)
