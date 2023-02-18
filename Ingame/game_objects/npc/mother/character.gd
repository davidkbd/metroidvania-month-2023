extends Node2D

func update_data(_data : Dictionary) -> void:
	pass

func _ready() -> void:
	get_parent().update_instance_data({ "HOLI": "HOLI" })
