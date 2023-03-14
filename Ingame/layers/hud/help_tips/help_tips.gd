extends Control

@onready var saved_label   : PixelLabel = $saved_label
@onready var pad_sprite    : Sprite2D   = $pad_sprite
@onready var querty_sprite : Sprite2D   = $querty_sprite
@onready var text          : PixelLabel = $text

var text_tween : Tween

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

func show_text(_text : String) -> void:
	if text_tween: text_tween.kill()
	text.text = _text
	text.queue_redraw()
	text_tween = create_tween()
	text_tween.tween_property(text, "modulate:a", 1.0, 1.0).from(.0)
	text_tween.tween_interval(5.0)
	text_tween.tween_property(text, "modulate:a", .0, 5.0)

func hide_control() -> void:
	pad_sprite.hide_control()
	querty_sprite.hide_control()

func _ready() -> void:
	saved_label.hide()
