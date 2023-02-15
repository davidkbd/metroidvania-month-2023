extends StateMachineState

@onready var player : Player = get_parent().get_parent()

var damage_timer : float

func enter() -> void:
	player.damaged_sfx.play()
	if is_instance_valid(player.damager):
		player.velocity.y = player.DAMAGE_IMPULSE
		player.velocity.x = player.DAMAGE_IMPULSE * sign(player.damager.global_position.x - player.global_position.x)
		if player.cube_is_full:
			player.drop_cube()
		damage_timer = .1
	player.damager = null

func exit() -> void:
	pass

func step(delta : float) -> StateMachineState:
	if player.go_down_floor_sensor.is_colliding(): _go_down_cancel()
	if player.damager: enter()

	player.fall(delta)
	player.velocity.x = move_toward(player.velocity.x, .0, player.DAMAGE_DECELERATION)

	damage_timer -= delta
	player.move_and_slide()

	if damage_timer < .0 and player.is_on_floor(): return get_parent().on_ground
	return self

func _go_down_cancel() -> void:
	player.set_collision_mask_value(1, true)
