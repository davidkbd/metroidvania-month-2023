@tool
extends Node2D

@export_group("Data")

@export var value : float = 3.0 :
	get:
		return value
	set(_value):
		if value == _value: return
		value = clamp(_value, .0, max_value)
		queue_redraw()

@export var max_value : int = 5 :
	get:
		return max_value
	set(_value):
		if max_value == _value: return
		max_value = _value
		queue_redraw()

@export_group("Graphics")

@export var lifes_texture : Texture2D :
	get:
		return lifes_texture
	set(_texture):
		if lifes_texture == _texture: return
		lifes_texture = _texture
		queue_redraw()

func _draw() -> void:
	if lifes_texture == null: return
	var lifes   = int(floor(value))
	var decimas = int(floor(value * 10)) % 10
	var i : int = 0
	while i <= lifes and i < max_value:
		_draw_life(10 if i < lifes else decimas, i)
		i += 1
	while i < max_value:
		_draw_life(.0, i)
		i += 1

func _draw_life(_value : int, _x : int) -> void:
	var rect_src : Rect2 = Rect2(_value * 26, 0, 26, 26)
	var rect_pos : Rect2 = Rect2(_x * 26, 0, 26, 26)
	draw_texture_rect_region(lifes_texture, rect_pos, rect_src, Color.WHITE)
