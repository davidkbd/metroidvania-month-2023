@icon("res://Ingame/game_objects/room/autoadvance_area/icon.png")
@tool
extends Area2D
class_name AutoadvanceArea

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
enum Direction {
	UP, RIGHT, DOWN, LEFT
}

@export var fade_out_in : bool = true
@export var direction : Direction = Direction.RIGHT
@export var distance  : float     = 96.0

@onready var collider : CollisionShape2D = $collider

func _update_collider() -> void:
	if is_inside_tree():
		collider.scale = collider_size
		collider.position = collider_offset * 32.0

func _ready():
#	if not Engine.is_editor_hint():
	_update_collider()
