extends StateMachineState

@export var fadeout_timer  : float = 1.0
@export var teleport_timer : float = 1.5

var fadeout_time  : float
var teleport_time : float
var fadeout_executed : bool

func enter() -> void:
	fadeout_time  = fadeout_timer
	teleport_time = teleport_timer
	fadeout_executed = false
	host.life.increment_value(-.5)
	host.deatharea_entered = false

func exit() -> void:
	if not host.life.is_died():
		host.global_position = host.restartpoint_sensor.last_restartpoint.global_position
		host.velocity = Vector2.ZERO
		get_tree().call_group("PLAYER_LISTENER", "player_listener_on_deatharea_restarted")

func step(_delta : float) -> StateMachineState:
	fadeout_time -= _delta
	teleport_time -= _delta
	if host.life.is_died(): return state_machine.on_died
	if not fadeout_executed and fadeout_time < .0:
		get_tree().call_group("PLAYER_LISTENER", "player_listener_on_entered_in_deatharea")
		fadeout_executed = true
	if teleport_time < .0:
		return state_machine.on_ground
	return self
