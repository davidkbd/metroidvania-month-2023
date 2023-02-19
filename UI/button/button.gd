extends TextureButton
class_name UIButton

@onready var label = $label

func _on_focus_entered():
	label.modulate = Color(1.5, 1.5, 1.5, 1.0)

func _on_focus_exited():
	label.modulate = Color.WHITE
