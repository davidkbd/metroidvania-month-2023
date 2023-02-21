extends StateMachineState

func enter() -> void:
	host.animation_playblack.travel(name)
	host.sprite.material = host.sprite.shader_mat
	var tween : Tween = create_tween()
	tween.tween_method(_disolve, 1.0, .0, .5)

func exit() -> void:
	pass

func step(_delta : float) -> StateMachineState:
	return self

func _disolve(q : float) -> void:
	host.sprite.shader_mat.set_shader_parameter("dissolve_value", q)
