extends UIButton

var quit_confirm : ConfirmationDialog

func _on_pressed() -> void:
	get_tree().call_group("MENU_SFX", "play_button")
	quit_confirm = ConfirmationDialog.new()
	add_child(quit_confirm)
	quit_confirm.title = "Quit game?"
	quit_confirm.ok_button_text = "Quit"
	quit_confirm.cancel_button_text = "Cancel"
	quit_confirm.dialog_text = "Press Quit to close the game or Cancel to return to menu."
	quit_confirm.connect("confirmed", _on_quit_confirmed)
	quit_confirm.connect("cancelled", _on_quit_cancelled)
	quit_confirm.popup_centered()
	quit_confirm.get_cancel_button().grab_focus()

func _on_quit_confirmed() -> void:
	get_tree().quit()

func _on_quit_cancelled() -> void:
	get_tree().call_group("MENU_SFX", "play_button")
	quit_confirm.queue_free()
