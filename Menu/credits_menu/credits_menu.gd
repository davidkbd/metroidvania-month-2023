extends Control

var quit_confirm : ConfirmationDialog

func _on_back_button_pressed():
	get_tree().call_group("MENU_SFX", "play_button_back")
	get_tree().call_group("MENU_LISTENER", "menu_listener_on_open_principal_menu_pressed")

func _ready() -> void:
	$back_button.grab_focus()
