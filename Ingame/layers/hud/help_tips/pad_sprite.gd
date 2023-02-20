extends Sprite2D

var tween : Tween

func show_pad(pad : int) -> void:
	show()
	region_rect.position.x = pad * 32.0
	if tween: tween.kill()
	tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "modulate:a", 1.0, .25)
	await tween.finished
	tween = null

func hide_pad() -> void:
	if tween: tween.kill()
	tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "modulate:a", 0.0, 1.0)
	await tween.finished
	tween = null
	hide()

func _ready() -> void:
	modulate.a = .0
