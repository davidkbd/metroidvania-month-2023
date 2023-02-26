extends StateMachineState

func enter() -> void:
	host.animation_playblack.travel(name)
	host.velocity = Vector2.ZERO
	get_tree().get_first_node_in_group("MAP").show_map()

func exit() -> void:
#	map.hide_map()
	#aqui no ocultamos el mapa, se oculta a si mismo, porque
	#mientras esta abierto, el juego queda pausado
	pass

func step(delta : float) -> StateMachineState:
	if ControlInput.is_map_just_pressed(): return state_machine.on_ground
	return self
