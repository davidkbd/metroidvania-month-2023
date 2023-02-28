extends Node2D

@export_range(.1, 1.0) var new_position_min_seconds : float = .1
@export_range(.1, 1.0) var new_position_max_seconds : float = .1
@export_range(1.0, 5.0) var new_position_min_radius : float = 1.0
@export_range(1.0, 5.0) var new_position_max_radius : float = 1.0
@export_range(1.0, 16.0) var speed : float = 8.0

@onready var light : PointLight2D = $light

var new_position_time : float

func _process(_delta : float):
	new_position_time -= _delta
	
	if new_position_time < .0:
		_choose_new_position(_delta)

func _choose_new_position(_delta : float) -> void:
	var radius = randf_range(new_position_min_radius, new_position_max_radius)
	var angle = randf_range(-PI, PI)
	var pos = Vector2(sin(angle) * radius, cos(angle) * radius) - light.offset
	light.position = lerp(light.position, pos, _delta * speed)
	
	new_position_time = randf_range(new_position_min_seconds, new_position_max_seconds)

func _ready() -> void:
	_choose_new_position(.0)
