extends StateMachineState

func enter() -> void:
	host.animation_playblack.travel(name)
	state_machine.start_idle_patrol_switch_timer()

func exit() -> void:
	pass
	
func step(delta : float) -> StateMachineState:
	if host.player : return state_machine.on_chase
	if state_machine.idle_patrol_timer_flag: return state_machine.on_patrol
	return self
