extends StateMachine

@export var on_idle_state        : NodePath
@export var on_patrol_state      : NodePath
@export var on_attack_state      : NodePath
@export var on_chase_state       : NodePath
@export var on_comeback_state    : NodePath
@export var on_damaged_state     : NodePath
@export var on_died_state        : NodePath

@onready var on_idle        : StateMachineState = get_node(on_idle_state)
#@onready var on_patrol      : StateMachineState = get_node(on_patrol_state)
#@onready var on_attack      : StateMachineState = get_node(on_attack_state)
#@onready var on_chase       : StateMachineState = get_node(on_chase_state)
#@onready var on_comeback    : StateMachineState = get_node(on_comeback_state)
#@onready var on_damaged     : StateMachineState = get_node(on_damaged_state)
#@onready var on_died        : StateMachineState = get_node(on_died_state)

@onready var idle_patrol_switch_timer : Timer = $IdlePatrolSwitchTimer
@export var idle_patrol_switch_min_time : float = 2.0
@export var idle_patrol_switch_max_time : float = 5.0

var idle_patrol_timer_flag : bool


func _on_idle_patrol_switch_timer_timeout():
	idle_patrol_timer_flag = true
	
	
func start_idle_patrol_switch_timer():
	idle_patrol_timer_flag = false
	idle_patrol_switch_timer.start(randi_range(idle_patrol_switch_min_time,idle_patrol_switch_max_time))
