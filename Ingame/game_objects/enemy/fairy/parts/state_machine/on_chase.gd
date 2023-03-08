extends StateMachineState

@export var chase_distance   : float = 200.0
#@export var min_attack_delay : float = 2.0
#@export var max_attack_delay : float = 5.0

#var attack_delay_time : float
var navigation_finished : bool

func enter() -> void:
	host.animation_playblack.travel(name)
#	_calc_attack_delay_time()
	_choose_destination()

func exit() -> void:
	pass
	
func step(_delta : float) -> StateMachineState:
	if not host.player: return state_machine.on_patrol
	
	_movement(_delta)
	host.move_and_slide()
	
#	attack_delay_time -= _delta

	if host.life <= 0: return state_machine.on_die
	if navigation_finished: return state_machine.on_attack
#	if attack_delay_time < .0: return state_machine.on_attack
	return self

func _movement(_delta : float):
	var next_location = host.navigation_agent.get_next_path_position()
	var direction = host.global_position.direction_to(next_location)
	host.navigation_agent.path_max_distance = 8.0
	host.velocity = lerp(host.velocity, direction * host.specs.speed, _delta)

func _choose_destination() -> void:
	var destination = host.player.global_position
	destination.x += cos(randf_range(-PI, PI)) * chase_distance
	destination.y += sin(randf_range(-PI, PI)) * chase_distance
	host.navigation_agent.target_position = destination
	navigation_finished = false

func _on_velocity_computed(_safe_velocity: Vector2) -> void:
#	host.global_position += _safe_velocity
	host.velocity = _safe_velocity
	print("VELOCITY COMPUTED ", _safe_velocity)

func _on_path_changed() -> void:
#	print("ON_PATH_CHANGED: ", host.navigation_agent.get_current_navigation_path())
	pass

func _on_target_reached() -> void:
	pass

func _on_navigation_finished() -> void:
	navigation_finished = true

func _connect_navigation_agent() -> void:
	host.navigation_agent.velocity_computed.connect(_on_velocity_computed)
	host.navigation_agent.path_changed.connect(_on_path_changed)
	host.navigation_agent.target_reached.connect(_on_target_reached)
	host.navigation_agent.navigation_finished.connect(_on_navigation_finished)

func _ready() -> void:
	call_deferred("_connect_navigation_agent")
