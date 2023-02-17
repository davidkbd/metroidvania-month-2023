extends Area2D

class_name RoomArea

# Cuidado, si este size es mayor que los los margenes del area de sala
# se puede llegar a mover la camara antes de entrar en la siguiente sala
# la camara se movera pero el hook no se activara
@export var margin : Vector2 = Vector2.ONE * 8.0

@onready var room_area_manager : RoomAreaManager = get_tree().get_first_node_in_group("ROOM_AREA_MANAGER")
@onready var room              : Room            = get_parent()

@onready var hook : Node2D = $camera_hook

func enable_camera_hook() -> void:
	room_area_manager.camera_request(hook)
	
func disable_camera_hook() -> void:
	room_area_manager.camera_unrequest(hook)

func enable_room() -> void:
	room_area_manager.room_activate(room)
	
func disable_room() -> void:
	room_area_manager.room_deactivate(room)

func _configure_hook() -> void:
	var col  : CollisionShape2D = get_node("CollisionShape2D")
	var rect : Rect2 = col.shape.get_rect()
	rect.size.x -= get_viewport().size.x
	rect.size.y -= get_viewport().size.y
	rect.size += margin * 2.0
	rect.position += col.global_position + get_viewport().size / 2.0
	rect.position -= margin
	hook.set_rect(rect)

func _ready() -> void:
	call_deferred("_configure_hook")
