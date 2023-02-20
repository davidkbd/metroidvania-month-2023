extends Node
class_name PlayerSkills

var double_jump : bool = false

func initialize(_game_state : Dictionary) -> void:
	if not _game_state.has("player"): return
	var player_data = _game_state.player
	if player_data.has("skills"):
		_initialize_skills(player_data.skills)

func set_skill_double_jump(value : bool) -> void:
	double_jump = value
	_update_skills_data()

func _initialize_skills(_skills_data : Dictionary) -> void:
	double_jump = _get_value_from_data(_skills_data, "double_jump", false)

func _update_skills_data() -> void:
	get_tree().call_group("PROGRESS_LISTENER", "progress_listener_on_player_skills_updated", {
		"double_jump": double_jump
	})

func _get_value_from_data(_data : Dictionary, _key : String, _default):
	if _data.has(_key):
		return _data[_key]
	return _default
