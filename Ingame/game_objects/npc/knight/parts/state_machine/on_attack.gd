extends StateMachineState

var animation_finished_timer : float

func enter():
	animation_finished_timer = host.animation.get_animation("attack").length
	
func exit():
	pass
	
func step(delta):
	animation_finished_timer -= delta
	if _is_animation_finished(delta): return state_machine.on_chase
	return self

func _is_animation_finished(delta) -> bool:
	return animation_finished_timer <= 0
