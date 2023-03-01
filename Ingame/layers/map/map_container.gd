extends Control

@export var movement_speed : float = 150.0
@export var movement_accel : float = 10.0
@export var movement_decel : float = 25.0

@onready var scroll   : Node2D = $scroll
@onready var map      : Node2D = $scroll/map

@onready var movement : Vector2 = Vector2.ZERO

var player : Player
var reset_position_tween : Tween

func room_listener_on_updated(aaa) -> void:
	pass

func initialize_rooms_state(_rooms_state : Dictionary) -> void:
	player = get_tree().get_first_node_in_group("PLAYER")

func initialize_map_state(_map_state : Dictionary) -> void:
	map.initialize_map_state(_map_state)

func open() -> void:
	show()
	map.open()

func _physics_process(_delta : float):
	if reset_position_tween: return
	map.position = -player.global_position * .08
	_move_container(_delta)
	if ControlInput.is_jump_just_pressed():
		_reset_container_position()

func _move_container(_delta : float) -> void:
	var hz_axis = ControlInput.get_horizontal_axis()
	var vt_axis = ControlInput.get_vertical_axis()
	if hz_axis:
		movement.x = lerp(movement.x, hz_axis * movement_speed, _delta * movement_accel)
	else:
		movement.x = lerp(movement.x, .0, _delta * movement_decel)
	if vt_axis:
		movement.y = lerp(movement.y, vt_axis * movement_speed, _delta * movement_accel)
	else:
		movement.y = lerp(movement.y, .0, _delta * movement_decel)
	
	scroll.position += movement * _delta

func _reset_container_position() -> void:
	if reset_position_tween: reset_position_tween.kill()
	reset_position_tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	reset_position_tween.tween_property(scroll, "position", Vector2.ZERO, .5)
	await reset_position_tween.finished
	reset_position_tween = null
