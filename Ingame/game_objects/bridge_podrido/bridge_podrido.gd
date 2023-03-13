extends BreakablePlatform

func _break_begin() -> void:
	super._break_begin()
	get_tree().call_group("ROOM_LISTENER", "room_listener_on_dramatic_event")
	ProgressManager.game_state.bundle.bridge_podrido.destroyed = true

func _ready():
	if ProgressManager.game_state.bundle.bridge_podrido.destroyed:
		queue_free()
