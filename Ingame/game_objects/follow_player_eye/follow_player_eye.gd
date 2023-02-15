extends Node2D

const IRIS_OFFSET = Vector2(-4,0)

var player : Player

func player_listener_on_ready(new_player : Player) -> void:
	player = new_player
	set_physics_process(true)

func _physics_process(_delta : float) -> void:
	var diff = global_position - player.global_position
	var new_pos = IRIS_OFFSET.rotated(diff.angle()) * Vector2(1, .5)
	$iris.global_position = new_pos + global_position

func _ready() -> void:
	set_physics_process(false)
