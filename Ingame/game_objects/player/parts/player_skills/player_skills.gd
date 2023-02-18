extends Node
class_name PlayerSkills

var double_jump : bool = false

func progress_listener_on_game_state_loaded(_saved_state : Dictionary) -> void:
	if not _saved_state.has("player"): return
	double_jump = _saved_state.player.skills.double_jump
