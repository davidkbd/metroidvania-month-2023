extends Area2D

@export var disabled_seconds : float = 2.0

@onready var player : Player = get_parent()

var disable_area_tween : Tween
var hilight_tween : Tween

func disable_collision() -> void:
	set_collision_mask_value(4, false)

func enable_collision() -> void:
	set_collision_mask_value(4, true)

func disable_ignored_invulnerability_collision() -> void:
	set_collision_mask_value(14, false)

func enable_ignored_invulnerability_collision() -> void:
	set_collision_mask_value(14, true)

func reset() -> void:
	if disable_area_tween: disable_area_tween.kill()
	if hilight_tween: hilight_tween.kill()
	enable_collision()
	enable_ignored_invulnerability_collision()
	player.modulate = Color.WHITE

func _on_area_entered(area : Area2D) -> void:
	player.damager = area.get_damage_data()
	get_tree().call_group("PLAYER_LISTENER", "player_listener_on_damaged", player)

	_hilight_player()
	_temporal_invulnerability()

func _hilight_player() -> void:
	if hilight_tween: hilight_tween.kill()
	hilight_tween = create_tween()
	hilight_tween.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUINT) \
			.set_loops() \
			.tween_property(player, "modulate", Color(1.0, 1.0, 1.0, .5), .3) \
			.from(Color(1.5, 1.5, 1.5, 1))

func _temporal_invulnerability() -> void:
	disable_collision()
	if disable_area_tween: disable_area_tween.kill()
	disable_area_tween = create_tween()
	await disable_area_tween.tween_interval(disabled_seconds).finished
	enable_collision()
	if hilight_tween: hilight_tween.kill()
	player.modulate = Color.WHITE
