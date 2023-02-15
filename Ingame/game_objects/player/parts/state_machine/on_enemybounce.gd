extends StateMachineState

@onready var player : Player = get_parent().get_parent()

var jump_timer : float

func enter() -> void:
	player.velocity.y = player.JUMP_IMPULSE
	jump_timer = .1
	player.enemy_died = null

func exit() -> void:
	pass

func step(delta : float) -> StateMachineState:
	if player.go_down_floor_sensor.is_colliding(): _go_down_cancel()
	if player.enemy_died: enter()

	_jump(delta)
	
	jump_timer -= delta
	player.move_and_slide()
	
	if player.damager: return get_parent().on_damaged
	if jump_timer < .0 and player.is_on_floor(): return get_parent().on_ground
	if Input.is_action_just_pressed("j"): return get_parent().on_doublejump
	return self

func _jump(delta : float) -> void:
	player.fall(delta)

	var direction = Input.get_axis("l", "r")
	if direction:
		player.velocity.x = move_toward(player.velocity.x, direction * player.SPEED, player.AIR_ACCELERATION)
	else:
		player.velocity.x = move_toward(player.velocity.x, .0, player.AIR_DECELERATION)

func _go_down_cancel() -> void:
	player.set_collision_mask_value(1, true)
