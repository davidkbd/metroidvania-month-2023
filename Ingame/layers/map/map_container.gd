extends Control

@onready var map : Node2D = $map

var player : Player
var tween : Tween

func room_listener_on_updated(aaa) -> void:
	print(aaa)

#func room_listener_on_hooked(room) -> void:
#	if tween: tween.kill()
#	tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
#	tween.tween_property(map, "position", -room.global_position * .1, .75)

func initialize_rooms_state(_rooms_state : Dictionary) -> void:
	player = get_tree().get_first_node_in_group("PLAYER")
	map.initialize_rooms_state(_rooms_state)

func _physics_process(_delta : float):
	map.position = -player.global_position * .08
	
