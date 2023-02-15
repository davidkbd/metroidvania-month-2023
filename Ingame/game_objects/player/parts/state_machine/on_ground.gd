extends StateMachineState

@export var check_floor_ray_vector : Vector2 = Vector2.DOWN * 32.0
@export var coyote_time : float = .08

var coyote_timer : float

func enter() -> void:
	coyote_timer = coyote_time

func exit() -> void:
	pass

func step(delta : float) -> StateMachineState:
	_coyote_time(delta)
	_movement()

	if host.velocity.x > .0:
		host.sprite.flip_h = true
	elif host.velocity.x < .0:
		host.sprite.flip_h = false

	host.move_and_slide()

	if Input.is_action_just_pressed("j"): return state_machine.on_jump
	if Input.is_action_pressed("d"): return state_machine.on_crouch
	if coyote_timer < .0: return state_machine.on_air
	if host.damager: return state_machine.on_damaged
	
	return self

func _coyote_time(delta : float) -> void:
	if host.is_on_floor():
		coyote_timer = coyote_time
	else:
		host.fall(delta)
		coyote_timer -= delta

func _movement() -> void:
	var direction = Input.get_axis("l", "r")
	if direction:
		host.velocity.x = move_toward(host.velocity.x, direction * host.specs.speed, host.specs.acceleration)
	else:
		host.velocity.x = move_toward(host.velocity.x, .0, host.specs.deceleration)
