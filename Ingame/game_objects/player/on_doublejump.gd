extends StateMachineState

@onready var player : Player = get_parent().get_parent()

func enter() -> void:
	player.jump_sfx.play()
	player.velocity.y = player.DOUBLEJUMP_IMPULSE
	if player.cube_is_full:
		player.drop_cube()

func exit() -> void:
	pass

func step(delta : float) -> StateMachineState:
	if player.go_down_floor_sensor.is_colliding(): _go_down_cancel()

	_jump(delta)

	player.move_and_slide()

	if player.is_on_floor(): return get_parent().on_ground
	if player.enemy_died: return get_parent().on_enemybounce
	if player.damager: return get_parent().on_damaged
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
