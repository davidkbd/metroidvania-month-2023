extends StateMachineState


@export var coyote_time : float = .08

var coyote_timer : float

func enter() -> void:
	host.animation_playblack.travel(name)
	coyote_timer = coyote_time

func exit() -> void:
	pass

func step(delta : float) -> StateMachineState:
	_coyote_time(delta)
	_movement()

	host.move_and_slide()
	_floor_interact()

#	# Returns
	if ControlInput.is_jump_just_pressed(): return state_machine.on_jump
	if ControlInput.is_attack_just_pressed(): return state_machine.on_simple_attack
	if host.skills.data.super_attack and host.superattack_manager.charged() and ControlInput.is_attack_just_released(): return state_machine.on_super_attack
	if host.skills.data.dash and ControlInput.is_dash_just_pressed(): return state_machine.on_dash
	if host.eating_enemy and ControlInput.is_interact_just_pressed(): return state_machine.on_eating
	if host.talking_npc and ControlInput.is_interact_just_pressed(): return state_machine.on_talking
	if coyote_timer < .0: return state_machine.on_air
	if host.damager.size(): return state_machine.on_damaged
	if host.deatharea_entered: return state_machine.on_deatharea_entered
	if host.autoadvance_area and is_instance_valid(host.autoadvance_area): return state_machine.on_autoadvancing
	return self

func _floor_interact() -> void:
	if host.is_on_floor():
		for i in host.get_slide_collision_count():
			var col = host.get_slide_collision(i)
			if col and col.get_collider() is BreakablePlatform:
				col.get_collider().interact()

func _coyote_time(delta : float) -> void:
	if host.is_on_floor():
		coyote_timer = coyote_time
	else:
		host.fall(delta)
		coyote_timer -= delta

func _movement() -> void:
	host.set_walk_direction(ControlInput.get_horizontal_axis())
	if host.walk_direction:
		host.animation_tree.set("parameters/on_ground/blend_position", host.velocity.x)
		host.velocity.x = move_toward(host.velocity.x, host.walk_direction * host.specs.speed, host.specs.acceleration)
	else:
		host.animation_tree.set("parameters/on_ground/blend_position", .0)
		host.velocity.x = move_toward(host.velocity.x, .0, host.specs.acceleration)
