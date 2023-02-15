extends Node

@export var beetle_template    : PackedScene

@export var min_time           : float = 2.0
@export var max_time           : float = 5.0

@export var height_offset      : float = -64.0

@export var max_beetles_ingame : int = 4

@onready var spawn_timer       : Timer = $spawn_timer
@onready var space_state       = get_tree().get_first_node_in_group("PLAYER").get_world_2d().get_direct_space_state()

@onready var min_height        : float = 0.0
@onready var max_height        : float = _calc_max_height()

func _calc_max_height() -> float:
	var height : float = -9999.0
	while height < .0:
		if _detect_platform(height):
			return height + height_offset
		height += 10.0
	return 0.0

func _detect_platform(height : float) -> bool:
	var query : PhysicsRayQueryParameters2D = PhysicsRayQueryParameters2D.new()
	query.from = Vector2(-1024.0, height)
	query.to =   Vector2(1024.0,  height)
	query.collide_with_bodies = true
	query.collide_with_areas = false
	query.collision_mask = 1
	var result = space_state.intersect_ray(query)
	return result.size() > 0

func _on_spawn_timer_timeout():
	_instance()
	spawn_timer.start(randf_range(min_time, max_time))

func _instance() -> void:
	var all_beetles = get_tree().get_nodes_in_group("BEETLE")
	if all_beetles.size() >= max_beetles_ingame: return
	var current_height : float = randf_range(min_height, max_height)
	var instance = beetle_template.instantiate()
	get_parent().add_child(instance)
	instance.direction = 1 if (randi() % 2) else -1
	instance.global_position.x = 320.0 * sign(-instance.direction)
	instance.global_position.y = current_height
	
	get_tree().call_group("PLAYER", "add_collision_exception_with", instance)
	
	for other in all_beetles:
		other.add_collision_exception_with(instance)
