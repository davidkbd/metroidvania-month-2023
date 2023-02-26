extends Node2D

@export var scale_factor : float = 2.0
@export_file var level_tscn : String
@onready var camera       : FollowTargetCamera = get_tree().get_first_node_in_group("CAMERA")

var level_instance : Node2D
var speed : float = 200

func _instance() -> void:
	level_instance = load(level_tscn).instantiate()
	add_child(level_instance)

func _physics_process(delta):
	if not camera: return
	var s = speed
	if Input.is_key_pressed(KEY_SHIFT): s *= 3.0
	camera.global_position.x += Input.get_axis("l", "r") * delta * s
	camera.global_position.y += Input.get_axis("u", "d") * delta * s

func _ready() -> void:
	DisplayServer.window_set_size(Vector2i(640, 360) * scale_factor)
	DisplayServer.window_set_position(Vector2i.ZERO)#(DisplayServer.screen_get_size() + DisplayServer.window_get_size()) / 2.0)

	_instance()
	camera.set_process(false)
