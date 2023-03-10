extends Area2D

@export var disabled_seconds : float = .5

@onready var player : Player = get_parent()

var disable_area_tween : Tween

func disable_collision() -> void:
	set_collision_mask_value(4, false)

func enable_collision() -> void:
	set_collision_mask_value(4, true)

func _on_area_entered(area : Area2D) -> void:
	player.damager = area.get_damage_data()
	get_tree().call_group("PLAYER_LISTENER", "player_listener_on_damaged", player)

	disable_collision()
	if disable_area_tween: disable_area_tween.kill()
	disable_area_tween = create_tween()
	await disable_area_tween.tween_interval(disabled_seconds).finished
	enable_collision()
