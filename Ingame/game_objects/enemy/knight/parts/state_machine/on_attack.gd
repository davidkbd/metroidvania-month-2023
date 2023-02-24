extends StateMachineState

var animation_finished_timer : float

func enter() -> void:
	host.animation_playblack.travel(name)
	host.velocity = Vector2.ZERO
	animation_finished_timer = host.animation.get_animation("attack").length
	pass

func exit() -> void:
	pass
	
func step(delta : float) -> StateMachineState:
	_brake()
	host.fall(delta)
	host.move_and_slide()
	
	animation_finished_timer -= delta
	
	if host.life <= 0: return state_machine.on_die
	if _is_animation_finished(): return state_machine.on_chase
	return self

func _is_animation_finished() -> bool:
	return animation_finished_timer <= .0

func _brake() -> void:
	host.velocity.x = move_toward(host.velocity.x, .0, host.specs.attack_deceleration)
