extends UIButton

var confirm_dialog_instance_template : PackedScene = preload("res://UI/confirm_dialog/confirm_dialog.tscn")
var confirm_dialog_instance          : ConfirmDialog

func _on_pressed() -> void:
	get_tree().call_group("MENU_SFX", "play_button")
	confirm_dialog_instance = confirm_dialog_instance_template.instantiate()
	confirm_dialog_instance.title = "Quit game?"
	confirm_dialog_instance.set_texts(
			"Press 'Quit' to close the game or 'Cancel' to return to menu.",
			"Quit", "Cancel")
	add_child(confirm_dialog_instance)
	confirm_dialog_instance.accepted.connect(_on_quit_confirmed)

func _on_quit_confirmed() -> void:
	get_tree().quit()

func _physics_process(_delta : float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		grab_focus()
