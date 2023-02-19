extends StateMachineState

func enter():
	pass

func step(delta):
	if _is_animation_finished(): return state_machine.on_patrol
	return self

func _is_animation_finished() -> bool:
	return host.animation.current_animation_length == host.animation.current_animation_position
