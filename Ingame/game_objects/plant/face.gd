extends Node2D

const IRIS_OFFSET = Vector2(-4,0)

var player : Player

func player_listener_on_ready(new_player : Player) -> void:
	player = new_player
	set_physics_process(true)

func _physics_process(_delta : float) -> void:
	if global_position.x > player.global_position.x:
		scale.x = 1
	else:
		scale.x = -1

func _ready() -> void:
	set_physics_process(false)
