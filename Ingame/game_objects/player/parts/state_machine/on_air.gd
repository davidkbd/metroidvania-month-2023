extends StateMachineState

func enter() -> void:
	host.animation_playblack.travel(name)

func exit() -> void:
	pass

func step(delta : float) -> StateMachineState:
	_movement(delta)
	host.fall(delta)
	
	host.move_and_slide()

	if host.get_collision_mask_value(1) and host.is_on_floor(): return state_machine.on_ground
	if host.can_snap_to_wall(): return state_machine.on_wall
	if host.enemy_died: return state_machine.on_enemybounce
	if host.damager.size(): return state_machine.on_damaged

	return self

func _movement(_delta : float) -> void:
	host.set_walk_direction(ControlInput.get_horizontal_axis())
	if host.walk_direction:
		host.velocity.x = move_toward(host.velocity.x, host.walk_direction * host.specs.speed, host.specs.air_acceleration)
	else:
		host.velocity.x = move_toward(host.velocity.x, .0, host.specs.air_deceleration)
