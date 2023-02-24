extends StateMachineState

func enter() -> void:
	host.animation_playblack.travel(name)

func exit() -> void:
	pass

func step(delta : float) -> StateMachineState:
	if host.life <= 0: return state_machine.on_die
	if not host.player : return state_machine.on_comeback
	_choose_direction()
	_movement()
	host.fall(delta)
	host.move_and_slide()
	if host.player.global_position.distance_to(host.center.global_position) < host.specs.attack_distance: 
		return state_machine.on_attack
	return self

func _movement():
	if host.walk_direction:
		host.velocity.x = move_toward(host.velocity.x, host.walk_direction * host.specs.speed, host.specs.acceleration)
	else:
		host.velocity.x = move_toward(host.velocity.x, .0, host.specs.deceleration)
	
func _choose_direction():
	host.set_walk_direction(sign(host.player.global_position.x - host.global_position.x))
