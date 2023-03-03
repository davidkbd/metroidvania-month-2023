@icon("res://Ingame/game_objects/room/restart_point/icon.png")
@tool
extends Area2D
class_name RestartPointArea

@onready var collider : CollisionShape2D = $collider

@export var collider_size : Vector2i = Vector2i.ONE * 4 :
	get:
		return collider_size
	set(value):
		if collider_size == value: return
		collider_size = value
		_update_collider()

@export var collider_offset : Vector2i = Vector2i.ZERO :
	get:
		return collider_offset
	set(value):
		if collider_offset == value: return
		collider_offset = value
		_update_collider()

func _update_collider() -> void:
	if is_inside_tree():
		collider.scale = collider_size
		collider.position = collider_offset * 32.0

func _ready():
#	if not Engine.is_editor_hint():
	_update_collider()
