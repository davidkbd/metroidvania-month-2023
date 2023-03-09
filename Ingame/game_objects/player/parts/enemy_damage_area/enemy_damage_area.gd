extends Area2D

@export var disabled_seconds : float = .5

@onready var default_collision_mask = collision_mask
@onready var player : Player = get_parent()

var disable_area_tween : Tween

func disable_collision() -> void:
	collision_mask = 0

func enable_collision() -> void:
	collision_mask = default_collision_mask

func _on_area_entered(area : Area2D) -> void:
	player.damager = area.get_damage_data()
	get_tree().call_group("PLAYER_LISTENER", "player_listener_on_damaged", player)

	if player.damager.enable_invulnerability:
		disable_collision()
		if disable_area_tween: disable_area_tween.kill()
		disable_area_tween = create_tween()
		await disable_area_tween.tween_interval(disabled_seconds).finished
		enable_collision()
