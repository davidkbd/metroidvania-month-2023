extends StateMachineState

# Called when the node enters the scene tree for the first time.
func enter():
	host.sprite.material = host.sprite.shader_mat
	var tween : Tween = create_tween()
	tween.tween_method(_disolve, 1.0, .0, .5)

func _disolve(q : float) -> void:
	host.sprite.shader_mat.set_shader_parameter("dissolve_value", q)
