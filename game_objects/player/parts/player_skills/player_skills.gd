extends Node
class_name PlayerSkills

var data : Dictionary = {
	"double_jump": false
}

func initialize(_game_state : Dictionary) -> void:
	if not _game_state.has("player"): return
	var player_data = _game_state.player
	if player_data.has("skills"):
		data = player_data.skills

func set_skill_value(key : String, value : bool) -> void:
	data[key] = value
	get_tree().call_group("PROGRESS_LISTENER", "progress_listener_on_player_skills_updated", data)

func _get_value_from_data(_data : Dictionary, _key : String, _default):
	if _data.has(_key):
		return _data[_key]
	return _default
