extends StateMachineState

var jump_timer            : float
var prevent_on_wall_timer : float

func enter() -> void:
	host.jump_sfx.play()
	host.velocity.y = host.specs.jump_impulse
	jump_timer = .1
	prevent_on_wall_timer = .2

func exit() -> void:
	pass

func step(delta : float) -> StateMachineState:
	_jump(delta)
	
	host.move_and_slide()
	
	var direction = Input.get_axis("l", "r")
	_flip_player(direction)

	jump_timer -= delta
	prevent_on_wall_timer -= delta

	if Input.is_action_just_pressed("j"): return state_machine.on_doublejump
	if jump_timer < .0 and host.is_on_floor(): return state_machine.on_ground
	if prevent_on_wall_timer < .0 and host.is_on_wall(): return state_machine.on_wall
	if host.enemy_died: return state_machine.on_enemybounce
	if host.damager: return state_machine.on_damaged
	return self

func _jump(delta : float) -> void:
	host.fall(delta)

	var direction = Input.get_axis("l", "r")
	if direction:
		host.velocity.x = move_toward(host.velocity.x, direction * host.specs.speed, host.specs.air_acceleration)
	else:
		host.velocity.x = move_toward(host.velocity.x, .0, host.specs.air_deceleration)

func _flip_player(direction) -> void:
	if direction > .0:
		host.sprite.flip_h = true
	elif direction < .0:
		host.sprite.flip_h = false 
