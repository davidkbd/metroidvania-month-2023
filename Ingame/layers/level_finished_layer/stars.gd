extends Control

signal finished

@export var star_animation_seconds : float = .5

@onready var level_instance : Level = get_tree().get_first_node_in_group("LEVEL")
@onready var plant_instance : Plant = get_tree().get_first_node_in_group("PLANT")

@onready var stars = [ $star_1, $star_2, $star_3 ]
@onready var particles = [ $star_1/particles, $star_2/particles, $star_3/particles ]
@onready var star_sfx           : AudioStreamPlayer = $star_sfx

var star_count : int

func _count_enabled_stars() -> void:
	if plant_instance.drop_count >= level_instance.stars_drops_third:
		star_count = 3
	elif plant_instance.drop_count >= level_instance.stars_drops_second:
		star_count = 2
	elif plant_instance.drop_count >= level_instance.stars_drops_first:
		star_count = 1
	else:
		star_count = 0

func _hide_stars() -> void:
	for star in stars:
		star.hide()

func _animate_stars() -> void:
	if star_count > 0:
		await get_tree().create_tween().bind_node(self).tween_method(_wait, 0, 1, 1).finished
		_show_star(0)
	if star_count > 1:
		await get_tree().create_tween().bind_node(self).tween_method(_wait, 0, 1, 1).finished
		_show_star(1)
	if star_count > 2:
		await get_tree().create_tween().bind_node(self).tween_method(_wait, 0, 1, 1).finished
		_show_star(2)

	await get_tree().create_tween().bind_node(self).tween_method(_wait, 0, 1, 1).finished
	
	emit_signal("finished")

func _show_star(_star_id : int) -> void:
	star_sfx.play()
	stars[_star_id].show()
	particles[_star_id].emitting = true

func _wait(_n : float) -> void:
	pass

func _ready() -> void:
	_count_enabled_stars()
	_hide_stars()
	_animate_stars()
