extends StateMachineState


@export var plant_detection_vector : Vector2 = Vector2.RIGHT * 18.0
@export var obstacle_detection_vector : Vector2 = Vector2.RIGHT * 32.0

@onready var beetle : Beetle = get_parent().get_parent()

@onready var space_state = beetle.get_world_2d().get_direct_space_state()

var timer : float

func enter() -> void:
	timer = .3
	beetle.hitting_player = null

func exit() -> void:
	pass

func step(_delta : float) -> StateMachineState:
	timer -= _delta
	if timer <= .0: return get_parent().on_ground
	return self
