extends CharacterBody2D

class_name CharacterAlive

@onready var state_machine : StateMachine = $state_machine
@onready var sprite        : Sprite2D     = $sprite
@onready var specs         : Dictionary   = CharacterAliveSpecs.get_default_specs()

func fall(_delta : float) -> void:
	velocity.y = clamp(
			velocity.y + specs.gravity * _delta,
			specs.max_up_speed, specs.max_down_speed)
			
func wall_fall(_delta : float) -> void:
	velocity.y = clamp(
			velocity.y + specs.gravity * _delta,
			specs.max_up_speed, specs.wall_down_speed)

func _physics_process(delta : float) -> void:
	state_machine.step(delta)
