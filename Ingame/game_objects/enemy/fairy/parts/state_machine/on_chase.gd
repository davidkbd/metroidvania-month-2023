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
	_check_navigation_finished()
	
	if host.life <= 0: return state_machine.on_die
	if navigation_finished:
		return state_machine.on_attack
	return self

func _movement(_delta : float):
	var next_location = host.navigation_agent.get_next_path_position()
	var direction = host.global_position.direction_to(next_location)
	host.navigation_agent.path_max_distance = 8.0
	host.velocity = lerp(host.velocity, direction * host.specs.speed, _delta)

func _check_navigation_finished() -> void:
	navigation_finished = host.global_position.distance_to(host.navigation_agent.target_position) < host.navigation_agent.path_desired_distance

func _look_at_player() -> void:
	if not host.player: return
	host.set_walk_direction(sign(host.player.global_position.x - host.global_position.x))

func _choose_destination() -> void:
	var bad_destination : bool = true
	var retries : int = 20
	var retry   : int = 0
	var angle   : float = randf_range(-PI, PI)
	var angle_retry_increment : float = TAU / retries
	
	while bad_destination and retry < retries:
		# Si el player se esta respawneando, estara en una posicion
		# MUY lejos y ahi no hay navegacion. PERO, en el siguiente
		# fotograma ya aparecera en escena. La cosa es que el Fairy
		# en ese salto de posicion tan grande dejaria de tenerlo como
		# objetivo porque saldria de su area, y entraria en estado patrol
		var destination = host.player.global_position
		destination.x += cos(angle) * chase_distance
		destination.y += sin(angle) * chase_distance
		host.navigation_agent.target_position = destination
		if host.navigation_agent.is_target_reachable():
			bad_destination = false
		retry += 1
		angle += angle_retry_increment
	navigation_finished = false
