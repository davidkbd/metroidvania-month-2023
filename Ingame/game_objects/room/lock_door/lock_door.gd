extends StaticBody2D

@onready var door_top_sprite : Sprite2D = $Sprite2DTop
@onready var door_bot_sprite : Sprite2D = $Sprite2DBot

var door_anim_tween : Tween

func room_listener_on_activated(room : Room) -> void:
	if room.is_any_enemy_alive():
		_close()

func room_listener_on_cleared(room : Room) -> void:
	_open()

func room_listener_on_deactivated() -> void:
	_open()

func _open():
	if door_anim_tween: door_anim_tween.kill()
	door_anim_tween = create_tween()
	door_anim_tween.tween_interval(0.5)
	door_anim_tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	door_anim_tween.tween_property(door_bot_sprite, "position:y", 0.0, 1.0)
	door_anim_tween.parallel().tween_property(door_top_sprite, "position:y", -198.0, 1.0)
	await door_anim_tween.finished
	set_collision_layer_value(1, false)
	set_collision_layer_value(11, false)
	
func _close():
	if door_anim_tween: door_anim_tween.kill()
	set_collision_layer_value(1, true)
	set_collision_layer_value(11, true)
	door_anim_tween = create_tween()
	door_anim_tween.tween_interval(0.5)
	door_anim_tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BOUNCE)
	door_anim_tween.tween_property(door_bot_sprite, "position:y", -64.0, 1.0)
	door_anim_tween.parallel().tween_property(door_top_sprite, "position:y", -134.0, 1.0)

