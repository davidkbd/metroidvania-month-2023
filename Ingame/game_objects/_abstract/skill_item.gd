extends Area2D

class_name SkillItem

@onready var label       : PixelLabel = $label

var catched : bool = false

func get_skill_name() -> String:
	return ""

func get_tip() -> String:
	return ""

func catch() -> void:
	catched = true
	label.hide()
	collision_layer = 0
	collision_mask = 0
	get_tree().call_group("HELP_TIPS", "show_text", get_tip())
