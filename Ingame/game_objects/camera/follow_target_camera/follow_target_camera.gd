extends Camera2D
class_name FollowTargetCamera

@export var offset_position : Vector2 = Vector2.UP * 24.0
@export var distance_factor : float = .25

@onready var target : Node2D = get_tree().get_first_node_in_group("PLAYER")

var target_position  : Vector2
var distance         : float
var delta_speed      : float

func set_target(_target : Node2D) -> void:
	target = _target

func teleport() -> void:
	target_position = round(target.global_position + offset_position)
	global_position = target_position

func _process(_delta : float) -> void:
	distance = clamp(target_position.distance_squared_to(target.global_position), 1.0, 150.0) / 5.0
	if distance < 2.0: return

	delta_speed = _delta * distance * distance_factor
	target_position.x = lerp(target_position.x, target.global_position.x, delta_speed)
	target_position.y = lerp(target_position.y, target.global_position.y, delta_speed)
	
	global_position = round(target_position + offset_position)

func _ready() -> void:
	make_current()
