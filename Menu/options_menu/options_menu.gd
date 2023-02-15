extends Control

@onready var _silent := true

func _on_sfx_volume_value_changed(value : float):
	if _silent: return
	get_tree().call_group("MENU_SFX", "play_slider")
	AudioServer.set_bus_volume_db(1, linear_to_db(value))
	Settings.save_sfx_volume()

func _on_music_volume_value_changed(value):
	if _silent: return
	get_tree().call_group("MENU_SFX", "play_slider")
	AudioServer.set_bus_volume_db(2, linear_to_db(value))
	Settings.save_music_volume()

func _on_back_button_pressed():
	get_tree().call_group("MENU_SFX", "play_button_back")
	get_tree().call_group("MENU_LISTENER", "menu_listener_on_open_principal_menu_pressed")

func _ready() -> void:
	$sfx_volume.grab_focus()
	$sfx_volume.value = db_to_linear(AudioServer.get_bus_volume_db(1))
	$music_volume.value = db_to_linear(AudioServer.get_bus_volume_db(2))
	_silent = false
