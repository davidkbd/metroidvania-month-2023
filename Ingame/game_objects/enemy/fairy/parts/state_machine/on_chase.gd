extends StateMachineState

@export var chase_distance   : float = 200.0

var navigation_finished : bool

func enter() -> void:
	if host.player:
		host.animation_playblack.travel(name)
		_choose_destination()

func exit() -> void:
	pass
	
func step(_delta : float) -> StateMachineState:
	if not host.player: return state_machine.on_patrol
	
	_movement(_delta)
	_look_at_player()
	host.move_and_slide()
	
	if host.life <= 0: return state_machine.on_die
	if navigation_finished: return state_machine.on_attack
	return self

func _movement(_delta : float):
	var next_location = host.navigation_agent.get_next_path_position()
	var direction = host.global_position.direction_to(next_location)
	host.navigation_agent.path_max_distance = 8.0
	host.velocity = lerp(host.velocity, direction * host.specs.speed, _delta)

func _look_at_player() -> void:
	if not host.player: return
	host.set_walk_direction(sign(host.player.global_position.x - host.global_position.x))

func _choose_destination() -> void:
	var angle = randf_range(-PI, PI)
	var destination = host.player.global_position
	destination.x += cos(angle) * chase_distance
	destination.y += sin(angle) * chase_distance
	host.navigation_agent.target_position = destination
	navigation_finished = false
	if not host.navigation_agent.is_target_reachable():
		_choose_destination()

func _on_velocity_computed(_safe_velocity: Vector2) -> void:
	pass

func _on_path_changed() -> void:
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
