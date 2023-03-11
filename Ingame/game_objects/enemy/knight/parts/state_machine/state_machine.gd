extends StateMachine

@export var on_idle_state        : NodePath
@export var on_patrol_state      : NodePath
@export var on_attack_state      : NodePath
@export var on_chase_state       : NodePath
@export var on_comeback_state    : NodePath
@export var on_damaged_state     : NodePath
@export var on_die_state        : NodePath

@export_group("idle patrol switch time")
@export var idle_patrol_switch_min_time : float = 2.0
@export var idle_patrol_switch_max_time : float = 5.0
@export_group("attack choose time")
@export var attack_choose_min_time : float = 1.0
@export var attack_choose_max_time : float = 8.0

@onready var on_idle        : StateMachineState = get_node(on_idle_state)
@onready var on_patrol      : StateMachineState = get_node(on_patrol_state)
@onready var on_attack      : StateMachineState = get_node(on_attack_state)
@onready var on_chase       : StateMachineState = get_node(on_chase_state)
@onready var on_comeback    : StateMachineState = get_node(on_comeback_state)
#@onready var on_damaged     : StateMachineState = get_node(on_damaged_state)
@onready var on_die         : StateMachineState = get_node(on_die_state)

@onready var idle_patrol_switch_timer : Timer = $IdlePatrolSwitchTimer
@onready var attack_choose_timer      : Timer = $AttackChooseTimer

var idle_patrol_timer_flag : bool

@onready var attack_data : Dictionary = {
	"animation": "",
	"deceleration": 0,
	"distance": 0
}
var attack_id : int = 0

func _on_idle_patrol_switch_timer_timeout():
	idle_patrol_timer_flag = true

func _on_attack_choose_timer_timeout():
	attack_id += 1
	if attack_id > 2: attack_id = 1
	
	match attack_id:
		1:
			attack_data.animation    = "attack"
			attack_data.deceleration = get_parent().specs.attack1_deceleration
			attack_data.distance     = get_parent().specs.attack1_distance
		2:
			attack_data.animation    = "attack"
			attack_data.deceleration = get_parent().specs.attack2_deceleration
			attack_data.distance     = get_parent().specs.attack2_distance

	attack_choose_timer.start(randi_range(attack_choose_min_time, attack_choose_max_time))

func start_idle_patrol_switch_timer():
	idle_patrol_timer_flag = false
	idle_patrol_switch_timer.start(randi_range(idle_patrol_switch_min_time, idle_patrol_switch_max_time))
