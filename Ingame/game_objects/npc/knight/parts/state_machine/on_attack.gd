extends StateMachineState

var animation_finished_timer : float

func enter() -> void:
	host.animation_playblack.travel(name)
	animation_finished_timer = host.animation.get_animation("attack").length
	
func exit() -> void:
	pass
	
func step(delta : float) -> StateMachineState:
	animation_finished_timer -= delta
	if _is_animation_finished(): return state_machine.on_chase
	return self

func _is_animation_finished() -> bool:
	return animation_finished_timer <= .0
