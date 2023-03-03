extends Node2D

class_name CameraHook

var target  : Player
var pos_ini : Vector2
var pos_end : Vector2

var target_offset : Vector2

func enable(_player : Player) -> void:
	set_physics_process(true)
	target = _player
	_update_position()
	target_offset = Vector2.ZERO

func disable() -> void:
	set_physics_process(false)

func set_rect(_rect : Rect2):
	pos_ini = _rect.position
	pos_end = pos_ini + _rect.size

func _physics_process(_delta : float) -> void:
	if ControlInput.is_up_pressed():
		target_offset.y = -156.0
	elif ControlInput.is_down_pressed():
		target_offset.y = 192.0
	else:
		target_offset.y = .0
	_update_position()

func _update_position() -> void:
	global_position.x = clamp(target.global_position.x,                   pos_ini.x, pos_end.x)
	global_position.y = clamp(target.global_position.y + target_offset.y, pos_ini.y, pos_end.y)

func _ready() -> void:
	set_physics_process(false)
