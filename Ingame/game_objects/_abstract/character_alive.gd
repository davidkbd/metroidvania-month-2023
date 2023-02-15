extends CharacterBody2D

class_name CharacterAlive

@onready var state_machine : StateMachine = $state_machine

func _physics_process(delta : float) -> void:
	state_machine.step(delta)
