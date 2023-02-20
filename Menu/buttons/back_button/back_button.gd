extends UIButton

func _on_pressed() -> void:
	get_tree().call_group("MENU_SFX", "play_button_back")
	get_tree().call_group("MENU_LISTENER", "menu_listener_on_open_principal_menu_pressed")

