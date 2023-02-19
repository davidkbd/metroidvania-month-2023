extends StateMachineState

func enter():
	pass

func step(delta):
	if not host.player : return state_machine.on_comeback
	if host.player.global_position.distance_to(host.global_position) < 128.0: 
		return state_machine.on_attack
	return self
