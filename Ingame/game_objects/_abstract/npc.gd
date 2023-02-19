extends Node2D
class_name NPC

var player_target_relative_position : Vector2

func get_texts() -> Array[String]:
	return ["HOLI"]

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
