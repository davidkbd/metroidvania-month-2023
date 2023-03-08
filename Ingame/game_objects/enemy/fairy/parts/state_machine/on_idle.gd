extends StateMachineState

var current_position : Vector2
var destination      : Vector2

var time : float

func enter() -> void:
	time = .0
	current_position = host.global_position
	host.animation_playblack.travel(name)
	state_machine.start_idle_patrol_switch_timer()
#	host.velocity = Vector2.ZERO

func exit() -> void:
	pass
	
func step(_delta : float) -> StateMachineState:
	_movement(_delta)
	host.move_and_slide()
	
	time += _delta
	
	if host.life <= 0: return state_machine.on_die
#	if host.player : return state_machine.on_chase
	if state_machine.idle_patrol_timer_flag: return state_machine.on_patrol
	return self

func _movement(_delta : float) -> void:
#	host.global_position.y = current_position.y + sin(time * host.specs.idle_speed) * host.specs.idle_movement
	host.velocity.y = sin(time * host.specs.idle_speed) * host.specs.idle_movement
