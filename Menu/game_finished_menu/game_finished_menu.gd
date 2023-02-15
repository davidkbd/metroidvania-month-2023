extends Control

var quit_confirm : ConfirmationDialog

func _on_back_button_pressed():
	get_tree().call_group("MENU_SFX", "play_button_back")
	get_tree().call_group("MENU_LISTENER", "hud_listener_on_level_closed")
	get_tree().call_group("MENU_LISTENER", "menu_listener_on_open_principal_menu_pressed")

func _ready() -> void:
	$back_button.grab_focus()
	await get_tree().create_timer(1.0).timeout
	get_tree().call_group("LEVEL_LISTENER", "level_listener_on_ready", {})
