extends Control

@onready var pad = $Pad

@onready var _silent := true

func _on_sfx_volume_value_changed(value : float):
	if _silent: return
	get_tree().call_group("MENU_SFX", "play_slider")
	var c_val = clamp(value, .001, 1.0)
	AudioServer.set_bus_volume_db(1, log(c_val) * 20.0)
	Settings.save_sfx_volume()

func _on_music_volume_value_changed(value):
	if _silent: return
	get_tree().call_group("MENU_SFX", "play_slider")
	var c_val = clamp(value, .001, 1.0)
	AudioServer.set_bus_volume_db(2, log(c_val) * 20.0)
	Settings.save_music_volume()

func _on_controls_value_changed(value):
	if _silent: return
	get_tree().call_group("MENU_SFX", "play_slider")
	ControlInput.configurated_control_mode = value
	pad.update_texts()

func _ready() -> void:
	$sfx_volume.grab_focus()
	$sfx_volume.value = exp(AudioServer.get_bus_volume_db(1) / 20)
	$music_volume.value = exp(AudioServer.get_bus_volume_db(2) / 20)
	_silent = false
