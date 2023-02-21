extends StateMachineState

var jump_timer            : float
var prevent_on_wall_timer : float

func enter() -> void:
	host.animation_playblack.travel(name)
	host.jump_sfx.play()
	host.velocity.y = host.specs.jump_impulse
	jump_timer = .1
	prevent_on_wall_timer = .2

func exit() -> void:
	pass

func step(delta : float) -> StateMachineState:
	_movement(delta)
	host.fall(delta)

	host.move_and_slide()

	jump_timer -= delta
	prevent_on_wall_timer -= delta

	if host.can_double_jump() and Input.is_action_just_pressed("j"): return state_machine.on_doublejump
	if jump_timer < .0 and host.is_on_floor(): return state_machine.on_ground
	if prevent_on_wall_timer < .0 and host.can_snap_to_wall(): return state_machine.on_wall
	if host.enemy_died: return state_machine.on_enemybounce
	if host.damager: return state_machine.on_damaged
	return self

func _movement(_delta : float) -> void:
	host.set_walk_direction(Input.get_axis("l", "r"))
	if host.walk_direction:
		host.velocity.x = move_toward(host.velocity.x, host.walk_direction * host.specs.speed, host.specs.air_acceleration)
	else:
		host.velocity.x = move_toward(host.velocity.x, .0, host.specs.air_deceleration)
