extends NPC

var value : int = 0

func update_room_data(_data : Dictionary) -> void:
	print("NPC LOADED DATA: ", _data)
	if _data.size() == 0:
		value = 0
	else:
		value = _data.value
	value += 1
	_update_room_data()

func get_texts() -> Array[String]:
	return [
		"HOLA AMIGOS",
		"Que se te acontece asdfkajsdh kajdf\njaksdfkajdfasdf\noasda dsf asdfsdfasd asdfasdf asdf asd fasdfa sdfa sdfa sdf afjadfkj",
		"HOLA AMIGOS"
	]

func _update_room_data() -> void:
	get_parent().update_instance_data({ "storeable": true, "value": value })

func _ready() -> void:
	super._ready()
	_update_room_data()
