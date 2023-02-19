extends Node2D
class_name TextBox
@tool

@export_multiline var text = "holi holi holi holi holi ssssss ssss asdfasdf asdfasdfadsf aa  asdfads fasdf asdf aafasdf asdf holi holi holi holi holi holi holi holi holi holi holi holi aafasdf asdf aafasdf asdf aafasdf asdf aaasad asdffff aa comadreja ssdfgsdfg sdfgsdfg holi holi holi holi holi holi holi holi holi holi holi holi holi holi holi holi dfa adfasd fasdfad ad adfasdf dfadsf adsf asdf asdf asdfasdf adsf asdfadsf adf holi holi holi holi holi holi holi " :
	get: return text
	set(value):
		if value == text: return
		text = value
		_update(text)
@export var position_offset : Vector2 = Vector2.UP * 96.0
@export var animation_speed : float = 16.0

@export var border_textures : Array[Texture2D]


var text_tween : Tween

func _update(_text) -> void:
	if is_inside_tree():
		var text_height : int = $label.calc_size(text).y
		$border.texture = border_textures[clamp(text_height / 11 - 3, 0, border_textures.size() - 1)]
		$label.text = _text

func _animate() -> void:
	if text_tween: text_tween.kill
	text_tween = create_tween()
	text_tween.tween_method(_update_text_tween_method, 0, text.length(), text.length() / animation_speed)
	text_tween = null

func _update_text_tween_method(_text_length : int) -> void:
	_update(text.substr(0,_text_length))

func _center() -> void:
	var text_height : int = clamp($label.calc_size(text).y, 44.0, 1000.0)
	global_position.x = (640 - 400) / 2.0
	global_position.y = (360 - text_height - 32) / 2.0
	global_position += position_offset

func _ready():
	if not Engine.is_editor_hint():
		_animate()
		_center()

