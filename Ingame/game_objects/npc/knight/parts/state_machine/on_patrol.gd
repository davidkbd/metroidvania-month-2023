extends StateMachineState

func enter():
	print(get_path())
	state_machine.start_idle_patrol_switch_timer()

func step(delta):
	if host.player : return state_machine.on_chase
	if state_machine.idle_patrol_timer_flag: return state_machine.on_idle
	return self
