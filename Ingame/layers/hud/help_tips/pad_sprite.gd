extends Sprite2D

var tween : Tween

func show_control(action : String) -> void:
	show()
	region_rect.position.x = _convert_action_to_region_position(action)
	if tween: tween.kill()
	tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "modulate:a", 1.0, .25)
	await tween.finished
	tween = null

func hide_control() -> void:
	if tween: tween.kill()
	tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "modulate:a", 0.0, 1.0)
	await tween.finished
	tween = null
	hide()

func _convert_action_to_region_position(_action : String) -> float:
	var r : float = .0
	match _action:
		"u": r = .0
		"A": r = 4.0
	return r  * 64.0

func _ready() -> void:
	modulate.a = .0
