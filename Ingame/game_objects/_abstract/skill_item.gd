extends Area2D

class_name SkillItem

@onready var sprite      : Sprite2D     = $sprite
@onready var light       : PointLight2D = $light

var catched : bool = false

func get_skill_name() -> String:
	return ""

func get_tip() -> String:
	return ""

func catch() -> void:
	disable()
	get_tree().call_group("HELP_TIPS", "show_text", get_tip())
	var tween : Tween = create_tween()
	tween.tween_property(sprite, "modulate", Color.WHITE, 1.0).from(Color(2.0, 2.0, 2.0, 1.0))

func disable() -> void:
	catched = true
	sprite.frame = 1
	light.energy = .5
	collision_layer = 0
	collision_mask = 0
