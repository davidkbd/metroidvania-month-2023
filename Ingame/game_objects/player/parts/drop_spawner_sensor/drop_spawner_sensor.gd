extends Area2D

@onready var space_state = get_world_2d().get_direct_space_state()

@onready var object_inside = null

func is_spawner_detected() -> bool:
	if object_inside == null: return false
	var query : PhysicsRayQueryParameters2D = PhysicsRayQueryParameters2D.new()
	query.from = global_position
	query.to = object_inside.global_position
	query.collide_with_bodies = true
	query.collide_with_areas = true
	query.collision_mask = collision_mask + 1
	query.exclude = [get_rid(), get_parent().get_rid()]
	var result := space_state.intersect_ray(query)
	if result.size() == 0: return false
	return not result.collider is StaticBody2D

func _on_body_entered(_body):
	object_inside = _body

func _on_body_exited(_body):
	object_inside = null

func _on_area_entered(_area):
	object_inside = _area

func _on_area_exited(_area):
	object_inside = null
