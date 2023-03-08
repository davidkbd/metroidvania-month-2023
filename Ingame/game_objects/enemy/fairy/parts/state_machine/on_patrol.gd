extends StateMachineState

var navigation_finished : bool

func enter() -> void:
	host.animation_playblack.travel(name)
	state_machine.start_idle_patrol_switch_timer()
	navigation_finished = false
	_choose_destination()

func exit() -> void:
	pass
	
func step(delta : float) -> StateMachineState:
	if not host.navigation_agent.is_target_reachable(): return state_machine.on_idle

	_movement()
	host.move_and_slide()

	if host.life <= 0: return state_machine.on_die
	if navigation_finished: return state_machine.on_idle
	if state_machine.idle_patrol_timer_flag: return state_machine.on_idle
	return self

func _movement():
	var next_location = host.navigation_agent.get_next_path_position()
	var direction = host.global_position.direction_to(next_location)
	host.velocity = direction * host.specs.speed

func _choose_destination() -> void:
	var destination = host.default_position
	destination.x += randf_range(-128.0, 128.0)
	destination.y += randf_range(-128.0, 128.0)
	host.navigation_agent.target_position = destination
	if not host.navigation_agent.is_target_reachable():
		_choose_destination()


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
