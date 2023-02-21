extends UIButton

func _on_pressed() -> void:
	get_tree().call_group("MENU_SFX", "play_button_back")
	get_tree().call_group("MENU_LISTENER", "menu_listener_on_open_principal_menu_pressed")

func _physics_process(_delta : float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		grab_focus()
