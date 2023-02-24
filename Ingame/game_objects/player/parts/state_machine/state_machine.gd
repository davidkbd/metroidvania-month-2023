extends StateMachine

@export var on_autoadvancing_state  : NodePath
@export var on_ground_state         : NodePath
@export var on_jump_state           : NodePath
@export var on_doublejump_state     : NodePath
@export var on_attack_state         : NodePath
@export var on_wall_state           : NodePath
@export var on_air_state            : NodePath
@export var on_damaged_state        : NodePath
@export var on_enemybounce_state    : NodePath
@export var on_talking_state        : NodePath


@onready var on_autoadvancing  : StateMachineState = get_node(on_autoadvancing_state)
@onready var on_ground         : StateMachineState = get_node(on_ground_state)
@onready var on_jump           : StateMachineState = get_node(on_jump_state)
@onready var on_doublejump     : StateMachineState = get_node(on_doublejump_state)
@onready var on_attack         : StateMachineState = get_node(on_attack_state)
@onready var on_wall           : StateMachineState = get_node(on_wall_state)
@onready var on_air            : StateMachineState = get_node(on_air_state)
@onready var on_damaged        : StateMachineState = get_node(on_damaged_state)
@onready var on_enemybounce    : StateMachineState = get_node(on_enemybounce_state)
@onready var on_talking        : StateMachineState = get_node(on_talking_state)
