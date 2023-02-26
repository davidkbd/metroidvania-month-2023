extends StateMachineState

func enter() -> void:
	host.animation_playblack.travel(name)
	print("La muerte de knight la dejo asi con particulas, pero mejor habria que hacerle una animacion digna")
	host.sprite.hide()
	host.set_died()
	for particles in host.explode_particles:
		particles.emitting = true

func exit() -> void:
	pass

func step(_delta : float) -> StateMachineState:
	return self

func _disolve(q : float) -> void:
	pass
