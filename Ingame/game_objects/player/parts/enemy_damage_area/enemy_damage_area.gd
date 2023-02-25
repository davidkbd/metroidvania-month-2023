extends Area2D

@export var disabled_seconds : float = .4

@onready var default_collision_mask = collision_mask

var disable_area_tween : Tween

func _on_area_entered(area : Area2D) -> void:
	get_parent().damager = area.get_damage_data()
	collision_mask = 0
	if disable_area_tween: disable_area_tween.kill()
	disable_area_tween = create_tween()
	await disable_area_tween.tween_interval(disabled_seconds).finished
	collision_mask = default_collision_mask
