extends Control

@onready var map_sprite : Sprite2D = $map_sprite
var tween : Tween

func room_listener_on_hooked(room) -> void:
	if tween: tween.kill()
	tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	tween.tween_property(map_sprite, "position", -room.global_position * .1, .75)
