extends StateMachineState

@export var check_floor_ray_vector : Vector2 = Vector2.DOWN * 32.0

func enter() -> void:
	host.animation_playblack.travel(name)

func exit() -> void:
	pass

func step(delta : float) -> StateMachineState:

	if not host.is_on_floor():
		host.fall(delta)

	host.velocity.x = move_toward(host.velocity.x, .0, host.specs.deceleration)

	host.move_and_slide()
	
	if Input.is_action_just_released("d"): return get_parent().on_ground
	
	if Input.is_action_just_pressed("j") and _can_go_down():
		_go_down()
		return state_machine.on_air
		
	if host.damager.size(): return state_machine.on_damaged
	
	return self

func _can_go_down() -> bool:
	var query : PhysicsRayQueryParameters2D = PhysicsRayQueryParameters2D.new()
	query.from = host.global_position
	query.to = host.global_position + check_floor_ray_vector
	query.collide_with_bodies = true
	query.collide_with_areas = false
	query.collision_mask = 2 + 4096
	var result = host.space_state.intersect_ray(query)
	return result.size() == 0

func _go_down() -> void:
	host.set_collision_mask_value(1, false)
