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

	host.animation_tree.set("parameters/on_jump/blend_position", host.velocity)
	
	jump_timer -= delta
	prevent_on_wall_timer -= delta

	if host.skills.data.double_jump and ControlInput.is_doublejump_just_pressed(): return state_machine.on_doublejump
	if ControlInput.is_attack_just_pressed():
		if host.skills.data.normal_attack:
			return state_machine.on_normal_attack
		else:
			return state_machine.on_simple_attack
	if jump_timer < .0 and host.is_on_floor(): return state_machine.on_ground
	if host.skills.data.dash and ControlInput.is_dash_just_pressed(): return state_machine.on_air_dash
	if host.skills.data.snap_wall and prevent_on_wall_timer < .0 and host.can_snap_to_wall(): return state_machine.on_wall
	if host.damager.size(): return state_machine.on_damaged
	if host.autoadvance_area and is_instance_valid(host.autoadvance_area): return state_machine.on_autoadvancing
	return self

func _movement(_delta : float) -> void:
	host.set_walk_direction(ControlInput.get_horizontal_axis())
	if host.walk_direction:
		host.velocity.x = move_toward(host.velocity.x, host.walk_direction * host.specs.speed, host.specs.air_acceleration)
	else:
		host.velocity.x = move_toward(host.velocity.x, .0, host.specs.air_deceleration)
