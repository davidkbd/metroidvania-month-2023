extends Node2D

class_name CameraHook

var target : Player
var rect   : Rect2

func enable(_player : Player) -> void:
	set_physics_process(true)
	target = _player
	_update_position()

func disable() -> void:
	set_physics_process(false)

func set_rect(_rect):
	rect = _rect

func _physics_process(_delta : float) -> void:
	_update_position()

func _update_position() -> void:
	global_position.x = clamp(target.global_position.x, rect.position.x, rect.position.x + rect.size.x)
	global_position.y = clamp(target.global_position.y, rect.position.y, rect.position.y + rect.size.y)

func _ready() -> void:
	set_physics_process(false)
