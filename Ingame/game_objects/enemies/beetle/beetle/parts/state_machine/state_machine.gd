extends StateMachine

@export var on_ground_state      : NodePath
@export var on_air_state         : NodePath
@export var on_eating_state      : NodePath
@export var on_died_state        : NodePath
@export var on_attack_state      : NodePath

@onready var on_ground           : StateMachineState = get_node(on_ground_state)
@onready var on_air              : StateMachineState = get_node(on_air_state)
@onready var on_eating           : StateMachineState = get_node(on_eating_state)
@onready var on_died             : StateMachineState = get_node(on_died_state)
@onready var on_attack           : StateMachineState = get_node(on_attack_state)
