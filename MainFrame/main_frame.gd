extends Node

func _ready() -> void:
	randomize()
	Directories.create()
	Settings.load_settings()
