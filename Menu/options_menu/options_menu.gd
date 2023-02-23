extends Control

@onready var pad = $Pad

@onready var _silent := true

func _on_sfx_volume_value_changed(value : float):
	if _silent: return
	get_tree().call_group("MENU_SFX", "play_slider")
#	AudioServer.set_bus_volume_db(1, linear_to_db(value))
	AudioServer.set_bus_volume_db(1, log(value) * 20.0)
	Settings.save_sfx_volume()

func _on_music_volume_value_changed(value):
	if _silent: return
	get_tree().call_group("MENU_SFX", "play_slider")
#	AudioServer.set_bus_volume_db(2, linear_to_db(value))
	AudioServer.set_bus_volume_db(2, log(value) * 20.0)
	Settings.save_music_volume()

func _on_controls_value_changed(value):
	if _silent: return
	get_tree().call_group("MENU_SFX", "play_slider")
	ControlInput.configurated_control_mode = value
	pad.update_texts()

func _ready() -> void:
	$sfx_volume.grab_focus()
	$sfx_volume.value = db_to_linear(AudioServer.get_bus_volume_db(1))
	$music_volume.value = db_to_linear(AudioServer.get_bus_volume_db(2))
	_silent = false
