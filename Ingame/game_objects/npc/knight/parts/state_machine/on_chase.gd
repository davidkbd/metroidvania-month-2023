extends StateMachineState

func enter():
	pass

func exit():
	pass

func step(delta):
	if not host.player : return state_machine.on_comeback
	_choose_direction()
	_movement()
	host.fall(delta)
	host.move_and_slide()
	if host.player.global_position.distance_to(host.center.global_position) < 64.0: 
		return state_machine.on_attack
	return self

func _movement():
	if host.walk_direction:
		host.velocity.x = move_toward(host.velocity.x, host.walk_direction * host.speed * 0.1, host.acceleration)
	else:
		host.velocity.x = move_toward(host.velocity.x, .0, host.deceleration)
	
func _choose_direction():
	host.set_walk_direction(sign(host.player.global_position.x - host.global_position.x))
