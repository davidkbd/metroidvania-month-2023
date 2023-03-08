extends StateMachineState

@export var raycast_direction        : Vector2 = Vector2.LEFT * 32.0

func enter() -> void:
	host.animation_playblack.travel(name)
	state_machine.start_idle_patrol_switch_timer()
	host.navigation_agent.target_position = host.global_position + Vector2.LEFT * 128

func exit() -> void:
	pass
	
func step(delta : float) -> StateMachineState:
	var nav_agent : NavigationAgent2D = host.navigation_agent
#	if nav_agent.is_navigation_finished(): return state_machine.on_idle
	if nav_agent.is_target_reachable():
		var next_location = nav_agent.get_next_path_position()
		var direction = host.global_position.direction_to(next_location)
#		host.global_position += direction * delta * host.specs.speed
#		host.velocity = direction * host.specs.speed
		nav_agent.set_velocity(direction * host.specs.speed)
	
#	_movement()
	host.move_and_slide()
#	if host.player : return state_machine.on_chase
	if host.life <= 0: return state_machine.on_die
#	if state_machine.idle_patrol_timer_flag: return state_machine.on_idle
	return self

#func _movement():
#	host.velocity = Vector2.ZERO

func _on_velocity_computed(_safe_velocity: Vector2) -> void:
#	host.global_position += _safe_velocity
	host.velocity = _safe_velocity
	print("VELOCITY COMPUTED ", _safe_velocity)

func _on_path_changed() -> void:
#	print("ON_PATH_CHANGED: ", host.navigation_agent.get_current_navigation_path())
	pass

func _on_target_reached() -> void:
	print("reached goal")

func _on_navigation_finished() -> void:
	print("NAVIGATION FINISHED")

func _connect_navigation_agent() -> void:
	host.navigation_agent.velocity_computed.connect(_on_velocity_computed)
	host.navigation_agent.path_changed.connect(_on_path_changed)
	host.navigation_agent.target_reached.connect(_on_target_reached)
	host.navigation_agent.navigation_finished.connect(_on_navigation_finished)

func _ready() -> void:
	call_deferred("_connect_navigation_agent")
