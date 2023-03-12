extends StateMachineState

@export var dash_timer : float = .6

var dash_time            : float

func enter() -> void:
	host.animation_playblack.travel(name)
	dash_time = dash_timer
	_impulse()
	host.velocity.y = .0
	host.set_collision_layer_value(4, false)
	host.set_collision_mask_value(4, false)
	host.enemy_damage_area.disable_collision()
	host.enemy_damage_area.disable_ignored_invulnerability_collision()
	host.ondash_collider.disabled = false
	host.body_collider.disabled = true

func exit() -> void:
	host.set_collision_layer_value(4, true)
	host.set_collision_mask_value(4, true)
	# Si estas invulnerable... y haces dash, se acaba la invulnerabilidad
	# esto se deberia de mejorar
	host.enemy_damage_area.enable_collision()
	host.enemy_damage_area.enable_ignored_invulnerability_collision()
	host.ondash_collider.disabled = true
	host.body_collider.disabled = false

func is_an_on_air_state() -> bool: return true

func step(delta : float) -> StateMachineState:
	_brake(delta)

	host.move_and_slide()
	
	dash_time -= delta

	if dash_time < .0: return state_machine.on_air
	if host.skills.data.double_jump and ControlInput.is_jump_just_pressed(): return state_machine.on_doublejump
	if host.skills.data.drop_attack and ControlInput.is_attack_just_pressed() and ControlInput.is_down_pressed(): return state_machine.on_drop_attack
	if host.skills.data.super_attack and host.superattack_manager.charged() and ControlInput.is_attack_just_released(): return state_machine.on_super_attack
	if host.skills.data.snap_wall and host.can_snap_to_wall(): return state_machine.on_wall
	# Si el raycast de snap no detecta pared, pero aun asi nos hemos chocado con una, nos caemos:
	if host.is_on_wall(): return state_machine.on_air
	if host.damager.size(): return state_machine.on_damaged
	if host.deatharea_entered: return state_machine.on_deatharea_entered
	if host.autoadvance_area and is_instance_valid(host.autoadvance_area): return state_machine.on_autoadvancing
	if host.is_on_floor(): return state_machine.on_ground
	return self

func _brake(_delta : float) -> void:
	host.velocity.x = move_toward(host.velocity.x, .0, host.specs.dash_deceleration)

func _impulse() -> void:
	var direction = ControlInput.get_horizontal_axis()
	if direction:
		host.velocity.x = host.specs.dash_impulse * sign(direction)
	else:
		host.velocity.x = host.specs.dash_impulse * (1.0 if host.sprite.flip_h else -1.0)
	host.set_walk_direction(sign(host.velocity.x))
