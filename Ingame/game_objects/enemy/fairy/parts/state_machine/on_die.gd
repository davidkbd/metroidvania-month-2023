extends StateMachineState

func enter() -> void:
	host.animation_playblack.travel(name)
#	print("La muerte de gremlin la dejo asi con particulas, pero mejor habria que hacerle una animacion digna")
#	host.sprite.hide()
	host.set_died()
#	for particles in host.explode_particles:
#		particles.emitting = true

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
