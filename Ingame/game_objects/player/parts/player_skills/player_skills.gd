extends Node
class_name PlayerSkills

var double_jump : bool = false

func progress_listener_on_level_opened(_level_data : Dictionary) -> void:
	if not _level_data.has("player"): return
	double_jump = _level_data.player.skills.double_jump
