extends Node
class_name PlayerSkills

var data : Dictionary = {
	"super_attack": false,
	"double_jump": false,
	"dash": false,
	"snap_wall": false
}

func initialize(_game_state : Dictionary) -> void:
	if not _game_state.has("player"): return
	var player_data = _game_state.player
	if player_data.has("skills"):
		data = player_data.skills
	get_tree().call_group("PLAYER_LISTENER", "player_listener_on_skills_updated", data)

func set_skill_value(key : String, value : bool) -> void:
	data[key] = value
	get_tree().call_group("PLAYER_LISTENER", "player_listener_on_skills_updated", data)
