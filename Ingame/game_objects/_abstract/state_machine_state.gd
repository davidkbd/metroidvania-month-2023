extends Node

class_name StateMachineState

@onready var state_machine : StateMachine   = get_parent()
@onready var host          : CharacterAlive = state_machine.get_parent()

func enter() -> void:
	print("enter")

func exit() -> void:
	print("exit")

func is_an_on_air_state() -> bool:
	return false

func step(_delta : float) -> StateMachineState:
	return self
