extends BreakablePlatform

class_name BridgePodrido

var destroyed : bool = false

func _break_begin() -> void:
	super._break_begin()
	get_tree().call_group("ROOM_LISTENER", "room_listener_on_dramatic_event")
	destroyed = true
