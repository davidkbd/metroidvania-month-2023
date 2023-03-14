extends Control

@onready var saved_label   : PixelLabel = $saved_label
@onready var pad_sprite    : Sprite2D   = $pad_sprite
@onready var querty_sprite : Sprite2D   = $querty_sprite
@onready var tip           : PixelLabel = $tip

var tip_tween : Tween

func progress_listener_on_progress_stored(_game_state : Dictionary) -> void:
	saved_label.show()
	$tip_sfx.play()
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
	if tip_tween: tip_tween.kill()
	tip.text = _text
	tip.queue_redraw()
	tip_tween = create_tween()
	tip_tween.tween_property(tip, "modulate:a", 1.0, 1.0).from(.0)
	tip_tween.tween_interval(5.0)
	tip_tween.tween_property(tip, "modulate:a", .0, 5.0)
	$tip_sfx.play()

func hide_control() -> void:
	pad_sprite.hide_control()
	querty_sprite.hide_control()

func _ready() -> void:
	saved_label.hide()
