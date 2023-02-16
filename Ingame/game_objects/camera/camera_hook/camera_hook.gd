extends Node2D

class_name CameraHook

var target : Player
var rect   : Rect2

func enable(_player : Player):
	set_physics_process(true)
	target = _player
	global_position.x = clamp(target.global_position.x, rect.position.x, rect.position.x + rect.size.x)
	global_position.y = clamp(target.global_position.y, rect.position.y, rect.position.y + rect.size.y)

func disable():
	set_physics_process(false)
	
func _physics_process(delta):
	global_position.x = clamp(target.global_position.x, rect.position.x, rect.position.x + rect.size.x)
	global_position.y = clamp(target.global_position.y, rect.position.y, rect.position.y + rect.size.y)
	
func _ready():
	set_physics_process(false)

func set_rect(_rect):
	rect = _rect
