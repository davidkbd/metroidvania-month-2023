extends StateMachineState


@export var plant_detection_vector : Vector2 = Vector2.RIGHT * 18.0
@export var obstacle_detection_vector : Vector2 = Vector2.RIGHT * 32.0

@onready var beetle : Beetle = get_parent().get_parent()

@onready var space_state = beetle.get_world_2d().get_direct_space_state()

var coyote_timer : float

func enter() -> void:
	pass

func exit() -> void:
	pass

func step(_sdelta : float) -> StateMachineState:
	if _obstacle_detection(): beetle.direction *= -1
	
	beetle.velocity.x = move_toward(beetle.velocity.x, beetle.direction * beetle.SPEED, beetle.ACCELERATION)

	if beetle.velocity.x > .0:
		beetle.sprite.flip_h = true
	elif beetle.velocity.x < .0:
		beetle.sprite.flip_h = false

	beetle.move_and_slide()

	if not beetle.is_on_floor(): return get_parent().on_air
	if beetle.is_marked_to_die: return get_parent().on_died
	if _plant_detection(): return get_parent().on_eating
	if beetle.hitting_player: return get_parent().on_attack

	return self

func _plant_detection() -> bool:
	var query : PhysicsRayQueryParameters2D = PhysicsRayQueryParameters2D.new()
	query.from = beetle.global_position
	query.to = beetle.global_position + plant_detection_vector * beetle.direction
	query.collide_with_bodies = false
	query.collide_with_areas = true
	query.collision_mask = 8192
	var result := space_state.intersect_ray(query)
	if result.size() == 0: return false
	beetle.plant = result.collider.get_parent().get_parent()
	return true

func _obstacle_detection() -> bool:
	var query : PhysicsRayQueryParameters2D = PhysicsRayQueryParameters2D.new()
	query.from = beetle.global_position
	query.to = beetle.global_position + obstacle_detection_vector * beetle.direction
	query.collide_with_bodies = true
	query.collide_with_areas = false
	query.collision_mask = 1
	var result := space_state.intersect_ray(query)
	if result.size() == 0: return false
	return result.collider is StaticBody2D
