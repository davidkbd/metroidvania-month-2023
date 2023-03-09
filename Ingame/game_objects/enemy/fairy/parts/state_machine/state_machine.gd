extends StateMachine

@export var on_patrol_state      : NodePath
@export var on_attack_state      : NodePath
@export var on_chase_state       : NodePath
@export var on_damaged_state     : NodePath
@export var on_die_state        : NodePath

@onready var on_patrol      : StateMachineState = get_node(on_patrol_state)
@onready var on_attack      : StateMachineState = get_node(on_attack_state)
@onready var on_chase       : StateMachineState = get_node(on_chase_state)
#@onready var on_damaged     : StateMachineState = get_node(on_damaged_state)
@onready var on_die         : StateMachineState = get_node(on_die_state)
