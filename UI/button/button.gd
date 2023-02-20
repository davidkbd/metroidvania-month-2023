extends TextureButton
class_name UIButton
@tool

@onready var label = $label

@export var text : String = "" :
	get: return text
	set(value):
		if value == text: return
		text = value
		_update_text()

func _on_focus_entered():
	label.modulate = Color(1.5, 1.5, 1.5, 1.0)

func _on_focus_exited():
	label.modulate = Color.WHITE

func _update_text() -> void:
	if is_inside_tree():
		$label.text = text
		$label.queue_redraw()

func _ready() -> void:
	if not Engine.is_editor_hint():
		_update_text()
