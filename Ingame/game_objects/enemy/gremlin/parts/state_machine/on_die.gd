extends StateMachineState

func enter() -> void:
	host.animation_playblack.travel(name)
	host.set_died()
	host.body_collider.disabled = true
	host.sword_collider.disabled = true

func exit() -> void:
	pass

func step(_delta : float) -> StateMachineState:
	_brake()
	host.fall(_delta)
	host.move_and_slide()
	return self

func _disolve(q : float) -> void:
	pass

func _brake() -> void:
	host.velocity.x = move_toward(host.velocity.x, .0, host.specs.attack_deceleration)
