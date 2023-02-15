extends StateMachineState

func enter() -> void:
	host.jump_sfx.play()
	host.velocity.y = host.DOUBLEJUMP_IMPULSE

func exit() -> void:
	pass

func step(delta : float) -> StateMachineState:
	if host.go_down_floor_sensor.is_colliding(): _go_down_cancel()

	_jump(delta)

	host.move_and_slide()

	if host.is_on_floor(): return state_machine.on_ground
	if host.enemy_died: return state_machine.on_enemybounce
	if host.damager: return state_machine.on_damaged
	return self

func _jump(delta : float) -> void:
	host.fall(delta)
	var direction = Input.get_axis("l", "r")
	if direction:
		host.velocity.x = move_toward(host.velocity.x, direction * host.SPEED, host.AIR_ACCELERATION)
	else:
		host.velocity.x = move_toward(host.velocity.x, .0, host.AIR_DECELERATION)

func _go_down_cancel() -> void:
	host.set_collision_mask_value(1, true)
