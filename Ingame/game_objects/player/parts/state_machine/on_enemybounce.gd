extends StateMachineState

var jump_timer : float

func enter() -> void:
	host.velocity.y = host.JUMP_IMPULSE
	jump_timer = .1
	host.enemy_died = null

func exit() -> void:
	pass

func step(delta : float) -> StateMachineState:
	if host.go_down_floor_sensor.is_colliding(): _go_down_cancel()
	if host.enemy_died: enter()

	_jump(delta)
	
	jump_timer -= delta
	host.move_and_slide()
	
	if host.damager: return state_machine.on_damaged
	if jump_timer < .0 and host.is_on_floor(): return state_machine.on_ground
	if Input.is_action_just_pressed("j"): return state_machine.on_doublejump
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
