extends StateMachineState

@onready var beetle : Beetle = get_parent().get_parent()

func enter() -> void:
	beetle.die_sfx.play()
	var tween : Tween = get_tree().create_tween().bind_node(beetle)
	beetle.modulate = Color.WHITE * 4.0
	beetle.modulate.a = 1.0
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(beetle, "modulate", Color.WHITE, .1)
	tween.parallel()
	tween.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_BACK)
	tween.tween_property(beetle, "scale", Vector2.ZERO, .25).set_delay(.2)
	await tween.finished
	beetle.queue_free()

func exit() -> void:
	pass

func step(_delta : float) -> StateMachineState:
	return self
