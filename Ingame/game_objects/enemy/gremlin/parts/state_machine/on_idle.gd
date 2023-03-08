extends StateMachineState

func enter() -> void:
	host.animation_playblack.travel(name)
	state_machine.start_idle_patrol_switch_timer()

func exit() -> void:
	pass
	
func step(delta : float) -> StateMachineState:
	host.fall(delta)
	if host.life <= 0: return state_machine.on_die
	if host.player : return state_machine.on_chase
	if state_machine.idle_patrol_timer_flag: return state_machine.on_patrol
	return self
