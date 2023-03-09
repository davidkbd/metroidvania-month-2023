extends Node2D
class_name NPC


@export_category("Talk Letter Label")
@export var talk_letter_label_offset : Vector2 = Vector2.UP * 128.0
@export var talk_letter_label_first_color : Color = Color.RED
@export var talk_letter_label_last_color : Color = Color.DARK_GOLDENROD
@export var talk_letter_label_shadow_color : Color = Color.DARK_SLATE_BLUE

@onready var help_tips = get_tree().get_first_node_in_group("HELP_TIPS")

@onready var talk_letter_label_packedscene : PackedScene = preload("res://UI/label/label.tscn")

var talk_letter_label_instance : Node2D
var player_target_relative_position : Vector2

func get_texts() -> Array[String]:
	return ["HOLI"]

func show_talk_letter() -> void:
	help_tips.show_control(ControlInput.INTERACT_ACTIONS[ControlInput.configurated_control_mode])
	if is_instance_valid(talk_letter_label_instance): talk_letter_label_instance.queue_free()
	talk_letter_label_instance = talk_letter_label_packedscene.instantiate()
	talk_letter_label_instance.text = "Talk"
	talk_letter_label_instance.bold = true
	talk_letter_label_instance.centered = true
	talk_letter_label_instance.vertical_centered = true
	talk_letter_label_instance.first_half_color = talk_letter_label_first_color
	talk_letter_label_instance.last_half_color = talk_letter_label_last_color
	talk_letter_label_instance.shadow_color = talk_letter_label_shadow_color
	add_child(talk_letter_label_instance)
	talk_letter_label_instance.global_position = global_position + talk_letter_label_offset

func hide_talk_letter() -> void:
	help_tips.hide_control()
	if is_instance_valid(talk_letter_label_instance): talk_letter_label_instance.queue_free()

func _instance_area() -> void:
	var area : Area2D = Area2D.new()
	var col : CollisionShape2D = CollisionShape2D.new()
	var col_shape : RectangleShape2D = RectangleShape2D.new()
	area.add_child(col)
	area.monitoring = false
	area.monitorable = true
	area.collision_mask = 0
	area.collision_layer = 32
	col.shape = col_shape
	col_shape.size = Vector2(160.0, 64.0)
	call_deferred("add_child", area)
	area.position = Vector2.ZERO
	
	player_target_relative_position = Vector2.LEFT * 72.0

func _ready() -> void:
	_instance_area()
