extends StateMachineState

var time : float

func enter() -> void:
	host.animation_playblack.start(name, true)
	host.velocity = Vector2.ZERO
	time = 1.5
	#host.throw_projectile()

func exit() -> void:
	pass
	
func step(delta : float) -> StateMachineState:
	_brake()
	host.move_and_slide()
	
	time -= delta
	
	if host.life <= 0: return state_machine.on_die
	if time <= .0: return state_machine.on_chase
	return self

func _brake() -> void:
	host.velocity.x = move_toward(host.velocity.x, .0, host.specs.attack_deceleration)
	host.velocity.y = move_toward(host.velocity.y, .0, host.specs.attack_deceleration)
