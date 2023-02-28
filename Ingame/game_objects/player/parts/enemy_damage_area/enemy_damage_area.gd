extends Area2D

@export var disabled_seconds : float = .2

@onready var default_collision_mask = collision_mask

var disable_area_tween : Tween

func disable_collision() -> void:
	collision_mask = 0

func enable_collision() -> void:
	collision_mask = default_collision_mask

func _on_area_entered(area : Area2D) -> void:
	get_parent().damager = area.get_damage_data()
	disable_collision()
	if disable_area_tween: disable_area_tween.kill()
	disable_area_tween = create_tween()
	await disable_area_tween.tween_interval(disabled_seconds).finished
	enable_collision()
