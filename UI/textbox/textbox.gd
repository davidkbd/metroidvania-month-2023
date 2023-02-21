@tool
extends Node2D
class_name TextBox

signal text_animation_finished

@export_multiline var text = "" :
	get: return text
	set(value):
		if value == text: return
		text = value
		_update(text)
@export var position_offset : Vector2 = Vector2.UP * 96.0
@export var animation_speed : float = 16.0

@export var border_textures : Array[Texture2D]

@onready var viewport_size = Vector2i(
			ProjectSettings.get_setting("display/window/size/viewport_width"),
			ProjectSettings.get_setting("display/window/size/viewport_height")
			)

var text_tween : Tween

func terminate_animation() -> void:
	if text_tween: text_tween.kill()
	_update_text_tween_method(text.length())

func _update(_text) -> void:
	if is_inside_tree():
		var text_height : int = $label.calc_size(text).y
		$border.texture = border_textures[clamp(text_height / $label.CHAR_HEIGHT - 3, 0, border_textures.size() - 1)]
		$label.text = _text
		print(text_height / $label.CHAR_HEIGHT)

func _animate() -> void:
	if text_tween: text_tween.kill()
	text_tween = create_tween()
	text_tween.tween_method(_update_text_tween_method, 0, text.length(), text.length() / animation_speed)
	await text_tween.finished
	emit_signal("text_animation_finished")
	text_tween = null

func _update_text_tween_method(_text_length : int) -> void:
	_update(text.substr(0,_text_length))

func _center() -> void:
	var text_height : int = clamp($label.calc_size(text).y, 44.0, 1000.0)
	global_position.x = (viewport_size.x - 400.0) / 2.0
	global_position.y = (viewport_size.y - text_height - 32.0) / 2.0
	global_position += position_offset

func _ready():
	if not Engine.is_editor_hint():
		_animate()
		_center()

