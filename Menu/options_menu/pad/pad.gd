extends Sprite2D

func update_texts() -> void:
	for opt in get_children():
		opt.text = _get_texts(opt.name)
		opt.queue_redraw()

func _get_texts(name : String) -> String:
	var r = ""
	var configuration = ControlInput.configurated_control_mode
	if ControlInput.U_ACTIONS[configuration] == name:          r += "\nLook up"
	if ControlInput.D_ACTIONS[configuration] == name:          r += "\nLook down"
	if ControlInput.L_ACTIONS[configuration] == name \
	or ControlInput.R_ACTIONS[configuration] == name:          r += "\nMovement"
	if ControlInput.JUMP_ACTIONS[configuration] == name:       r += "\nJump"
	if ControlInput.DOUBLEJUMP_ACTIONS[configuration] == name: r += "\nDouble Jump"
	if ControlInput.DASH_ACTIONS[configuration] == name:       r += "\nDash"
	if ControlInput.ATTACK_ACTIONS[configuration] == name:     r += "\nAttack"
	if ControlInput.INTERACT_ACTIONS[configuration] == name:   r += "\nInteract"
	if ControlInput.PASS_TEXT_ACTIONS[configuration] == name:  r += "\nPass texts"
	if ControlInput.MAP_ACTIONS[configuration] == name:        r += "\nMap"
	if ControlInput.MENU_ACTIONS[configuration] == name:       r += "\nMenu"
	return r.trim_prefix("\n")
