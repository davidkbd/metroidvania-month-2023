extends Node

class_name StateMachine

@export var initial_state        : NodePath

@onready var current_state  : StateMachineState = get_node(initial_state)

func step(delta : float) -> void:
	var next_state = current_state.step(delta)
	if next_state != current_state:
		_change_state(next_state)

func _change_state(next_state : StateMachineState) -> void:
	current_state.exit()
	next_state.enter()
	current_state = next_state
	
func _ready():
	current_state.enter()
