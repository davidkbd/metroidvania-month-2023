extends Control

@onready var saved_label   : PixelLabel = $saved_label
@onready var pad_sprite    : Sprite2D   = $pad_sprite
@onready var querty_sprite : Sprite2D   = $querty_sprite

func progress_listener_on_progress_stored(_game_state : Dictionary) -> void:
	saved_label.show()
	var tween = create_tween().tween_interval(1.0)
	await tween.finished
	saved_label.hide()

func show_control(action : String) -> void:
	if Input.get_connected_joypads().size() > 0:
		pad_sprite.show_control(action)
		querty_sprite.hide()
	else:
		querty_sprite.show_control(action)
		pad_sprite.hide()

func hide_control() -> void:
	pad_sprite.hide_control()
	querty_sprite.hide_control()

func _ready() -> void:
	saved_label.hide()
