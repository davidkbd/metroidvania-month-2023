extends Camera2D
class_name FollowTargetCamera

@export var offset_position : Vector2 = Vector2.UP * 24.0

@onready var target : Node2D = get_tree().get_first_node_in_group("PLAYER")

var requested_target : Node2D

var target_position  : Vector2
var distance         : float
var delta_speed      : float

func request(_target : Node2D) -> void:
	print("REQ ", _target.get_path())
	requested_target = _target
	if target == null or not target is CameraHook:
		set_target(_target)

func unrequest(_target : Node2D) -> bool:
	print("UNREQ ", _target.get_path())
	if _target == requested_target: return false
	target = requested_target
	return true

func set_target(_target : Node2D) -> void:
	target = _target

func teleport() -> void:
	target_position = target.global_position

func _process(_delta : float) -> void:
	distance = clamp(target_position.distance_to(target.global_position), 1.0, 150.0) / 5.0
	delta_speed = _delta * distance
	target_position.x = lerp(target_position.x, target.global_position.x, delta_speed)
	target_position.y = lerp(target_position.y, target.global_position.y, delta_speed)
	global_position = round(target_position + offset_position)

func _ready() -> void:
	current = true
