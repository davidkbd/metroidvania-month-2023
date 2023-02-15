extends Node

class_name Settings

static func load_settings() -> void:
	_load_sfx_volume()
	_load_music_volume()

static func save_sfx_volume():
	var file = FileAccess.open(Directories.SETTINGS_PATH + "sfx-volume", FileAccess.WRITE)
	file.store_float(AudioServer.get_bus_volume_db(1))

static func save_music_volume():
	var file = FileAccess.open(Directories.SETTINGS_PATH + "music-volume", FileAccess.WRITE)
	file.store_float(AudioServer.get_bus_volume_db(2))

static func _load_sfx_volume() -> void:
	var file = FileAccess.open(Directories.SETTINGS_PATH + "sfx-volume", FileAccess.READ)
	if file:
		AudioServer.set_bus_volume_db(1, file.get_float())

static func _load_music_volume() -> void:
	var file = FileAccess.open(Directories.SETTINGS_PATH + "music-volume", FileAccess.READ)
	if file:
		AudioServer.set_bus_volume_db(2, file.get_float())
