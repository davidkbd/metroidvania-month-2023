extends Window
class_name ConfirmDialog

signal accepted
signal cancelled

func set_texts(_text : String, _accept_button_text : String = "OK", _cancel_button_text : String = "Cancel") -> void:
	$label.text = _text
	$buttons/accept_button.text = _accept_button_text
	$buttons/cancel_button.text = _cancel_button_text

func _on_accept_button_pressed():
	get_tree().call_group("MENU_SFX", "play_slider")
	emit_signal("accepted")
	queue_free()
	get_tree().paused = false

func _on_cancel_button_pressed():
	get_tree().call_group("MENU_SFX", "play_button_back")
	emit_signal("cancelled")
	queue_free()
	get_tree().paused = false

func _physics_process(_delta : float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		$buttons/cancel_button.grab_focus()

func _ready() -> void:
	popup_centered(Vector2(200, 100))
	$buttons/cancel_button.grab_focus()
	get_tree().paused = true
