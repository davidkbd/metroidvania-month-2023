extends StateMachineState

func enter():
	state_machine.start_idle_patrol_switch_timer()

func exit():
	pass
	
func step(delta):
	if host.player : return state_machine.on_chase
	if state_machine.idle_patrol_timer_flag: return state_machine.on_patrol
	return self
