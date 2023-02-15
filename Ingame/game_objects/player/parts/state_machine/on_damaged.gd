extends StateMachineState

var damage_timer : float

func enter() -> void:
	host.damaged_sfx.play()
	if is_instance_valid(host.damager):
		host.velocity.y = host.DAMAGE_IMPULSE
		host.velocity.x = host.DAMAGE_IMPULSE * sign(host.damager.global_position.x - host.global_position.x)
		if host.cube_is_full:
			host.drop_cube()
		damage_timer = .1
	host.damager = null

func exit() -> void:
	pass

func step(delta : float) -> StateMachineState:
	if host.go_down_floor_sensor.is_colliding(): _go_down_cancel()
	if host.damager: enter()

	host.fall(delta)
	host.velocity.x = move_toward(host.velocity.x, .0, host.DAMAGE_DECELERATION)

	damage_timer -= delta
	host.move_and_slide()

	if damage_timer < .0 and host.is_on_floor(): return state_machine.on_ground
	return self

func _go_down_cancel() -> void:
	host.set_collision_mask_value(1, true)
