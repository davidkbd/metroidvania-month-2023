extends StateMachineState

#@export var raycast_direction        : Vector2 = Vector2.LEFT * 32.0

func enter() -> void:
	host.animation_playblack.travel(name)
	call_deferred("_choose_direction")
	state_machine.start_idle_patrol_switch_timer()

func exit() -> void:
	pass
	
func step(delta : float) -> StateMachineState:
	if not _can_walk():
		host.set_walk_direction(-host.walk_direction)
	_movement()
	host.fall(delta)
	host.move_and_slide()
	if host.player : return state_machine.on_chase
	if host.life <= 0: return state_machine.on_die
	if state_machine.idle_patrol_timer_flag: return state_machine.on_idle
	return self

func _movement():
	if host.walk_direction:
		host.velocity.x = move_toward(host.velocity.x, host.walk_direction * host.specs.speed, host.specs.acceleration)
	else:
		host.velocity.x = move_toward(host.velocity.x, .0, host.specs.deceleration)

func _choose_direction():
	host.set_walk_direction(-1.0 if randi()%2 == 0 else -1.0)

func _can_walk() -> bool:
	if not host.floor_sensor.is_colliding(): return false
	return not host.wall_sensor.is_colliding()
#	var query : PhysicsRayQueryParameters2D = PhysicsRayQueryParameters2D.new()
#	var my_position = host.center.global_position
#	query.from = my_position
#	query.to = my_position + raycast_direction * Vector2.LEFT * host.walk_direction
#	query.collide_with_bodies = true
#	query.collide_with_areas = false
#	query.collision_mask = 1
#	var result = host.space_state.intersect_ray(query)
#	return result.size() == 0

