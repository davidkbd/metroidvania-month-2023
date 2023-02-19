extends StateMachineState

func enter():
	pass

func step(delta):
	if host.player : return state_machine.on_chase
	return self
