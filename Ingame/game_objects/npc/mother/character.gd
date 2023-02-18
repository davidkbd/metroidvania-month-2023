extends Node2D

var value : int = 0

func update_data(_data : Dictionary) -> void:
	print("NPC LOADED DATA: ", _data)
	if _data.size() == 0:
		value = 0
	else:
		value = _data.value
	value += 1
	_update_data()

func _update_data() -> void:
	get_parent().update_instance_data({ "storeable": true, "value": value })

func _ready() -> void:
	_update_data()
