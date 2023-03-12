@tool
extends Area2D
class_name ControlDisableArea

@export var collider_size : Vector2i = Vector2i.ONE * 4 :
	get:
		return collider_size
	set(value):
		if collider_size == value: return
		collider_size = value
		_update_collider()

@onready var collider : CollisionShape2D = $collider

func _on_body_entered(body : Player):
	ControlInput.disable()

func _on_body_exited(body):
	ControlInput.enable()

func _update_collider() -> void:
	if is_inside_tree():
		collider.scale = collider_size

func _ready():
#	if not Engine.is_editor_hint():
	_update_collider()
