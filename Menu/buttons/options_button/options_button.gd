extends UIButton

func _on_pressed() -> void:
	get_tree().call_group("MENU_SFX", "play_button")
	get_tree().call_group("MENU_LISTENER", "menu_listener_on_open_options_menu_pressed")

