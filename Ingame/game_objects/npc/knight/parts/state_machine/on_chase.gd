extends StateMachineState

var direction: float

func enter():
	pass

func exit():
	pass

func step(delta):
	_movement()
	host.fall(delta)
	host.move_and_slide()
	if not host.player : return state_machine.on_comeback
	if host.player.global_position.distance_to(host.global_position) < 128.0: 
		return state_machine.on_attack
	return self

func _movement():
	if direction:
		host.velocity.x = move_toward(host.velocity.x, direction * host.specs.speed * 0.1, host.specs.acceleration)
	else:
		host.velocity.x = move_toward(host.velocity.x, .0, host.specs.deceleration)
	host.flip(direction)
	
func _random_direction():
	direction = sign(host.global_position.x - host.player.global_position.x)
	host.flip(direction)
