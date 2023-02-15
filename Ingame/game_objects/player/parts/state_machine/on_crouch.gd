extends StateMachineState

@export var check_floor_ray_vector : Vector2 = Vector2.DOWN * 32.0

@onready var player : Player = get_parent().get_parent()
@onready var space_state = player.get_world_2d().get_direct_space_state()

func enter() -> void:
	pass

func exit() -> void:
	pass

func step(delta : float) -> StateMachineState:

	if not player.is_on_floor():
		player.fall(delta)

	player.velocity.x = move_toward(player.velocity.x, .0, player.DECELERATION)

	player.move_and_slide()
	
	if Input.is_action_just_released("d"): return get_parent().on_ground
	
	if Input.is_action_just_pressed("j") and _can_go_down():
		_go_down()
		return get_parent().on_air
		
	if player.damager: return get_parent().on_damaged
	
	return self

func _can_go_down() -> bool:
	var query : PhysicsRayQueryParameters2D = PhysicsRayQueryParameters2D.new()
	query.from = player.global_position
	query.to = player.global_position + check_floor_ray_vector
	query.collide_with_bodies = true
	query.collide_with_areas = false
	query.collision_mask = 2 + 4096
	var result := space_state.intersect_ray(query)
	return result.size() == 0

func _go_down() -> void:
	player.set_collision_mask_value(1, false)
