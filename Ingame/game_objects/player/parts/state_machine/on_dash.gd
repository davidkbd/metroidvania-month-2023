extends StateMachineState

@export var dash_timer : float = .5

var dash_time            : float

func enter() -> void:
	host.animation_playblack.travel(name)
	dash_time = dash_timer
	host.velocity.x = host.specs.dash_impulse * (1.0 if host.sprite.flip_h else -1.0)
	host.set_collision_layer_value(4, false)
	host.set_collision_mask_value(4, false)
	host.enemy_damage_area.set_collision_mask_value(4, false)

func exit() -> void:
	host.set_collision_layer_value(4, true)
	host.set_collision_mask_value(4, true)
	host.enemy_damage_area.set_collision_mask_value(4, true)

func step(delta : float) -> StateMachineState:
	_brake(delta)
	host.fall(delta)

	host.move_and_slide()
	
	dash_time -= delta


	if ControlInput.is_jump_just_pressed(): return state_machine.on_jump
	if ControlInput.is_attack_just_pressed():
		if host.skills.data.normal_attack:
			return state_machine.on_normal_attack
		else:
			return state_machine.on_simple_attack
	if host.damager.size(): return state_machine.on_damaged
	if host.autoadvance_area and is_instance_valid(host.autoadvance_area): return state_machine.on_autoadvancing
	if dash_time < .0: return state_machine.on_ground
	return self

func _brake(_delta : float) -> void:
	host.velocity.x = move_toward(host.velocity.x, .0, host.specs.dash_deceleration)
