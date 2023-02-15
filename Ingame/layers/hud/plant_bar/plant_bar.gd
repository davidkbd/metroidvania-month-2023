extends Control

@export var color_ramp : Gradient
@export var color_transition_seconds : float = 1.0
@export var drop_count_transition_seconds : float = 1.0

@onready var statusbar : ColorRect = $statusbar

var drop_count_tween : Tween
var health_tween     : Tween
var plant            : Plant

func plant_listener_on_ready(new_plant : Plant) -> void:
	plant = new_plant
	_update_drop_count()
	_update_health()

func plant_listener_on_got_water() -> void:
	if plant.drop_count >= plant.max_drop_count:
		get_tree().call_group("HUD_LISTENER", "hud_listener_on_level_finished")
	else:
		_update_drop_count()

func plant_listener_on_health_changed() -> void:
	if (plant.health <= .0):
		get_tree().call_group("HUD_LISTENER", "hud_listener_on_level_finished")
	else:
		_update_health()

func _update_drop_count() -> void:
	if plant.max_drop_count < .1: return
	if drop_count_tween: drop_count_tween.kill()
	drop_count_tween = get_tree().create_tween().bind_node(self)
	drop_count_tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	drop_count_tween.tween_property(statusbar, "anchor_right", float(plant.drop_count) / float(plant.max_drop_count), drop_count_transition_seconds)

func _update_health() -> void:
	if health_tween: health_tween.kill()
	health_tween = get_tree().create_tween().bind_node(self)
	health_tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	health_tween.tween_property(self, "modulate", color_ramp.sample(plant.health), color_transition_seconds)
