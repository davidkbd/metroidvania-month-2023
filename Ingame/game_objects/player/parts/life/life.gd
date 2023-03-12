extends Node

class_name PlayerLife

var value     : float
var max_value : int

func initialize(_game_state : Dictionary) -> void:
	if not _game_state.has("player"): return
	var player_data = _game_state.player
	if player_data.has("life"):
		max_value = _game_state.player.life.max_value
		value = _game_state.player.life.value
	else:
		max_value = 4
		value = max_value
	
	get_tree().call_group("PLAYER_LISTENER", "player_listener_on_life_updated", {
		"value": value,
		"max_value": max_value
	})

func is_died() -> bool:
	return value  <= .0

func increment_value(_q : float) -> void:
	set_value(value + _q)

func reset() -> void:
	set_value(max_value)

func set_value(_q : float) -> void:
	value = clamp(_q, -1, max_value)
	get_tree().call_group("PLAYER_LISTENER", "player_listener_on_life_updated", {
		"value": value,
		"max_value": max_value
	})

func set_max_life(_q : int) -> void:
	max_value = _q
	get_tree().call_group("PLAYER_LISTENER", "player_listener_on_life_updated", {
		"value": value,
		"max_value": max_value
	})
