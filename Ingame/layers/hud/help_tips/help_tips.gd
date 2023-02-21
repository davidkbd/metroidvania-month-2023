extends Control

@onready var saved_label : PixelLabel = $saved_label
@onready var pad_sprite  : Sprite2D   = $pad_sprite

func progress_listener_on_progress_stored(_game_state : Dictionary) -> void:
	saved_label.show()
	var tween = create_tween().tween_interval(1.0)
	await tween.finished
	saved_label.hide()

func show_pad(pad : int) -> void:
	pad_sprite.show_pad(pad)

func hide_pad() -> void:
	pad_sprite.hide_pad()

func _ready() -> void:
	saved_label.hide()
