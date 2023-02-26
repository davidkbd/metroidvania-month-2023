extends CharacterBody2D

class_name CharacterAlive

@onready var animation_tree       : AnimationTree = $AnimationTree
@onready var animation_playblack  : AnimationNodeStateMachinePlayback = animation_tree.get("parameters/playback")

@onready var state_machine : StateMachine = $state_machine
@onready var sprite        : Sprite2D     = $sprite
@onready var specs         : Dictionary   = CharacterAliveSpecs.get_default_specs()
@onready var space_state = get_world_2d().get_direct_space_state()

func fall(_delta : float) -> void:
	velocity.y = clamp(
			velocity.y + specs.gravity * _delta,
			specs.max_up_speed, specs.max_down_speed)
			
func fall_dash(_delta : float) -> void:
	velocity.y = clamp(
			velocity.y + specs.gravity * _delta,
			specs.max_up_speed, specs.max_down_air_speed)
			
func wall_fall(_delta : float) -> void:
	velocity.y = clamp(
			velocity.y + specs.gravity * _delta,
			specs.max_up_speed, specs.wall_down_speed)

func _physics_process(delta : float) -> void:
	state_machine.step(delta)

func _ready() -> void:
	animation_playblack.travel("idle")
