extends StateMachineState

func enter() -> void:
	host.animation_playblack.travel(name)

func exit() -> void:
	pass
	
func step(delta : float) -> StateMachineState:
	_choose_direction()
	_movement()
	host.fall(delta)
	host.move_and_slide()
	if host.life <= 0: return state_machine.on_die
	if host.player : return state_machine.on_chase
	if _initial_position_distance() < 1.0: return state_machine.on_idle
	return self

func _initial_position_distance() -> float:
	var distance_to_init = abs(host.global_position.x - host.initial_position.x)
	if distance_to_init < 2.0:
		return .0
	else:
		return distance_to_init
		
func _movement():
	if host.walk_direction:
		host.velocity.x = move_toward(host.velocity.x, host.walk_direction * host.specs.speed, host.specs.acceleration)
	else:
		host.velocity.x = move_toward(host.velocity.x, .0, host.specs.deceleration)
	
func _choose_direction():
	host.set_walk_direction(-sign(host.global_position.x - host.initial_position.x))

