extends Area2D

enum ControlType {
	L, R, INTERACT, JUMP
}

@export var control_type : ControlType = ControlType.INTERACT

func _on_body_entered(body : Player):
	get_tree().get_first_node_in_group("HELP_TIPS").show_control(_get_control_action())

func _on_body_exited(body : Player):
	get_tree().get_first_node_in_group("HELP_TIPS").hide_control()

func _get_control_action() -> String:
	match control_type:
		ControlType.L:
			return ControlInput.L_ACTIONS[ControlInput.configurated_control_mode]
		ControlType.R:
			return ControlInput.R_ACTIONS[ControlInput.configurated_control_mode]
		ControlType.INTERACT:
			return ControlInput.INTERACT_ACTIONS[ControlInput.configurated_control_mode]
		ControlType.JUMP:
			return ControlInput.JUMP_ACTIONS[ControlInput.configurated_control_mode]
	return ""

