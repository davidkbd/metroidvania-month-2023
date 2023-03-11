extends StateMachineState

func enter() -> void:
	host.animation_playblack.travel(name)

func exit() -> void:
	pass

func step(delta : float) -> StateMachineState:
	if host.life <= 0: return state_machine.on_die
	if not host.player : return state_machine.on_comeback
	_choose_direction()
	_movement()
	host.fall(delta)
	if host.wall_sensor.is_colliding():
		if host.wall_top_sensor.is_colliding():
			return state_machine.on_comeback
		else:
			_jump()
	host.move_and_slide()
	if _i_can_see_the_player() and host.is_on_floor() and host.player.global_position.distance_to(host.center.global_position) < host.specs.attack_distance: 
		return state_machine.on_attack
	return self

func _movement():
#	if not host.floor_sensor.is_colliding():
#		host.velocity.x = .0
#	el
	if host.walk_direction:
		host.velocity.x = move_toward(host.velocity.x, host.walk_direction * host.specs.speed, host.specs.acceleration)
	else:
		host.velocity.x = move_toward(host.velocity.x, .0, host.specs.deceleration)
	
func _choose_direction():
	host.set_walk_direction(sign(host.player.global_position.x - host.global_position.x))

func _jump() -> void:
	if host.is_on_floor():
		host.velocity.y = -host.specs.jump

func _i_can_see_the_player() -> bool:
	var query : PhysicsRayQueryParameters2D = PhysicsRayQueryParameters2D.new()
	var my_position = host.center.global_position
	query.from = host.center.global_position
	query.to = host.player.global_position
	query.collide_with_bodies = true
	query.collide_with_areas = false
	query.collision_mask = 8 # player-enemies
	var result = host.space_state.intersect_ray(query)
	return result.size() > 0

