extends Node2D

@onready var player : Player             = $player
@onready var camera : FollowTargetCamera = $camera

func initialize(_game_state : Dictionary) -> void:
	player.initialize(_game_state)
