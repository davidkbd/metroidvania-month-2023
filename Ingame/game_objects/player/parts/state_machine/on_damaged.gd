extends StateMachineState

var hilight_tween : Tween

var damage_timer : float

func enter() -> void:
	host.animation_playblack.travel(name)
	if hilight_tween: hilight_tween.kill()
	hilight_tween = create_tween()
	host.modulate = Color(1.5, 1.5, 1.5, 1)
	hilight_tween.tween_property(host, "modulate", Color.WHITE, .50)
	host.damaged_sfx.play()
	if host.damager.size():
		var impulse := Vector2.ZERO
		impulse.y = host.specs.damage_impulse
		impulse.x = host.specs.damage_impulse * sign(host.damager.global_position.x - host.global_position.x)
		impulse *= host.damager.power
		host.velocity = impulse
		damage_timer = .1
		host.life.increment_value(-host.damager.power * host.specs.damage_received_factor)
	host.damager = {}
	host.superattack_manager.reset_charge()

func exit() -> void:
	pass

func step(delta : float) -> StateMachineState:
	if host.damager.size(): enter()

	host.fall(delta)
	host.velocity.x = move_toward(host.velocity.x, .0, host.specs.damage_deceleration)

	damage_timer -= delta
	host.move_and_slide()

	if damage_timer < .0:
		if host.life.is_died(): return state_machine.on_died
		if host.is_on_floor(): return state_machine.on_ground
	if host.deatharea_entered: return state_machine.on_deatharea_entered
	if ControlInput.is_jump_just_pressed(): return state_machine.on_jump
	return self
