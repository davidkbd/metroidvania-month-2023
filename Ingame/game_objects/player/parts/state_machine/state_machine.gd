extends StateMachine

@export var on_autoadvancing_state     : NodePath
@export var on_ground_state            : NodePath
@export var on_jump_state              : NodePath
@export var on_doublejump_state        : NodePath
@export var on_simple_attack_state     : NodePath
@export var on_super_attack_state      : NodePath
@export var on_drop_attack_state       : NodePath
@export var on_dash_state              : NodePath
@export var on_air_dash_state          : NodePath
@export var on_wall_state              : NodePath
@export var on_air_state               : NodePath
@export var on_damaged_state           : NodePath
@export var on_died_state              : NodePath
@export var on_deatharea_entered_state : NodePath
@export var on_talking_state           : NodePath
@export var on_eating_state            : NodePath



@onready var on_autoadvancing     : StateMachineState = get_node(on_autoadvancing_state)
@onready var on_ground            : StateMachineState = get_node(on_ground_state)
@onready var on_jump              : StateMachineState = get_node(on_jump_state)
@onready var on_doublejump        : StateMachineState = get_node(on_doublejump_state)
@onready var on_simple_attack     : StateMachineState = get_node(on_simple_attack_state)
@onready var on_super_attack      : StateMachineState = get_node(on_super_attack_state)
@onready var on_drop_attack       : StateMachineState = get_node(on_drop_attack_state)
@onready var on_dash              : StateMachineState = get_node(on_dash_state)
@onready var on_air_dash          : StateMachineState = get_node(on_air_dash_state)
@onready var on_wall              : StateMachineState = get_node(on_wall_state)
@onready var on_air               : StateMachineState = get_node(on_air_state)
@onready var on_damaged           : StateMachineState = get_node(on_damaged_state)
@onready var on_died              : StateMachineState = get_node(on_died_state)
@onready var on_deatharea_entered : StateMachineState = get_node(on_deatharea_entered_state)
@onready var on_talking           : StateMachineState = get_node(on_talking_state)
@onready var on_eating            : StateMachineState = get_node(on_eating_state)
