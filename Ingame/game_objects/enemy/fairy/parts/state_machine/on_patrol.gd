extends StateMachineState

var navigation_finished : bool

func enter() -> void:
	host.animation_playblack.travel(name)
	_choose_destination()

func exit() -> void:
	pass
	
func step(_delta : float) -> StateMachineState:
	if navigation_finished: _choose_destination()
	_movement(_delta)
	host.move_and_slide()
	_check_navigation_finished()
	
	if host.life <= 0: return state_machine.on_die
	if host.player: return state_machine.on_chase
	
	return self

func _movement(_delta : float):
	var next_location = host.navigation_agent.get_next_path_position()
	var direction = host.global_position.direction_to(next_location)
	host.navigation_agent.path_max_distance = 8.0
	host.velocity = lerp(host.velocity, direction * host.specs.speed, _delta)

func _check_navigation_finished() -> void:
	navigation_finished = host.global_position.distance_to(host.navigation_agent.target_position) < host.navigation_agent.path_desired_distance

func _choose_destination() -> void:
	var destination = host.default_position
	destination.x += randf_range(-160.0, 160.0)
	destination.y += randf_range(-160.0, 160.0)
	host.navigation_agent.target_position = destination
	navigation_finished = false
	if not host.navigation_agent.is_target_reachable():
		_choose_destination()
