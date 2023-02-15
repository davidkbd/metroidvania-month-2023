extends StateMachine

@export var on_ground_state      : NodePath
@export var on_crouch_state      : NodePath
@export var on_jump_state        : NodePath
@export var on_doublejump_state  : NodePath
@export var on_air_state         : NodePath
@export var on_damaged_state     : NodePath
@export var on_enemybounce_state : NodePath

@onready var on_crouch      : StateMachineState = get_node(on_crouch_state)
@onready var on_ground      : StateMachineState = get_node(on_ground_state)
@onready var on_jump        : StateMachineState = get_node(on_jump_state)
@onready var on_doublejump  : StateMachineState = get_node(on_doublejump_state)
@onready var on_air         : StateMachineState = get_node(on_air_state)
@onready var on_damaged     : StateMachineState = get_node(on_damaged_state)
@onready var on_enemybounce : StateMachineState = get_node(on_enemybounce_state)
