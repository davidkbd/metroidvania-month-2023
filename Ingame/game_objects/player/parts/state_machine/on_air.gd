extends StateMachineState

func enter() -> void:
	pass

func exit() -> void:
	pass

func step(delta : float) -> StateMachineState:
	_fall(delta)
	
	host.move_and_slide()

	if host.get_collision_mask_value(1) and host.is_on_floor(): return state_machine.on_ground
	if host.enemy_died: return state_machine.on_enemybounce
	if host.damager: return state_machine.on_damaged

	return self

func _fall(delta : float) -> void:
	host.fall(delta)
	var direction = Input.get_axis("l", "r")
	if direction:
		host.velocity.x = move_toward(host.velocity.x, direction * host.specs.speed, host.specs.air_acceleration)
	else:
		host.velocity.x = move_toward(host.velocity.x, .0, host.specs.air_deceleration)
