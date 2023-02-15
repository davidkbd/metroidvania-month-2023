extends Node

class_name StateMachineState

func enter() -> void:
	print("enter")

func exit() -> void:
	print("exit")

func step(_delta : float) -> StateMachineState:
	return self
