extends StateMachineState

@export var raycast_origin_position      : Vector2 = Vector2.UP * 32.0
@export var raycast_destination_position : Vector2 = Vector2.UP * 32.0 + Vector2.LEFT * 32.0

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
	if state_machine.idle_patrol_timer_flag: return state_machine.on_idle
	return self

func _movement():
	if host.walk_direction:
		host.velocity.x = move_toward(host.velocity.x, host.walk_direction * host.speed * 0.1, host.acceleration)
	else:
		host.velocity.x = move_toward(host.velocity.x, .0, host.deceleration)

func _choose_direction():
	host.set_walk_direction(-1.0 if randi()%2 == 0 else -1.0)

func _can_walk() -> bool:
	var query : PhysicsRayQueryParameters2D = PhysicsRayQueryParameters2D.new()
	query.from = host.global_position + raycast_origin_position
	query.to = host.global_position + raycast_destination_position * Vector2.LEFT * host.walk_direction
	query.collide_with_bodies = true
	query.collide_with_areas = false
	query.collision_mask = 1
	var result = host.space_state.intersect_ray(query)
	return result.size() == 0

