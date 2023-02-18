extends Node
class_name PlayerSkills

var double_jump : bool = false

func progress_listener_on_game_state_loaded(_game_state : Dictionary) -> void:
	print("Se han de caragar los skills del player")
	if not _game_state.has("player"): return
	double_jump = _game_state.player.skills.double_jump
