extends StateMachineState

var direction : float

func enter():
	pass

func exit():
	pass
	
func step(delta):
	_movement()
	host.fall(delta)
	host.move_and_slide()
	if host.player : return state_machine.on_chase
	if _returned_to_init() : return state_machine.on_idle
	return self

func _returned_to_init() -> bool:
	var distance_to_init = host.global_position.x - host.initial_position.x
	if abs(distance_to_init) > 5.0:
		return false
	else:
		return true
		
func _movement():
	if direction:
		host.velocity.x = move_toward(host.velocity.x, direction * host.specs.speed * 0.1, host.specs.acceleration)
	else:
		host.velocity.x = move_toward(host.velocity.x, .0, host.specs.deceleration)
	host.flip(direction)
	
func _random_direction():
	direction = sign(host.global_position.x - host.initial_position.x)
	host.flip(direction)
