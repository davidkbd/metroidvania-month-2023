extends StateMachineState

@onready var map : Map = get_tree().get_first_node_in_group("MAP")

func enter() -> void:
	host.animation_playblack.travel(name)
	host.velocity = Vector2.ZERO
	map.show_map()

func exit() -> void:
	map.hide_map()

func step(delta : float) -> StateMachineState:
	if ControlInput.is_map_just_pressed(): return state_machine.on_ground
	return self
