extends StateMachineState

@export var dash_timer : float = .5

var dash_time            : float

func enter() -> void:
	host.animation_playblack.travel(name)
	dash_time = dash_timer
	host.velocity.x = host.specs.dash_impulse * (1.0 if host.sprite.flip_h else -1.0)

func exit() -> void:
	pass

func step(delta : float) -> StateMachineState:
	_brake(delta)
	host.fall(delta)

	host.move_and_slide()
	
	dash_time -= delta


	print("Habra que hacer algo con damager.size() no, o que?")
	if host.damager.size(): return state_machine.on_damaged
	if host.autoadvance_area and is_instance_valid(host.autoadvance_area): return state_machine.on_autoadvancing
	if dash_time < .0: return state_machine.on_ground
	return self

func _brake(_delta : float) -> void:
	host.velocity.x = move_toward(host.velocity.x, .0, host.specs.dash_deceleration)
